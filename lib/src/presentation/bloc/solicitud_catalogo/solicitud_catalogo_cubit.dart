import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/local_db/solicitudes_pendientes.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/catalogo/catalogo_valor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_parametro_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/departments_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes-pendientes/solicitudes_pendientes_repository.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'solicitud_catalogo_state.dart';

class SolicitudCatalogoCubit extends Cubit<SolicitudCatalogoState> {
  final SolicitudesCreditoRepository _repository;
  final ObjectBoxService _objectBoxService;
  final DepartamentoRepository departamentoRepository;
  final SolicitudesPendientesRepository solicitudesPendientesRepository;

  SolicitudCatalogoCubit(
    this._repository,
    this._objectBoxService,
    this.departamentoRepository,
    this.solicitudesPendientesRepository,
  ) : super(SolicitudCatalogoInitial());

  Future<void> getCatalogoByCodigo({
    required String codigo,
    required bool isConnected,
  }) async {
    try {
      final data = await _repository.getCatalogoByCodigo(codigo: codigo);
      if (isConnected) {
        await _saveToDatabase(codigo: codigo, items: data.data);
      }
    } on SocketException {
      emit(const SolicitudCatalogoError(
        error: 'Tienes problemas de conexión. Revisa tu conexión a internet.',
      ));
    } on AppException catch (e) {
      emit(SolicitudCatalogoError(error: e.optionalMsg));
    } catch (e) {
      emit(SolicitudCatalogoError(
          error: 'Error no controlado: ${e.toString()}'));
    }
  }

  Future<void> getandSaveProductos() async {
    final data = await _repository.getCatalogoProductos();
    final query = _objectBoxService.catalogoBox
        .query(CatalogoLocalDb_.type.equals('PRODUCTO'))
        .build();
    query.remove();
    for (var item in data.data) {
      _objectBoxService.catalogoBox.put(CatalogoLocalDb(
        valor: item.valor,
        nombre: item.nombre,
        interes: item.interes,
        type: 'PRODUCTO',
        montoMaximo: item.montoMaximo,
        montoMinimo: item.montoMinimo,
      ));
    }
  }

  Future<void> getAndSaveDepartamentos() async {
    try {
      final data = await departamentoRepository.getDepartamentos();
      final query = _objectBoxService.departmentsBox.query().build();
      query.remove();
      for (var item in data.departamentos) {
        _objectBoxService.departmentsBox.put(
          DepartmentsLocalDb(
            valor: item.valor,
            nombre: item.nombre,
          ),
        );
      }
      log('Guardados los departamentos en la base de datos local');
    } catch (e) {
      emit(SolicitudCatalogoError(error: e.toString()));
    }
  }

  Future<void> saveAllCatalogos({
    required bool isConnected,
    required BuildContext context,
  }) async {
    if (!isConnected) {
      emit(SolicitudCatalogoSuccess());
      return;
    }

    emit(SolicitudCatalogoLoading());
    try {
      await getAndSaveDepartamentos();

      await saveCatalogosSolicitudesCreditoToLocalDb(isConnected: isConnected);

      if (!context.mounted) return;
      await saveKIVAPendingRequestsToLocalDb(context: context);

      LocalStorage().setLastUpdate(DateTime.now().millisecondsSinceEpoch);
      emit(SolicitudCatalogoSuccess());
    } on AppException catch (e) {
      emit(SolicitudCatalogoError(error: 'Error controlado: ${e.optionalMsg}'));
    } catch (e) {
      emit(SolicitudCatalogoError(error: 'Error controlado: ${e.toString()}'));
    }
  }

  Future<void> saveCatalogosSolicitudesCreditoToLocalDb({
    required bool isConnected,
  }) async {
    final actions = LocalStorage().currentActions;
    if (!actions.contains('LLENARSOLICITUDESMOVIL')) return;
    const codigos = [
      'PARENTESCO',
      'TIPOVIVIENDA',
      'MONEDA',
      'DESTINOCREDITO',
      'FRECUENCIAPAGO',
      'SECTORECONOMICO',
      'ESTADOCIVIL',
      'ESTADOSOLICITUDCREDITO',
      'ESCOLARIDAD',
      'SEXO',
      'RUBROACTIVIDAD',
      'TIPOSPERSONACREDITO',
      'ACTIVIDADECONOMICA',
      'TIPODOCUMENTOPERSONA',
    ];

    for (final codigo in codigos) {
      await getCatalogoByCodigo(codigo: codigo, isConnected: isConnected);
    }
    log('Catalogos guardados');

    await getandSaveProductos();
    log('Productos guardados');
    await getAndSaveParametros();
  }

  Future<void> saveKIVAPendingRequestsToLocalDb({
    required BuildContext context,
  }) async {
    final actions = LocalStorage().currentActions;

    if (!actions.contains('LLENARKIVAMOVIL')) return;

    final solicitudesKiva =
        await solicitudesPendientesRepository.getSolicitudesPendientes();
    if (!context.mounted) return;

    final solicitudes = solicitudesKiva.solicitudes.map((e) {
      return SolicitudesPendientes()
        ..estado = e.estado
        ..fecha = e.fecha
        ..moneda = e.moneda
        ..numero = e.numero
        ..producto = e.producto
        ..nombreFormulario = e.nombreFormulario
        ..solicitudId = e.id
        ..cedula = e.cedula
        ..sucursal = LocalStorage().database
        ..nombre = e.nombre
        ..monto = double.tryParse(e.monto.toString()) ?? 0.00
        ..tipoSolicitud = e.tipoSolicitud
        ..idAsesor = int.tryParse(LocalStorage().userId)
        ..motivoAnterior = e.motivoAnterior;
    }).toList();

    context.read<SolicitudesPendientesLocalDbCubit>().saveSolicitudesPendientes(
          solicitudes: solicitudes,
        );
    log('Solicitudes KIVA guardadas');
  }

  Future<void> getAndSaveParametros() async {
    final edadMinima =
        await _repository.getParametroByName(nombre: 'EDADMINIMACLIENTE');
    final edadMaxima =
        await _repository.getParametroByName(nombre: 'EDADMAXIMACLIENTE');
    final query = _objectBoxService.catalogoParametroBox.query().build();
    query.remove();
    _objectBoxService.catalogoParametroBox.put(CatalogoParametroLocalDb(
      valor: edadMinima.data.valor,
      type: 'EDADMINIMACLIENTE',
    ));
    _objectBoxService.catalogoParametroBox.put(CatalogoParametroLocalDb(
      valor: edadMaxima.data.valor,
      type: 'EDADMAXIMACLIENTE',
    ));
  }

  Future<void> _saveToDatabase({
    required String codigo,
    required List<Catalogo> items,
  }) async {
    final query = _objectBoxService.catalogoBox
        .query(CatalogoLocalDb_.type.equals(codigo))
        .build();

    query.remove();

    for (var item in items) {
      _objectBoxService.catalogoBox.put(CatalogoLocalDb(
        valor: item.valor,
        nombre: item.nombre,
        type: codigo,
        interes: item.interes,
        montoMaximo: item.montoMaximo,
        montoMinimo: item.montoMinimo,
      ));
    }
  }
}

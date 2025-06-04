import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/catalogo/catalogo_valor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/departments_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:equatable/equatable.dart';

part 'solicitud_catalogo_state.dart';

class SolicitudCatalogoCubit extends Cubit<SolicitudCatalogoState> {
  final SolicitudesCreditoRepository _repository;
  final ObjectBoxService _objectBoxService;
  final DepartamentoRepository departamentoRepository;

  SolicitudCatalogoCubit(
    this._repository,
    this._objectBoxService,
    this.departamentoRepository,
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
      log(item.interes.toString());
      log(item.nombre.toString());
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

  Future<void> saveAllCatalogos({required bool isConnected}) async {
    if (!isConnected) {
      emit(SolicitudCatalogoSuccess());
      return;
    }

    try {
      emit(SolicitudCatalogoLoading());
      await getAndSaveDepartamentos();

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
      LocalStorage().setLastUpdate(DateTime.now().millisecondsSinceEpoch);
      emit(SolicitudCatalogoSuccess());
    } on AppException catch (e) {
      emit(SolicitudCatalogoError(error: 'Error controlado: ${e.optionalMsg}'));
    } catch (e) {
      emit(SolicitudCatalogoError(error: 'Error controlado: ${e.toString()}'));
    }
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

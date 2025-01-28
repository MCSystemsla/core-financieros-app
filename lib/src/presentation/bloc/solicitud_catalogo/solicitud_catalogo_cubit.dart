import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/catalogo/catalogo_valor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:equatable/equatable.dart';

part 'solicitud_catalogo_state.dart';

class SolicitudCatalogoCubit extends Cubit<SolicitudCatalogoState> {
  final SolicitudesCreditoRepository _repository;
  final ObjectBoxService _objectBoxService;
  SolicitudCatalogoCubit(this._repository, this._objectBoxService)
      : super(SolicitudCatalogoInitial());

  Future<void> getCatalogoByCodigo(
      {required String codigo, required bool isConnected}) async {
    try {
      final data = await _repository.getCatalogoByCodigo(codigo: codigo);
      if (isConnected) await _saveToDatabase(codigo: codigo, items: data.data);
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

      await getCatalogoByCodigo(
        codigo: 'PARENTESCO',
        isConnected: isConnected,
      );
      await getCatalogoByCodigo(
        codigo: 'TIPOVIVIENDA',
        isConnected: isConnected,
      );
      await getCatalogoByCodigo(
        codigo: 'MONEDA',
        isConnected: isConnected,
      );
      await getCatalogoByCodigo(
        codigo: 'DESTINOCREDITO',
        isConnected: isConnected,
      );
      await getCatalogoByCodigo(
        codigo: 'FRECUENCIAPAGO',
        isConnected: isConnected,
      );
      await getCatalogoByCodigo(
        codigo: 'SECTORECONOMICO',
        isConnected: isConnected,
      );
      await getCatalogoByCodigo(
        codigo: 'ESTADOCIVIL',
        isConnected: isConnected,
      );
      await getCatalogoByCodigo(
        codigo: 'ESTADOSOLICITUDCREDITO',
        isConnected: isConnected,
      );
      await getCatalogoByCodigo(
        codigo: 'ESCOLARIDAD',
        isConnected: isConnected,
      );
      await getCatalogoByCodigo(
        codigo: 'SEXO',
        isConnected: isConnected,
      );
      await getCatalogoByCodigo(
        codigo: 'RUBROACTIVIDAD',
        isConnected: isConnected,
      );
      await getCatalogoByCodigo(
        codigo: 'TIPOSPERSONACREDITO',
        isConnected: isConnected,
      );
      await getCatalogoByCodigo(
        codigo: 'ACTIVIDADECONOMICA',
        isConnected: isConnected,
      );
      emit(SolicitudCatalogoSuccess());
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _saveToDatabase({
    required String codigo,
    required List<Catalogo> items,
  }) async {
    try {
      switch (codigo) {
        case 'PARENTESCO':
          final query = _objectBoxService.catalogoBox
              .query(CatalogoLocalDb_.type.equals(codigo))
              .build();

          query.remove();

          for (var item in items) {
            _objectBoxService.catalogoBox.put(CatalogoLocalDb(
              valor: item.valor,
              nombre: item.nombre,
              type: 'PARENTESCO',
            ));
          }
          break;

        case 'TIPOVIVIENDA':
          final query = _objectBoxService.catalogoBox
              .query(CatalogoLocalDb_.type.equals(codigo))
              .build();

          query.remove();
          for (var item in items) {
            _objectBoxService.catalogoBox.put(CatalogoLocalDb(
              valor: item.valor,
              nombre: item.nombre,
              type: 'TIPOVIVIENDA',
            ));
          }
          break;

        case 'MONEDA':
          final query = _objectBoxService.catalogoBox
              .query(CatalogoLocalDb_.type.equals(codigo))
              .build();

          query.remove();
          for (var item in items) {
            _objectBoxService.catalogoBox.put(CatalogoLocalDb(
              valor: item.valor,
              nombre: item.nombre,
              type: 'MONEDA',
            ));
          }
          break;

        case 'DESTINOCREDITO':
          final query = _objectBoxService.catalogoBox
              .query(CatalogoLocalDb_.type.equals(codigo))
              .build();

          query.remove();
          for (var item in items) {
            _objectBoxService.catalogoBox.put(CatalogoLocalDb(
              valor: item.valor,
              nombre: item.nombre,
              type: 'DESTINOCREDITO',
            ));
          }
          break;
        case 'FRECUENCIAPAGO':
          final query = _objectBoxService.catalogoBox
              .query(CatalogoLocalDb_.type.equals(codigo))
              .build();

          query.remove();
          for (var item in items) {
            _objectBoxService.catalogoBox.put(CatalogoLocalDb(
              valor: item.valor,
              nombre: item.nombre,
              type: 'FRECUENCIAPAGO',
            ));
          }
          break;
        case 'SECTORECONOMICO':
          final query = _objectBoxService.catalogoBox
              .query(CatalogoLocalDb_.type.equals(codigo))
              .build();

          query.remove();
          for (var item in items) {
            _objectBoxService.catalogoBox.put(CatalogoLocalDb(
              valor: item.valor,
              nombre: item.nombre,
              type: 'SECTORECONOMICO',
            ));
          }
          break;
        case 'ESTADOCIVIL':
          final query = _objectBoxService.catalogoBox
              .query(CatalogoLocalDb_.type.equals(codigo))
              .build();

          query.remove();
          for (var item in items) {
            _objectBoxService.catalogoBox.put(CatalogoLocalDb(
              valor: item.valor,
              nombre: item.nombre,
              type: 'ESTADOCIVIL',
            ));
          }
          break;
        case 'ESTADOSOLICITUDCREDITO':
          final query = _objectBoxService.catalogoBox
              .query(CatalogoLocalDb_.type.equals(codigo))
              .build();

          query.remove();
          for (var item in items) {
            _objectBoxService.catalogoBox.put(CatalogoLocalDb(
              valor: item.valor,
              nombre: item.nombre,
              type: 'ESTADOSOLICITUDCREDITO',
            ));
          }
          break;
        case 'ESCOLARIDAD':
          final query = _objectBoxService.catalogoBox
              .query(CatalogoLocalDb_.type.equals(codigo))
              .build();

          query.remove();
          for (var item in items) {
            _objectBoxService.catalogoBox.put(CatalogoLocalDb(
              valor: item.valor,
              nombre: item.nombre,
              type: 'ESCOLARIDAD',
            ));
          }
          break;
        case 'SEXO':
          final query = _objectBoxService.catalogoBox
              .query(CatalogoLocalDb_.type.equals(codigo))
              .build();

          query.remove();
          for (var item in items) {
            _objectBoxService.catalogoBox.put(CatalogoLocalDb(
              valor: item.valor,
              nombre: item.nombre,
              type: 'SEXO',
            ));
          }
          break;
        case 'RUBROACTIVIDAD':
          final query = _objectBoxService.catalogoBox
              .query(CatalogoLocalDb_.type.equals(codigo))
              .build();

          query.remove();
          for (var item in items) {
            _objectBoxService.catalogoBox.put(CatalogoLocalDb(
              valor: item.valor,
              nombre: item.nombre,
              type: 'RUBROACTIVIDAD',
            ));
          }
          break;
        case 'TIPOSPERSONACREDITO':
          final query = _objectBoxService.catalogoBox
              .query(CatalogoLocalDb_.type.equals(codigo))
              .build();

          query.remove();
          for (var item in items) {
            _objectBoxService.catalogoBox.put(CatalogoLocalDb(
              valor: item.valor,
              nombre: item.nombre,
              type: 'TIPOSPERSONACREDITO',
            ));
          }
          break;
        case 'ACTIVIDADECONOMICA':
          final query = _objectBoxService.catalogoBox
              .query(CatalogoLocalDb_.type.equals(codigo))
              .build();

          query.remove();
          for (var item in items) {
            _objectBoxService.catalogoBox.put(CatalogoLocalDb(
              valor: item.valor,
              nombre: item.nombre,
              type: 'ACTIVIDADECONOMICA',
            ));
          }
          break;

        default:
          throw Exception('Código no soportado: $codigo');
      }
      log('Guardados los datos en la base de datos local');
    } catch (e) {
      throw Exception('Error al guardar en la base de datos: $e');
    }
  }
}

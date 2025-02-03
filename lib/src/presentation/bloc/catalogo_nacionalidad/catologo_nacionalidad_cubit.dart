import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_nacionalidad_dep.db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_nacionalidad_mun.db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_nacionalidad_pais_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/nacionalidad/catalogo_nacionalidad.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:equatable/equatable.dart';

part 'catologo_nacionalidad_state.dart';

class CatologoNacionalidadCubit extends Cubit<CatologoNacionalidadState> {
  final SolicitudesCreditoRepository _repository;
  final ObjectBoxService _objectBoxService;
  CatologoNacionalidadCubit(this._repository, this._objectBoxService)
      : super(CatologoNacionalidadInitial());

  Future<void> getNacionalidadByCodigo({
    required String codigo,
    required bool isConnected,
  }) async {
    try {
      final data = await _repository.getNacionalidadByCodigo(codigo: codigo);
      if (isConnected) await _saveToDatabase(codigo: codigo, items: data.data);
    } catch (e) {
      emit(CatologoNacionalidadError());
    }
  }

  Future<void> saveAllCatalogos({required bool isConnected}) async {
    if (!isConnected) {
      emit(CatologoNacionalidadSuccess());
      return;
    }

    try {
      log('Guardando los catalogos en la base de datos local');
      emit(CatologoNacionalidadLoading());

      await getNacionalidadByCodigo(
        codigo: 'PAIS',
        isConnected: isConnected,
      );
      await getNacionalidadByCodigo(
        codigo: 'MUN',
        isConnected: isConnected,
      );
      await getNacionalidadByCodigo(
        codigo: 'DEP',
        isConnected: isConnected,
      );

      emit(CatologoNacionalidadSuccess());
      log('Catalogos guardados en la base de datos local');
    } catch (e) {
      emit(CatologoNacionalidadError());
      log(e.toString());
    }
  }

  Future<void> _saveToDatabase({
    required String codigo,
    required List<Nacionalidad> items,
  }) async {
    try {
      switch (codigo) {
        case 'PAIS':
          final query =
              _objectBoxService.catalogoNacionalidadPaisBox.query().build();

          query.remove();

          for (var item in items) {
            _objectBoxService.catalogoNacionalidadPaisBox
                .put(CatalogoNacionalidadPaisDb(
              valor: item.valor,
              nombre: item.nombre,
              relacion: item.relacion,
            ));
          }
          break;
        case 'DEP':
          final query =
              _objectBoxService.catalogoNacionalidadDepBox.query().build();

          query.remove();

          for (var item in items) {
            _objectBoxService.catalogoNacionalidadDepBox
                .put(CatalogoNacionalidadDepDb(
              valor: item.valor,
              nombre: item.nombre,
            ));
          }
          break;
        case 'MUN':
          final query =
              _objectBoxService.catalogoNacionalidadMunBox.query().build();

          query.remove();

          for (var item in items) {
            _objectBoxService.catalogoNacionalidadMunBox
                .put(CatalogoNacionalidadMunDb(
              valor: item.valor,
              nombre: item.nombre,
              relacion: item.relacion,
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

import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/catalogos/actividades_economicas_alias_filtered_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/catalogos/catalogo_actividad_cnbs_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/catalogos/catalogo_aldea_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/catalogos/catalogo_barrio_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/catalogos/catalogo_caserio_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_frecuencia_pago_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_nacionalidad_dep.db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_nacionalidad_mun.db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_nacionalidad_pais_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/nacionalidad/catalogo_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/catalogo/catalogo_valor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';

part 'solicitud_catalogo_hn_state.dart';

class SolicitudCatalogoHnCubit extends Cubit<SolicitudCatalogoHnState> {
  final SolicitudesCreditoHnRepository _repository;
  final SolicitudesHnBoxService _objectBoxService;

  SolicitudCatalogoHnCubit(
    this._repository,
    this._objectBoxService,
  ) : super(SolicitudCatalogoHnInitial());

  /// Obtiene un catálogo por código con manejo de errores
  Future<CatalogoValor?> getCatalogoByCodigo({required String codigo}) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.getCatalogoByCodigo(codigo: codigo);
      if (resp.data.isEmpty) {
        log('Catálogo vacío o nulo para código: $codigo');
        return null;
      }
      return resp;
    } catch (e, stack) {
      log('Error al obtener catálogo $codigo: $e\n$stack');
      return null;
    }
  }

  Future<void> saveAllCatalogos() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      await saveCatalogosToDatabase();
      log('Todos los catálogos guardados correctamente.');
      await getNacionalidadByCodigo(
        codigo: 'PAIS',
        isConnected: true,
      );
      await getNacionalidadByCodigo(
        codigo: 'MUN',
        isConnected: true,
      );
      await getNacionalidadByCodigo(
        codigo: 'DEP',
        isConnected: true,
      );
      // await getNacionalidadByCodigo(
      //   codigo: 'BR',
      //   isConnected: true,
      // );
      await getNacionalidadByCodigo(
        codigo: 'ALD',
        isConnected: true,
      );
      // await getNacionalidadByCodigo(
      //   codigo: 'CAS',
      //   isConnected: true,
      // );
      await saveCatalogoFrecuenciaPago();
      await getAndSaveParametros();
      await saveActividadesEconomicasAlias();
      emit(state.copyWith(status: Status.done));
      LocalStorage().setLastUpdate(DateTime.now().millisecondsSinceEpoch);
    } catch (e, stack) {
      log('Error al guardar catálogos: $e\n$stack');
      emit(state.copyWith(errorMsg: e.toString(), status: Status.error));
    }
  }

  static const List<String> _codigos = [
    'TIPOSPERSONACREDITO',
    'SEXO',
    'MONEDA',
    'TIPODOCUMENTOPERSONA',
    'TIPOVIVIENDA',
    'ESTADOCIVIL',
    'ESCOLARIDAD',
    'TIPOPERSONACNBS',
    'TIPOCLIENTE',
    'OCUPACION',
    'NIVELAPROXIMADOINGRESOS',
    'TIPOSOLICITUDCREDITO',
    'ESTATUSCLIENTE',
    'PROFESION',
    'DESTINOCREDITO',
    'SECTORECONOMICO',
    'ACTIVIDADECONOMICA',
    'MEDIDASCONOCIMIENTO',
    'PARENTESCO',
    'ESTADOPRESTAMO',
  ];

  Future<void> saveCatalogosToDatabase() async {
    try {
      try {
        await _objectBoxService.catalogoLocalBox.removeAllAsync();
        await _objectBoxService.catalogoActividadCnbsBox.removeAllAsync();
        await _objectBoxService.actividadesEconomicasAliasFilteredBox
            .removeAllAsync();
      } catch (e) {
        log('Error al limpiar la base ObjectBox: $e');
      }

      for (final codigo in _codigos) {
        final catalogoResponse = await getCatalogoByCodigo(codigo: codigo);

        if (catalogoResponse?.data == null || catalogoResponse!.data.isEmpty) {
          log('Saltando catálogo vacío: $codigo');
          continue;
        }

        for (final item in catalogoResponse.data) {
          try {
            _objectBoxService.catalogoLocalBox.put(CatalogoLocalDb(
              valor: item.valor,
              nombre: item.nombre,
              type: codigo,
              interes: item.interes,
              montoMaximo: item.montoMaximo,
              montoMinimo: item.montoMinimo?.toInt(),
            ));
          } catch (e) {
            log('Error al guardar item $item del catálogo $codigo: $e');
          }
        }
      }

      final catalogosActividadesCNSB = await getCatalogoByCodigo(
        codigo: 'ACTIVIDADESECONOMICASCNBS',
      );
      for (var item in catalogosActividadesCNSB!.data) {
        _objectBoxService.catalogoActividadCnbsBox
            .put(CatalogoActividadCnbsLocalDb(
          nombre: item.nombre,
          valor: item.valor,
          isApnfd: item.esAPNFD,
          isApnfdString: item.esAPNFD.toString(),
        ));
        if (item.esAPNFD) {
          log('esAPNFD ${item.esAPNFD} ${item.nombre}');
        }
      }

      final catalogoProductos = await _repository.getCatalogoProducts();
      for (var item in catalogoProductos.data) {
        _objectBoxService.catalogoLocalBox.put(CatalogoLocalDb(
          valor: item.valor,
          nombre: item.nombre,
          interes: item.interes,
          montoMaximo: item.montoMaximo,
          montoMinimo: item.montoMinimo?.toInt() ?? 0,
          isRecurrente: item.isRecurrente,
          type: 'PRODUCTO',
        ));
      }
      final catalogoEmpleadosActivos = await _repository.getEmpleadosActivos();
      for (var item in catalogoEmpleadosActivos.data) {
        _objectBoxService.catalogoLocalBox.put(CatalogoLocalDb(
          valor: item.valor.toString(),
          nombre: item.nombre,
          interes: 0,
          montoMaximo: 0,
          montoMinimo: 0,
          isRecurrente: false,
          type: 'EMPLEADOS',
        ));
      }
    } catch (e, stack) {
      log('Error general al guardar catálogos: $e\n$stack');
      rethrow;
    }
  }

  Future<void> _saveToDatabaseUbicaciones({
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
              // relacion: item.relacion,
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
              relacion: item.relacion,
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
        case 'BR':
          final query = _objectBoxService.catalogoBarrioBox.query().build();

          query.remove();

          for (var item in items) {
            _objectBoxService.catalogoBarrioBox.put(CatalogoBarrioLocalDb(
              valor: item.valor,
              nombre: item.nombre,
              relacion: item.relacion,
            ));
          }
          break;
        case 'ALD':
          final query = _objectBoxService.catalogoAldeaBox.query().build();

          query.remove();

          for (var item in items) {
            _objectBoxService.catalogoAldeaBox.put(CatalogoAldeaLocalDb(
              valor: item.valor,
              nombre: item.nombre,
              relacion: item.relacion,
            ));
          }
          break;
        case 'CAS':
          final query = _objectBoxService.catalogoCaserioBox.query().build();

          query.remove();

          for (var item in items) {
            _objectBoxService.catalogoCaserioBox.put(CatalogoCaserioLocalDb(
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

  Future<void> getNacionalidadByCodigo({
    required String codigo,
    required bool isConnected,
  }) async {
    try {
      final data = await _repository.getCatalogoUbicaciones(codigo: codigo);

      if (isConnected) {
        await _saveToDatabaseUbicaciones(
          codigo: codigo,
          items: data.data,
        );
      }
    } catch (_) {}
  }

  Future<void> saveCatalogoFrecuenciaPago() async {
    final data = await _repository.getCatalogoFrecuenciaPago();
    final query = _objectBoxService.catalogoFrecuenciaPagoBox.query().build();
    query.remove();
    for (var item in data.catalogo) {
      _objectBoxService.catalogoFrecuenciaPagoBox.put(CatalogoFrecuenciaPagoDb(
        valor: item.valor,
        meses: item.meses,
        nombre: item.nombre,
      ));
    }
  }

  Future<void> getAndSaveParametros() async {
    final edadMinima =
        await _repository.getParametroValor(nombre: 'EDADMINIMACLIENTE');
    final edadMaxima =
        await _repository.getParametroValor(nombre: 'EDADMAXIMACLIENTE');
    final incobrablesxCobrar =
        await _repository.getParametroValor(nombre: 'INCOBRABLESDECXCOBRAR');

    _objectBoxService.catalogoLocalBox.put(CatalogoLocalDb(
      valor: edadMinima.data.valor,
      nombre: 'EDADMINIMACLIENTE',
      type: 'EDADMINIMACLIENTE',
    ));
    _objectBoxService.catalogoLocalBox.put(CatalogoLocalDb(
      valor: edadMaxima.data.valor,
      type: 'EDADMAXIMACLIENTE',
      nombre: 'EDADMAXIMACLIENTE',
    ));
    _objectBoxService.catalogoLocalBox.put(CatalogoLocalDb(
      valor: incobrablesxCobrar.data.valor,
      type: 'INCOBRABLESDECXCOBRAR',
      nombre: 'INCOBRABLESDECXCOBRAR',
    ));
  }

  Future<void> saveActividadesEconomicasAlias() async {
    try {
      final resp = await _repository.getActividadesEconomicasAliasFiltered();
      final query = _objectBoxService.actividadesEconomicasAliasFilteredBox
          .query()
          .build();
      query.remove();
      for (var item in resp.data) {
        _objectBoxService.actividadesEconomicasAliasFilteredBox.put(
          ActividadesEconomicasAliasFilteredLocalDb(
            alias: item.alias,
            codActividadEconomica: item.codActividadEconomica,
            idActividadEconomica: item.id,
            nombre: item.nombre,
          ),
        );
      }
    } catch (e, s) {
      log('Error al guardar actividades economicas alias: $e, $s');
      rethrow;
    }
  }
}

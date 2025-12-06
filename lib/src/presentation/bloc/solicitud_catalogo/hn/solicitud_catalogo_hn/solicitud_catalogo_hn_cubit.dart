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

      await Future.wait([
        getNacionalidadByCodigo(codigo: 'PAIS', isConnected: true),
        getNacionalidadByCodigo(codigo: 'MUN', isConnected: true),
        getNacionalidadByCodigo(codigo: 'DEP', isConnected: true),
        getNacionalidadByCodigo(codigo: 'ALD', isConnected: true),
      ]);

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
    'RELACIONPERSONAS',
    'TIPOGARANTIA',
    'TIPOPERSONA'
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
        final items = catalogoResponse.data.map((item) {
          return CatalogoLocalDb(
            valor: item.valor,
            nombre: item.nombre,
            type: codigo,
            interes: item.interes,
            montoMaximo: item.montoMaximo,
            montoMinimo: item.montoMinimo?.toInt(),
          );
        }).toList();

        _objectBoxService.catalogoLocalBox.putMany(items);
      }

      final actividadesCNBS =
          await getCatalogoByCodigo(codigo: 'ACTIVIDADESECONOMICASCNBS');

      if (actividadesCNBS != null) {
        final items = actividadesCNBS.data.map((item) {
          return CatalogoActividadCnbsLocalDb(
            nombre: item.nombre,
            valor: item.valor,
            isApnfd: item.esAPNFD,
            isApnfdString: item.esAPNFD.toString(),
          );
        }).toList();

        _objectBoxService.catalogoActividadCnbsBox.putMany(items);
      }

      final productos = await _repository.getCatalogoProducts();
      final productosItems = productos.data.map((item) {
        return CatalogoLocalDb(
          valor: item.valor,
          nombre: item.nombre,
          interes: item.interes,
          montoMaximo: item.montoMaximo,
          montoMinimo: item.montoMinimo?.toInt() ?? 0,
          isRecurrente: item.isRecurrente,
          type: 'PRODUCTO',
        );
      }).toList();
      _objectBoxService.catalogoLocalBox.putMany(productosItems);

      final empleados = await _repository.getEmpleadosActivos();
      final empleadosItems = empleados.data.map((item) {
        return CatalogoLocalDb(
          valor: item.valor.toString(),
          nombre: item.nombre,
          interes: 0,
          montoMaximo: 0,
          montoMinimo: 0,
          isRecurrente: false,
          type: 'EMPLEADOS',
        );
      }).toList();

      _objectBoxService.catalogoLocalBox.putMany(empleadosItems);
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
          await _objectBoxService.catalogoNacionalidadPaisBox.removeAllAsync();

          final list = items.map((e) {
            return CatalogoNacionalidadPaisDb(
              valor: e.valor,
              nombre: e.nombre,
            );
          }).toList();

          _objectBoxService.catalogoNacionalidadPaisBox.putMany(list);
          break;

        case 'DEP':
          await _objectBoxService.catalogoNacionalidadDepBox.removeAllAsync();

          final list = items.map((e) {
            return CatalogoNacionalidadDepDb(
              valor: e.valor,
              nombre: e.nombre,
              relacion: e.relacion,
            );
          }).toList();

          _objectBoxService.catalogoNacionalidadDepBox.putMany(list);
          break;

        case 'MUN':
          await _objectBoxService.catalogoNacionalidadMunBox.removeAllAsync();

          final list = items.map((e) {
            return CatalogoNacionalidadMunDb(
              valor: e.valor,
              nombre: e.nombre,
              relacion: e.relacion,
            );
          }).toList();

          _objectBoxService.catalogoNacionalidadMunBox.putMany(list);
          break;

        case 'BR':
          await _objectBoxService.catalogoBarrioBox.removeAllAsync();

          final list = items.map((e) {
            return CatalogoBarrioLocalDb(
              valor: e.valor,
              nombre: e.nombre,
              relacion: e.relacion,
            );
          }).toList();

          _objectBoxService.catalogoBarrioBox.putMany(list);
          break;

        case 'ALD':
          await _objectBoxService.catalogoAldeaBox.removeAllAsync();

          final list = items.map((e) {
            return CatalogoAldeaLocalDb(
              valor: e.valor,
              nombre: e.nombre,
              relacion: e.relacion,
            );
          }).toList();

          _objectBoxService.catalogoAldeaBox.putMany(list);
          break;

        case 'CAS':
          await _objectBoxService.catalogoCaserioBox.removeAllAsync();

          final list = items.map((e) {
            return CatalogoCaserioLocalDb(
              valor: e.valor,
              nombre: e.nombre,
              relacion: e.relacion,
            );
          }).toList();

          _objectBoxService.catalogoCaserioBox.putMany(list);
          break;

        default:
          throw Exception('Código no soportado: $codigo');
      }
      await Future(() {});
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
    final list = data.catalogo
        .map(
          (e) => CatalogoFrecuenciaPagoDb(
            valor: e.valor,
            meses: e.meses,
            nombre: e.nombre,
          ),
        )
        .toList();
    _objectBoxService.catalogoFrecuenciaPagoBox.putMany(list);
  }

  Future<void> getAndSaveParametros() async {
    final edadMinima =
        await _repository.getParametroValor(nombre: 'EDADMINIMACLIENTE');
    final edadMaxima =
        await _repository.getParametroValor(nombre: 'EDADMAXIMACLIENTE');
    final incobrablesxCobrar =
        await _repository.getParametroValor(nombre: 'INCOBRABLESDECXCOBRAR');
    final fechaOperacion =
        await _repository.getParametroValor(nombre: 'FECHAOPERACION');

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
    _objectBoxService.catalogoLocalBox.put(CatalogoLocalDb(
      valor: fechaOperacion.data.valor,
      type: 'FECHAOPERACION',
      nombre: 'FECHAOPERACION',
    ));
  }

  Future<void> saveActividadesEconomicasAlias() async {
    try {
      final resp = await _repository.getActividadesEconomicasAliasFiltered();
      final query = _objectBoxService.actividadesEconomicasAliasFilteredBox
          .query()
          .build();
      query.remove();
      final list = resp.data.map((e) {
        return ActividadesEconomicasAliasFilteredLocalDb(
          alias: e.alias,
          codActividadEconomica: e.codActividadEconomica,
          idActividadEconomica: e.id,
          nombre: e.nombre,
        );
      }).toList();
      _objectBoxService.actividadesEconomicasAliasFilteredBox.putMany(list);
    } catch (e, s) {
      log('Error al guardar actividades economicas alias: $e, $s');
      rethrow;
    }
  }
}

import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/analisis_list_data_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
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
import 'package:core_financiero_app/src/datasource/solicitudes/ni/parametro/parametro_valor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/utils/extensions/catalogo_type/catalogo_type.dart';
import 'package:core_financiero_app/src/utils/extensions/parametros_type/parametros_type.dart';
import 'package:core_financiero_app/src/utils/extensions/ubicacion_type/ubicacion_type.dart';
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

  /// Guarda todos los catálogos generales, ubicaciones, actividades economicas, etc. en BD Local
  Future<void> saveAllCatalogos() async {
    emit(state.copyWith(status: Status.inProgress, unsyncedCatalogos: []));
    try {
      await saveCatalogosToDatabase();
      log('Todos los catálogos generales guardados correctamente.');

      await Future.wait([
        getNacionalidadByCodigo(codigo: UbicacionType.pais),
        getNacionalidadByCodigo(codigo: UbicacionType.municipio),
        getNacionalidadByCodigo(codigo: UbicacionType.departamento),
        getNacionalidadByCodigo(codigo: UbicacionType.aldea),
      ]);

      await saveActividadesEconomicasAlias();

      await saveCatalogoFrecuenciaPago();

      await getAndSaveParametros();
      await guardarAnalisisAsignados();
      await saveCatalogosSolicitudesGrupal();
      LocalStorage().setLastUpdate(DateTime.now().millisecondsSinceEpoch);
      emit(state.copyWith(status: Status.done));
    } on AppException catch (e) {
      emit(
        state.copyWith(
          errorMsg:
              'No se pudieron sincronizar los catálogos. Intente de nuevo. ${e.optionalMsg}',
          status: Status.error,
        ),
      );
    } catch (e, stack) {
      log('Error al guardar catálogos: $e\n$stack');
      emit(
        state.copyWith(
          errorMsg:
              'No se pudieron sincronizar los catálogos. Intente de nuevo. $e',
          status: Status.error,
        ),
      );
    }
  }

  static const List<CatalogoType> _codigos = [
    CatalogoType.tipoPersonaCredito,
    CatalogoType.sexo,
    CatalogoType.moneda,
    CatalogoType.tipoDocumentoPersona,
    CatalogoType.tipoVivienda,
    CatalogoType.estadoCivil,
    CatalogoType.escolaridad,
    CatalogoType.tipoPersonaCNBS,
    CatalogoType.tipoCliente,
    CatalogoType.ocupacion,
    CatalogoType.nivelaproximadoIngresos,
    CatalogoType.tipoSolicitudCredito,
    CatalogoType.estatusCliente,
    CatalogoType.profesion,
    CatalogoType.destinoCredito,
    CatalogoType.sectorEconomico,
    CatalogoType.actividadEconomica,
    CatalogoType.medidasConocimiento,
    CatalogoType.parentesco,
    CatalogoType.estadoPrestamo,
    CatalogoType.relacionPersonas,
    CatalogoType.tipoGarantia,
    CatalogoType.tipoPersona,
    CatalogoType.ubicacionGPS,
    CatalogoType.programa,
    CatalogoType.tipoDesembolsos,
    CatalogoType.tipoRelacionPeps,
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
        final catalogoResponse =
            await getCatalogoByCodigo(codigo: codigo.codigo);

        if (catalogoResponse?.data == null || catalogoResponse!.data.isEmpty) {
          log('Saltando catálogo vacío: $codigo');
          continue;
        }
        final items = catalogoResponse.data.map((item) {
          return CatalogoLocalDb(
            valor: item.valor,
            nombre: item.nombre,
            type: codigo.codigo,
            interes: item.interes,
            montoMaximo: item.montoMaximo,
            montoMinimo: item.montoMinimo?.toInt(),
          );
        }).toList();

        _objectBoxService.catalogoLocalBox.putMany(items);
      }

      final actividadesCNBS = await getCatalogoByCodigo(
        codigo: CatalogoType.actividadesEconomicasCNBS.codigo,
      );

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
          type: CatalogoType.producto.codigo,
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
          type: CatalogoType.empleados.codigo,
        );
      }).toList();

      _objectBoxService.catalogoLocalBox.putMany(empleadosItems);
    } on AppException catch (e) {
      emit(
        state.copyWith(
          unsyncedCatalogos: [
            'No se pudo sincronizar catalogo: ${e.optionalMsg}',
            ...state.unsyncedCatalogos
          ],
        ),
      );
    } catch (e, stack) {
      log('Error general al guardar catálogos: $e\n$stack');
      rethrow;
    }
  }

  Future<void> saveCatalogosSolicitudesGrupal() async {
    try {
      final catalogoGrupo = await _repository.getGruposActivos();
      final catalogoCargos = await _repository.getCargosDisponibles();
      final listGrupos = catalogoGrupo.data.map((e) {
        return CatalogoLocalDb(
          valor: e.codigo,
          nombre: e.nombreCompleto,
          interes: 0,
          montoMaximo: 0,
          montoMinimo: 0,
          type: CatalogoType.gruposActivos.codigo,
        );
      }).toList();
      final listCargos = catalogoCargos.data.map((e) {
        return CatalogoLocalDb(
          valor: e.valor,
          nombre: e.nombre,
          interes: 0,
          montoMaximo: 0,
          montoMinimo: 0,
          type: CatalogoType.cargosDisponibles.codigo,
        );
      }).toList();

      _objectBoxService.catalogoLocalBox.putMany(listCargos);
      _objectBoxService.catalogoLocalBox.putMany(listGrupos);
    } catch (e) {
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
    required UbicacionType codigo,
  }) async {
    try {
      final data =
          await _repository.getCatalogoUbicaciones(codigo: codigo.codigo);

      await _saveToDatabaseUbicaciones(
        codigo: codigo.codigo,
        items: data.data,
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          unsyncedCatalogos: [
            'No se pudo sincronizar catalogo ubicacion ${codigo.codigo}: ${e.optionalMsg}',
            ...state.unsyncedCatalogos
          ],
        ),
      );
    } catch (_) {}
  }

  Future<void> saveCatalogoFrecuenciaPago() async {
    try {
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
    } on AppException catch (e) {
      emit(
        state.copyWith(
          unsyncedCatalogos: [
            'No se pudo sincronizar el catalogo frecuencia de pago: ${e.optionalMsg}',
            ...state.unsyncedCatalogos
          ],
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getAndSaveParametros() async {
    try {
      final edadMinima = await saveParametroByParamName(
        paramName: ParametroType.edadMinimaCliente,
      );

      final edadMaxima = await saveParametroByParamName(
        paramName: ParametroType.edadMaximaCliente,
      );

      final incobrablesxCobrar = await saveParametroByParamName(
        paramName: ParametroType.incobrablesDeCXCobrar,
      );

      final fechaOperacion = await saveParametroByParamName(
        paramName: ParametroType.fechaOperacion,
      );

      final montoMenorAMil = await saveParametroByParamName(
        paramName: ParametroType.menorMil,
      );

      final relacionminrazoncuotarecurrente = await saveParametroByParamName(
        paramName: ParametroType.relacionMinimaRazonCuotaCredtioRecurrente,
      );

      final relacionMinRazonCuotaCreditoNueva = await saveParametroByParamName(
        paramName: ParametroType.relacionMaximaRazonCuotaCreditoNuevo,
      );

      _objectBoxService.catalogoLocalBox.put(CatalogoLocalDb(
        valor: edadMinima.valor,
        nombre: ParametroType.edadMinimaCliente.codigo,
        type: ParametroType.edadMinimaCliente.codigo,
      ));

      _objectBoxService.catalogoLocalBox.put(CatalogoLocalDb(
        valor: edadMaxima.valor,
        type: ParametroType.edadMaximaCliente.codigo,
        nombre: ParametroType.edadMaximaCliente.codigo,
      ));

      _objectBoxService.catalogoLocalBox.put(CatalogoLocalDb(
        valor: incobrablesxCobrar.valor,
        type: ParametroType.incobrablesDeCXCobrar.codigo,
        nombre: ParametroType.incobrablesDeCXCobrar.codigo,
      ));

      _objectBoxService.catalogoLocalBox.put(CatalogoLocalDb(
        valor: fechaOperacion.valor,
        type: ParametroType.fechaOperacion.codigo,
        nombre: ParametroType.fechaOperacion.codigo,
      ));

      _objectBoxService.catalogoLocalBox.put(CatalogoLocalDb(
        valor: montoMenorAMil.valor,
        type: ParametroType.menorMil.codigo,
        nombre: ParametroType.menorMil.codigo,
      ));

      _objectBoxService.catalogoLocalBox.put(CatalogoLocalDb(
        valor: relacionminrazoncuotarecurrente.valor,
        type: ParametroType.relacionMinimaRazonCuotaCredtioRecurrente.codigo,
        nombre: ParametroType.relacionMinimaRazonCuotaCredtioRecurrente.codigo,
      ));

      _objectBoxService.catalogoLocalBox.put(CatalogoLocalDb(
        valor: relacionMinRazonCuotaCreditoNueva.valor,
        type: ParametroType.relacionMaximaRazonCuotaCreditoNuevo.codigo,
        nombre: ParametroType.relacionMaximaRazonCuotaCreditoNuevo.codigo,
      ));
    } on AppException catch (e) {
      log('Error al guardar parametro: $e');
    } catch (e) {
      rethrow;
    }
  }

  Future<ParametroData> saveParametroByParamName({
    required ParametroType paramName,
  }) async {
    try {
      final parametro = await _repository.getParametroValor(
        nombre: paramName.codigo,
      );
      return parametro.data;
    } on AppException catch (e) {
      emit(
        state.copyWith(
          unsyncedCatalogos: [
            'No se pudo sincronizar el parametro ${paramName.codigo}: ${e.optionalMsg}',
            ...state.unsyncedCatalogos
          ],
        ),
      );
      rethrow;
    } catch (e) {
      rethrow;
    }
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
    } on AppException catch (e) {
      emit(
        state.copyWith(
          unsyncedCatalogos: [
            'No se pudo sincronizar el catalogo actividades economicas alias: ${e.optionalMsg}',
            ...state.unsyncedCatalogos
          ],
        ),
      );
      rethrow;
    } catch (e, s) {
      log('Error al guardar actividades economicas alias: $e, $s');
      rethrow;
    }
  }

  Future<void> guardarAnalisisAsignados() async {
    final analisisListData = await _repository.getSolicitudesByEstado(
      isAsignadaToAsesorCredito: true,
      estadoCredito: EstadoCredito.asignada,
      cedulaCliente: '',
      pagina: 1,
      numeroSolicitud: '',
      codigoGrupo: null,
      isCustomEstadoCredito: false,
    );

    final analisisLocalDbProvider = global<AnalisisBoxServiceHn>();

    analisisLocalDbProvider.saveAnalisisListDataHn(
      analisisListDataHn: analisisListData.data
          .map((e) => _mapToAnalisisListDataHn(e))
          .toList(),
    );
  }

  AnalisisListDataHn _mapToAnalisisListDataHn(SolicitudEstado e) {
    return AnalisisListDataHn(
      numero: e.numero,
      objTipoSolicitudId: e.objTipoSolicitudId,
      objEstadoSolicitudId: e.objEstadoSolicitudId,
      monto: e.monto,
      sucursal: e.sucursal,
      observacion: e.observacion,
      cuota: e.cuota,
      nombreCompleto: e.nombreCompleto,
      estado: e.estado,
      tipoSolicitud: e.tipoSolicitud,
      nombrePromotor: e.nombrePromotor,
      fechaSolicitud: e.fechaSolicitud,
      cedulaCliente: e.cedulaCliente,
      tipoPersonaCodigo: e.tipoPersonaCodigo,
      idAnalisis: e.id,
      esSolicitudGrupal: e.esSolicitudGrupal,
    );
  }
}

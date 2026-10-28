import 'dart:developer';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/analisis_list_data_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/datasource/local_db/solicitudes_pendientes.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_frecuencia_pago_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/catalogo/departments_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/kiva_configuracion/kiva_configuracion_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes-pendientes/solicitudes_pendientes_repository.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/ni/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:equatable/equatable.dart';
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

  static const _accionKiva = 'LLENARKIVAMOVIL';

  /// Parámetros que leen los cubits de análisis NI desde la BD local:
  /// incobrables (asalariado, mayor a mil, represtamo) y la razón cuota que
  /// da el D.P.P. de menor a mil (nueva y represtamo).
  static const _parametrosAnalisis = [
    'INCOBRABLESDECXCOBRAR',
    'RELACIONMAXRAZONCUOTACREDITONUEVO',
    'RELACIONMAXRAZONCUOTACREDITOREPRESTAMO',
  ];

  static const _codigosCatalogo = [
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
    'ESTADOPRESTAMO',
    'UBICACIONGPS',
    // "Relación con el cliente" del formulario de fiadores del análisis NI.
    'RELACIONPERSONAS',
  ];

  /// Punto de entrada único: descarga y persiste todos los catálogos.
  ///
  /// Los catálogos que fallen individualmente no abortan la sincronización;
  /// se reportan en [SolicitudCatalogoSuccess.unsyncedCatalogos].
  Future<void> saveAllCatalogos({
    required bool isConnected,
    required SolicitudesPendientesLocalDbCubit
        solicitudesPendientesLocalDbCubit,
  }) async {
    if (!isConnected) {
      _safeEmit(const SolicitudCatalogoSuccess());
      return;
    }

    _safeEmit(SolicitudCatalogoLoading());
    try {
      await getAndSaveDepartamentos();

      final unsynced = await saveCatalogosSolicitudesCreditoToLocalDb();

      await saveKIVAPendingRequestsToLocalDb(
        solicitudesPendientesLocalDbCubit: solicitudesPendientesLocalDbCubit,
      );

      LocalStorage().setLastUpdate(DateTime.now().millisecondsSinceEpoch);
      _safeEmit(SolicitudCatalogoSuccess(unsyncedCatalogos: unsynced));
    } on AppException catch (e) {
      _safeEmit(
          SolicitudCatalogoError(error: 'Error controlado: ${e.optionalMsg}'));
    } catch (e) {
      _safeEmit(SolicitudCatalogoError(error: 'Error controlado: $e'));
    }
  }

  Future<List<String>> saveCatalogosSolicitudesCreditoToLocalDb() async {
    // if (!LocalStorage().currentActions.contains(_accionSolicitudes)) return [];

    final unsynced = <String>[];

    for (final codigo in _codigosCatalogo) {
      try {
        await getCatalogoByCodigo(codigo: codigo);
      } catch (e) {
        log('Error sincronizando catalogo $codigo: $e');
        unsynced.add(codigo);
      }
    }
    log('Catalogos guardados');

    try {
      await getAndSaveEmpleadosActivos();
      log('Empleados activos guardados');
    } catch (e) {
      log('Error sincronizando catalogo EMPLEADOS: $e');
      unsynced.add('EMPLEADOS');
    }

    await getAndSaveProductos();
    log('Productos guardados');

    await getAndSaveParametros();
    log('Parámetros guardados');

    for (final nombre in _parametrosAnalisis) {
      try {
        await getAndSaveParametroAnalisis(nombre: nombre);
        log('Parámetro $nombre guardado');
      } catch (e) {
        log('Error sincronizando parámetro $nombre: $e');
        unsynced.add(nombre);
      }
    }

    await saveCatalogoFrecuenciaPago();
    log('Frecuencia de Pago guardados');

    // Lista offline de análisis: solo NI (Costa Rica también usa este sync).
    if (global<FlavorCubit>().state.flavor == Flavor.nicaragua) {
      try {
        await guardarAnalisisAsignadosNi();
        log('Análisis asignados guardados');
      } catch (e) {
        log('Error sincronizando análisis asignados: $e');
        unsynced.add('ANALISISASIGNADOS');
      }
    }

    return unsynced;
  }

  /// Guarda en `AnalisisListDataHn` la página 1 de las solicitudes asignadas
  /// al asesor (mismo filtro que `AnalisisSolicitudesScreen`), para que
  /// `AnalisisSolicitudesHnOfflineScreen` las muestre sin conexión.
  Future<void> guardarAnalisisAsignadosNi() async {
    final analisisListData = await _repository.getSolicitudesByEstado(
      estadoCredito: EstadoCredito.asignada,
      isAsignadaToAsesorCredito: true,
      numeroSolicitud: '',
      cedulaCliente: '',
      pagina: 1,
      isCustomEstadoCredito: false,
    );

    global<AnalisisBoxServiceHn>().saveAnalisisListDataHn(
      analisisListDataHn:
          analisisListData.data.map(_mapToAnalisisListDataHn).toList(),
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

  Future<void> getCatalogoByCodigo({required String codigo}) async {
    final data = await _repository.getCatalogoByCodigo(codigo: codigo);
    _replaceCatalogoByType(
      type: codigo,
      items: data.data.map(
        (item) => CatalogoLocalDb(
          valor: item.valor,
          nombre: item.nombre,
          type: codigo,
          interes: item.interes,
          montoMaximo: item.montoMaximo,
          montoMinimo: item.montoMinimo?.toInt(),
        ),
      ),
    );
  }

  Future<void> getAndSaveEmpleadosActivos() async {
    final empleados = await _repository.getEmpleadosActivos();
    _replaceCatalogoByType(
      type: 'EMPLEADOS',
      items: empleados.data.map(
        (item) => CatalogoLocalDb(
          valor: item.valor,
          nombre: item.nombre,
          type: 'EMPLEADOS',
        ),
      ),
    );
  }

  Future<void> getAndSaveProductos() async {
    final productos = await _repository.getCatalogoProductos();
    final kivaConfiguracion = await _repository.getKivaConfiguracion();

    _replaceCatalogoByType(
      type: 'PRODUCTO',
      items: productos.data.map(
        (item) => CatalogoLocalDb(
          valor: item.valor,
          nombre: item.nombre,
          interes: item.interes,
          type: 'PRODUCTO',
          montoMaximo: item.montoMaximo,
          montoMinimo: item.montoMinimo?.toInt(),
          isRecurrente: item.isRecurrente,
          esNuevo: item.esNuevo,
        ),
      ),
    );

    _objectBoxService.kivaConfiguracionBox.removeAll();
    _objectBoxService.kivaConfiguracionBox.putMany(
      kivaConfiguracion.data
          .map(
            (item) => KivaConfiguracionLocalDb(
              productoCodigo: item.productoCodigo,
              producto: item.producto,
              esRecurrente: item.esRecurrente,
              formularioKiva: item.formularioKiva,
              montoMinimo: item.montoMinimo,
              montoMaximo: item.montoMaximo,
              plazoMinimo: item.plazoMinimo,
              plazoMaximo: item.plazoMaximo,
              aplicaMigrantesEconomicos: item.aplicaMigrantesEconomicos,
              masculino: item.masculino,
              femenino: item.femenino,
            ),
          )
          .toList(),
    );
  }

  Future<void> getAndSaveDepartamentos() async {
    final data = await departamentoRepository.getDepartamentos();

    _objectBoxService.departmentsBox.removeAll();
    _objectBoxService.departmentsBox.putMany(
      data.departamentos
          .map(
            (item) => DepartmentsLocalDb(
              valor: item.valor,
              nombre: item.nombre,
            ),
          )
          .toList(),
    );
    log('Guardados los departamentos en la base de datos local');
  }

  Future<void> saveCatalogoFrecuenciaPago() async {
    final data = await _repository.getCatalogoFrecuenciaPago();

    _objectBoxService.catalogoFrecuenciaPagoBox.removeAll();
    _objectBoxService.catalogoFrecuenciaPagoBox.putMany(
      data.catalogo
          .map(
            (item) => CatalogoFrecuenciaPagoDb(
              valor: item.valor,
              meses: item.meses,
              nombre: item.nombre,
            ),
          )
          .toList(),
    );
  }

  Future<void> getAndSaveParametros() async {
    final edadMinima =
        await _repository.getParametroByName(nombre: 'EDADMINIMACLIENTE');
    final edadMaxima =
        await _repository.getParametroByName(nombre: 'EDADMAXIMACLIENTE');

    _replaceCatalogoByType(
      type: 'EDADMINIMACLIENTE',
      items: [
        CatalogoLocalDb(
          valor: edadMinima.data.valor,
          nombre: 'EDADMINIMACLIENTE',
          type: 'EDADMINIMACLIENTE',
        ),
      ],
    );
    _replaceCatalogoByType(
      type: 'EDADMAXIMACLIENTE',
      items: [
        CatalogoLocalDb(
          valor: edadMaxima.data.valor,
          nombre: 'EDADMAXIMACLIENTE',
          type: 'EDADMAXIMACLIENTE',
        ),
      ],
    );
  }

  /// Guarda un parámetro que usan los análisis. Va aparte de
  /// [getAndSaveParametros] para que, si falla, no tumbe la sincronización de
  /// las edades.
  Future<void> getAndSaveParametroAnalisis({required String nombre}) async {
    final parametro = await _repository.getParametroByName(nombre: nombre);

    _replaceCatalogoByType(
      type: nombre,
      items: [
        CatalogoLocalDb(
          valor: parametro.data.valor,
          nombre: nombre,
          type: nombre,
        ),
      ],
    );
  }

  Future<void> saveKIVAPendingRequestsToLocalDb({
    required SolicitudesPendientesLocalDbCubit
        solicitudesPendientesLocalDbCubit,
  }) async {
    if (!LocalStorage().currentActions.contains(_accionKiva)) return;

    final solicitudesKiva =
        await solicitudesPendientesRepository.getSolicitudesPendientes();

    final sucursal = LocalStorage().database;
    final idAsesor = int.tryParse(LocalStorage().userId);

    final solicitudes = solicitudesKiva.solicitudes
        .map(
          (e) => SolicitudesPendientes()
            ..estado = e.estado
            ..fecha = e.fecha
            ..moneda = e.moneda
            ..numero = e.numero
            ..producto = e.producto
            ..nombreFormulario = e.nombreFormulario
            ..solicitudId = e.id
            ..cedula = e.cedula
            ..sucursal = sucursal
            ..nombre = e.nombre
            ..monto = double.tryParse(e.monto.toString()) ?? 0.00
            ..tipoSolicitud = e.tipoSolicitud
            ..idAsesor = idAsesor
            ..motivoAnterior = e.motivoAnterior,
        )
        .toList();

    await solicitudesPendientesLocalDbCubit.saveSolicitudesPendientes(
      solicitudes: solicitudes,
    );
    log('Solicitudes KIVA guardadas');
  }

  /// Borra las filas de [type] y escribe [items] en un solo lote.
  void _replaceCatalogoByType({
    required String type,
    required Iterable<CatalogoLocalDb> items,
  }) {
    final query = _objectBoxService.catalogoBox
        .query(CatalogoLocalDb_.type.equals(type))
        .build();
    try {
      query.remove();
    } finally {
      query.close();
    }

    _objectBoxService.catalogoBox.putMany(items.toList());
  }

  void _safeEmit(SolicitudCatalogoState state) {
    if (isClosed) return;
    emit(state);
  }
}

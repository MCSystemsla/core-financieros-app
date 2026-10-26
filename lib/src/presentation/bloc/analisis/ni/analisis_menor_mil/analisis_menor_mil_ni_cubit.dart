import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/config/helpers/autosave/analisis/analisis_menor_mil_hn_autosave.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_menor_mil.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/nueva_menor_mil/nueva_menor_mil_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_inventario_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/ni/analisis_forms_repository_ni.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_solicitudes_interceptor_type.dart';
import 'package:core_financiero_app/src/utils/extensions/double/double_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'analisis_menor_mil_ni_state.dart';

class AnalisisMenorMilNiCubit extends Cubit<AnalisisMenorMilNiState> {
  final AnalisisFormsRepositoryNi _repository;
  late final NuevaMenorMilAutosaveHN autoSaveHelper;

  AnalisisMenorMilNiCubit(this._repository) : super(AnalisisMenorMilInitial());

  Future<void> createAnalisisMenorMil({
    required AnalisisSolicitudesInterceptorType tipoSolicitud,
  }) async {
    final totalInventarioCalc = state.inventarioHn.fold(
      0,
      (sum, element) => sum + element.total,
    );

    final totalActivosCirculantesCalc = state.caja +
        state.banco +
        state.cuentasXCobrar +
        state.otrosActivos +
        totalInventarioCalc;

    final totalActivoCalc = state.activoFijo + totalActivosCirculantesCalc;

    final totalPasivosCalc =
        state.proveedores + state.cuentasXPagar + state.otrasDeudas;

    final totalCapitalCalc = totalActivoCalc - totalPasivosCalc;

    final pasivosCapitalCalc = totalPasivosCalc + totalCapitalCalc;

    final totalIngresosCalc = state.ventasContado + state.recuperaciones;

    final ingresoAnualVenta = totalIngresosCalc * 12;

    final costoPorcentajeVenta = state.inventarioHn.isEmpty
        ? 0.0.toSafeString(2)
        : (state.inventarioHn.fold<double>(
                  0.0,
                  (sum, e) => sum + e.costoVentaPorcentaje,
                ) /
                state.inventarioHn.length)
            .toSafeString(2);

    final relacionMaxRazonCuotaParam = switch (tipoSolicitud) {
      AnalisisSolicitudesInterceptorType.nueva =>
        'RELACIONMAXRAZONCUOTACREDITONUEVO',
      AnalisisSolicitudesInterceptorType.represtamo =>
        'RELACIONMAXRAZONCUOTACREDITOREPRESTAMO',
      _ => throw Exception('Tipo de solicitud no soportado $tipoSolicitud'),
    };

    final relacionMinRazonCuota = global<ObjectBoxService>()
        .getParametroByName(nombre: relacionMaxRazonCuotaParam);
    emit(state.copyWith(status: Status.inProgress));

    final costoVentaCalc =
        totalIngresosCalc * double.parse(costoPorcentajeVenta);

    final margenBrutoNegocioCalc =
        totalIngresosCalc - costoVentaCalc - state.gastosOperativos;

    final saldoDisponibleUnidadFamiliarCalc = margenBrutoNegocioCalc +
        state.otrosIngresos -
        state.gastosUnidadFamiliar;

    final relacionMinRazonCuotaPercent =
        (double.tryParse(relacionMinRazonCuota?.valor ?? '') ?? 0) / 100;
    final relacionMinRazonCuotaCalc =
        (relacionMinRazonCuotaPercent * saldoDisponibleUnidadFamiliarCalc);

    try {
      await _repository.createAnalisisMenorMilByTipoSolicitud(
        tipoSolicitud: tipoSolicitud,
        analisis: AnalisisMenorMilHN(
          numeroSolicitud: state.numeroSolicitud,
          caja: state.caja,
          banco: state.banco,
          cuentasXCobrar: state.cuentasXCobrar,
          inventario: totalInventarioCalc.toDouble(),
          otrosActivos: state.otrosActivos,
          totalAc: totalActivosCirculantesCalc,
          activoFijo: state.activoFijo,
          totalActivo: totalActivoCalc,
          proveedores: state.proveedores,
          cuentasXPagar: state.cuentasXPagar,
          otrasDeudas: state.otrasDeudas,
          totalPasivo: totalPasivosCalc,
          capital: totalCapitalCalc,
          pasivoCapital: pasivosCapitalCalc,
          ventasContado: state.ventasContado,
          aniosConocerReferido1: state.aniosConocerReferido1,
          aniosConocerReferido2: state.aniosConocerReferido2,
          aniosConocerReferido3: state.aniosConocerReferido3,
          cliente1: state.cliente1,
          cliente2: state.cliente2,
          cliente3: state.cliente3,
          proveedor1: state.proveedor1,
          proveedor2: state.proveedor2,
          proveedor3: state.proveedor3,
          cedulaReferencia1: state.cedulaReferencia1,
          cedulaReferencia2: state.cedulaReferencia2,
          cedulaReferencia3: state.cedulaReferencia3,
          costoVenta: costoVentaCalc,
          ingresoAnual: ingresoAnualVenta,
          gastosOperativos: state.gastosOperativos,
          gastosUnidadFamiliar: state.gastosUnidadFamiliar,
          otrosIngresos: state.otrosIngresos,
          costoVentaPorcentaje: double.parse(costoPorcentajeVenta),
          resultadoVerificacion1: state.resultadoVerificacion1,
          resultadoVerificacion2: state.resultadoVerificacion2,
          resultadoVerificacion3: state.resultadoVerificacion3,
          inventarioTb: state.inventarioHn,
          direccionReferencia1: state.direccionReferencia1,
          direccionReferencia2: state.direccionReferencia2,
          direccionReferencia3: state.direccionReferencia3,
          lugarTrabajoReferencia1: state.lugarTrabajoReferencia1,
          lugarTrabajoReferencia2: state.lugarTrabajoReferencia2,
          lugarTrabajoReferencia3: state.lugarTrabajoReferencia3,
          telefonoReferencia1: state.telefonoReferencia1,
          telefonoReferencia2: state.telefonoReferencia2,
          telefonoReferencia3: state.telefonoReferencia3,
          parentescoReferenciaCodigo1: state.parentescoReferenciaCodigo1,
          parentescoReferenciaCodigo2: state.parentescoReferenciaCodigo2,
          parentescoReferenciaCodigo3: state.parentescoReferenciaCodigo3,
          margenBrutoNegocio: margenBrutoNegocioCalc,
          disponidadFamiliar: saldoDisponibleUnidadFamiliarCalc,
          dppPorcentaje: double.tryParse(relacionMinRazonCuota?.valor ?? '') ?? 0,
          dpp: relacionMinRazonCuotaCalc,
          nombreInstitucionLicencia: state.nombreInstitucionLicencia,
          nombreInstitucionMatricula: state.nombreInstitucionMatricula,
          nombreInstitucionRuc: state.nombreInstitucionRuc,
          nombreReferencia1: state.nombreReferencia1,
          nombreReferencia2: state.nombreReferencia2,
          nombreReferencia3: state.nombreReferencia3,
          numeroLicencia: state.numeroLicencia,
          numeroMatricula: state.numeroMatricula,
          numeroRuc: state.numeroRuc,
          objEmpleadoVerificaReferenciaId3:
              state.objEmpleadoVerificaReferenciaId3,
          objEmpleadoVerificaReferenciaId2:
              state.objEmpleadoVerificaReferenciaId2,
          objEmpleadoVerificaReferenciaId1:
              state.objEmpleadoVerificaReferenciaId1,
          permisoOperacionNombreInstitucion:
              state.permisoOperacionNombreInstitucion,
          recuperaciones: state.recuperaciones,
          permisoOperacionNumero: state.permisoOperacionNumero,
          totalIngresos: totalIngresosCalc,
          fechaEmisionRuc: DateTime.tryParse(state.fechaEmisionRuc),
          fechaVencimientoRuc: DateTime.tryParse(state.fechaVencimientoRuc),
          fechaEmisionMatricula: DateTime.tryParse(state.fechaEmisionMatricula),
          fechaVencimientoMatricula:
              DateTime.tryParse(state.fechaVencimientoMatricula),
          fechaEmisionLicencia: DateTime.tryParse(state.fechaEmisionLicencia),
          fechaVencimientoLicencia:
              DateTime.tryParse(state.fechaVencimientoLicencia),
          permisoOperacionFechaEmision:
              DateTime.tryParse(state.permisoOperacionFechaEmision),
          permisoOperacionFechaVencimiento:
              DateTime.tryParse(state.permisoOperacionFechaVencimiento),
          fechaVerificacion1: state.fechaVerificacion1.isEmpty
              ? DateTime.now()
              : DateTime.parse(state.fechaVerificacion1),
          fechaVerificacion2: state.fechaVerificacion2.isEmpty
              ? DateTime.now()
              : DateTime.parse(state.fechaVerificacion2),
          fechaVerificacion3: DateTime.tryParse(state.fechaVerificacion3),
        ),
      );
      emit(state.copyWith(status: Status.done));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  void initAutoSave({String? uuid, required int numeroSolicitud}) {
    final newUuid = uuid ?? state.uuid ?? const Uuid().v4();
    final localDbProvider = global<AnalisisBoxServiceHn>();

    emit(state.copyWith(uuid: newUuid, numeroSolicitud: numeroSolicitud));

    autoSaveHelper = NuevaMenorMilAutosaveHN(
      box: localDbProvider.analisisNuevaMenorMilHnLocalDb,
      buildModel: _buildModel,
      uuid: newUuid,
      numeroSolicitud: numeroSolicitud,
      onSaved: (m) {
        emit(state.copyWith(
          idLocalResponse: m.id,
          uuid: m.uuid,
          numeroSolicitud: m.numeroSolicitud,
        ));
      },
    );
  }

  NuevaMenorMilLocalDb _buildModel(
    NuevaMenorMilLocalDb? existing,
  ) {
    final prev = existing;

    return NuevaMenorMilLocalDb(
      id: prev?.id ?? 0,
      uuid: prev?.uuid ?? state.uuid ?? const Uuid().v4(),
      cedulaReferencia1: state.cedulaReferencia1,
      cedulaReferencia2: state.cedulaReferencia2,
      cedulaReferencia3: state.cedulaReferencia3,
      cliente1: state.cliente1,
      cliente2: state.cliente2,
      cliente3: state.cliente3,
      proveedor1: state.proveedor1,
      proveedor2: state.proveedor2,
      proveedor3: state.proveedor3,
      fechaVerificacion1: DateTime.tryParse(state.fechaVerificacion1),
      nombreReferencia1: state.nombreReferencia1,
      direccionReferencia1: state.direccionReferencia1,
      telefonoReferencia1: state.telefonoReferencia1,
      lugarTrabajoReferencia1: state.lugarTrabajoReferencia1,
      direccionReferencia2: state.direccionReferencia2,
      telefonoReferencia2: state.telefonoReferencia2,
      lugarTrabajoReferencia2: state.lugarTrabajoReferencia2,
      direccionReferencia3: state.direccionReferencia3,
      telefonoReferencia3: state.telefonoReferencia3,
      lugarTrabajoReferencia3: state.lugarTrabajoReferencia3,
      resultadoVerificacion1: state.resultadoVerificacion1,
      parentescoReferenciaCodigo1: state.parentescoReferenciaCodigo1,
      nombreInstitucionLicencia: state.nombreInstitucionLicencia,
      fechaEmisionLicencia: DateTime.tryParse(state.fechaEmisionLicencia),
      fechaVencimientoLicencia:
          DateTime.tryParse(state.fechaVencimientoLicencia),
      numeroLicencia: state.numeroLicencia,
      nombreInstitucionMatricula: state.nombreInstitucionMatricula,
      fechaEmisionMatricula: DateTime.tryParse(state.fechaEmisionMatricula),
      fechaVencimientoMatricula:
          DateTime.tryParse(state.fechaVencimientoMatricula),
      numeroMatricula: state.numeroMatricula,
      nombreInstitucionRuc: state.nombreInstitucionRuc,
      numeroRuc: state.numeroRuc,
      fechaEmisionRuc: DateTime.tryParse(state.fechaEmisionRuc),
      fechaVencimientoRuc: DateTime.tryParse(state.fechaVencimientoRuc),
      permisoOperacionNumero: state.permisoOperacionNumero,
      permisoOperacionNombreInstitucion:
          state.permisoOperacionNombreInstitucion,
      permisoOperacionFechaEmision:
          DateTime.tryParse(state.permisoOperacionFechaEmision),
      permisoOperacionFechaVencimiento:
          DateTime.tryParse(state.permisoOperacionFechaVencimiento),
      numeroSolicitud: state.numeroSolicitud,
      caja: state.caja,
      banco: state.banco,
      cuentasXCobrar: state.cuentasXCobrar,
      inventario: state.inventario,
      otrosActivos: state.otrosActivos,
      totalAc: state.totalAc,
      activoFijo: state.activoFijo,
      totalActivo: state.totalActivo,
      proveedores: state.proveedores,
      cuentasXPagar: state.cuentasXPagar,
      otrasDeudas: state.otrasDeudas,
      totalPasivo: state.totalPasivo,
      capital: state.capital,
      pasivoCapital: state.pasivoCapital,
      ventasContado: state.ventasContado,
      recuperaciones: state.recuperaciones,
      otrosIngresos: state.otrosIngresos,
      gastosUnidadFamiliar: state.gastosUnidadFamiliar,
      totalIngresos: state.totalIngresos,
      costoVentaPorcentaje: state.costoVentaPorcentaje,
      costoVenta: state.costoVenta,
      gastosOperativos: state.gastosOperativos,
      margenBrutoNegocio: state.margenBrutoNegocio,
      disponidadFamiliar: state.disponidadFamiliar,
      dppPorcentaje: state.dppPorcentaje,
      dpp: state.dpp,
      nombreReferencia2: state.nombreReferencia2,
      nombreReferencia3: state.nombreReferencia3,
      parentescoReferenciaCodigo2: state.parentescoReferenciaCodigo2,
      parentescoReferenciaCodigo3: state.parentescoReferenciaCodigo3,
      aniosConocerReferido2: state.aniosConocerReferido2,
      aniosConocerReferido3: state.aniosConocerReferido3,
      resultadoVerificacion2: state.resultadoVerificacion2,
      resultadoVerificacion3: state.resultadoVerificacion3,
      aniosConocerReferido1: state.aniosConocerReferido1,
      fechaVerificacion2: DateTime.tryParse(state.fechaVerificacion2),
      fechaVerificacion3: DateTime.tryParse(state.fechaVerificacion3),
      ingresoAnual: state.ingresoAnual,
      objEmpleadoVerificaReferenciaId1: state.objEmpleadoVerificaReferenciaId1,
      objEmpleadoVerificaReferenciaId2: state.objEmpleadoVerificaReferenciaId2,
      objEmpleadoVerificaReferenciaId3: state.objEmpleadoVerificaReferenciaId3,
    );
  }

  void onFieldChanged(AnalisisMenorMilNiState Function() copyWithFn) {
    emit(copyWithFn());
    autoSaveHelper.trigger();
  }

  /// Limpia la referencia adicional cuando el asesor la quita, para que no se
  /// envíe ni quede en el borrador.
  void quitarReferencia3() {
    onFieldChanged(
      () => state.copyWith(
        nombreReferencia3: '',
        cedulaReferencia3: '',
        direccionReferencia3: '',
        telefonoReferencia3: '',
        lugarTrabajoReferencia3: '',
        aniosConocerReferido3: 0,
        parentescoReferenciaCodigo3: '',
        resultadoVerificacion3: '',
        objEmpleadoVerificaReferenciaId3: '',
        fechaVerificacion3: '',
      ),
    );
  }

  void loadFromLocalDb(NuevaMenorMilLocalDb? solicitud) {
    onFieldChanged(
      () => state.copyWith(
        activoFijo: solicitud?.activoFijo,
        aniosConocerReferido1: solicitud?.aniosConocerReferido1,
        aniosConocerReferido2: solicitud?.aniosConocerReferido2,
        aniosConocerReferido3: solicitud?.aniosConocerReferido3,
        banco: solicitud?.banco,
        caja: solicitud?.caja,
        cedulaReferencia1: solicitud?.cedulaReferencia1,
        cedulaReferencia2: solicitud?.cedulaReferencia2,
        cedulaReferencia3: solicitud?.cedulaReferencia3,
        cliente1: solicitud?.cliente1,
        cliente2: solicitud?.cliente2,
        cliente3: solicitud?.cliente3,
        capital: solicitud?.capital,
        costoVenta: solicitud?.costoVenta,
        cuentasXCobrar: solicitud?.cuentasXCobrar,
        costoVentaPorcentaje: solicitud?.costoVentaPorcentaje,
        cuentasXPagar: solicitud?.cuentasXPagar,
        direccionReferencia1: solicitud?.direccionReferencia1,
        direccionReferencia2: solicitud?.direccionReferencia2,
        direccionReferencia3: solicitud?.direccionReferencia3,
        disponidadFamiliar: solicitud?.disponidadFamiliar,
        dpp: solicitud?.dpp,
        dppPorcentaje: solicitud?.dppPorcentaje,
        fechaEmisionLicencia:
            solicitud?.fechaEmisionLicencia?.toIso8601String(),
        fechaVencimientoLicencia:
            solicitud?.fechaVencimientoLicencia?.toIso8601String(),
        fechaVerificacion1: solicitud?.fechaVerificacion1?.toIso8601String(),
        fechaVerificacion2: solicitud?.fechaVerificacion2?.toIso8601String(),
        fechaVerificacion3: solicitud?.fechaVerificacion3?.toIso8601String(),
        gastosOperativos: solicitud?.gastosOperativos,
        gastosUnidadFamiliar: solicitud?.gastosUnidadFamiliar,
        fechaEmisionMatricula:
            solicitud?.fechaEmisionMatricula?.toIso8601String(),
        fechaVencimientoMatricula:
            solicitud?.fechaVencimientoMatricula?.toIso8601String(),
        fechaEmisionRuc: solicitud?.fechaEmisionRuc?.toIso8601String(),
        fechaVencimientoRuc: solicitud?.fechaVencimientoRuc?.toIso8601String(),
        ingresoAnual: solicitud?.ingresoAnual,
        inventario: solicitud?.inventario,
        lugarTrabajoReferencia1: solicitud?.lugarTrabajoReferencia1,
        lugarTrabajoReferencia2: solicitud?.lugarTrabajoReferencia2,
        lugarTrabajoReferencia3: solicitud?.lugarTrabajoReferencia3,
        nombreInstitucionLicencia: solicitud?.nombreInstitucionLicencia,
        nombreInstitucionMatricula: solicitud?.nombreInstitucionMatricula,
        nombreInstitucionRuc: solicitud?.nombreInstitucionRuc,
        nombreReferencia1: solicitud?.nombreReferencia1,
        nombreReferencia2: solicitud?.nombreReferencia2,
        nombreReferencia3: solicitud?.nombreReferencia3,
        numeroMatricula: solicitud?.numeroMatricula,
        numeroLicencia: solicitud?.numeroLicencia,
        numeroRuc: solicitud?.numeroRuc,
        margenBrutoNegocio: solicitud?.margenBrutoNegocio,
        objEmpleadoVerificaReferenciaId1:
            solicitud?.objEmpleadoVerificaReferenciaId1,
        objEmpleadoVerificaReferenciaId2:
            solicitud?.objEmpleadoVerificaReferenciaId2,
        objEmpleadoVerificaReferenciaId3:
            solicitud?.objEmpleadoVerificaReferenciaId3,
        otrosIngresos: solicitud?.otrosIngresos,
        otrasDeudas: solicitud?.otrasDeudas,
        otrosActivos: solicitud?.otrosActivos,
        parentescoReferenciaCodigo1: solicitud?.parentescoReferenciaCodigo1,
        parentescoReferenciaCodigo2: solicitud?.parentescoReferenciaCodigo2,
        parentescoReferenciaCodigo3: solicitud?.parentescoReferenciaCodigo3,
        numeroSolicitud: solicitud?.numeroSolicitud,
        permisoOperacionNumero: solicitud?.permisoOperacionNumero,
        permisoOperacionNombreInstitucion:
            solicitud?.permisoOperacionNombreInstitucion,
        permisoOperacionFechaEmision:
            solicitud?.permisoOperacionFechaEmision?.toIso8601String(),
        permisoOperacionFechaVencimiento:
            solicitud?.permisoOperacionFechaVencimiento?.toIso8601String(),
        proveedores: solicitud?.proveedores,
        proveedor1: solicitud?.proveedor1,
        proveedor2: solicitud?.proveedor2,
        proveedor3: solicitud?.proveedor3,
        recuperaciones: solicitud?.recuperaciones,
        pasivoCapital: solicitud?.pasivoCapital,
        resultadoVerificacion1: solicitud?.resultadoVerificacion1,
        resultadoVerificacion2: solicitud?.resultadoVerificacion2,
        resultadoVerificacion3: solicitud?.resultadoVerificacion3,
        telefonoReferencia1: solicitud?.telefonoReferencia1,
        telefonoReferencia2: solicitud?.telefonoReferencia2,
        telefonoReferencia3: solicitud?.telefonoReferencia3,
        totalAc: solicitud?.totalAc,
        totalIngresos: solicitud?.totalIngresos,
        totalPasivo: solicitud?.totalPasivo,
        totalActivo: solicitud?.totalActivo,
        ventasContado: solicitud?.ventasContado,
      ),
    );
  }

  void loadInventarioFromLocalDb({
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();

    // Traer todos los registros de la base local
    final inventarioDb = localDbProvider.analisisInventarioHnLocalDb
        .query(AnalisisInventarioHnLocalDb_.numeroSolicitud
            .equals(numeroSolicitud))
        .build()
        .find();

    // Convertirlos a tu modelo del state si hace falta
    final inventarioList = inventarioDb
        .map((c) => InventarioHN(
              cantidad: c.cantidad ?? 0,
              articulo: c.articulo ?? '',
              costoCompra: c.costoCompra ?? 0,
              precioVenta: c.precioVenta ?? 0,
              costoVentaPorcentaje: c.costoVentaPorcentaje ?? 0,
              total: c.total ?? 0,
              uuid: c.uuid ?? '',
            ))
        .toList();

    // Actualizar el state
    emit(state.copyWith(
      inventarioHn: inventarioList,
    ));
  }

  saveInventario({
    required InventarioHN inventario,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    localDbProvider.analisisInventarioHnLocalDb.put(
      AnalisisInventarioHnLocalDb(
        articulo: inventario.articulo,
        costoCompra: inventario.costoCompra,
        precioVenta: inventario.precioVenta,
        cantidad: inventario.cantidad,
        costoVentaPorcentaje: inventario.costoVentaPorcentaje,
        total: inventario.total,
        numeroSolicitud: numeroSolicitud,
        uuid: inventario.uuid,
      ),
    );
    emit(
      state.copyWith(
        inventarioHn: [
          ...state.inventarioHn,
          inventario,
        ],
      ),
    );
  }

  void updateInventario({
    required AnalisisInventarioHnLocalDb inventario,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final box = localDbProvider.analisisInventarioHnLocalDb;

    // 1. Buscar registro existente en la base local
    final query = box
        .query(
          AnalisisInventarioHnLocalDb_.uuid.equals(inventario.uuid!) &
              AnalisisInventarioHnLocalDb_.numeroSolicitud
                  .equals(numeroSolicitud),
        )
        .build();

    final existente = query.findFirst();
    query.close();

    if (existente == null) {
      // No existe → no hay nada que actualizar
      return;
    }

    // 2. Actualizar campos
    existente
      ..articulo = inventario.articulo
      ..cantidad = inventario.cantidad
      ..costoCompra = inventario.costoCompra
      ..precioVenta = inventario.precioVenta
      ..costoVentaPorcentaje = inventario.costoVentaPorcentaje
      ..total = inventario.total;

    // 3. Guardar UPDATE en ObjectBox
    box.put(existente);

    final comprasPorProveedorList = InventarioHN(
      cantidad: inventario.cantidad ?? 0,
      articulo: inventario.articulo ?? '',
      costoCompra: inventario.costoCompra ?? 0,
      precioVenta: inventario.precioVenta ?? 0,
      costoVentaPorcentaje: inventario.costoVentaPorcentaje ?? 0,
      total: inventario.total ?? 0,
      uuid: inventario.uuid ?? '',
    );

    // 4. Actualizar lista en el estado usando tu línea preferida
    emit(
      state.copyWith(
        inventarioHn: state.inventarioHn
            .map((e) => e.uuid == inventario.uuid ? comprasPorProveedorList : e)
            .toList(),
      ),
    );
  }

  void deleteInventario({
    required String uuid,
    required int numeroSolicitud,
  }) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final box = localDbProvider.analisisInventarioHnLocalDb;

    // 1. Buscar el registro por uuid + solicitud
    final query = box
        .query(
          AnalisisInventarioHnLocalDb_.uuid.equals(uuid) &
              AnalisisInventarioHnLocalDb_.numeroSolicitud
                  .equals(numeroSolicitud),
        )
        .build();

    final existente = query.findFirst();
    query.close();

    if (existente == null) {
      // No hay nada que borrar
      return;
    }

    // 2. Eliminarlo por ID
    box.remove(existente.id);

    // 3. Eliminar también del estado
    emit(
      state.copyWith(
        inventarioHn: state.inventarioHn.where((e) => e.uuid != uuid).toList(),
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/objectbox.g.dart';
import 'package:core_financiero_app/src/config/helpers/autosave/analisis/analisis_menor_mil_hn_autosave.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_menor_mil.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/nueva_menor_mil/nueva_menor_mil_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/shared/analisis_inventario_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/utils/extensions/double/double_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'analisis_menor_mil_state.dart';

class AnalisisMenorMilCubit extends Cubit<AnalisisMenorMilState> {
  final AnalisisRepositoryHn _repository;
  late final NuevaMenorMilAutosaveHN autoSaveHelper;

  AnalisisMenorMilCubit(this._repository) : super(AnalisisMenorMilInitial());

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

    final costoPorcentajeVenta = state.inventarioHn.fold(
            0.0,
            (sum, element) =>
                sum +
                (num.tryParse(element.costoVentaPorcentaje.toSafeString(2)) ??
                    0)) /
        (state.inventarioHn.length);

    final relacionMaxRazonCuotaParam = switch (tipoSolicitud) {
      AnalisisSolicitudesInterceptorType.nueva =>
        'RELACIONMAXRAZONCUOTACREDITONUEVO',
      AnalisisSolicitudesInterceptorType.represtamo =>
        'RELACIONMAXRAZONCUOTACREDITOREPRESTAMO',
      _ => throw Exception('Tipo de solicitud no soportado $tipoSolicitud'),
    };

    final relacionMinRazonCuota = global<SolicitudesHnBoxService>()
        .getParametroByName(nombre: relacionMaxRazonCuotaParam);
    emit(state.copyWith(status: Status.inProgress));

    final costoVentaCalc =
        totalIngresosCalc * double.parse(costoPorcentajeVenta.toSafeString(2));

    final margenBrutoNegocioCalc =
        totalIngresosCalc - costoVentaCalc - state.gastosOperativos;

    final saldoDisponibleUnidadFamiliarCalc = margenBrutoNegocioCalc +
        state.otrosIngresos -
        state.gastosUnidadFamiliar;

    final relacionMinRazonCuotaPercent =
        (int.tryParse(relacionMinRazonCuota?.valor ?? '0') ?? 0) / 100;
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
          costoVentaPorcentaje: costoPorcentajeVenta,
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
          dppPorcentaje: double.parse(relacionMinRazonCuota?.valor ?? '0'),
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
      cedulaReferencia1:
          _prefer(state.cedulaReferencia1, prev?.cedulaReferencia1),
      cedulaReferencia2:
          _prefer(state.cedulaReferencia2, prev?.cedulaReferencia2),
      cedulaReferencia3:
          _prefer(state.cedulaReferencia3, prev?.cedulaReferencia3),
      cliente1: _prefer(state.cliente1, prev?.cliente1),
      cliente2: _prefer(state.cliente2, prev?.cliente2),
      cliente3: _prefer(state.cliente3, prev?.cliente3),
      proveedor1: _prefer(state.proveedor1, prev?.proveedor1),
      proveedor2: _prefer(state.proveedor2, prev?.proveedor2),
      proveedor3: _prefer(state.proveedor3, prev?.proveedor3),
      fechaVerificacion1:
          _preferDate(state.fechaVerificacion1, prev?.fechaVerificacion1),
      nombreReferencia1:
          _prefer(state.nombreReferencia1, prev?.nombreReferencia1),
      direccionReferencia1:
          _prefer(state.direccionReferencia1, prev?.direccionReferencia1),
      telefonoReferencia1:
          _prefer(state.telefonoReferencia1, prev?.telefonoReferencia1),
      lugarTrabajoReferencia1:
          _prefer(state.lugarTrabajoReferencia1, prev?.lugarTrabajoReferencia1),
      direccionReferencia2:
          _prefer(state.direccionReferencia2, prev?.direccionReferencia2),
      telefonoReferencia2:
          _prefer(state.telefonoReferencia2, prev?.telefonoReferencia2),
      lugarTrabajoReferencia2:
          _prefer(state.lugarTrabajoReferencia2, prev?.lugarTrabajoReferencia2),
      direccionReferencia3:
          _prefer(state.direccionReferencia3, prev?.direccionReferencia3),
      telefonoReferencia3:
          _prefer(state.telefonoReferencia3, prev?.telefonoReferencia3),
      lugarTrabajoReferencia3:
          _prefer(state.lugarTrabajoReferencia3, prev?.lugarTrabajoReferencia3),
      resultadoVerificacion1:
          _prefer(state.resultadoVerificacion1, prev?.resultadoVerificacion1),
      parentescoReferenciaCodigo1: _prefer(
          state.parentescoReferenciaCodigo1, prev?.parentescoReferenciaCodigo1),
      nombreInstitucionLicencia: _prefer(
          state.nombreInstitucionLicencia, prev?.nombreInstitucionLicencia),
      fechaEmisionLicencia:
          _preferDate(state.fechaEmisionLicencia, prev?.fechaEmisionLicencia),
      fechaVencimientoLicencia: _preferDate(
          state.fechaVencimientoLicencia, prev?.fechaVencimientoLicencia),
      numeroLicencia: _prefer(state.numeroLicencia, prev?.numeroLicencia),
      nombreInstitucionMatricula: _prefer(
          state.nombreInstitucionMatricula, prev?.nombreInstitucionMatricula),
      fechaEmisionMatricula:
          _preferDate(state.fechaEmisionMatricula, prev?.fechaEmisionMatricula),
      fechaVencimientoMatricula: _preferDate(
          state.fechaVencimientoMatricula, prev?.fechaVencimientoMatricula),
      numeroMatricula: _prefer(state.numeroMatricula, prev?.numeroMatricula),
      nombreInstitucionRuc:
          _prefer(state.nombreInstitucionRuc, prev?.nombreInstitucionRuc),
      numeroRuc: _prefer(state.numeroRuc, prev?.numeroRuc),
      fechaEmisionRuc:
          _preferDate(state.fechaEmisionRuc, prev?.fechaEmisionRuc),
      fechaVencimientoRuc:
          _preferDate(state.fechaVencimientoRuc, prev?.fechaVencimientoRuc),
      permisoOperacionNumero:
          _prefer(state.permisoOperacionNumero, prev?.permisoOperacionNumero),
      permisoOperacionNombreInstitucion: _prefer(
          state.permisoOperacionNombreInstitucion,
          prev?.permisoOperacionNombreInstitucion),
      permisoOperacionFechaEmision: _preferDate(
          state.permisoOperacionFechaEmision,
          prev?.permisoOperacionFechaEmision),
      permisoOperacionFechaVencimiento: _preferDate(
          state.permisoOperacionFechaVencimiento,
          prev?.permisoOperacionFechaVencimiento),
      numeroSolicitud: state.numeroSolicitud == 0
          ? (prev?.numeroSolicitud ?? 0)
          : state.numeroSolicitud,
      caja: state.caja == 0 ? (prev?.caja ?? 0) : state.caja,
      banco: state.banco == 0 ? (prev?.banco ?? 0) : state.banco,
      cuentasXCobrar: state.cuentasXCobrar == 0
          ? (prev?.cuentasXCobrar ?? 0)
          : state.cuentasXCobrar,
      inventario:
          state.inventario == 0 ? (prev?.inventario ?? 0) : state.inventario,
      otrosActivos: state.otrosActivos == 0
          ? (prev?.otrosActivos ?? 0)
          : state.otrosActivos,
      totalAc: state.totalAc == 0 ? (prev?.totalAc ?? 0) : state.totalAc,
      activoFijo:
          state.activoFijo == 0 ? (prev?.activoFijo ?? 0) : state.activoFijo,
      totalActivo:
          state.totalActivo == 0 ? (prev?.totalActivo ?? 0) : state.totalActivo,
      proveedores:
          state.proveedores == 0 ? (prev?.proveedores ?? 0) : state.proveedores,
      cuentasXPagar: state.cuentasXPagar == 0
          ? (prev?.cuentasXPagar ?? 0)
          : state.cuentasXPagar,
      otrasDeudas:
          state.otrasDeudas == 0 ? (prev?.otrasDeudas ?? 0) : state.otrasDeudas,
      totalPasivo:
          state.totalPasivo == 0 ? (prev?.totalPasivo ?? 0) : state.totalPasivo,
      capital: state.capital == 0 ? (prev?.capital ?? 0) : state.capital,
      pasivoCapital: state.pasivoCapital == 0
          ? (prev?.pasivoCapital ?? 0)
          : state.pasivoCapital,
      ventasContado: state.ventasContado == 0
          ? (prev?.ventasContado ?? 0)
          : state.ventasContado,
      recuperaciones: state.recuperaciones == 0
          ? (prev?.recuperaciones ?? 0)
          : state.recuperaciones,
      otrosIngresos: state.otrosIngresos == 0
          ? (prev?.otrosIngresos ?? 0)
          : state.otrosIngresos,
      gastosUnidadFamiliar: state.gastosUnidadFamiliar == 0
          ? (prev?.gastosUnidadFamiliar ?? 0)
          : state.gastosUnidadFamiliar,
      totalIngresos: state.totalIngresos == 0
          ? (prev?.totalIngresos ?? 0)
          : state.totalIngresos,
      costoVentaPorcentaje: state.costoVentaPorcentaje == 0
          ? (prev?.costoVentaPorcentaje ?? 0)
          : state.costoVentaPorcentaje,
      costoVenta:
          state.costoVenta == 0 ? (prev?.costoVenta ?? 0) : state.costoVenta,
      gastosOperativos: state.gastosOperativos == 0
          ? (prev?.gastosOperativos ?? 0)
          : state.gastosOperativos,
      margenBrutoNegocio: state.margenBrutoNegocio == 0
          ? (prev?.margenBrutoNegocio ?? 0)
          : state.margenBrutoNegocio,
      disponidadFamiliar: state.disponidadFamiliar == 0
          ? (prev?.disponidadFamiliar ?? 0)
          : state.disponidadFamiliar,
      dppPorcentaje: state.dppPorcentaje == 0
          ? (prev?.dppPorcentaje ?? 0)
          : state.dppPorcentaje,
      dpp: state.dpp == 0 ? (prev?.dpp ?? 0) : state.dpp,
      nombreReferencia2:
          _prefer(state.nombreReferencia2, prev?.nombreReferencia2),
      nombreReferencia3:
          _prefer(state.nombreReferencia3, prev?.nombreReferencia3),
      parentescoReferenciaCodigo2: _prefer(
          state.parentescoReferenciaCodigo2, prev?.parentescoReferenciaCodigo2),
      parentescoReferenciaCodigo3: _prefer(
          state.parentescoReferenciaCodigo3, prev?.parentescoReferenciaCodigo3),
      aniosConocerReferido2: state.aniosConocerReferido2 == 0
          ? (prev?.aniosConocerReferido2 ?? 0)
          : state.aniosConocerReferido2,
      aniosConocerReferido3: state.aniosConocerReferido3 == 0
          ? (prev?.aniosConocerReferido3 ?? 0)
          : state.aniosConocerReferido3,
      resultadoVerificacion2:
          _prefer(state.resultadoVerificacion2, prev?.resultadoVerificacion2),
      resultadoVerificacion3:
          _prefer(state.resultadoVerificacion3, prev?.resultadoVerificacion3),
      aniosConocerReferido1: state.aniosConocerReferido1 == 0
          ? (prev?.aniosConocerReferido1 ?? 0)
          : state.aniosConocerReferido1,
      fechaVerificacion2:
          _preferDate(state.fechaVerificacion2, prev?.fechaVerificacion2),
      fechaVerificacion3:
          _preferDate(state.fechaVerificacion3, prev?.fechaVerificacion3),
      ingresoAnual: state.ingresoAnual == 0
          ? (prev?.ingresoAnual ?? 0)
          : state.ingresoAnual,
      objEmpleadoVerificaReferenciaId1: _prefer(
          state.objEmpleadoVerificaReferenciaId1,
          prev?.objEmpleadoVerificaReferenciaId1),
      objEmpleadoVerificaReferenciaId2: _prefer(
          state.objEmpleadoVerificaReferenciaId2,
          prev?.objEmpleadoVerificaReferenciaId2),
      objEmpleadoVerificaReferenciaId3: _prefer(
        state.objEmpleadoVerificaReferenciaId3,
        prev?.objEmpleadoVerificaReferenciaId3,
      ),
    );
  }

  void onFieldChanged(AnalisisMenorMilState Function() copyWithFn) {
    emit(copyWithFn());
    autoSaveHelper.trigger();
  }

  String _prefer(String? current, String? previous) =>
      current?.isNotEmpty == true ? current! : previous ?? '';

  DateTime? _preferDate(String? current, DateTime? previous) {
    final parsed = DateTime.tryParse(current ?? '');
    return parsed ?? previous;
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

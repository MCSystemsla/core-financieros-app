import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/get_data_analisis_menor_mil.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'get_analisis_menor_mil_data_state.dart';

class GetAnalisisMenorMilDataCubit extends Cubit<GetAnalisisMenorMilDataState> {
  final AnalisisRepositoryHn _repository;
  GetAnalisisMenorMilDataCubit(this._repository)
      : super(GetAnalisisMenorMilDataInitial());

  Future<void> getAnalisisMenorMilData({
    required String numeroSolicitud,
    required String tipoSolicitud,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.getAnalisisDataNuevaMenorMil(
        numeroSolicitud: numeroSolicitud,
        tipoSolicitud: tipoSolicitud,
      );
      emit(state.copyWith(
        status: Status.done,
        database: resp.database,
        caja: resp.caja,
        costoVenta: resp.costoVenta,
        gastosOperativos: resp.gastosOperativos,
        maquinaModificacion: resp.maquinaModificacion,
        otrosIngresos: resp.otrosIngresos,
        activoFijo: resp.activoFijo,
        banco: resp.banco,
        capital: resp.capital,
        disponidadFamiliar: resp.disponidadFamiliar,
        dpp: resp.dpp,
        dppPorcentaje: resp.dppPorcentaje,
        gastosUnidadFamiliar: resp.gastosUnidadFamiliar,
        inventario: resp.inventario,
        margenBrutoNegocio: resp.margenBrutoNegocio,
        otrasDeudas: resp.otrasDeudas,
        otrosActivos: resp.otrosActivos,
        pasivoCapital: resp.pasivoCapital,
        totalAc: resp.totalAc,
        ingresoAnual: resp.ingresoAnual,
        aniosConocerReferido1: resp.aniosConocerReferido1,
        aniosConocerReferido2: resp.aniosConocerReferido2,
        cuentasXCobrar: resp.cuentasXCobrar,
        cuentasXPagar: resp.cuentasXPagar,
        direccionReferencia1: resp.direccionReferencia1,
        direccionReferencia2: resp.direccionReferencia2,
        fechaVerificacion1: resp.fechaVerificacion1?.toIso8601String(),
        fechaVerificacion2: resp.fechaVerificacion2?.toIso8601String(),
        lugarTrabajoReferencia1: resp.lugarTrabajoReferencia1,
        lugarTrabajoReferencia2: resp.lugarTrabajoReferencia2,
        nombreReferencia1: resp.nombreReferencia1,
        nombreReferencia2: resp.nombreReferencia2,
        objEmpleadoVerificaReferenciaId1: resp.objEmpleadoVerificaReferenciaId1,
        objEmpleadoVerificaReferenciaId2: resp.objEmpleadoVerificaReferenciaId2,
        resultadoVerificacion1: resp.resultadoVerificacion1,
        resultadoVerificacion2: resp.resultadoVerificacion2,
        telefonoReferencia1: resp.telefonoReferencia1,
        telefonoReferencia2: resp.telefonoReferencia2,
        totalActivo: resp.totalActivo,
        totalIngresos: resp.totalIngresos,
        totalPasivo: resp.totalPasivo,
        proveedores: resp.proveedores,
        recuperaciones: resp.recuperaciones,
        ventasContado: resp.ventasContado,
        costoVentaPorcentaje: resp.costoVentaPorcentaje,
        aniosConocerReferido3: resp.aniosConocerReferido3,
        cedulaReferencia1: resp.cedulaReferencia1,
        cedulaReferencia2: resp.cedulaReferencia2,
        cedulaReferencia3: resp.cedulaReferencia3,
        direccionReferencia3: resp.direccionReferencia3,
        fechaVerificacion3: resp.fechaVerificacion3?.toIso8601String(),
        lugarTrabajoReferencia3: resp.lugarTrabajoReferencia3,
        nombreReferencia3: resp.nombreReferencia3,
        objEmpleadoVerificaReferenciaId3: resp.objEmpleadoVerificaReferenciaId3,
        resultadoVerificacion3: resp.resultadoVerificacion3,
        telefonoReferencia3: resp.telefonoReferencia3,
        fechaEmisionLicencia: resp.fechaEmisionLicencia?.toIso8601String(),
        fechaEmisionMatricula: resp.fechaEmisionMatricula?.toIso8601String(),
        fechaEmisionRuc: resp.fechaEmisionRuc?.toIso8601String(),
        fechaVencimientoLicencia:
            resp.fechaVencimientoLicencia?.toIso8601String(),
        fechaVencimientoMatricula:
            resp.fechaVencimientoMatricula?.toIso8601String(),
        fechaVencimientoRuc: resp.fechaVencimientoRuc?.toIso8601String(),
        nombreInstitucionLicencia: resp.nombreInstitucionLicencia,
        nombreInstitucionMatricula: resp.nombreInstitucionMatricula,
        nombreInstitucionRuc: resp.nombreInstitucionRuc,
        numeroLicencia: resp.numeroLicencia,
        numeroMatricula: resp.numeroMatricula,
        numeroRuc: resp.numeroRuc,
        permisoOperacionFechaEmision:
            resp.permisoOperacionFechaEmision?.toIso8601String(),
        permisoOperacionFechaVencimiento:
            resp.permisoOperacionFechaVencimiento?.toIso8601String(),
        permisoOperacionNombreInstitucion:
            resp.permisoOperacionNombreInstitucion,
        permisoOperacionNumero: resp.permisoOperacionNumero,
        parentescoReferenciaCodigo3: resp.parentescoReferenciaCodigo3,
        proveedor1: resp.proveedor1,
        proveedor2: resp.proveedor2,
        proveedor3: resp.proveedor3,
        cliente1: resp.cliente1,
        cliente2: resp.cliente2,
        cliente3: resp.cliente3,
        inventarioTb: resp.inventarioTb,
        parentescoReferenciaCodigo1: resp.parentescoReferenciaCodigo1,
        parentescoReferenciaCodigo2: resp.parentescoReferenciaCodigo2,
        usuarioModificacion: resp.usuarioModificacion,
        numeroSolicitud: resp.numeroSolicitud,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.optionalMsg,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMsg: e.toString(),
      ));
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/analisis/nuevamenor/analisis_nueva_menor.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/analisis_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:equatable/equatable.dart';

part 'analisis_solicitud_nueva_menor_state.dart';

class AnalisisSolicitudNuevaMenorCubit
    extends Cubit<AnalisisSolicitudNuevaMenorState> {
  AnalisisSolicitudNuevaMenorCubit(this._repository)
      : super(AnalisisSolicitudNuevaMenorInitial());
  final AnalisisRepository _repository;

  void createAnalisisSolicitudNuevaMenorCubit({
    required String numeroSolicitud,
  }) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, msg) = await _repository.createAnalisisSolicitudNuevaMenor(
        numeroSolicitud: numeroSolicitud,
        analisisSolicitudNuevaMenor: AnalisisNuevaMenorData(
          inventario: [],
          analisis: AnalisisNuevaMenor(
            caja: state.caja,
            banco: state.banco,
            cuentasXCobrar: state.cuentasXCobrar,
            cuentasXPagar: state.cuentasXPagar,
            fechaAnalisis: DateTime.tryParse(state.fechaAnalisis),
            numeroSolicitud: state.numeroSolicitud,
            otrosActivos: state.otrosActivos,
            totalAc: state.totalAc,
            activoFijo: state.activoFijo,
            totalActivo: state.totalActivo,
            proveedores: state.proveedores,
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
            numeroRuc: state.numeroRuc,
            nombreInstitucionRuc: state.nombreInstitucionRuc,
            fechaEmisionRuc: DateTime.tryParse(state.fechaEmisionRuc),
            fechaVencimientoRuc: DateTime.tryParse(state.fechaVencimientoRuc),
            numeroMatricula: state.numeroMatricula,
            nombreInstitucionMatricula: state.nombreInstitucionMatricula,
            fechaEmisionMatricula:
                DateTime.tryParse(state.fechaEmisionMatricula),
            fechaVencimientoMatricula:
                DateTime.tryParse(state.fechaVencimientoMatricula),
            numeroLicencia: state.numeroLicencia,
            nombreInstitucionLicencia: state.nombreInstitucionLicencia,
            fechaEmisionLicencia: DateTime.tryParse(state.fechaEmisionLicencia),
            fechaVencimientoLicencia:
                DateTime.tryParse(state.fechaVencimientoLicencia),
            ingresoAnual: state.ingresoAnual,
            cliente1: state.cliente1,
            cliente2: state.cliente2,
            cliente3: state.cliente3,
            proveedor1: state.proveedor1,
            proveedor2: state.proveedor2,
            proveedor3: state.proveedor3,
            fechaVerificacion1: DateTime.tryParse(state.fechaVerificacion1),
            nombreReferencia1: state.nombreReferencia1,
            cedulaReferencia1: state.cedulaReferencia1,
            direccionReferencia1: state.direccionReferencia1,
            telefonoReferencia1: state.telefonoReferencia1,
            lugarTrabajoReferencia1: state.lugarTrabajoReferencia1,
            aniosConocerReferido1: state.aniosConocerReferido1,
            objParentescoIdReferencia1: state.objParentescoIdReferencia1,
            resultadoVerificacion1: state.resultadoVerificacion1,
            objEmpleadoVerificaReferenciaId1:
                state.objEmpleadoVerificaReferenciaId1,
            fechaVerificacion2: DateTime.tryParse(state.fechaVerificacion2),
            nombreReferencia2: state.nombreReferencia2,
            cedulaReferencia2: state.cedulaReferencia2,
            direccionReferencia2: state.direccionReferencia2,
            telefonoReferencia2: state.telefonoReferencia2,
            lugarTrabajoReferencia2: state.lugarTrabajoReferencia2,
            aniosConocerReferido2: state.aniosConocerReferido2,
            objParentescoIdReferencia2: state.objParentescoIdReferencia2,
            resultadoVerificacion2: state.resultadoVerificacion2,
            objEmpleadoVerificaReferenciaId2:
                state.objEmpleadoVerificaReferenciaId2,
            inventario: state.inventario,
          ),
        ),
      );
      if (!isOk) {
        emit(state.copyWith(status: Status.error, errorMessage: msg));
        return;
      }
      emit(state.copyWith(status: Status.done));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMessage: e.toString()));
    }
  }

  void initializeFields({
    required AnalisisSolicitudNuevaMenorResponse solicitud,
  }) {
    emit(
      state.copyWith(
        id: solicitud.data.analisis?.id,
        objSolicitudId: solicitud.data.analisis?.objSolicitudId,
        numeroSolicitud: solicitud.data.analisis?.numeroSolicitud,
        fechaAnalisis:
            solicitud.data.analisis?.fechaAnalisis?.toIso8601String(),
        caja: solicitud.data.analisis?.caja,
        banco: solicitud.data.analisis?.banco,
        cuentasXCobrar: solicitud.data.analisis?.cuentasXCobrar,
        inventario: solicitud.data.analisis?.inventario,
        otrosActivos: solicitud.data.analisis?.otrosActivos,
        totalAc: solicitud.data.analisis?.totalAc,
        activoFijo: solicitud.data.analisis?.activoFijo,
        totalActivo: solicitud.data.analisis?.totalActivo,
        proveedores: solicitud.data.analisis?.proveedores,
        cuentasXPagar: solicitud.data.analisis?.cuentasXPagar,
        otrasDeudas: solicitud.data.analisis?.otrasDeudas,
        totalPasivo: solicitud.data.analisis?.totalPasivo,
        capital: solicitud.data.analisis?.capital,
        pasivoCapital: solicitud.data.analisis?.pasivoCapital,
        ventasContado: solicitud.data.analisis?.ventasContado,
        recuperaciones: solicitud.data.analisis?.recuperaciones,
        otrosIngresos: solicitud.data.analisis?.otrosIngresos,
        gastosUnidadFamiliar: solicitud.data.analisis?.gastosUnidadFamiliar,
        totalIngresos: solicitud.data.analisis?.totalIngresos,
        costoVentaPorcentaje:
            solicitud.data.analisis?.costoVentaPorcentaje?.toDouble(),
        costoVenta: solicitud.data.analisis?.costoVenta,
        gastosOperativos: solicitud.data.analisis?.gastosOperativos,
        margenBrutoNegocio: solicitud.data.analisis?.margenBrutoNegocio,
        disponidadFamiliar: solicitud.data.analisis?.disponidadFamiliar,
        dppPorcentaje: solicitud.data.analisis?.dppPorcentaje,
        dpp: solicitud.data.analisis?.dpp?.toDouble(),
        numeroRuc: solicitud.data.analisis?.numeroRuc,
        nombreInstitucionRuc: solicitud.data.analisis?.nombreInstitucionRuc,
        fechaEmisionRuc:
            solicitud.data.analisis?.fechaEmisionRuc?.toIso8601String(),
        fechaVencimientoRuc:
            solicitud.data.analisis?.fechaVencimientoRuc?.toIso8601String(),
        numeroMatricula: solicitud.data.analisis?.numeroMatricula,
        nombreInstitucionMatricula:
            solicitud.data.analisis?.nombreInstitucionMatricula,
        fechaEmisionMatricula: solicitud.data.analisis?.fechaEmisionMatricula,
        fechaVencimientoMatricula:
            solicitud.data.analisis?.fechaVencimientoMatricula,
        numeroLicencia: solicitud.data.analisis?.numeroLicencia,
        nombreInstitucionLicencia:
            solicitud.data.analisis?.nombreInstitucionLicencia,
        fechaEmisionLicencia: solicitud.data.analisis?.fechaEmisionLicencia,
        fechaVencimientoLicencia:
            solicitud.data.analisis?.fechaVencimientoLicencia,
        ingresoAnual: solicitud.data.analisis?.ingresoAnual,
        cliente1: solicitud.data.analisis?.cliente1,
        cliente2: solicitud.data.analisis?.cliente2,
        cliente3: solicitud.data.analisis?.cliente3,
        proveedor1: solicitud.data.analisis?.proveedor1,
        proveedor2: solicitud.data.analisis?.proveedor2,
        proveedor3: solicitud.data.analisis?.proveedor3,
        fechaVerificacion1:
            solicitud.data.analisis?.fechaVerificacion1?.toIso8601String(),
        nombreReferencia1: solicitud.data.analisis?.nombreReferencia1,
        cedulaReferencia1: solicitud.data.analisis?.cedulaReferencia1,
        direccionReferencia1: solicitud.data.analisis?.direccionReferencia1,
        telefonoReferencia1: solicitud.data.analisis?.telefonoReferencia1,
        lugarTrabajoReferencia1:
            solicitud.data.analisis?.lugarTrabajoReferencia1,
        aniosConocerReferido1: solicitud.data.analisis?.aniosConocerReferido1,
        objParentescoIdReferencia1:
            solicitud.data.analisis?.objParentescoIdReferencia1,
        fechaVerificacion2:
            solicitud.data.analisis?.fechaVerificacion2?.toIso8601String(),
        nombreReferencia2: solicitud.data.analisis?.nombreReferencia2,
        cedulaReferencia2: solicitud.data.analisis?.cedulaReferencia2,
        direccionReferencia2: solicitud.data.analisis?.direccionReferencia2,
        telefonoReferencia2: solicitud.data.analisis?.telefonoReferencia2,
        lugarTrabajoReferencia2:
            solicitud.data.analisis?.lugarTrabajoReferencia2,
        aniosConocerReferido2: solicitud.data.analisis?.aniosConocerReferido2,
        objParentescoIdReferencia2:
            solicitud.data.analisis?.objParentescoIdReferencia2,
        objEmpleadoVerificaReferenciaId1:
            solicitud.data.analisis?.objEmpleadoVerificaReferenciaId1,
        objEmpleadoVerificaReferenciaId2:
            solicitud.data.analisis?.objEmpleadoVerificaReferenciaId2,
        resultadoVerificacion1: solicitud.data.analisis?.resultadoVerificacion1,
        resultadoVerificacion2: solicitud.data.analisis?.resultadoVerificacion2,
      ),
    );
  }

  void onFieldChanged(AnalisisSolicitudNuevaMenorState Function() copyWithFn) {
    emit(copyWithFn());
  }
}

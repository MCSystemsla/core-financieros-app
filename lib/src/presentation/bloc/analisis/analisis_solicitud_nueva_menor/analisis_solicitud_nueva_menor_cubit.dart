import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/analisis/nuevamenor/analisis_nueva_menor.dart';
import 'package:equatable/equatable.dart';

part 'analisis_solicitud_nueva_menor_state.dart';

class AnalisisSolicitudNuevaMenorCubit
    extends Cubit<AnalisisSolicitudNuevaMenorState> {
  AnalisisSolicitudNuevaMenorCubit()
      : super(AnalisisSolicitudNuevaMenorInitial());

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

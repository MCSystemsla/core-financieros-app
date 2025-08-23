// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_solicitud_nueva_menor_cubit.dart';

class AnalisisSolicitudNuevaMenorState extends Equatable {
  final Status status;
  final String errorMessage;
  final String id;
  final num objSolicitudId;
  final String numeroSolicitud;
  final String fechaAnalisis;
  final num caja;
  final num banco;
  final num cuentasXCobrar;
  final num inventario;
  final num otrosActivos;
  final num totalAc;
  final num activoFijo;
  final num totalActivo;
  final num proveedores;
  final num cuentasXPagar;
  final num otrasDeudas;
  final num totalPasivo;
  final num capital;
  final num pasivoCapital;
  final num ventasContado;
  final num recuperaciones;
  final num otrosIngresos;
  final num gastosUnidadFamiliar;
  final num totalIngresos;
  final double costoVentaPorcentaje;
  final num costoVenta;
  final num gastosOperativos;
  final num margenBrutoNegocio;
  final num disponidadFamiliar;
  final num dppPorcentaje;
  final double dpp;
  final String numeroRuc;
  final String nombreInstitucionRuc;
  final String fechaEmisionRuc;
  final String fechaVencimientoRuc;
  final String numeroMatricula;
  final String nombreInstitucionMatricula;
  final String fechaEmisionMatricula;
  final String fechaVencimientoMatricula;
  final String numeroLicencia;
  final String nombreInstitucionLicencia;
  final String fechaEmisionLicencia;
  final String fechaVencimientoLicencia;
  final num ingresoAnual;
  final String cliente1;
  final String cliente2;
  final String cliente3;
  final String proveedor1;
  final String proveedor2;
  final String proveedor3;
  final String fechaVerificacion1;
  final String nombreReferencia1;
  final String cedulaReferencia1;
  final String direccionReferencia1;
  final String telefonoReferencia1;
  final String lugarTrabajoReferencia1;
  final num aniosConocerReferido1;
  final num objParentescoIdReferencia1;
  final String resultadoVerificacion1;
  final String objEmpleadoVerificaReferenciaId1;
  final String fechaVerificacion2;
  final String nombreReferencia2;
  final String cedulaReferencia2;
  final String direccionReferencia2;
  final String telefonoReferencia2;
  final String lugarTrabajoReferencia2;
  final num aniosConocerReferido2;
  final num objParentescoIdReferencia2;
  final String resultadoVerificacion2;
  final String objEmpleadoVerificaReferenciaId2;
  const AnalisisSolicitudNuevaMenorState({
    this.status = Status.notStarted,
    this.errorMessage = '',
    this.id = '',
    this.objSolicitudId = 0,
    this.numeroSolicitud = '',
    this.fechaAnalisis = '',
    this.caja = 0,
    this.banco = 0,
    this.cuentasXCobrar = 0,
    this.inventario = 0,
    this.otrosActivos = 0,
    this.totalAc = 0,
    this.activoFijo = 0,
    this.totalActivo = 0,
    this.proveedores = 0,
    this.cuentasXPagar = 0,
    this.otrasDeudas = 0,
    this.totalPasivo = 0,
    this.capital = 0,
    this.pasivoCapital = 0,
    this.ventasContado = 0,
    this.recuperaciones = 0,
    this.otrosIngresos = 0,
    this.gastosUnidadFamiliar = 0,
    this.totalIngresos = 0,
    this.costoVentaPorcentaje = 0,
    this.costoVenta = 0,
    this.gastosOperativos = 0,
    this.margenBrutoNegocio = 0,
    this.disponidadFamiliar = 0,
    this.dppPorcentaje = 0,
    this.dpp = 0,
    this.numeroRuc = '',
    this.nombreInstitucionRuc = '',
    this.fechaEmisionRuc = '',
    this.fechaVencimientoRuc = '',
    this.numeroMatricula = '',
    this.nombreInstitucionMatricula = '',
    this.fechaEmisionMatricula = '',
    this.fechaVencimientoMatricula = '',
    this.numeroLicencia = '',
    this.nombreInstitucionLicencia = '',
    this.fechaEmisionLicencia = '',
    this.fechaVencimientoLicencia = '',
    this.ingresoAnual = 0,
    this.cliente1 = '',
    this.cliente2 = '',
    this.cliente3 = '',
    this.proveedor1 = '',
    this.proveedor2 = '',
    this.proveedor3 = '',
    this.fechaVerificacion1 = '',
    this.nombreReferencia1 = '',
    this.cedulaReferencia1 = '',
    this.direccionReferencia1 = '',
    this.telefonoReferencia1 = '',
    this.lugarTrabajoReferencia1 = '',
    this.aniosConocerReferido1 = 0,
    this.objParentescoIdReferencia1 = 0,
    this.resultadoVerificacion1 = '',
    this.objEmpleadoVerificaReferenciaId1 = '',
    this.fechaVerificacion2 = '',
    this.nombreReferencia2 = '',
    this.cedulaReferencia2 = '',
    this.direccionReferencia2 = '',
    this.telefonoReferencia2 = '',
    this.lugarTrabajoReferencia2 = '',
    this.aniosConocerReferido2 = 0,
    this.objParentescoIdReferencia2 = 0,
    this.resultadoVerificacion2 = '',
    this.objEmpleadoVerificaReferenciaId2 = '',
  });

  @override
  List<Object> get props => [
        status,
        errorMessage,
        id,
        objSolicitudId,
        numeroSolicitud,
        fechaAnalisis,
        caja,
        banco,
        cuentasXCobrar,
        inventario,
        otrosActivos,
        totalAc,
        activoFijo,
        totalActivo,
        proveedores,
        cuentasXPagar,
        otrasDeudas,
        totalPasivo,
        capital,
        pasivoCapital,
        ventasContado,
        recuperaciones,
        otrosIngresos,
        gastosUnidadFamiliar,
        totalIngresos,
        costoVentaPorcentaje,
        costoVenta,
        gastosOperativos,
        margenBrutoNegocio,
        disponidadFamiliar,
        dppPorcentaje,
        dpp,
        numeroRuc,
        nombreInstitucionRuc,
        fechaEmisionRuc,
        fechaVencimientoRuc,
        numeroMatricula,
        nombreInstitucionMatricula,
        fechaEmisionMatricula,
        fechaVencimientoMatricula,
        numeroLicencia,
        nombreInstitucionLicencia,
        fechaEmisionLicencia,
        fechaVencimientoLicencia,
        ingresoAnual,
        cliente1,
        cliente2,
        cliente3,
        proveedor1,
        proveedor2,
        proveedor3,
        fechaVerificacion1,
        nombreReferencia1,
        cedulaReferencia1,
        direccionReferencia1,
        telefonoReferencia1,
        lugarTrabajoReferencia1,
        aniosConocerReferido1,
        objParentescoIdReferencia1,
        resultadoVerificacion1,
        objEmpleadoVerificaReferenciaId1,
        fechaVerificacion2,
        nombreReferencia2,
        cedulaReferencia2,
        direccionReferencia2,
        telefonoReferencia2,
        lugarTrabajoReferencia2,
        aniosConocerReferido2,
        objParentescoIdReferencia2,
        resultadoVerificacion2,
        objEmpleadoVerificaReferenciaId2,
      ];

  AnalisisSolicitudNuevaMenorState copyWith({
    Status? status,
    String? errorMessage,
    String? id,
    num? objSolicitudId,
    String? numeroSolicitud,
    String? fechaAnalisis,
    num? caja,
    num? banco,
    num? cuentasXCobrar,
    num? inventario,
    num? otrosActivos,
    num? totalAc,
    num? activoFijo,
    num? totalActivo,
    num? proveedores,
    num? cuentasXPagar,
    num? otrasDeudas,
    num? totalPasivo,
    num? capital,
    num? pasivoCapital,
    num? ventasContado,
    num? recuperaciones,
    num? otrosIngresos,
    num? gastosUnidadFamiliar,
    num? totalIngresos,
    double? costoVentaPorcentaje,
    num? costoVenta,
    num? gastosOperativos,
    num? margenBrutoNegocio,
    num? disponidadFamiliar,
    num? dppPorcentaje,
    double? dpp,
    String? numeroRuc,
    String? nombreInstitucionRuc,
    String? fechaEmisionRuc,
    String? fechaVencimientoRuc,
    String? numeroMatricula,
    String? nombreInstitucionMatricula,
    String? fechaEmisionMatricula,
    String? fechaVencimientoMatricula,
    String? numeroLicencia,
    String? nombreInstitucionLicencia,
    String? fechaEmisionLicencia,
    String? fechaVencimientoLicencia,
    num? ingresoAnual,
    String? cliente1,
    String? cliente2,
    String? cliente3,
    String? proveedor1,
    String? proveedor2,
    String? proveedor3,
    String? fechaVerificacion1,
    String? nombreReferencia1,
    String? cedulaReferencia1,
    String? direccionReferencia1,
    String? telefonoReferencia1,
    String? lugarTrabajoReferencia1,
    num? aniosConocerReferido1,
    num? objParentescoIdReferencia1,
    String? resultadoVerificacion1,
    String? objEmpleadoVerificaReferenciaId1,
    String? fechaVerificacion2,
    String? nombreReferencia2,
    String? cedulaReferencia2,
    String? direccionReferencia2,
    String? telefonoReferencia2,
    String? lugarTrabajoReferencia2,
    num? aniosConocerReferido2,
    num? objParentescoIdReferencia2,
    String? resultadoVerificacion2,
    String? objEmpleadoVerificaReferenciaId2,
  }) {
    return AnalisisSolicitudNuevaMenorState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      id: id ?? this.id,
      objSolicitudId: objSolicitudId ?? this.objSolicitudId,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      fechaAnalisis: fechaAnalisis ?? this.fechaAnalisis,
      caja: caja ?? this.caja,
      banco: banco ?? this.banco,
      cuentasXCobrar: cuentasXCobrar ?? this.cuentasXCobrar,
      inventario: inventario ?? this.inventario,
      otrosActivos: otrosActivos ?? this.otrosActivos,
      totalAc: totalAc ?? this.totalAc,
      activoFijo: activoFijo ?? this.activoFijo,
      totalActivo: totalActivo ?? this.totalActivo,
      proveedores: proveedores ?? this.proveedores,
      cuentasXPagar: cuentasXPagar ?? this.cuentasXPagar,
      otrasDeudas: otrasDeudas ?? this.otrasDeudas,
      totalPasivo: totalPasivo ?? this.totalPasivo,
      capital: capital ?? this.capital,
      pasivoCapital: pasivoCapital ?? this.pasivoCapital,
      ventasContado: ventasContado ?? this.ventasContado,
      recuperaciones: recuperaciones ?? this.recuperaciones,
      otrosIngresos: otrosIngresos ?? this.otrosIngresos,
      gastosUnidadFamiliar: gastosUnidadFamiliar ?? this.gastosUnidadFamiliar,
      totalIngresos: totalIngresos ?? this.totalIngresos,
      costoVentaPorcentaje: costoVentaPorcentaje ?? this.costoVentaPorcentaje,
      costoVenta: costoVenta ?? this.costoVenta,
      gastosOperativos: gastosOperativos ?? this.gastosOperativos,
      margenBrutoNegocio: margenBrutoNegocio ?? this.margenBrutoNegocio,
      disponidadFamiliar: disponidadFamiliar ?? this.disponidadFamiliar,
      dppPorcentaje: dppPorcentaje ?? this.dppPorcentaje,
      dpp: dpp ?? this.dpp,
      numeroRuc: numeroRuc ?? this.numeroRuc,
      nombreInstitucionRuc: nombreInstitucionRuc ?? this.nombreInstitucionRuc,
      fechaEmisionRuc: fechaEmisionRuc ?? this.fechaEmisionRuc,
      fechaVencimientoRuc: fechaVencimientoRuc ?? this.fechaVencimientoRuc,
      numeroMatricula: numeroMatricula ?? this.numeroMatricula,
      nombreInstitucionMatricula:
          nombreInstitucionMatricula ?? this.nombreInstitucionMatricula,
      fechaEmisionMatricula:
          fechaEmisionMatricula ?? this.fechaEmisionMatricula,
      fechaVencimientoMatricula:
          fechaVencimientoMatricula ?? this.fechaVencimientoMatricula,
      numeroLicencia: numeroLicencia ?? this.numeroLicencia,
      nombreInstitucionLicencia:
          nombreInstitucionLicencia ?? this.nombreInstitucionLicencia,
      fechaEmisionLicencia: fechaEmisionLicencia ?? this.fechaEmisionLicencia,
      fechaVencimientoLicencia:
          fechaVencimientoLicencia ?? this.fechaVencimientoLicencia,
      ingresoAnual: ingresoAnual ?? this.ingresoAnual,
      cliente1: cliente1 ?? this.cliente1,
      cliente2: cliente2 ?? this.cliente2,
      cliente3: cliente3 ?? this.cliente3,
      proveedor1: proveedor1 ?? this.proveedor1,
      proveedor2: proveedor2 ?? this.proveedor2,
      proveedor3: proveedor3 ?? this.proveedor3,
      fechaVerificacion1: fechaVerificacion1 ?? this.fechaVerificacion1,
      nombreReferencia1: nombreReferencia1 ?? this.nombreReferencia1,
      cedulaReferencia1: cedulaReferencia1 ?? this.cedulaReferencia1,
      direccionReferencia1: direccionReferencia1 ?? this.direccionReferencia1,
      telefonoReferencia1: telefonoReferencia1 ?? this.telefonoReferencia1,
      lugarTrabajoReferencia1:
          lugarTrabajoReferencia1 ?? this.lugarTrabajoReferencia1,
      aniosConocerReferido1:
          aniosConocerReferido1 ?? this.aniosConocerReferido1,
      objParentescoIdReferencia1:
          objParentescoIdReferencia1 ?? this.objParentescoIdReferencia1,
      resultadoVerificacion1:
          resultadoVerificacion1 ?? this.resultadoVerificacion1,
      objEmpleadoVerificaReferenciaId1: objEmpleadoVerificaReferenciaId1 ??
          this.objEmpleadoVerificaReferenciaId1,
      fechaVerificacion2: fechaVerificacion2 ?? this.fechaVerificacion2,
      nombreReferencia2: nombreReferencia2 ?? this.nombreReferencia2,
      cedulaReferencia2: cedulaReferencia2 ?? this.cedulaReferencia2,
      direccionReferencia2: direccionReferencia2 ?? this.direccionReferencia2,
      telefonoReferencia2: telefonoReferencia2 ?? this.telefonoReferencia2,
      lugarTrabajoReferencia2:
          lugarTrabajoReferencia2 ?? this.lugarTrabajoReferencia2,
      aniosConocerReferido2:
          aniosConocerReferido2 ?? this.aniosConocerReferido2,
      objParentescoIdReferencia2:
          objParentescoIdReferencia2 ?? this.objParentescoIdReferencia2,
      resultadoVerificacion2:
          resultadoVerificacion2 ?? this.resultadoVerificacion2,
      objEmpleadoVerificaReferenciaId2: objEmpleadoVerificaReferenciaId2 ??
          this.objEmpleadoVerificaReferenciaId2,
    );
  }
}

final class AnalisisSolicitudNuevaMenorInitial
    extends AnalisisSolicitudNuevaMenorState {}

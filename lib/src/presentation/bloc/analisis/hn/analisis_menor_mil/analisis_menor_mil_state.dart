// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_menor_mil_cubit.dart';

class AnalisisMenorMilState extends Equatable {
  final String? uuid;
  final int idLocalResponse;
  final Status status;
  final String errorMsg;
  final int numeroSolicitud;
  final double caja;
  final double banco;
  final double cuentasXCobrar;
  final double inventario;
  final double otrosActivos;
  final double totalAc;
  final double activoFijo;
  final double totalActivo;
  final double proveedores;
  final double cuentasXPagar;
  final double otrasDeudas;
  final double totalPasivo;
  final double capital;
  final double pasivoCapital;
  final double ventasContado;
  final double recuperaciones;
  final double otrosIngresos;
  final double gastosUnidadFamiliar;
  final double totalIngresos;
  final double costoVentaPorcentaje;
  final double costoVenta;
  final double gastosOperativos;
  final double margenBrutoNegocio;
  final double disponidadFamiliar;
  final double dppPorcentaje;
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
  final double ingresoAnual;
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
  final int aniosConocerReferido1;
  final String parentescoReferenciaCodigo1;
  final String resultadoVerificacion1;
  final String objEmpleadoVerificaReferenciaId1;
  final String fechaVerificacion2;
  final String nombreReferencia2;
  final String cedulaReferencia2;
  final String direccionReferencia2;
  final String telefonoReferencia2;
  final String lugarTrabajoReferencia2;
  final int aniosConocerReferido2;
  final String parentescoReferenciaCodigo2;
  final String resultadoVerificacion2;
  final String objEmpleadoVerificaReferenciaId2;
  final String fechaVerificacion3;
  final String nombreReferencia3;
  final String cedulaReferencia3;
  final String direccionReferencia3;
  final String telefonoReferencia3;
  final String lugarTrabajoReferencia3;
  final int aniosConocerReferido3;
  final String parentescoReferenciaCodigo3;
  final String resultadoVerificacion3;
  final String objEmpleadoVerificaReferenciaId3;
  final String permisoOperacionNumero;
  final String permisoOperacionNombreInstitucion;
  final String permisoOperacionFechaEmision;
  final String permisoOperacionFechaVencimiento;
  final List<InventarioHN> inventarioHn;
  const AnalisisMenorMilState({
    this.uuid,
    this.idLocalResponse = 0,
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.numeroSolicitud = 0,
    this.caja = 0.0,
    this.banco = 0.0,
    this.cuentasXCobrar = 0.0,
    this.inventario = 0.0,
    this.otrosActivos = 0.0,
    this.totalAc = 0.0,
    this.activoFijo = 0.0,
    this.totalActivo = 0.0,
    this.proveedores = 0.0,
    this.cuentasXPagar = 0.0,
    this.otrasDeudas = 0.0,
    this.totalPasivo = 0.0,
    this.capital = 0.0,
    this.pasivoCapital = 0.0,
    this.ventasContado = 0.0,
    this.recuperaciones = 0.0,
    this.otrosIngresos = 0.0,
    this.gastosUnidadFamiliar = 0.0,
    this.totalIngresos = 0.0,
    this.costoVentaPorcentaje = 0.0,
    this.costoVenta = 0.0,
    this.gastosOperativos = 0.0,
    this.margenBrutoNegocio = 0.0,
    this.disponidadFamiliar = 0.0,
    this.dppPorcentaje = 0.0,
    this.dpp = 0.0,
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
    this.ingresoAnual = 0.0,
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
    this.parentescoReferenciaCodigo1 = '',
    this.resultadoVerificacion1 = '',
    this.objEmpleadoVerificaReferenciaId1 = '',
    this.fechaVerificacion2 = '',
    this.nombreReferencia2 = '',
    this.cedulaReferencia2 = '',
    this.direccionReferencia2 = '',
    this.telefonoReferencia2 = '',
    this.lugarTrabajoReferencia2 = '',
    this.aniosConocerReferido2 = 0,
    this.parentescoReferenciaCodigo2 = '',
    this.resultadoVerificacion2 = '',
    this.objEmpleadoVerificaReferenciaId2 = '',
    this.fechaVerificacion3 = '',
    this.nombreReferencia3 = '',
    this.cedulaReferencia3 = '',
    this.direccionReferencia3 = '',
    this.telefonoReferencia3 = '',
    this.lugarTrabajoReferencia3 = '',
    this.aniosConocerReferido3 = 0,
    this.parentescoReferenciaCodigo3 = '',
    this.resultadoVerificacion3 = '',
    this.objEmpleadoVerificaReferenciaId3 = '',
    this.permisoOperacionNumero = '',
    this.permisoOperacionNombreInstitucion = '',
    this.permisoOperacionFechaEmision = '',
    this.permisoOperacionFechaVencimiento = '',
    this.inventarioHn = const [],
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        numeroSolicitud,
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
        parentescoReferenciaCodigo1,
        resultadoVerificacion1,
        objEmpleadoVerificaReferenciaId1,
        fechaVerificacion2,
        nombreReferencia2,
        cedulaReferencia2,
        direccionReferencia2,
        telefonoReferencia2,
        lugarTrabajoReferencia2,
        aniosConocerReferido2,
        parentescoReferenciaCodigo2,
        resultadoVerificacion2,
        objEmpleadoVerificaReferenciaId2,
        fechaVerificacion3,
        nombreReferencia3,
        cedulaReferencia3,
        direccionReferencia3,
        telefonoReferencia3,
        lugarTrabajoReferencia3,
        aniosConocerReferido3,
        parentescoReferenciaCodigo3,
        resultadoVerificacion3,
        objEmpleadoVerificaReferenciaId3,
        permisoOperacionNumero,
        permisoOperacionNombreInstitucion,
        permisoOperacionFechaEmision,
        permisoOperacionFechaVencimiento,
        inventarioHn,
      ];

  AnalisisMenorMilState copyWith({
    String? uuid,
    int? idLocalResponse,
    Status? status,
    String? errorMsg,
    int? numeroSolicitud,
    double? caja,
    double? banco,
    double? cuentasXCobrar,
    double? inventario,
    double? otrosActivos,
    double? totalAc,
    double? activoFijo,
    double? totalActivo,
    double? proveedores,
    double? cuentasXPagar,
    double? otrasDeudas,
    double? totalPasivo,
    double? capital,
    double? pasivoCapital,
    double? ventasContado,
    double? recuperaciones,
    double? otrosIngresos,
    double? gastosUnidadFamiliar,
    double? totalIngresos,
    double? costoVentaPorcentaje,
    double? costoVenta,
    double? gastosOperativos,
    double? margenBrutoNegocio,
    double? disponidadFamiliar,
    double? dppPorcentaje,
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
    double? ingresoAnual,
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
    int? aniosConocerReferido1,
    String? parentescoReferenciaCodigo1,
    String? resultadoVerificacion1,
    String? objEmpleadoVerificaReferenciaId1,
    String? fechaVerificacion2,
    String? nombreReferencia2,
    String? cedulaReferencia2,
    String? direccionReferencia2,
    String? telefonoReferencia2,
    String? lugarTrabajoReferencia2,
    int? aniosConocerReferido2,
    String? parentescoReferenciaCodigo2,
    String? resultadoVerificacion2,
    String? objEmpleadoVerificaReferenciaId2,
    String? fechaVerificacion3,
    String? nombreReferencia3,
    String? cedulaReferencia3,
    String? direccionReferencia3,
    String? telefonoReferencia3,
    String? lugarTrabajoReferencia3,
    int? aniosConocerReferido3,
    String? parentescoReferenciaCodigo3,
    String? resultadoVerificacion3,
    String? objEmpleadoVerificaReferenciaId3,
    String? permisoOperacionNumero,
    String? permisoOperacionNombreInstitucion,
    String? permisoOperacionFechaEmision,
    String? permisoOperacionFechaVencimiento,
    List<InventarioHN>? inventarioHn,
  }) {
    return AnalisisMenorMilState(
      uuid: uuid ?? this.uuid,
      idLocalResponse: idLocalResponse ?? this.idLocalResponse,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
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
      parentescoReferenciaCodigo1:
          parentescoReferenciaCodigo1 ?? this.parentescoReferenciaCodigo1,
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
      parentescoReferenciaCodigo2:
          parentescoReferenciaCodigo2 ?? this.parentescoReferenciaCodigo2,
      resultadoVerificacion2:
          resultadoVerificacion2 ?? this.resultadoVerificacion2,
      objEmpleadoVerificaReferenciaId2: objEmpleadoVerificaReferenciaId2 ??
          this.objEmpleadoVerificaReferenciaId2,
      fechaVerificacion3: fechaVerificacion3 ?? this.fechaVerificacion3,
      nombreReferencia3: nombreReferencia3 ?? this.nombreReferencia3,
      cedulaReferencia3: cedulaReferencia3 ?? this.cedulaReferencia3,
      direccionReferencia3: direccionReferencia3 ?? this.direccionReferencia3,
      telefonoReferencia3: telefonoReferencia3 ?? this.telefonoReferencia3,
      lugarTrabajoReferencia3:
          lugarTrabajoReferencia3 ?? this.lugarTrabajoReferencia3,
      aniosConocerReferido3:
          aniosConocerReferido3 ?? this.aniosConocerReferido3,
      parentescoReferenciaCodigo3:
          parentescoReferenciaCodigo3 ?? this.parentescoReferenciaCodigo3,
      resultadoVerificacion3:
          resultadoVerificacion3 ?? this.resultadoVerificacion3,
      objEmpleadoVerificaReferenciaId3: objEmpleadoVerificaReferenciaId3 ??
          this.objEmpleadoVerificaReferenciaId3,
      permisoOperacionNumero:
          permisoOperacionNumero ?? this.permisoOperacionNumero,
      permisoOperacionNombreInstitucion: permisoOperacionNombreInstitucion ??
          this.permisoOperacionNombreInstitucion,
      permisoOperacionFechaEmision:
          permisoOperacionFechaEmision ?? this.permisoOperacionFechaEmision,
      permisoOperacionFechaVencimiento: permisoOperacionFechaVencimiento ??
          this.permisoOperacionFechaVencimiento,
      inventarioHn: inventarioHn ?? this.inventarioHn,
    );
  }
}

final class AnalisisMenorMilInitial extends AnalisisMenorMilState {}

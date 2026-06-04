// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_analisis_menor_mil_data_cubit.dart';

class GetAnalisisMenorMilDataState extends Equatable {
  final Status status;
  final String errorMsg;
  final String database;
  final int numeroSolicitud;
  final num costoVenta;
  final num gastosOperativos;
  final String maquinaModificacion;
  final num otrosIngresos;
  final String usuarioModificacion;
  final num ingresoAnual;
  final num aniosConocerReferido1;
  final num aniosConocerReferido2;
  final num cuentasXCobrar;
  final num cuentasXPagar;
  final String direccionReferencia1;
  final String direccionReferencia2;
  final String fechaVerificacion1;
  final String fechaVerificacion2;
  final String lugarTrabajoReferencia1;
  final String lugarTrabajoReferencia2;
  final String nombreReferencia1;
  final String nombreReferencia2;
  final int objEmpleadoVerificaReferenciaId1;
  final int objEmpleadoVerificaReferenciaId2;
  final String resultadoVerificacion1;
  final String resultadoVerificacion2;
  final String telefonoReferencia1;
  final String telefonoReferencia2;
  final num totalActivo;
  final num totalIngresos;
  final num totalPasivo;
  final num caja;
  final num proveedores;
  final num recuperaciones;
  final num ventasContado;
  final num costoVentaPorcentaje;
  final num activoFijo;
  final num banco;
  final num capital;
  final num disponidadFamiliar;
  final num dpp;
  final num dppPorcentaje;
  final num gastosUnidadFamiliar;
  final num inventario;
  final num margenBrutoNegocio;
  final num otrasDeudas;
  final num otrosActivos;
  final num pasivoCapital;
  final num totalAc;
  final String parentescoReferenciaCodigo1;
  final String parentescoReferenciaCodigo2;
  final String cliente1;
  final String cliente2;
  final String cliente3;
  final String proveedor1;
  final String proveedor2;
  final String proveedor3;
  final int aniosConocerReferido3;
  final String cedulaReferencia1;
  final String cedulaReferencia2;
  final String cedulaReferencia3;
  final String direccionReferencia3;
  final String fechaVerificacion3;
  final String lugarTrabajoReferencia3;
  final String nombreReferencia3;
  final int objEmpleadoVerificaReferenciaId3;
  final String resultadoVerificacion3;
  final String telefonoReferencia3;
  final String fechaEmisionLicencia;
  final String fechaEmisionMatricula;
  final String fechaEmisionRuc;
  final String fechaVencimientoLicencia;
  final String fechaVencimientoMatricula;
  final String fechaVencimientoRuc;
  final String nombreInstitucionLicencia;
  final String nombreInstitucionMatricula;
  final String nombreInstitucionRuc;
  final String numeroLicencia;
  final String numeroMatricula;
  final String numeroRuc;
  final String permisoOperacionFechaEmision;
  final String permisoOperacionFechaVencimiento;
  final String permisoOperacionNombreInstitucion;
  final String permisoOperacionNumero;
  final String parentescoReferenciaCodigo3;
  final List<InventarioMenorMilData> inventarioTb;
  const GetAnalisisMenorMilDataState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.database = '',
    this.numeroSolicitud = 0,
    this.costoVenta = 0,
    this.gastosOperativos = 0,
    this.maquinaModificacion = '',
    this.otrosIngresos = 0,
    this.usuarioModificacion = '',
    this.ingresoAnual = 0,
    this.aniosConocerReferido1 = 0,
    this.aniosConocerReferido2 = 0,
    this.cuentasXCobrar = 0,
    this.cuentasXPagar = 0,
    this.direccionReferencia1 = '',
    this.direccionReferencia2 = '',
    this.fechaVerificacion1 = '',
    this.fechaVerificacion2 = '',
    this.lugarTrabajoReferencia1 = '',
    this.lugarTrabajoReferencia2 = '',
    this.nombreReferencia1 = '',
    this.nombreReferencia2 = '',
    this.objEmpleadoVerificaReferenciaId1 = 0,
    this.objEmpleadoVerificaReferenciaId2 = 0,
    this.resultadoVerificacion1 = '',
    this.resultadoVerificacion2 = '',
    this.telefonoReferencia1 = '',
    this.telefonoReferencia2 = '',
    this.totalActivo = 0,
    this.totalIngresos = 0,
    this.totalPasivo = 0,
    this.caja = 0,
    this.proveedores = 0,
    this.recuperaciones = 0,
    this.ventasContado = 0,
    this.costoVentaPorcentaje = 0,
    this.activoFijo = 0,
    this.banco = 0,
    this.capital = 0,
    this.disponidadFamiliar = 0,
    this.dpp = 0,
    this.dppPorcentaje = 0,
    this.gastosUnidadFamiliar = 0,
    this.inventario = 0,
    this.margenBrutoNegocio = 0,
    this.otrasDeudas = 0,
    this.otrosActivos = 0,
    this.pasivoCapital = 0,
    this.totalAc = 0,
    this.parentescoReferenciaCodigo1 = '',
    this.parentescoReferenciaCodigo2 = '',
    this.cliente1 = '',
    this.cliente2 = '',
    this.cliente3 = '',
    this.proveedor1 = '',
    this.proveedor2 = '',
    this.proveedor3 = '',
    this.aniosConocerReferido3 = 0,
    this.cedulaReferencia1 = '',
    this.cedulaReferencia2 = '',
    this.cedulaReferencia3 = '',
    this.direccionReferencia3 = '',
    this.fechaVerificacion3 = '',
    this.lugarTrabajoReferencia3 = '',
    this.nombreReferencia3 = '',
    this.objEmpleadoVerificaReferenciaId3 = 0,
    this.resultadoVerificacion3 = '',
    this.telefonoReferencia3 = '',
    this.fechaEmisionLicencia = '',
    this.fechaEmisionMatricula = '',
    this.fechaEmisionRuc = '',
    this.fechaVencimientoLicencia = '',
    this.fechaVencimientoMatricula = '',
    this.fechaVencimientoRuc = '',
    this.nombreInstitucionLicencia = '',
    this.nombreInstitucionMatricula = '',
    this.nombreInstitucionRuc = '',
    this.numeroLicencia = '',
    this.numeroMatricula = '',
    this.numeroRuc = '',
    this.permisoOperacionFechaEmision = '',
    this.permisoOperacionFechaVencimiento = '',
    this.permisoOperacionNombreInstitucion = '',
    this.permisoOperacionNumero = '',
    this.parentescoReferenciaCodigo3 = '',
    this.inventarioTb = const [],
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        database,
        numeroSolicitud,
        costoVenta,
        gastosOperativos,
        maquinaModificacion,
        otrosIngresos,
        usuarioModificacion,
        ingresoAnual,
        aniosConocerReferido1,
        aniosConocerReferido2,
        cuentasXCobrar,
        cuentasXPagar,
        direccionReferencia1,
        direccionReferencia2,
        fechaVerificacion1,
        fechaVerificacion2,
        lugarTrabajoReferencia1,
        lugarTrabajoReferencia2,
        nombreReferencia1,
        nombreReferencia2,
        objEmpleadoVerificaReferenciaId1,
        objEmpleadoVerificaReferenciaId2,
        resultadoVerificacion1,
        resultadoVerificacion2,
        telefonoReferencia1,
        telefonoReferencia2,
        totalActivo,
        totalIngresos,
        totalPasivo,
        caja,
        proveedores,
        recuperaciones,
        ventasContado,
        costoVentaPorcentaje,
        activoFijo,
        banco,
        capital,
        disponidadFamiliar,
        dpp,
        dppPorcentaje,
        gastosUnidadFamiliar,
        inventario,
        margenBrutoNegocio,
        otrasDeudas,
        otrosActivos,
        pasivoCapital,
        totalAc,
        parentescoReferenciaCodigo1,
        parentescoReferenciaCodigo2,
        cliente1,
        cliente2,
        cliente3,
        proveedor1,
        proveedor2,
        proveedor3,
        aniosConocerReferido3,
        cedulaReferencia1,
        cedulaReferencia2,
        cedulaReferencia3,
        direccionReferencia3,
        fechaVerificacion3,
        lugarTrabajoReferencia3,
        nombreReferencia3,
        objEmpleadoVerificaReferenciaId3,
        resultadoVerificacion3,
        telefonoReferencia3,
        fechaEmisionLicencia,
        fechaEmisionMatricula,
        fechaEmisionRuc,
        fechaVencimientoLicencia,
        fechaVencimientoMatricula,
        fechaVencimientoRuc,
        nombreInstitucionLicencia,
        nombreInstitucionMatricula,
        nombreInstitucionRuc,
        numeroLicencia,
        numeroMatricula,
        numeroRuc,
        permisoOperacionFechaEmision,
        permisoOperacionFechaVencimiento,
        permisoOperacionNombreInstitucion,
        permisoOperacionNumero,
        parentescoReferenciaCodigo3,
        inventarioTb,
      ];

  GetAnalisisMenorMilDataState copyWith({
    Status? status,
    String? errorMsg,
    String? database,
    int? numeroSolicitud,
    num? costoVenta,
    num? gastosOperativos,
    String? maquinaModificacion,
    num? otrosIngresos,
    String? usuarioModificacion,
    num? ingresoAnual,
    num? aniosConocerReferido1,
    num? aniosConocerReferido2,
    num? cuentasXCobrar,
    num? cuentasXPagar,
    String? direccionReferencia1,
    String? direccionReferencia2,
    String? fechaVerificacion1,
    String? fechaVerificacion2,
    String? lugarTrabajoReferencia1,
    String? lugarTrabajoReferencia2,
    String? nombreReferencia1,
    String? nombreReferencia2,
    int? objEmpleadoVerificaReferenciaId1,
    int? objEmpleadoVerificaReferenciaId2,
    String? resultadoVerificacion1,
    String? resultadoVerificacion2,
    String? telefonoReferencia1,
    String? telefonoReferencia2,
    num? totalActivo,
    num? totalIngresos,
    num? totalPasivo,
    num? caja,
    num? proveedores,
    num? recuperaciones,
    num? ventasContado,
    num? costoVentaPorcentaje,
    num? activoFijo,
    num? banco,
    num? capital,
    num? disponidadFamiliar,
    num? dpp,
    num? dppPorcentaje,
    num? gastosUnidadFamiliar,
    num? inventario,
    num? margenBrutoNegocio,
    num? otrasDeudas,
    num? otrosActivos,
    num? pasivoCapital,
    num? totalAc,
    String? parentescoReferenciaCodigo1,
    String? parentescoReferenciaCodigo2,
    String? cliente1,
    String? cliente2,
    String? cliente3,
    String? proveedor1,
    String? proveedor2,
    String? proveedor3,
    int? aniosConocerReferido3,
    String? cedulaReferencia1,
    String? cedulaReferencia2,
    String? cedulaReferencia3,
    String? direccionReferencia3,
    String? fechaVerificacion3,
    String? lugarTrabajoReferencia3,
    String? nombreReferencia3,
    int? objEmpleadoVerificaReferenciaId3,
    String? resultadoVerificacion3,
    String? telefonoReferencia3,
    String? fechaEmisionLicencia,
    String? fechaEmisionMatricula,
    String? fechaEmisionRuc,
    String? fechaVencimientoLicencia,
    String? fechaVencimientoMatricula,
    String? fechaVencimientoRuc,
    String? nombreInstitucionLicencia,
    String? nombreInstitucionMatricula,
    String? nombreInstitucionRuc,
    String? numeroLicencia,
    String? numeroMatricula,
    String? numeroRuc,
    String? permisoOperacionFechaEmision,
    String? permisoOperacionFechaVencimiento,
    String? permisoOperacionNombreInstitucion,
    String? permisoOperacionNumero,
    String? parentescoReferenciaCodigo3,
    List<InventarioMenorMilData>? inventarioTb,
  }) {
    return GetAnalisisMenorMilDataState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      database: database ?? this.database,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      costoVenta: costoVenta ?? this.costoVenta,
      gastosOperativos: gastosOperativos ?? this.gastosOperativos,
      maquinaModificacion: maquinaModificacion ?? this.maquinaModificacion,
      otrosIngresos: otrosIngresos ?? this.otrosIngresos,
      usuarioModificacion: usuarioModificacion ?? this.usuarioModificacion,
      ingresoAnual: ingresoAnual ?? this.ingresoAnual,
      aniosConocerReferido1:
          aniosConocerReferido1 ?? this.aniosConocerReferido1,
      aniosConocerReferido2:
          aniosConocerReferido2 ?? this.aniosConocerReferido2,
      cuentasXCobrar: cuentasXCobrar ?? this.cuentasXCobrar,
      cuentasXPagar: cuentasXPagar ?? this.cuentasXPagar,
      direccionReferencia1: direccionReferencia1 ?? this.direccionReferencia1,
      direccionReferencia2: direccionReferencia2 ?? this.direccionReferencia2,
      fechaVerificacion1: fechaVerificacion1 ?? this.fechaVerificacion1,
      fechaVerificacion2: fechaVerificacion2 ?? this.fechaVerificacion2,
      lugarTrabajoReferencia1:
          lugarTrabajoReferencia1 ?? this.lugarTrabajoReferencia1,
      lugarTrabajoReferencia2:
          lugarTrabajoReferencia2 ?? this.lugarTrabajoReferencia2,
      nombreReferencia1: nombreReferencia1 ?? this.nombreReferencia1,
      nombreReferencia2: nombreReferencia2 ?? this.nombreReferencia2,
      objEmpleadoVerificaReferenciaId1: objEmpleadoVerificaReferenciaId1 ??
          this.objEmpleadoVerificaReferenciaId1,
      objEmpleadoVerificaReferenciaId2: objEmpleadoVerificaReferenciaId2 ??
          this.objEmpleadoVerificaReferenciaId2,
      resultadoVerificacion1:
          resultadoVerificacion1 ?? this.resultadoVerificacion1,
      resultadoVerificacion2:
          resultadoVerificacion2 ?? this.resultadoVerificacion2,
      telefonoReferencia1: telefonoReferencia1 ?? this.telefonoReferencia1,
      telefonoReferencia2: telefonoReferencia2 ?? this.telefonoReferencia2,
      totalActivo: totalActivo ?? this.totalActivo,
      totalIngresos: totalIngresos ?? this.totalIngresos,
      totalPasivo: totalPasivo ?? this.totalPasivo,
      caja: caja ?? this.caja,
      proveedores: proveedores ?? this.proveedores,
      recuperaciones: recuperaciones ?? this.recuperaciones,
      ventasContado: ventasContado ?? this.ventasContado,
      costoVentaPorcentaje: costoVentaPorcentaje ?? this.costoVentaPorcentaje,
      activoFijo: activoFijo ?? this.activoFijo,
      banco: banco ?? this.banco,
      capital: capital ?? this.capital,
      disponidadFamiliar: disponidadFamiliar ?? this.disponidadFamiliar,
      dpp: dpp ?? this.dpp,
      dppPorcentaje: dppPorcentaje ?? this.dppPorcentaje,
      gastosUnidadFamiliar: gastosUnidadFamiliar ?? this.gastosUnidadFamiliar,
      inventario: inventario ?? this.inventario,
      margenBrutoNegocio: margenBrutoNegocio ?? this.margenBrutoNegocio,
      otrasDeudas: otrasDeudas ?? this.otrasDeudas,
      otrosActivos: otrosActivos ?? this.otrosActivos,
      pasivoCapital: pasivoCapital ?? this.pasivoCapital,
      totalAc: totalAc ?? this.totalAc,
      parentescoReferenciaCodigo1:
          parentescoReferenciaCodigo1 ?? this.parentescoReferenciaCodigo1,
      parentescoReferenciaCodigo2:
          parentescoReferenciaCodigo2 ?? this.parentescoReferenciaCodigo2,
      cliente1: cliente1 ?? this.cliente1,
      cliente2: cliente2 ?? this.cliente2,
      cliente3: cliente3 ?? this.cliente3,
      proveedor1: proveedor1 ?? this.proveedor1,
      proveedor2: proveedor2 ?? this.proveedor2,
      proveedor3: proveedor3 ?? this.proveedor3,
      aniosConocerReferido3:
          aniosConocerReferido3 ?? this.aniosConocerReferido3,
      cedulaReferencia1: cedulaReferencia1 ?? this.cedulaReferencia1,
      cedulaReferencia2: cedulaReferencia2 ?? this.cedulaReferencia2,
      cedulaReferencia3: cedulaReferencia3 ?? this.cedulaReferencia3,
      direccionReferencia3: direccionReferencia3 ?? this.direccionReferencia3,
      fechaVerificacion3: fechaVerificacion3 ?? this.fechaVerificacion3,
      lugarTrabajoReferencia3:
          lugarTrabajoReferencia3 ?? this.lugarTrabajoReferencia3,
      nombreReferencia3: nombreReferencia3 ?? this.nombreReferencia3,
      objEmpleadoVerificaReferenciaId3: objEmpleadoVerificaReferenciaId3 ??
          this.objEmpleadoVerificaReferenciaId3,
      resultadoVerificacion3:
          resultadoVerificacion3 ?? this.resultadoVerificacion3,
      telefonoReferencia3: telefonoReferencia3 ?? this.telefonoReferencia3,
      fechaEmisionLicencia: fechaEmisionLicencia ?? this.fechaEmisionLicencia,
      fechaEmisionMatricula:
          fechaEmisionMatricula ?? this.fechaEmisionMatricula,
      fechaEmisionRuc: fechaEmisionRuc ?? this.fechaEmisionRuc,
      fechaVencimientoLicencia:
          fechaVencimientoLicencia ?? this.fechaVencimientoLicencia,
      fechaVencimientoMatricula:
          fechaVencimientoMatricula ?? this.fechaVencimientoMatricula,
      fechaVencimientoRuc: fechaVencimientoRuc ?? this.fechaVencimientoRuc,
      nombreInstitucionLicencia:
          nombreInstitucionLicencia ?? this.nombreInstitucionLicencia,
      nombreInstitucionMatricula:
          nombreInstitucionMatricula ?? this.nombreInstitucionMatricula,
      nombreInstitucionRuc: nombreInstitucionRuc ?? this.nombreInstitucionRuc,
      numeroLicencia: numeroLicencia ?? this.numeroLicencia,
      numeroMatricula: numeroMatricula ?? this.numeroMatricula,
      numeroRuc: numeroRuc ?? this.numeroRuc,
      permisoOperacionFechaEmision:
          permisoOperacionFechaEmision ?? this.permisoOperacionFechaEmision,
      permisoOperacionFechaVencimiento: permisoOperacionFechaVencimiento ??
          this.permisoOperacionFechaVencimiento,
      permisoOperacionNombreInstitucion: permisoOperacionNombreInstitucion ??
          this.permisoOperacionNombreInstitucion,
      permisoOperacionNumero:
          permisoOperacionNumero ?? this.permisoOperacionNumero,
      parentescoReferenciaCodigo3:
          parentescoReferenciaCodigo3 ?? this.parentescoReferenciaCodigo3,
      inventarioTb: inventarioTb ?? this.inventarioTb,
    );
  }
}

final class GetAnalisisMenorMilDataInitial
    extends GetAnalisisMenorMilDataState {}

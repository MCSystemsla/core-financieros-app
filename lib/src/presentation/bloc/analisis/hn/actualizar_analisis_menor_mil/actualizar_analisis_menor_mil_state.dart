// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'actualizar_analisis_menor_mil_cubit.dart';

class ActualizarAnalisisMenorMilState extends Equatable {
  final Status status;
  final String errorMsg;
  final int numeroSolicitud;
  final double caja;
  final double banco;
  final double cuentasXCobrar;
  final double otrosActivos;
  final double activoFijo;
  final double proveedores;
  final double cuentasXPagar;
  final double otrasDeudas;
  final double ventasContado;
  final double recuperaciones;
  final double otrosIngresos;
  final double gastosUnidadFamiliar;
  final double gastosOperativos;
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
  final List<InventarioMenorMilData> inventarioTb;

  const ActualizarAnalisisMenorMilState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.numeroSolicitud = 0,
    this.caja = 0,
    this.banco = 0,
    this.cuentasXCobrar = 0,
    this.otrosActivos = 0,
    this.activoFijo = 0,
    this.proveedores = 0,
    this.cuentasXPagar = 0,
    this.otrasDeudas = 0,
    this.ventasContado = 0,
    this.recuperaciones = 0,
    this.otrosIngresos = 0,
    this.gastosUnidadFamiliar = 0,
    this.gastosOperativos = 0,
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
    this.inventarioTb = const [],
  });

  double get totalInventario => inventarioTb.fold(
        0.0,
        (sum, e) => sum + (e.total ?? 0),
      );

  double get totalActivosCirculantes =>
      caja + banco + cuentasXCobrar + otrosActivos + totalInventario;

  double get totalActivo => activoFijo + totalActivosCirculantes;

  double get totalPasivo => proveedores + cuentasXPagar + otrasDeudas;

  double get capital => totalActivo - totalPasivo;

  double get pasivoCapital => totalPasivo + capital;

  double get totalIngresos => ventasContado + recuperaciones;

  double get ingresoAnual => totalIngresos * 12;

  double get costoVentaPorcentaje => inventarioTb.isEmpty
      ? 0
      : inventarioTb.fold<double>(
            0.0,
            (sum, e) => sum + (e.costoVentaPorcentaje ?? 0),
          ) /
          inventarioTb.length;

  double get costoVenta => totalIngresos * costoVentaPorcentaje;

  double get margenBrutoNegocio =>
      totalIngresos - costoVenta - gastosOperativos;

  double get disponibilidadFamiliar =>
      margenBrutoNegocio + otrosIngresos - gastosUnidadFamiliar;

  @override
  List<Object> get props => [
        status,
        errorMsg,
        numeroSolicitud,
        caja,
        banco,
        cuentasXCobrar,
        otrosActivos,
        activoFijo,
        proveedores,
        cuentasXPagar,
        otrasDeudas,
        ventasContado,
        recuperaciones,
        otrosIngresos,
        gastosUnidadFamiliar,
        gastosOperativos,
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
        inventarioTb,
      ];

  ActualizarAnalisisMenorMilState copyWith({
    Status? status,
    String? errorMsg,
    int? numeroSolicitud,
    double? caja,
    double? banco,
    double? cuentasXCobrar,
    double? otrosActivos,
    double? activoFijo,
    double? proveedores,
    double? cuentasXPagar,
    double? otrasDeudas,
    double? ventasContado,
    double? recuperaciones,
    double? otrosIngresos,
    double? gastosUnidadFamiliar,
    double? gastosOperativos,
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
    List<InventarioMenorMilData>? inventarioTb,
  }) {
    return ActualizarAnalisisMenorMilState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      caja: caja ?? this.caja,
      banco: banco ?? this.banco,
      cuentasXCobrar: cuentasXCobrar ?? this.cuentasXCobrar,
      otrosActivos: otrosActivos ?? this.otrosActivos,
      activoFijo: activoFijo ?? this.activoFijo,
      proveedores: proveedores ?? this.proveedores,
      cuentasXPagar: cuentasXPagar ?? this.cuentasXPagar,
      otrasDeudas: otrasDeudas ?? this.otrasDeudas,
      ventasContado: ventasContado ?? this.ventasContado,
      recuperaciones: recuperaciones ?? this.recuperaciones,
      otrosIngresos: otrosIngresos ?? this.otrosIngresos,
      gastosUnidadFamiliar: gastosUnidadFamiliar ?? this.gastosUnidadFamiliar,
      gastosOperativos: gastosOperativos ?? this.gastosOperativos,
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
      inventarioTb: inventarioTb ?? this.inventarioTb,
    );
  }
}

final class ActualizarAnalisisMenorMilInitial
    extends ActualizarAnalisisMenorMilState {}

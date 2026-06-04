// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_asalariado_hn_cubit.dart';

class AnalisisAsalariadoHnState extends Equatable {
  final String objEmpleadoVerificaReferenciaID1;
  final String objEmpleadoVerificaReferenciaID2;
  final String objEmpleadoVerificaReferenciaID3;
  final int idLocalResponse;
  final String? uuid;
  final String errorMsg;
  final Status status;
  final String database;
  final int numeroSolicitud;
  final double activo;
  final double cuentasXCobrar;
  final int valoresAcciones;
  final double menajeHogar;
  final int vehiculo;
  final double maquinaria;
  final int bienesInmuebles;
  final double totalActivo;
  final int cuentasXPagar;
  final double prestamoBancoCp;
  final int prestamoBancoLp;
  final double otrasCuentasXPagar;
  final double totalPasivo;
  final int patrimonio;
  final double pasivoPatrimonio;
  final double ingresoNetoSalario;
  final double otrosIngresos;
  final double totalIngresos;
  final int alimentacion;
  final int educacion;
  final int serviciosBasicos;
  final int aseoLimpieza;
  final int vestimentaCalzado;
  final int transporteCombustibleMtto;
  final int imprevistos;
  final int amortizacionesDeudas;
  final int otrosEgresos;
  final int totalEgresos;
  final double disponible;
  final String fechaVerificacion1;
  final String nombreReferencia1;
  final String cedulaReferencia1;
  final String direccionReferencia1;
  final String telefonoReferencia1;
  final String lugarTrabajoReferencia1;
  final int aniosConocerReferido1;
  final String parentescoReferenciaCodigo1;
  final String resultadoVerificacion1;
  final String fechaVerificacion2;
  final String nombreReferencia2;
  final String cedulaReferencia2;
  final String direccionReferencia2;
  final String telefonoReferencia2;
  final String lugarTrabajoReferencia2;
  final int aniosConocerReferido2;
  final String parentescoReferenciaCodigo2;
  final String resultadoVerificacion2;
  final String fechaVerificacion3;
  final String nombreReferencia3;
  final String cedulaReferencia3;
  final String direccionReferencia3;
  final String telefonoReferencia3;
  final String lugarTrabajoReferencia3;
  final int aniosConocerReferido3;
  final String parentescoReferenciaCodigo3;
  final String resultadoVerificacion3;
  const AnalisisAsalariadoHnState({
    this.objEmpleadoVerificaReferenciaID1 = '',
    this.objEmpleadoVerificaReferenciaID2 = '',
    this.objEmpleadoVerificaReferenciaID3 = '',
    this.idLocalResponse = 0,
    this.uuid,
    this.errorMsg = '',
    this.status = Status.notStarted,
    this.database = '',
    this.numeroSolicitud = 0,
    this.activo = 0,
    this.cuentasXCobrar = 0,
    this.valoresAcciones = 0,
    this.menajeHogar = 0,
    this.vehiculo = 0,
    this.maquinaria = 0,
    this.bienesInmuebles = 0,
    this.totalActivo = 0,
    this.cuentasXPagar = 0,
    this.prestamoBancoCp = 0,
    this.prestamoBancoLp = 0,
    this.otrasCuentasXPagar = 0,
    this.totalPasivo = 0,
    this.patrimonio = 0,
    this.pasivoPatrimonio = 0,
    this.ingresoNetoSalario = 0,
    this.otrosIngresos = 0,
    this.totalIngresos = 0,
    this.alimentacion = 0,
    this.educacion = 0,
    this.serviciosBasicos = 0,
    this.aseoLimpieza = 0,
    this.vestimentaCalzado = 0,
    this.transporteCombustibleMtto = 0,
    this.imprevistos = 0,
    this.amortizacionesDeudas = 0,
    this.otrosEgresos = 0,
    this.totalEgresos = 0,
    this.disponible = 0,
    this.fechaVerificacion1 = '',
    this.nombreReferencia1 = '',
    this.cedulaReferencia1 = '',
    this.direccionReferencia1 = '',
    this.telefonoReferencia1 = '',
    this.lugarTrabajoReferencia1 = '',
    this.aniosConocerReferido1 = 0,
    this.parentescoReferenciaCodigo1 = '',
    this.resultadoVerificacion1 = '',
    this.fechaVerificacion2 = '',
    this.nombreReferencia2 = '',
    this.cedulaReferencia2 = '',
    this.direccionReferencia2 = '',
    this.telefonoReferencia2 = '',
    this.lugarTrabajoReferencia2 = '',
    this.aniosConocerReferido2 = 0,
    this.parentescoReferenciaCodigo2 = '',
    this.resultadoVerificacion2 = '',
    this.fechaVerificacion3 = '',
    this.nombreReferencia3 = '',
    this.cedulaReferencia3 = '',
    this.direccionReferencia3 = '',
    this.telefonoReferencia3 = '',
    this.lugarTrabajoReferencia3 = '',
    this.aniosConocerReferido3 = 0,
    this.parentescoReferenciaCodigo3 = '',
    this.resultadoVerificacion3 = '',
  });

  @override
  List<Object> get props => [
        objEmpleadoVerificaReferenciaID1,
        objEmpleadoVerificaReferenciaID2,
        objEmpleadoVerificaReferenciaID3,
        idLocalResponse,
        errorMsg,
        status,
        database,
        numeroSolicitud,
        activo,
        cuentasXCobrar,
        valoresAcciones,
        menajeHogar,
        vehiculo,
        maquinaria,
        bienesInmuebles,
        totalActivo,
        cuentasXPagar,
        prestamoBancoCp,
        prestamoBancoLp,
        otrasCuentasXPagar,
        totalPasivo,
        patrimonio,
        pasivoPatrimonio,
        ingresoNetoSalario,
        otrosIngresos,
        totalIngresos,
        alimentacion,
        educacion,
        serviciosBasicos,
        aseoLimpieza,
        vestimentaCalzado,
        transporteCombustibleMtto,
        imprevistos,
        amortizacionesDeudas,
        otrosEgresos,
        totalEgresos,
        disponible,
        fechaVerificacion1,
        nombreReferencia1,
        cedulaReferencia1,
        direccionReferencia1,
        telefonoReferencia1,
        lugarTrabajoReferencia1,
        aniosConocerReferido1,
        parentescoReferenciaCodigo1,
        resultadoVerificacion1,
        fechaVerificacion2,
        nombreReferencia2,
        cedulaReferencia2,
        direccionReferencia2,
        telefonoReferencia2,
        lugarTrabajoReferencia2,
        aniosConocerReferido2,
        parentescoReferenciaCodigo2,
        resultadoVerificacion2,
        fechaVerificacion3,
        nombreReferencia3,
        cedulaReferencia3,
        direccionReferencia3,
        telefonoReferencia3,
        lugarTrabajoReferencia3,
        aniosConocerReferido3,
        parentescoReferenciaCodigo3,
        resultadoVerificacion3,
      ];

  AnalisisAsalariadoHnState copyWith({
    String? objEmpleadoVerificaReferenciaID1,
    String? objEmpleadoVerificaReferenciaID2,
    String? objEmpleadoVerificaReferenciaID3,
    int? idLocalResponse,
    String? uuid,
    String? errorMsg,
    Status? status,
    String? database,
    int? numeroSolicitud,
    double? activo,
    double? cuentasXCobrar,
    int? valoresAcciones,
    double? menajeHogar,
    int? vehiculo,
    double? maquinaria,
    int? bienesInmuebles,
    double? totalActivo,
    int? cuentasXPagar,
    double? prestamoBancoCp,
    int? prestamoBancoLp,
    double? otrasCuentasXPagar,
    double? totalPasivo,
    int? patrimonio,
    double? pasivoPatrimonio,
    double? ingresoNetoSalario,
    double? otrosIngresos,
    double? totalIngresos,
    int? alimentacion,
    int? educacion,
    int? serviciosBasicos,
    int? aseoLimpieza,
    int? vestimentaCalzado,
    int? transporteCombustibleMtto,
    int? imprevistos,
    int? amortizacionesDeudas,
    int? otrosEgresos,
    int? totalEgresos,
    double? disponible,
    String? fechaVerificacion1,
    String? nombreReferencia1,
    String? cedulaReferencia1,
    String? direccionReferencia1,
    String? telefonoReferencia1,
    String? lugarTrabajoReferencia1,
    int? aniosConocerReferido1,
    String? parentescoReferenciaCodigo1,
    String? resultadoVerificacion1,
    String? fechaVerificacion2,
    String? nombreReferencia2,
    String? cedulaReferencia2,
    String? direccionReferencia2,
    String? telefonoReferencia2,
    String? lugarTrabajoReferencia2,
    int? aniosConocerReferido2,
    String? parentescoReferenciaCodigo2,
    String? resultadoVerificacion2,
    String? fechaVerificacion3,
    String? nombreReferencia3,
    String? cedulaReferencia3,
    String? direccionReferencia3,
    String? telefonoReferencia3,
    String? lugarTrabajoReferencia3,
    int? aniosConocerReferido3,
    String? parentescoReferenciaCodigo3,
    String? resultadoVerificacion3,
  }) {
    return AnalisisAsalariadoHnState(
      objEmpleadoVerificaReferenciaID1: objEmpleadoVerificaReferenciaID1 ??
          this.objEmpleadoVerificaReferenciaID1,
      objEmpleadoVerificaReferenciaID2: objEmpleadoVerificaReferenciaID2 ??
          this.objEmpleadoVerificaReferenciaID2,
      objEmpleadoVerificaReferenciaID3: objEmpleadoVerificaReferenciaID3 ??
          this.objEmpleadoVerificaReferenciaID3,
      idLocalResponse: idLocalResponse ?? this.idLocalResponse,
      uuid: uuid ?? this.uuid,
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
      database: database ?? this.database,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      activo: activo ?? this.activo,
      cuentasXCobrar: cuentasXCobrar ?? this.cuentasXCobrar,
      valoresAcciones: valoresAcciones ?? this.valoresAcciones,
      menajeHogar: menajeHogar ?? this.menajeHogar,
      vehiculo: vehiculo ?? this.vehiculo,
      maquinaria: maquinaria ?? this.maquinaria,
      bienesInmuebles: bienesInmuebles ?? this.bienesInmuebles,
      totalActivo: totalActivo ?? this.totalActivo,
      cuentasXPagar: cuentasXPagar ?? this.cuentasXPagar,
      prestamoBancoCp: prestamoBancoCp ?? this.prestamoBancoCp,
      prestamoBancoLp: prestamoBancoLp ?? this.prestamoBancoLp,
      otrasCuentasXPagar: otrasCuentasXPagar ?? this.otrasCuentasXPagar,
      totalPasivo: totalPasivo ?? this.totalPasivo,
      patrimonio: patrimonio ?? this.patrimonio,
      pasivoPatrimonio: pasivoPatrimonio ?? this.pasivoPatrimonio,
      ingresoNetoSalario: ingresoNetoSalario ?? this.ingresoNetoSalario,
      otrosIngresos: otrosIngresos ?? this.otrosIngresos,
      totalIngresos: totalIngresos ?? this.totalIngresos,
      alimentacion: alimentacion ?? this.alimentacion,
      educacion: educacion ?? this.educacion,
      serviciosBasicos: serviciosBasicos ?? this.serviciosBasicos,
      aseoLimpieza: aseoLimpieza ?? this.aseoLimpieza,
      vestimentaCalzado: vestimentaCalzado ?? this.vestimentaCalzado,
      transporteCombustibleMtto:
          transporteCombustibleMtto ?? this.transporteCombustibleMtto,
      imprevistos: imprevistos ?? this.imprevistos,
      amortizacionesDeudas: amortizacionesDeudas ?? this.amortizacionesDeudas,
      otrosEgresos: otrosEgresos ?? this.otrosEgresos,
      totalEgresos: totalEgresos ?? this.totalEgresos,
      disponible: disponible ?? this.disponible,
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
    );
  }
}

final class AnalisisAsalariadoHnInitial extends AnalisisAsalariadoHnState {}

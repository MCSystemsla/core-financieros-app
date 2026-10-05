import 'package:core_financiero_app/src/config/helpers/parsers/parse_format.dart';

class GetDataAnalisisAsalariado {
  final int? numeroSolicitud;
  final num? activo;
  final num? cuentasXCobrar;
  final num? valoresAcciones;
  final num? menajeHogar;
  final num? vehiculo;
  final num? maquinaria;
  final num? bienesInmuebles;
  final num? cuentasXPagar;
  final num? prestamoBancoCp;
  final num? prestamoBancoLp;
  final num? otrasCuentasXPagar;
  final num? ingresoNetoSalario;
  final num? otrosIngresos;
  final num? alimentacion;
  final num? educacion;
  final num? serviciosBasicos;
  final num? aseoLimpieza;
  final num? vestimentaCalzado;
  final num? transporteCombustibleMtto;
  final num? amortizacionesDeudas;
  final num? otrosEgresos;
  final DateTime? fechaVerificacion1;
  final String? nombreReferencia1;
  final String? cedulaReferencia1;
  final String? direccionReferencia1;
  final String? telefonoReferencia1;
  final String? lugarTrabajoReferencia1;
  final int? aniosConocerReferido1;
  final String? parentescoReferenciaCodigo1;
  final String? resultadoVerificacion1;
  final int? objEmpleadoVerificaReferenciaId1;
  final DateTime? fechaVerificacion2;
  final String? nombreReferencia2;
  final String? cedulaReferencia2;
  final String? direccionReferencia2;
  final String? telefonoReferencia2;
  final String? lugarTrabajoReferencia2;
  final int? aniosConocerReferido2;
  final String? parentescoReferenciaCodigo2;
  final String? resultadoVerificacion2;
  final int? objEmpleadoVerificaReferenciaId2;
  final DateTime? fechaVerificacion3;
  final String? nombreReferencia3;
  final String? cedulaReferencia3;
  final String? direccionReferencia3;
  final String? telefonoReferencia3;
  final String? lugarTrabajoReferencia3;
  final int? aniosConocerReferido3;
  final String? parentescoReferenciaCodigo3;
  final String? resultadoVerificacion3;
  final int? objEmpleadoVerificaReferenciaId3;

  GetDataAnalisisAsalariado({
    this.numeroSolicitud,
    this.activo,
    this.cuentasXCobrar,
    this.valoresAcciones,
    this.menajeHogar,
    this.vehiculo,
    this.maquinaria,
    this.bienesInmuebles,
    this.cuentasXPagar,
    this.prestamoBancoCp,
    this.prestamoBancoLp,
    this.otrasCuentasXPagar,
    this.ingresoNetoSalario,
    this.otrosIngresos,
    this.alimentacion,
    this.educacion,
    this.serviciosBasicos,
    this.aseoLimpieza,
    this.vestimentaCalzado,
    this.transporteCombustibleMtto,
    this.amortizacionesDeudas,
    this.otrosEgresos,
    this.fechaVerificacion1,
    this.nombreReferencia1,
    this.cedulaReferencia1,
    this.direccionReferencia1,
    this.telefonoReferencia1,
    this.lugarTrabajoReferencia1,
    this.aniosConocerReferido1,
    this.parentescoReferenciaCodigo1,
    this.resultadoVerificacion1,
    this.objEmpleadoVerificaReferenciaId1,
    this.fechaVerificacion2,
    this.nombreReferencia2,
    this.cedulaReferencia2,
    this.direccionReferencia2,
    this.telefonoReferencia2,
    this.lugarTrabajoReferencia2,
    this.aniosConocerReferido2,
    this.parentescoReferenciaCodigo2,
    this.resultadoVerificacion2,
    this.objEmpleadoVerificaReferenciaId2,
    this.fechaVerificacion3,
    this.nombreReferencia3,
    this.cedulaReferencia3,
    this.direccionReferencia3,
    this.telefonoReferencia3,
    this.lugarTrabajoReferencia3,
    this.aniosConocerReferido3,
    this.parentescoReferenciaCodigo3,
    this.resultadoVerificacion3,
    this.objEmpleadoVerificaReferenciaId3,
  });

  factory GetDataAnalisisAsalariado.fromJson(Map<String, dynamic> json) =>
      GetDataAnalisisAsalariado(
        numeroSolicitud: parseInt(json['NumeroSolicitud']),
        activo: parseNum(json['Activo']),
        cuentasXCobrar: parseNum(json['CuentasXCobrar']),
        valoresAcciones: parseNum(json['ValoresAcciones']),
        menajeHogar: parseNum(json['MenajeHogar']),
        vehiculo: parseNum(json['Vehiculo']),
        maquinaria: parseNum(json['Maquinaria']),
        bienesInmuebles: parseNum(json['BienesInmuebles']),
        cuentasXPagar: parseNum(json['CuentasXPagar']),
        prestamoBancoCp: parseNum(json['PrestamoBancoCP']),
        prestamoBancoLp: parseNum(json['PrestamoBancoLP']),
        otrasCuentasXPagar: parseNum(json['OtrasCuentasXPagar']),
        ingresoNetoSalario: parseNum(json['IngresoNetoSalario']),
        otrosIngresos: parseNum(json['OtrosIngresos']),
        alimentacion: parseNum(json['Alimentacion']),
        educacion: parseNum(json['Educacion']),
        serviciosBasicos: parseNum(json['ServiciosBasicos']),
        aseoLimpieza: parseNum(json['AseoLimpieza']),
        vestimentaCalzado: parseNum(json['VestimentaCalzado']),
        transporteCombustibleMtto: parseNum(json['TransporteCombustibleMtto']),
        amortizacionesDeudas: parseNum(json['AmortizacionesDeudas']),
        otrosEgresos: parseNum(json['OtrosEgresos']),
        fechaVerificacion1: parseDate(json['FechaVerificacion1']),
        nombreReferencia1: json['NombreReferencia1'],
        cedulaReferencia1: json['CedulaReferencia1'],
        direccionReferencia1: json['DireccionReferencia1'],
        telefonoReferencia1: json['TelefonoReferencia1'],
        lugarTrabajoReferencia1: json['LugarTrabajoReferencia1'],
        aniosConocerReferido1: parseInt(json['AniosConocerReferido1']),
        parentescoReferenciaCodigo1: json['ParentescoReferenciaCodigo1'],
        resultadoVerificacion1: json['ResultadoVerificacion1'],
        objEmpleadoVerificaReferenciaId1:
            parseInt(json['objEmpleadoVerificaReferenciaID1']),
        fechaVerificacion2: parseDate(json['FechaVerificacion2']),
        nombreReferencia2: json['NombreReferencia2'],
        cedulaReferencia2: json['CedulaReferencia2'],
        direccionReferencia2: json['DireccionReferencia2'],
        telefonoReferencia2: json['TelefonoReferencia2'],
        lugarTrabajoReferencia2: json['LugarTrabajoReferencia2'],
        aniosConocerReferido2: parseInt(json['AniosConocerReferido2']),
        parentescoReferenciaCodigo2: json['ParentescoReferenciaCodigo2'],
        resultadoVerificacion2: json['ResultadoVerificacion2'],
        objEmpleadoVerificaReferenciaId2:
            parseInt(json['objEmpleadoVerificaReferenciaID2']),
        fechaVerificacion3: parseDate(json['FechaVerificacion3']),
        nombreReferencia3: json['NombreReferencia3'],
        cedulaReferencia3: json['CedulaReferencia3'],
        direccionReferencia3: json['DireccionReferencia3'],
        telefonoReferencia3: json['TelefonoReferencia3'],
        lugarTrabajoReferencia3: json['LugarTrabajoReferencia3'],
        aniosConocerReferido3: parseInt(json['AniosConocerReferido3']),
        parentescoReferenciaCodigo3: json['ParentescoReferenciaCodigo3'],
        resultadoVerificacion3: json['ResultadoVerificacion3'],
        objEmpleadoVerificaReferenciaId3:
            parseInt(json['objEmpleadoVerificaReferenciaID3']),
      );
}

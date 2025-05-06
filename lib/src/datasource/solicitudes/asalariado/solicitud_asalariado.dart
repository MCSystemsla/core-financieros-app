import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String solicitudAsalariadoToJson(SolicitudAsalariado data) =>
    json.encode(data.toJson());

class SolicitudAsalariado {
  final String objOrigenSolicitudId;
  final String database;
  final String nombre1;
  final String nombre2;
  final String apellido1;
  final String apellido2;
  final String cedula;
  final String objPaisEmisorCedula;
  final DateTime? fechaEmisionCedula;
  final DateTime? fechaVencimientoCedula;
  final DateTime? fechaNacimiento;
  final String telefono;
  final String celular;
  final String direccionCasa;
  final String barrioCasa;
  final String objMunicipioCasaId;
  final String objDepartamentoCasaId;
  final String objPaisCasaId;
  final String profesion;
  final String ocupacion;
  final String nacionalidad;
  final String objCondicionCasaId;
  final int anosResidirCasa;
  final String email;
  final double monto;
  final String objMonedaId;
  final String objPropositoId;
  final String objFrecuenciaId;
  final double cuota;
  final String objSectorId;
  final int personasACargo;
  final String objEstadoCivilId;
  final String nombreConyugue;
  final bool trabajaConyugue;
  final String trabajoConyugue;
  final String direccionTrabajoConyugue;
  final String telefonoTrabajoConyugue;
  final String beneficiarioSeguro;
  final String cedulaBeneficiarioSeguro;
  final String objParentescoBeneficiarioSeguroId;
  final String objEstadoSolicitudId;
  final String objOficialCreditoId;
  final String objProductoId;
  final String observacion;
  final String sucursal;
  final String ubicacionLongitud;
  final String ubicacionLatitud;
  final String ubicacionGradosLongitud;
  final String ubicacionGradosLatitud;
  final String objEscolaridadId;
  final int cantidadHijos;
  final String nombrePublico;
  final String objSexoId;
  final String objPaisNacimientoId;
  final String nacionalidadConyugue;
  final String ubicacion;
  final bool espeps;
  final String nombreDeEntidadPeps;
  final String paisPeps;
  final String periodoPeps;
  final String cargoOficialPeps;
  final bool tieneFamiliarPeps;
  final String nombreFamiliarPeps2;
  final String parentescoFamiliarPeps2;
  final String cargoFamiliarPeps2;
  final String nombreEntidadPeps2;
  final String periodoPeps2;
  final String paisPeps2;
  final String objRubroActividad;
  final String objActividadPredominante;
  final bool esFamiliarEmpleado;
  final String nombreFamiliar;
  final String cedulaFamiliar;
  final String objTipoDocumentoId;
  final String objRubroActividad2;
  final String objRubroActividad3;
  final String objRubroActividadPredominante;
  final String tipoPersona;
  final String objTipoPersonaId;
  final String telefonoBeneficiario;
  final String codigoRed;
  final int plazoSolicitud;
  final DateTime? fechaPrimerPagoSolicitud;
  final String nombreTrabajo;
  final String direccionTrabajo;
  final String barrioTrabajo;
  final String objActividadEconomicaId;
  final String objActividadEconomicaId1;
  final String objActividadEconomicaId2;
  final String cargo;
  final String direccionFamiliarCercano;
  final String duenoVivienda;
  final DateTime? fechaVenceAvaluoAsalariado;
  final String fuenteOtrosIngresos;
  final String fuenteOtrosIngresosConyugue;
  final String lugarTrabajoAnterior;
  final String nombreFamiliarCercano;
  final String objParentescoFamiliarCercanoId;
  final double otrosIngresosConyugue;
  final double otrosIngresosCordoba;
  final int pagoAlquiler;
  final String profesionConyugue;
  final double salarioNetoCordoba;
  final double sueldoMesConyugue;
  final String telefonoFamiliarCercano;
  final String telefonoTrabajo;
  final String tiempoLaborar;
  final String tiempoLaborarConyugue;
  final double totalIngresoMes;
  final double totalIngresoMesConyugue;

  SolicitudAsalariado({
    required this.objOrigenSolicitudId,
    required this.database,
    required this.nombre1,
    required this.nombre2,
    required this.apellido1,
    required this.apellido2,
    required this.cedula,
    required this.objPaisEmisorCedula,
    this.fechaEmisionCedula,
    this.fechaVencimientoCedula,
    this.fechaNacimiento,
    required this.telefono,
    required this.celular,
    required this.direccionCasa,
    required this.barrioCasa,
    required this.objMunicipioCasaId,
    required this.objDepartamentoCasaId,
    required this.objPaisCasaId,
    required this.profesion,
    required this.ocupacion,
    required this.nacionalidad,
    required this.objCondicionCasaId,
    required this.anosResidirCasa,
    required this.email,
    required this.monto,
    required this.objMonedaId,
    required this.objPropositoId,
    required this.objFrecuenciaId,
    required this.cuota,
    required this.objSectorId,
    required this.personasACargo,
    required this.objEstadoCivilId,
    required this.nombreConyugue,
    required this.trabajaConyugue,
    required this.trabajoConyugue,
    required this.direccionTrabajoConyugue,
    required this.telefonoTrabajoConyugue,
    required this.beneficiarioSeguro,
    required this.cedulaBeneficiarioSeguro,
    required this.objParentescoBeneficiarioSeguroId,
    required this.objEstadoSolicitudId,
    required this.objOficialCreditoId,
    required this.objProductoId,
    required this.observacion,
    required this.sucursal,
    required this.ubicacionLongitud,
    required this.ubicacionLatitud,
    required this.ubicacionGradosLongitud,
    required this.ubicacionGradosLatitud,
    required this.objEscolaridadId,
    required this.cantidadHijos,
    required this.nombrePublico,
    required this.objSexoId,
    required this.objPaisNacimientoId,
    required this.nacionalidadConyugue,
    required this.ubicacion,
    required this.espeps,
    required this.nombreDeEntidadPeps,
    required this.paisPeps,
    required this.periodoPeps,
    required this.cargoOficialPeps,
    required this.tieneFamiliarPeps,
    required this.nombreFamiliarPeps2,
    required this.parentescoFamiliarPeps2,
    required this.cargoFamiliarPeps2,
    required this.nombreEntidadPeps2,
    required this.periodoPeps2,
    required this.paisPeps2,
    required this.objRubroActividad,
    required this.objActividadPredominante,
    required this.esFamiliarEmpleado,
    required this.nombreFamiliar,
    required this.cedulaFamiliar,
    required this.objTipoDocumentoId,
    required this.objRubroActividad2,
    required this.objRubroActividad3,
    required this.objRubroActividadPredominante,
    required this.tipoPersona,
    required this.objTipoPersonaId,
    required this.telefonoBeneficiario,
    required this.codigoRed,
    required this.plazoSolicitud,
    this.fechaPrimerPagoSolicitud,
    required this.nombreTrabajo,
    required this.direccionTrabajo,
    required this.barrioTrabajo,
    required this.objActividadEconomicaId,
    required this.objActividadEconomicaId1,
    required this.objActividadEconomicaId2,
    required this.cargo,
    required this.direccionFamiliarCercano,
    required this.duenoVivienda,
    this.fechaVenceAvaluoAsalariado,
    required this.fuenteOtrosIngresos,
    required this.fuenteOtrosIngresosConyugue,
    required this.lugarTrabajoAnterior,
    required this.nombreFamiliarCercano,
    required this.objParentescoFamiliarCercanoId,
    required this.otrosIngresosConyugue,
    required this.otrosIngresosCordoba,
    required this.pagoAlquiler,
    required this.profesionConyugue,
    required this.salarioNetoCordoba,
    required this.sueldoMesConyugue,
    required this.telefonoFamiliarCercano,
    required this.telefonoTrabajo,
    required this.tiempoLaborar,
    required this.tiempoLaborarConyugue,
    required this.totalIngresoMes,
    required this.totalIngresoMesConyugue,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'objOrigenSolicitudID': 'APPMOVIL',
      'database': LocalStorage().database,
      'Nombre1': nombre1,
      'Nombre2': nombre2,
      'Apellido1': apellido1,
      'Apellido2': apellido2,
      'Cedula': cedula,
      'ObjPaisEmisorCedula': objPaisEmisorCedula,
      'FechaEmisionCedula': fechaEmisionCedula?.toIso8601String(),
      'FechaVencimientoCedula': fechaVencimientoCedula?.toIso8601String(),
      'FechaNacimiento': fechaNacimiento?.toIso8601String(),
      'Telefono': telefono,
      'Celular': celular,
      'DireccionCasa': direccionCasa,
      'BarrioCasa': barrioCasa,
      'objMunicipioCasaID': objMunicipioCasaId,
      'objDepartamentoCasaID': objDepartamentoCasaId,
      'objPaisCasaID': objPaisCasaId,
      'Profesion': profesion,
      'Ocupacion': ocupacion,
      'Nacionalidad': nacionalidad,
      'objCondicionCasaID': objCondicionCasaId,
      'AnosResidirCasa': anosResidirCasa,
      'Email': email,
      'Monto': monto,
      'objMonedaID': objMonedaId,
      'objPropositoID': objPropositoId,
      'objFrecuenciaID': objFrecuenciaId,
      'Cuota': cuota,
      'objSectorID': objSectorId,
      'PersonasACargo': personasACargo,
      'objEstadoCivilID': objEstadoCivilId,
      'NombreConyugue': nombreConyugue,
      'TrabajaConyugue': trabajaConyugue,
      'TrabajoConyugue': trabajoConyugue,
      'DireccionTrabajoConyugue': direccionTrabajoConyugue,
      'TelefonoTrabajoConyugue': telefonoTrabajoConyugue,
      'BeneficiarioSeguro': beneficiarioSeguro,
      'CedulaBeneficiarioSeguro': cedulaBeneficiarioSeguro,
      'objParentescoBeneficiarioSeguroID': objParentescoBeneficiarioSeguroId,
      'objEstadoSolicitudID': objEstadoSolicitudId,
      'objOficialCreditoID': objOficialCreditoId,
      'objProductoID': objProductoId,
      'Observacion': observacion,
      'Sucursal': sucursal,
      'UbicacionLongitud': ubicacionLongitud,
      'UbicacionLatitud': ubicacionLatitud,
      'UbicacionGradosLongitud': ubicacionGradosLongitud,
      'UbicacionGradosLatitud': ubicacionGradosLatitud,
      'objEscolaridadID': objEscolaridadId,
      'CantidadHijos': cantidadHijos,
      'NombrePublico': nombrePublico,
      'objSexoID': objSexoId,
      'objPaisNacimientoID': objPaisNacimientoId,
      'NacionalidadConyugue': nacionalidadConyugue,
      'Ubicacion': ubicacion,
      'ESPEPS': espeps,
      'NombreDeEntidadPeps': nombreDeEntidadPeps,
      'PaisPeps': paisPeps,
      'PeriodoPeps': periodoPeps,
      'CargoOficialPeps': cargoOficialPeps,
      'TieneFamiliarPeps': tieneFamiliarPeps,
      'NombreFamiliarPeps2': nombreFamiliarPeps2,
      'ParentescoFamiliarPeps2': parentescoFamiliarPeps2,
      'CargoFamiliarPeps2': cargoFamiliarPeps2,
      'NombreEntidadPeps2': nombreEntidadPeps2,
      'PeriodoPeps2': periodoPeps2,
      'PaisPeps2': paisPeps2,
      'objRubroActividad': objRubroActividad,
      'objActividadPredominante': objActividadPredominante,
      'EsFamiliarEmpleado': esFamiliarEmpleado,
      'NombreFamiliar': nombreFamiliar,
      'CedulaFamiliar': cedulaFamiliar,
      'objTipoDocumentoID': objTipoDocumentoId,
      'objRubroActividad2': objRubroActividad2,
      'objRubroActividad3': objRubroActividad3,
      'objRubroActividadPredominante': objRubroActividadPredominante,
      'tipoPersona': tipoPersona,
      'objTipoPersonaID': objTipoPersonaId,
      'TelefonoBeneficiario': telefonoBeneficiario,
      'codigoRed': codigoRed,
      'PlazoSolicitud': plazoSolicitud,
      'FechaPrimerPagoSolicitud': fechaPrimerPagoSolicitud?.toIso8601String(),
      'NombreTrabajo': nombreTrabajo,
      'DireccionTrabajo': direccionTrabajo,
      'BarrioTrabajo': barrioTrabajo,
      'objActividadEconomicaID': objActividadEconomicaId,
      'objActividadEconomicaID1': objActividadEconomicaId1,
      'objActividadEconomicaID2': objActividadEconomicaId2,
      'Cargo': cargo,
      'DireccionFamiliarCercano': direccionFamiliarCercano,
      'DuenoVivienda': duenoVivienda,
      'FechaVenceAvaluoAsalariado':
          fechaVenceAvaluoAsalariado?.toIso8601String(),
      'FuenteOtrosIngresos': fuenteOtrosIngresos,
      'FuenteOtrosIngresosConyugue': fuenteOtrosIngresosConyugue,
      'LugarTrabajoAnterior': lugarTrabajoAnterior,
      'NombreFamiliarCercano': nombreFamiliarCercano,
      'objParentescoFamiliarCercanoId': objParentescoFamiliarCercanoId,
      'OtrosIngresosConyugue': otrosIngresosConyugue,
      'OtrosIngresosCordoba': otrosIngresosCordoba,
      'PagoAlquiler': pagoAlquiler,
      'ProfesionConyugue': profesionConyugue,
      'SalarioNetoCordoba': salarioNetoCordoba,
      'SueldoMesConyugue': sueldoMesConyugue,
      'TelefonoFamiliarCercano': telefonoFamiliarCercano,
      'TelefonoTrabajo': telefonoTrabajo,
      'TiempoLaborar': tiempoLaborar,
      'TiempoLaborarConyugue': tiempoLaborarConyugue,
      'TotalIngresoMes': totalIngresoMes,
      'TotalIngresoMesConyugue': totalIngresoMesConyugue,
    };
    data.removeWhere(
      (key, value) => value == null || value == '',
    );
    return data;
  }
}

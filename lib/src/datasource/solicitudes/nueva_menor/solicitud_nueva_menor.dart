import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String solicitudNuevaMenorToJson(SolicitudNuevaMenor data) =>
    json.encode(data.toJson());

class SolicitudNuevaMenor {
  final bool isOffline;
  final String objOrigenSolicitudId;
  final String nombre1;
  final String nombre2;
  final String apellido1;
  final String apellido2;
  final String cedula;
  final String objPaisEmisorCedula;
  final String fechaEmisionCedula;
  final String fechaVencimientoCedula;
  final String fechaNacimiento;
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
  final int monto;
  final String objMonedaId;
  final String objPropositoId;
  final String objFrecuenciaId;
  final int cuota;
  final String objActividadId;
  final String objActividadId1;
  final String objActividadId2;
  final String objSectorId;
  final String nombreNegocio;
  final String tiempoFuncionamientoNegocio;
  final String direccionNegocio;
  final String barrioNegocio;
  final String objMunicipioNegocioId;
  final String objCondicionNegocioId;
  final String horarioTrabajo;
  final String horarioVisita;
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
  final String beneficiarioSeguro1;
  final String cedulaBeneficiarioSeguro1;
  final String objParentescoBeneficiarioSeguroId1;
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
  final String database;
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
  final String telefonoBeneficiarioSeguro1;
  final int plazoSolicitud;
  final String fechaPrimerPagoSolicitud;
  SolicitudNuevaMenor({
    required this.isOffline,
    required this.objOrigenSolicitudId,
    required this.nombre1,
    required this.nombre2,
    required this.apellido1,
    required this.apellido2,
    required this.cedula,
    required this.objPaisEmisorCedula,
    required this.fechaEmisionCedula,
    required this.fechaVencimientoCedula,
    required this.fechaNacimiento,
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
    required this.objActividadId,
    required this.objActividadId1,
    required this.objActividadId2,
    required this.objSectorId,
    required this.nombreNegocio,
    required this.tiempoFuncionamientoNegocio,
    required this.direccionNegocio,
    required this.barrioNegocio,
    required this.objMunicipioNegocioId,
    required this.objCondicionNegocioId,
    required this.horarioTrabajo,
    required this.horarioVisita,
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
    required this.beneficiarioSeguro1,
    required this.cedulaBeneficiarioSeguro1,
    required this.objParentescoBeneficiarioSeguroId1,
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
    required this.database,
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
    required this.telefonoBeneficiarioSeguro1,
    required this.plazoSolicitud,
    required this.fechaPrimerPagoSolicitud,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'objOrigenSolicitudID': 'APPMOVIL',
      'Nombre1': nombre1,
      'Nombre2': nombre2,
      'Apellido1': apellido1,
      'Apellido2': apellido2,
      'Cedula': cedula,
      'ObjPaisEmisorCedula': objPaisEmisorCedula,
      'FechaEmisionCedula': fechaEmisionCedula,
      'FechaVencimientoCedula': fechaVencimientoCedula,
      'FechaNacimiento': fechaNacimiento,
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
      'objActividadID': objActividadId,
      'objActividadID1': objActividadId1,
      'objActividadID2': objActividadId2,
      'objSectorID': objSectorId,
      'NombreNegocio': nombreNegocio,
      'TiempoFuncionamientoNegocio': tiempoFuncionamientoNegocio,
      'DireccionNegocio': direccionNegocio,
      'BarrioNegocio': barrioNegocio,
      'objMunicipioNegocioID': objMunicipioNegocioId,
      'objCondicionNegocioID': objCondicionNegocioId,
      'HorarioTrabajo': horarioTrabajo,
      'HorarioVisita': horarioVisita,
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
      'BeneficiarioSeguro1': beneficiarioSeguro1,
      'CedulaBeneficiarioSeguro1': cedulaBeneficiarioSeguro1,
      'objParentescoBeneficiarioSeguroID1': objParentescoBeneficiarioSeguroId1,
      'objEstadoSolicitudID': objEstadoSolicitudId,
      'objOficialCreditoID': objOficialCreditoId,
      'ProductoCodigo': objProductoId,
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
      'database': LocalStorage().database,
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
      'TelefonoBeneficiarioSeguro1': telefonoBeneficiarioSeguro1,
      'PlazoSolicitud': plazoSolicitud,
      'FechaPrimerPagoSolicitud': fechaPrimerPagoSolicitud,
      'IsOffline': isOffline,
    };
    data.removeWhere(
      (key, value) => value == null || value == '' || value == 0,
    );
    return data;
  }
}

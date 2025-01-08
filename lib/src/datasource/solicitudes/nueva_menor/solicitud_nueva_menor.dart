import 'dart:convert';

String solicitudNuevaMenorToJson(SolicitudNuevaMenor data) =>
    json.encode(data.toJson());

class SolicitudNuevaMenor {
  final int objOrigenSolicitudId;
  final String nombre1;
  final String nombre2;
  final String apellido1;
  final String apellido2;
  final String cedula;
  final int objPaisEmisorCedula;
  final DateTime fechaEmisionCedula;
  final DateTime fechaVencimientoCedula;
  final DateTime fechaNacimiento;
  final String telefono;
  final String celular;
  final String direccionCasa;
  final String barrioCasa;
  final int objMunicipioCasaId;
  final int objDepartamentoCasaId;
  final int objPaisCasaId;
  final String profesion;
  final String ocupacion;
  final String nacionalidad;
  final int objCondicionCasaId;
  final int anosResidirCasa;
  final String email;
  final int monto;
  final int objMonedaId;
  final int objPropositoId;
  final int objFrecuenciaId;
  final int cuota;
  final int objActividadId;
  final int objActividadId1;
  final int objActividadId2;
  final int objSectorId;
  final String nombreNegocio;
  final int tiempoFuncionamientoNegocio;
  final String direccionNegocio;
  final String barrioNegocio;
  final int objMunicipioNegocioId;
  final int objCondicionNegocioId;
  final String horarioTrabajo;
  final String horarioVisita;
  final int personasACargo;
  final int objEstadoCivilId;
  final String nombreConyugue;
  final bool trabajaConyugue;
  final String trabajoConyugue;
  final String direccionTrabajoConyugue;
  final String telefonoTrabajoConyugue;
  final String beneficiarioSeguro;
  final String cedulaBeneficiarioSeguro;
  final int objParentescoBeneficiarioSeguroId;
  final String beneficiarioSeguro1;
  final String cedulaBeneficiarioSeguro1;
  final int objParentescoBeneficiarioSeguroId1;
  final int objEstadoSolicitudId;
  final int objOficialCreditoId;
  final int objProductoId;
  final String observacion;
  final String sucursal;
  final String ubicacionLongitud;
  final String ubicacionLatitud;
  final String ubicacionGradosLongitud;
  final String ubicacionGradosLatitud;
  final int objEscolaridadId;
  final int cantidadHijos;
  final String nombrePublico;
  final int objSexoId;
  final int objPaisNacimientoId;
  final String nacionalidadConyugue;
  final String database;

  SolicitudNuevaMenor({
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
  });

  Map<String, dynamic> toJson() => {
        'objOrigenSolicitudID': objOrigenSolicitudId,
        'Nombre1': nombre1,
        'Nombre2': nombre2,
        'Apellido1': apellido1,
        'Apellido2': apellido2,
        'Cedula': cedula,
        'ObjPaisEmisorCedula': objPaisEmisorCedula,
        'FechaEmisionCedula': fechaEmisionCedula.toIso8601String(),
        'FechaVencimientoCedula': fechaVencimientoCedula.toIso8601String(),
        'FechaNacimiento': fechaNacimiento.toIso8601String(),
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
        'objParentescoBeneficiarioSeguroID1':
            objParentescoBeneficiarioSeguroId1,
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
        'database': database,
      };
}

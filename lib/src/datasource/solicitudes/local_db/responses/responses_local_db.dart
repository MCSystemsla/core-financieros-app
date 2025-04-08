import 'package:objectbox/objectbox.dart';

@Entity()
class ResponseLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? objOrigenSolicitudId;
  String? objOrigenSolicitudIdVer;
  String? nombre1;
  String? nombre2;
  String? apellido1;
  String? apellido2;
  String? cedula;
  String? objPaisEmisorCedula;
  String? objPaisEmisorCedulaVer;
  String? fechaEmisionCedula;
  String? fechaVencimientoCedula;
  String? fechaNacimiento;
  String? telefono;
  String? celular;
  String? direccionCasa;
  String? barrioCasa;
  String? objMunicipioCasaId;
  String? objMunicipioCasaIdVer;
  String? objDepartamentoCasaId;
  String? objDepartamentoCasaIdVer;
  String? objPaisCasaId;
  String? objPaisCasaIdVer;
  String? profesion;
  String? ocupacion;
  String? nacionalidad;
  String? objCondicionCasaId;
  String? objCondicionCasaIdVer;
  int? anosResidirCasa;
  String? email;
  int? monto;
  String? objMonedaId;
  String? objMonedaIdVer;
  String? objPropositoId;
  String? objPropositoIdVer;
  String? objFrecuenciaId;
  String? objFrecuenciaIdVer;
  int? cuota;
  String? objActividadId;
  String? objActividadIdVer;
  String? objActividadId1;
  String? objActividadId1Ver;
  String? objActividadId2;
  String? objActividadId2Ver;
  String? objSectorId;
  String? objSectorIdVer;
  String? nombreNegocio;
  String? tiempoFuncionamientoNegocio;
  String? direccionNegocio;
  String? barrioNegocio;
  String? objMunicipioNegocioId;
  String? objMunicipioNegocioIdVer;
  String? objCondicionNegocioId;
  String? objCondicionNegocioIdVer;
  String? horarioTrabajo;
  String? horarioVisita;
  int? personasACargo;
  String? objEstadoCivilId;
  String? objEstadoCivilIdVer;
  String? nombreConyugue;
  bool? trabajaConyugue;
  String? trabajoConyugue;
  String? direccionTrabajoConyugue;
  String? telefonoTrabajoConyugue;
  String? beneficiarioSeguro;
  String? cedulaBeneficiarioSeguro;
  String? objParentescoBeneficiarioSeguroId;
  String? objParentescoBeneficiarioSeguroIdVer;
  String? beneficiarioSeguro1;
  String? cedulaBeneficiarioSeguro1;
  String? objParentescoBeneficiarioSeguroId1;
  String? objParentescoBeneficiarioSeguroId1Ver;
  String? objEstadoSolicitudId;
  String? objEstadoSolicitudIdVer;
  String? objOficialCreditoId;
  String? objOficialCreditoIdVer;
  String? objProductoId;
  String? objProductoIdVer;
  String? observacion;
  String? sucursal;
  String? ubicacionLongitud;
  String? ubicacionLatitud;
  String? ubicacionGradosLongitud;
  String? ubicacionGradosLatitud;
  String? objEscolaridadId;
  String? objEscolaridadIdVer;
  int? cantidadHijos;
  String? nombrePublico;
  String? objSexoId;
  String? objSexoIdVer;
  String? objPaisNacimientoId;
  String? objPaisNacimientoIdVer;
  String? nacionalidadConyugue;
  String? database;
  String? ubicacion;
  bool? espeps;
  String? nombreDeEntidadPeps;
  String? paisPeps;
  String? periodoPeps;
  String? cargoOficialPeps;
  bool? tieneFamiliarPeps;
  String? nombreFamiliarPeps2;
  String? parentescoFamiliarPeps2;
  String? cargoFamiliarPeps2;
  String? nombreEntidadPeps2;
  String? periodoPeps2;
  String? paisPeps2;
  String? objRubroActividad;
  String? objRubroActividadVer;
  String? objActividadPredominante;
  String? objActividadPredominanteVer;
  bool? esFamiliarEmpleado;
  String? nombreFamiliar;
  String? cedulaFamiliar;
  String? objTipoDocumentoId;
  String? objTipoDocumentoIdVer;
  String? objRubroActividad2;
  String? objRubroActividad2Ver;
  String? objRubroActividad3;
  String? objRubroActividad3Ver;
  String? objRubroActividadPredominante;
  String? objRubroActividadPredominanteVer;
  String? tipoPersona;
  String? objTipoPersonaId;
  String? objTipoPersonaIdVer;
  String? telefonoBeneficiario;
  String? telefonoBeneficiarioSeguro1;
  int? plazoSolicitud;
  String? fechaPrimerPagoSolicitud;
  String? fechaDesembolso;
  double? prestamoInteres;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  bool? isDone;
  String? errorMsg;
  bool? hasVerified;

  ResponseLocalDb({
    this.objOrigenSolicitudId,
    this.objOrigenSolicitudIdVer,
    this.nombre1,
    this.nombre2,
    this.apellido1,
    this.apellido2,
    this.cedula,
    this.objPaisEmisorCedula,
    this.objPaisEmisorCedulaVer,
    this.fechaEmisionCedula,
    this.fechaVencimientoCedula,
    this.fechaNacimiento,
    this.telefono,
    this.celular,
    this.direccionCasa,
    this.barrioCasa,
    this.objMunicipioCasaId,
    this.objMunicipioCasaIdVer,
    this.objDepartamentoCasaId,
    this.objDepartamentoCasaIdVer,
    this.objPaisCasaId,
    this.objPaisCasaIdVer,
    this.profesion,
    this.ocupacion,
    this.nacionalidad,
    this.objCondicionCasaId,
    this.objCondicionCasaIdVer,
    this.anosResidirCasa,
    this.email,
    this.monto,
    this.objMonedaId,
    this.objMonedaIdVer,
    this.objPropositoId,
    this.objPropositoIdVer,
    this.objFrecuenciaId,
    this.objFrecuenciaIdVer,
    this.cuota,
    this.objActividadId,
    this.objActividadIdVer,
    this.objActividadId1,
    this.objActividadId1Ver,
    this.objActividadId2,
    this.objActividadId2Ver,
    this.objSectorId,
    this.objSectorIdVer,
    this.nombreNegocio,
    this.tiempoFuncionamientoNegocio,
    this.direccionNegocio,
    this.barrioNegocio,
    this.objMunicipioNegocioId,
    this.objMunicipioNegocioIdVer,
    this.objCondicionNegocioId,
    this.objCondicionNegocioIdVer,
    this.horarioTrabajo,
    this.horarioVisita,
    this.personasACargo,
    this.objEstadoCivilId,
    this.objEstadoCivilIdVer,
    this.nombreConyugue,
    this.trabajaConyugue,
    this.trabajoConyugue,
    this.direccionTrabajoConyugue,
    this.telefonoTrabajoConyugue,
    this.beneficiarioSeguro,
    this.cedulaBeneficiarioSeguro,
    this.objParentescoBeneficiarioSeguroId,
    this.objParentescoBeneficiarioSeguroIdVer,
    this.beneficiarioSeguro1,
    this.cedulaBeneficiarioSeguro1,
    this.objParentescoBeneficiarioSeguroId1,
    this.objParentescoBeneficiarioSeguroId1Ver,
    this.objEstadoSolicitudId,
    this.objEstadoSolicitudIdVer,
    this.objOficialCreditoId,
    this.objOficialCreditoIdVer,
    this.objProductoId,
    this.objProductoIdVer,
    this.observacion,
    this.sucursal,
    this.ubicacionLongitud,
    this.ubicacionLatitud,
    this.ubicacionGradosLongitud,
    this.ubicacionGradosLatitud,
    this.objEscolaridadId,
    this.objEscolaridadIdVer,
    this.cantidadHijos,
    this.nombrePublico,
    this.objSexoId,
    this.objSexoIdVer,
    this.objPaisNacimientoId,
    this.objPaisNacimientoIdVer,
    this.nacionalidadConyugue,
    this.database,
    this.ubicacion,
    this.espeps,
    this.nombreDeEntidadPeps,
    this.paisPeps,
    this.periodoPeps,
    this.cargoOficialPeps,
    this.tieneFamiliarPeps,
    this.nombreFamiliarPeps2,
    this.parentescoFamiliarPeps2,
    this.cargoFamiliarPeps2,
    this.nombreEntidadPeps2,
    this.periodoPeps2,
    this.paisPeps2,
    this.objRubroActividad,
    this.objRubroActividadVer,
    this.objActividadPredominante,
    this.objActividadPredominanteVer,
    this.esFamiliarEmpleado,
    this.nombreFamiliar,
    this.cedulaFamiliar,
    this.objTipoDocumentoId,
    this.objTipoDocumentoIdVer,
    this.objRubroActividad2,
    this.objRubroActividad2Ver,
    this.objRubroActividad3,
    this.objRubroActividad3Ver,
    this.objRubroActividadPredominante,
    this.objRubroActividadPredominanteVer,
    this.tipoPersona,
    this.objTipoPersonaId,
    this.objTipoPersonaIdVer,
    this.telefonoBeneficiario,
    this.telefonoBeneficiarioSeguro1,
    this.plazoSolicitud,
    this.fechaPrimerPagoSolicitud,
    this.fechaDesembolso,
    this.prestamoInteres,
    this.createdAt,
    this.isDone = false,
    this.hasVerified = false,
    this.errorMsg,
  });
}

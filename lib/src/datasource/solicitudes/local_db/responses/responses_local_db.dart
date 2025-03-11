import 'package:objectbox/objectbox.dart';

@Entity()
class ResponseLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? objOrigenSolicitudId;
  String? nombre1;
  String? nombre2;
  String? apellido1;
  String? apellido2;
  String? cedula;
  String? objPaisEmisorCedula;
  String? fechaEmisionCedula;
  String? fechaVencimientoCedula;
  String? fechaNacimiento;
  String? telefono;
  String? celular;
  String? direccionCasa;
  String? barrioCasa;
  String? objMunicipioCasaId;
  String? objDepartamentoCasaId;
  String? objPaisCasaId;
  String? profesion;
  String? ocupacion;
  String? nacionalidad;
  String? objCondicionCasaId;
  int? anosResidirCasa;
  String? email;
  int? monto;
  String? objMonedaId;
  String? objPropositoId;
  String? objFrecuenciaId;
  int? cuota;
  String? objActividadId;
  String? objActividadId1;
  String? objActividadId2;
  String? objSectorId;
  String? nombreNegocio;
  String? tiempoFuncionamientoNegocio;
  String? direccionNegocio;
  String? barrioNegocio;
  String? objMunicipioNegocioId;
  String? objCondicionNegocioId;
  String? horarioTrabajo;
  String? horarioVisita;
  int? personasACargo;
  String? objEstadoCivilId;
  String? nombreConyugue;
  bool? trabajaConyugue;
  String? trabajoConyugue;
  String? direccionTrabajoConyugue;
  String? telefonoTrabajoConyugue;
  String? beneficiarioSeguro;
  String? cedulaBeneficiarioSeguro;
  String? objParentescoBeneficiarioSeguroId;
  String? beneficiarioSeguro1;
  String? cedulaBeneficiarioSeguro1;
  String? objParentescoBeneficiarioSeguroId1;
  String? objEstadoSolicitudId;
  String? objOficialCreditoId;
  String? objProductoId;
  String? observacion;
  String? sucursal;
  String? ubicacionLongitud;
  String? ubicacionLatitud;
  String? ubicacionGradosLongitud;
  String? ubicacionGradosLatitud;
  String? objEscolaridadId;
  int? cantidadHijos;
  String? nombrePublico;
  String? objSexoId;
  String? objPaisNacimientoId;
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
  String? objActividadPredominante;
  bool? esFamiliarEmpleado;
  String? nombreFamiliar;
  String? cedulaFamiliar;
  String? objTipoDocumentoId;
  String? objRubroActividad2;
  String? objRubroActividad3;
  String? objRubroActividadPredominante;
  String? tipoPersona;
  String? objTipoPersonaId;
  String? telefonoBeneficiario;
  String? telefonoBeneficiarioSeguro1;
  int? plazoSolicitud;
  String? fechaPrimerPagoSolicitud;
  String? fechaDesembolso;
  double? prestamoInteres;
  @Property(type: PropertyType.date)
  DateTime? createdAt;

  ResponseLocalDb({
    this.objOrigenSolicitudId,
    this.nombre1,
    this.nombre2,
    this.apellido1,
    this.apellido2,
    this.cedula,
    this.objPaisEmisorCedula,
    this.fechaEmisionCedula,
    this.fechaVencimientoCedula,
    this.fechaNacimiento,
    this.telefono,
    this.celular,
    this.direccionCasa,
    this.barrioCasa,
    this.objMunicipioCasaId,
    this.objDepartamentoCasaId,
    this.objPaisCasaId,
    this.profesion,
    this.ocupacion,
    this.nacionalidad,
    this.objCondicionCasaId,
    this.anosResidirCasa,
    this.email,
    this.monto,
    this.objMonedaId,
    this.objPropositoId,
    this.objFrecuenciaId,
    this.cuota,
    this.objActividadId,
    this.objActividadId1,
    this.objActividadId2,
    this.objSectorId,
    this.nombreNegocio,
    this.tiempoFuncionamientoNegocio,
    this.direccionNegocio,
    this.barrioNegocio,
    this.objMunicipioNegocioId,
    this.objCondicionNegocioId,
    this.horarioTrabajo,
    this.horarioVisita,
    this.personasACargo,
    this.objEstadoCivilId,
    this.nombreConyugue,
    this.trabajaConyugue,
    this.trabajoConyugue,
    this.direccionTrabajoConyugue,
    this.telefonoTrabajoConyugue,
    this.beneficiarioSeguro,
    this.cedulaBeneficiarioSeguro,
    this.objParentescoBeneficiarioSeguroId,
    this.beneficiarioSeguro1,
    this.cedulaBeneficiarioSeguro1,
    this.objParentescoBeneficiarioSeguroId1,
    this.objEstadoSolicitudId,
    this.objOficialCreditoId,
    this.objProductoId,
    this.observacion,
    this.sucursal,
    this.ubicacionLongitud,
    this.ubicacionLatitud,
    this.ubicacionGradosLongitud,
    this.ubicacionGradosLatitud,
    this.objEscolaridadId,
    this.cantidadHijos,
    this.nombrePublico,
    this.objSexoId,
    this.objPaisNacimientoId,
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
    this.objActividadPredominante,
    this.esFamiliarEmpleado,
    this.nombreFamiliar,
    this.cedulaFamiliar,
    this.objTipoDocumentoId,
    this.objRubroActividad2,
    this.objRubroActividad3,
    this.objRubroActividadPredominante,
    this.tipoPersona,
    this.objTipoPersonaId,
    this.telefonoBeneficiario,
    this.telefonoBeneficiarioSeguro1,
    this.plazoSolicitud,
    this.fechaPrimerPagoSolicitud,
    this.fechaDesembolso,
    this.prestamoInteres,
    this.createdAt,
  });
}

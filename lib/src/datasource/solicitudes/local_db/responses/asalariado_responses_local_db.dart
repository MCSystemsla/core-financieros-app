// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class AsalariadoResponsesLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? objOrigenSolicitudId;
  String? database;
  String? nombre1;
  String? nombre2;
  String? apellido1;
  String? apellido2;
  String? cedula;
  String? objPaisEmisorCedula;
  String? objPaisEmisorCedulaVer;
  DateTime? fechaEmisionCedula;
  DateTime? fechaVencimientoCedula;
  DateTime? fechaNacimiento;
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
  double? monto;
  String? objMonedaId;
  String? objMonedaIdVer;
  String? objPropositoId;
  String? objPropositoIdVer;
  String? objFrecuenciaId;
  String? objFrecuenciaIdVer;
  double? cuota;
  String? objSectorId;
  String? objSectorIdVer;
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
  String? objEstadoSolicitudId;
  String? objOficialCreditoId;
  String? objProductoId;
  String? objProductoIdVer;
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
  String? objPaisNacimientoIdVer;
  String? nacionalidadConyugue;
  String? nacionalidadConyugueVer;
  String? ubicacion;
  bool? espeps;
  String? nombreDeEntidadPeps;
  String? paisPeps;
  String? paisPepsVer;
  String? periodoPeps;
  String? cargoOficialPeps;
  bool? tieneFamiliarPeps;
  String? nombreFamiliarPeps2;
  String? parentescoFamiliarPeps2;
  String? parentescoFamiliarPeps2Ver;
  String? cargoFamiliarPeps2;
  String? nombreEntidadPeps2;
  String? periodoPeps2;
  String? paisPeps2;
  String? paisPeps2Ver;
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
  String? telefonoBeneficiario;
  String? codigoRed;
  int? plazoSolicitud;
  DateTime? fechaPrimerPagoSolicitud;
  String? nombreTrabajo;
  String? direccionTrabajo;
  String? barrioTrabajo;
  String? objActividadEconomicaId;
  String? objActividadEconomicaIdVer;
  String? objActividadEconomicaId1;
  String? objActividadEconomicaId1Ver;
  String? objActividadEconomicaId2;
  String? objActividadEconomicaId2Ver;
  String? cargo;
  String? direccionFamiliarCercano;
  String? duenoVivienda;
  DateTime? fechaVenceAvaluoAsalariado;
  String? fuenteOtrosIngresos;
  String? fuenteOtrosIngresosConyugue;
  String? lugarTrabajoAnterior;
  String? nombreFamiliarCercano;
  String? objParentescoFamiliarCercanoId;
  String? objParentescoFamiliarCercanoIdVer;
  double? otrosIngresosConyugue;
  double? otrosIngresosCordoba;
  int? pagoAlquiler;
  String? profesionConyugue;
  double? salarioNetoCordoba;
  double? sueldoMesConyugue;
  String? telefonoFamiliarCercano;
  String? telefonoTrabajo;
  String? tiempoLaborar;
  String? tiempoLaborarConyugue;
  double? totalIngresoMes;
  double? totalIngresoMesConyugue;
  String? errorMsg;
  bool? isDone;
  bool? isOffline;
  bool? hasVerified;
  DateTime? fechaDesembolso;
  double? tasaInteres;
  int? montoMinimo;
  int? montoMaximo;
  String? objOrigenSolicitudIdVer;
  String? objParentescoBeneficiarioSeguroIdVer;
  String? objEstadoSolicitudIdVer;
  String? objOficialCreditoIdVer;
  String? objEscolaridadIdVer;
  String? objSexoIdVer;
  String? objTipoPersonaIdVer;
  String? uuid;
  String? frecuenciaPagoMeses;
  @Property(type: PropertyType.date)
  DateTime? createdAt;

  AsalariadoResponsesLocalDb({
    required this.id,
    this.objOrigenSolicitudId,
    this.database,
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
    this.objSectorId,
    this.objSectorIdVer,
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
    this.objEstadoSolicitudId,
    this.objOficialCreditoId,
    this.objProductoId,
    this.objProductoIdVer,
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
    this.objPaisNacimientoIdVer,
    this.nacionalidadConyugue,
    this.nacionalidadConyugueVer,
    this.ubicacion,
    this.espeps,
    this.nombreDeEntidadPeps,
    this.paisPeps,
    this.paisPepsVer,
    this.periodoPeps,
    this.cargoOficialPeps,
    this.tieneFamiliarPeps,
    this.nombreFamiliarPeps2,
    this.parentescoFamiliarPeps2,
    this.parentescoFamiliarPeps2Ver,
    this.cargoFamiliarPeps2,
    this.nombreEntidadPeps2,
    this.periodoPeps2,
    this.paisPeps2,
    this.paisPeps2Ver,
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
    this.telefonoBeneficiario,
    this.codigoRed,
    this.plazoSolicitud,
    this.fechaPrimerPagoSolicitud,
    this.nombreTrabajo,
    this.direccionTrabajo,
    this.barrioTrabajo,
    this.objActividadEconomicaId,
    this.objActividadEconomicaIdVer,
    this.objActividadEconomicaId1,
    this.objActividadEconomicaId1Ver,
    this.objActividadEconomicaId2,
    this.objActividadEconomicaId2Ver,
    this.cargo,
    this.direccionFamiliarCercano,
    this.duenoVivienda,
    this.fechaVenceAvaluoAsalariado,
    this.fuenteOtrosIngresos,
    this.fuenteOtrosIngresosConyugue,
    this.lugarTrabajoAnterior,
    this.nombreFamiliarCercano,
    this.objParentescoFamiliarCercanoId,
    this.objParentescoFamiliarCercanoIdVer,
    this.otrosIngresosConyugue,
    this.otrosIngresosCordoba,
    this.pagoAlquiler,
    this.profesionConyugue,
    this.salarioNetoCordoba,
    this.sueldoMesConyugue,
    this.telefonoFamiliarCercano,
    this.telefonoTrabajo,
    this.tiempoLaborar,
    this.tiempoLaborarConyugue,
    this.totalIngresoMes,
    this.totalIngresoMesConyugue,
    this.errorMsg,
    this.isDone,
    this.isOffline,
    this.hasVerified,
    this.fechaDesembolso,
    this.tasaInteres,
    this.montoMinimo,
    this.montoMaximo,
    this.objOrigenSolicitudIdVer,
    this.objParentescoBeneficiarioSeguroIdVer,
    this.objEstadoSolicitudIdVer,
    this.objOficialCreditoIdVer,
    this.objEscolaridadIdVer,
    this.objSexoIdVer,
    this.objTipoPersonaIdVer,
    this.uuid,
    this.frecuenciaPagoMeses,
    this.createdAt,
  });
}

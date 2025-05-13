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
  DateTime? fechaEmisionCedula;
  DateTime? fechaVencimientoCedula;
  DateTime? fechaNacimiento;
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
  double? monto;
  String? objMonedaId;
  String? objPropositoId;
  String? objFrecuenciaId;
  double? cuota;
  String? objSectorId;
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
  String? codigoRed;
  int? plazoSolicitud;
  DateTime? fechaPrimerPagoSolicitud;
  String? nombreTrabajo;
  String? direccionTrabajo;
  String? barrioTrabajo;
  String? objActividadEconomicaId;
  String? objActividadEconomicaId1;
  String? objActividadEconomicaId2;
  String? cargo;
  String? direccionFamiliarCercano;
  String? duenoVivienda;
  DateTime? fechaVenceAvaluoAsalariado;
  String? fuenteOtrosIngresos;
  String? fuenteOtrosIngresosConyugue;
  String? lugarTrabajoAnterior;
  String? nombreFamiliarCercano;
  String? objParentescoFamiliarCercanoId;
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
  AsalariadoResponsesLocalDb({
    this.errorMsg,
    this.isDone,
    this.objOrigenSolicitudId,
    this.database,
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
    this.objSectorId,
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
    this.codigoRed,
    this.plazoSolicitud,
    this.fechaPrimerPagoSolicitud,
    this.nombreTrabajo,
    this.direccionTrabajo,
    this.barrioTrabajo,
    this.objActividadEconomicaId,
    this.objActividadEconomicaId1,
    this.objActividadEconomicaId2,
    this.cargo,
    this.direccionFamiliarCercano,
    this.duenoVivienda,
    this.fechaVenceAvaluoAsalariado,
    this.fuenteOtrosIngresos,
    this.fuenteOtrosIngresosConyugue,
    this.lugarTrabajoAnterior,
    this.nombreFamiliarCercano,
    this.objParentescoFamiliarCercanoId,
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
  });
}

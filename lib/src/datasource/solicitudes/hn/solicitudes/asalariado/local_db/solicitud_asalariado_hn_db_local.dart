// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class SolicitudAsalariadoHnDbLocal {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? uuid;
  String? database;
  bool? isOffline;
  String? origenSolicitudCodigo;
  String? nombre1;
  String? nombre2;
  String? apellido1;
  String? apellido2;
  String? cedula;
  String? paisEmisorCedulaCodigo;
  DateTime? fechaEmisionCedula;
  DateTime? fechaVencimientoCedula;
  DateTime? fechaNacimiento;
  String? telefono;
  String? celular;
  String? direccionCasa;
  String? barrioCasa;
  String? municipioCasaCodigo;
  String? departamentoCasaCodigo;
  String? paisCasaCodigo;
  String? nacinalidad;
  String? condicionCasaCodigo;
  int? anosResidirCasa;
  String? email;
  int? monto;
  String? monedaCodigo;
  String? propositoCodigo;
  String? frecuenciaCodigo;
  int? cuota;
  String? sectorCodigo;
  int? personasACargo;
  String? estadoCivilCodigo;
  String? nombreConyugue;
  String? trabajaConyugue;
  String? trabajoConyugue;
  String? direccionTrabajoConyugue;
  String? telefonoTrabajoConyugue;
  String? productoCodigo;
  String? observacion;
  String? ubicacionLongitud;
  String? ubicacionLatitud;
  String? escolaridadCodigo;
  int? cantidadHijos;
  String? nombrePublico;
  String? sexoCodigo;
  String? paisNacimientoCodigo;
  String? nacionalidadConyugue;
  String? ubicacion;
  String? espeps;
  String? nombreDeEntidadPeps;
  String? paisPeps;
  String? periodoPeps;
  String? cargoOficialPeps;
  String? tieneFamiliarPeps;
  String? nombreFamiliarPeps2;
  String? parentescoFamiliarPeps2;
  String? cargoFamiliarPeps2;
  String? nombreEntidadPeps2;
  String? periodoPeps2;
  String? paisPeps2;
  String? actividadPredominanteCodigo;
  String? esFamiliarEmpleado;
  String? nombreFamiliar;
  String? cedulaFamiliar;
  String? tipoDocumentoCodigo;
  String? tipoPersonaCodigo;
  int? plazoSolicitud;
  DateTime? fechaPrimerPagoSolicitud;
  String? nombreTrabajo;
  String? direccionTrabajo;
  String? barrioTrabajo;
  String? cargo;
  String? direccionFamiliarCercano;
  String? fuenteOtrosIngresos;
  String? fuenteOtrosIngresosConyugue;
  String? lugarTrabajoAnterior;
  String? nombreFamiliarCercano;
  String? parentescoFamiliarCercanoCodigo;
  int? otrosIngresosConyugue;
  int otrosIngresosCordoba = 0;
  String? profesionConyugue;
  int salarioNetoCordoba = 0;
  int sueldoMesConyugue = 0;
  String? telefonoFamiliarCercano;
  String? telefonoTrabajo;
  String? tiempoLaborar;
  String? tiempoLaborarConyugue;
  int totalIngresoMes = 0;
  int totalIngresoMesConyugue = 0;
  String? rtn;
  String? codigoUsa;
  String? tipoPersonaCnbsidCodigo;
  String? estatusClienteCodigo;
  String? tipoClienteCodigo;
  String? actividadEconomicaCiuu1Codigo;
  String? actividadEconomicaCiuu2Codigo;
  String? actividadEconomicaCiuu3Codigo;
  String? nivelAproximadoDeIngresosCodigo;
  String? ocupacionCodigo;
  String? profesionCodigo;
  String? actividadEconomicaDescripcion1;
  String? actividadEconomicaDescripcion2;
  String? actividadEconomicaDescripcion3;
  String? ejerceApnfd;
  String? esApnfd;
  String? paisDestinoCodigo;
  String? departamentoDestinoCodigo;
  String? municipioDestinoId;
  String? aldeaDestinoCodigo;
  String? caserioDestino;
  String? barrioDestino;
  String? caseriCasa;
  String? aldeaCodigo;
  String? descripcionDestino;
  bool isDone = false;
  String? errorMsg;
  DateTime createdAt = DateTime.now();
  String? tieneVinculosUsa;
  DateTime? fechaDesembolso;
  String? frecuenciaMeses;
  double? tasaInteres;
  bool hasVerified = false;
  String? cedulaConyuge;
  String? tipoDocumentoConyugeCodigo;
  double? cuotaWithDecimal;
  SolicitudAsalariadoHnDbLocal({
    this.id = 0,
    this.uuid,
    this.database,
    this.isOffline,
    this.origenSolicitudCodigo,
    this.nombre1,
    this.nombre2,
    this.apellido1,
    this.apellido2,
    this.cedula,
    this.paisEmisorCedulaCodigo,
    this.fechaEmisionCedula,
    this.fechaVencimientoCedula,
    this.fechaNacimiento,
    this.telefono,
    this.celular,
    this.direccionCasa,
    this.barrioCasa,
    this.municipioCasaCodigo,
    this.departamentoCasaCodigo,
    this.paisCasaCodigo,
    this.nacinalidad,
    this.condicionCasaCodigo,
    this.anosResidirCasa,
    this.email,
    this.monto,
    this.monedaCodigo,
    this.propositoCodigo,
    this.frecuenciaCodigo,
    this.cuota,
    this.sectorCodigo,
    this.personasACargo,
    this.estadoCivilCodigo,
    this.nombreConyugue,
    this.trabajaConyugue,
    this.trabajoConyugue,
    this.direccionTrabajoConyugue,
    this.telefonoTrabajoConyugue,
    this.productoCodigo,
    this.observacion,
    this.ubicacionLongitud,
    this.ubicacionLatitud,
    this.escolaridadCodigo,
    this.cantidadHijos,
    this.nombrePublico,
    this.sexoCodigo,
    this.paisNacimientoCodigo,
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
    this.actividadPredominanteCodigo,
    this.esFamiliarEmpleado,
    this.nombreFamiliar,
    this.cedulaFamiliar,
    this.tipoDocumentoCodigo,
    this.tipoPersonaCodigo,
    this.plazoSolicitud,
    this.fechaPrimerPagoSolicitud,
    this.nombreTrabajo,
    this.direccionTrabajo,
    this.barrioTrabajo,
    this.cargo,
    this.direccionFamiliarCercano,
    this.fuenteOtrosIngresos,
    this.fuenteOtrosIngresosConyugue,
    this.lugarTrabajoAnterior,
    this.nombreFamiliarCercano,
    this.parentescoFamiliarCercanoCodigo,
    this.otrosIngresosConyugue,
    this.otrosIngresosCordoba = 0,
    this.profesionConyugue,
    this.salarioNetoCordoba = 0,
    this.sueldoMesConyugue = 0,
    this.telefonoFamiliarCercano,
    this.telefonoTrabajo,
    this.tiempoLaborar,
    this.tiempoLaborarConyugue,
    this.totalIngresoMes = 0,
    this.totalIngresoMesConyugue = 0,
    this.rtn,
    this.codigoUsa,
    this.tipoPersonaCnbsidCodigo,
    this.estatusClienteCodigo,
    this.tipoClienteCodigo,
    this.actividadEconomicaCiuu1Codigo,
    this.actividadEconomicaCiuu2Codigo,
    this.actividadEconomicaCiuu3Codigo,
    this.nivelAproximadoDeIngresosCodigo,
    this.ocupacionCodigo,
    this.profesionCodigo,
    this.actividadEconomicaDescripcion1,
    this.actividadEconomicaDescripcion2,
    this.actividadEconomicaDescripcion3,
    this.ejerceApnfd,
    this.esApnfd,
    this.paisDestinoCodigo,
    this.departamentoDestinoCodigo,
    this.municipioDestinoId,
    this.aldeaDestinoCodigo,
    this.caserioDestino,
    this.barrioDestino,
    this.caseriCasa,
    this.aldeaCodigo,
    this.descripcionDestino,
    this.isDone = false,
    this.errorMsg,
    this.tieneVinculosUsa,
    this.fechaDesembolso,
    this.frecuenciaMeses,
    this.tasaInteres,
    this.hasVerified = false,
    this.cedulaConyuge,
    this.tipoDocumentoConyugeCodigo,
    this.cuotaWithDecimal,
  });
}

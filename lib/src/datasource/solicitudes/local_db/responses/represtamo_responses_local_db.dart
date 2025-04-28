// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:objectbox/objectbox.dart';

@Entity()
class ReprestamoResponsesLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? username;
  String? userIp;
  String? database;
  String? objOrigenSolicitudId;
  String? cedula;
  int? monto;
  String? objMonedaId;
  String? objPropositoId;
  String? objFrecuenciaId;
  String? objFrecuenciaIdVer;
  int? cuota;
  String? objActividadId;
  String? objActividadId1;
  String? objActividadId2;
  String? objSectorId;
  String? beneficiarioSeguro;
  String? cedulaBeneficiarioSeguro;
  String? objParentescoBeneficiarioSeguroId;
  String? objProductoId;
  String? observacion;
  String? ubicacionLongitud;
  String? ubicacionLatitud;
  String? sucursal;
  String? ubicacion;
  bool? esPeps;
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
  String? objTipoDocumentoId;
  String? objRubroActividad2;
  String? objRubroActividad3;
  String? objRubroActividadPredominante;
  String? tipoPersona;
  String? objTipoPersonaId;
  String? telefonoBeneficiario;
  String? celularReprestamo;
  bool? esFamiliarEmpleado;
  String? nombreFamiliar;
  String? cedulaFamiliar;
  int? plazoSolicitud;
  DateTime? fechaPrimerPagoSolicitud;
  double? prestamoInteres;
  DateTime? fechaDesembolso;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  bool? isDone;
  String? errorMsg;
  bool? hasVerified;
  bool? isOffline;
  ReprestamoResponsesLocalDb({
    this.isOffline = false,
    this.objFrecuenciaIdVer,
    this.username,
    this.userIp,
    this.database,
    this.objOrigenSolicitudId,
    this.cedula,
    this.monto,
    this.objMonedaId,
    this.objPropositoId,
    this.objFrecuenciaId,
    this.cuota,
    this.objActividadId,
    this.objActividadId1,
    this.objActividadId2,
    this.objSectorId,
    this.beneficiarioSeguro,
    this.cedulaBeneficiarioSeguro,
    this.objParentescoBeneficiarioSeguroId,
    this.objProductoId,
    this.observacion,
    this.ubicacionLongitud,
    this.ubicacionLatitud,
    this.sucursal,
    this.ubicacion,
    this.esPeps,
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
    this.objTipoDocumentoId,
    this.objRubroActividad2,
    this.objRubroActividad3,
    this.objRubroActividadPredominante,
    this.tipoPersona,
    this.objTipoPersonaId,
    this.telefonoBeneficiario,
    this.celularReprestamo,
    this.esFamiliarEmpleado,
    this.nombreFamiliar,
    this.cedulaFamiliar,
    this.plazoSolicitud,
    this.fechaPrimerPagoSolicitud,
    this.prestamoInteres,
    this.fechaDesembolso,
    this.createdAt,
    this.isDone = false,
    this.errorMsg = '',
    this.hasVerified = false,
  });
}

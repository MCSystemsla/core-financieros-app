// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:objectbox/objectbox.dart';

@Entity()
class SolicitudReprestamoHnLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? uuid;
  String? origenSolicitudCodigo;
  String? cedula;
  double? monto;
  String? monedaCodigo;
  String? propositoCodigo;
  String? frecuenciaCodigo;
  double? cuota;
  String? beneficiarioSeguro;
  String? cedulaBeneficiarioSeguro;
  String? parentescoBeneficiarioSeguroCodigo;
  String? productoCodigo;
  String? observacion;
  String? ubicacionLongitud;
  String? ubicacionLatitud;
  String? ubicacion;
  String? esPeps;
  String? nombreDeEntidadPeps;
  String? paisPeps;
  String? periodoPeps;
  String? cargoOficialPeps;
  String? tieneFamiliarPeps;
  String? nombreFamiliarPeps2;
  String? parentescoFamiliarPeps2Codigo;
  String? cargoFamiliarPeps2;
  String? nombreEntidadPeps2;
  String? periodoPeps2;
  String? paisPeps2;
  String? tipoDocumentoCodigo;
  String? celularReprestamo;
  String? esFamiliarEmpleado;
  String? nombreFamiliar;
  String? cedulaFamiliar;
  int? plazoSolicitud;
  DateTime? fechaPrimerPagoSolicitud;
  String? tipoPersonaCodigo;
  bool? cargaAnalisisAutomatico;
  String? motivoRevisionCodigo;
  String? actividadEconomicaCiuu1;
  String? actividadEconomicaCiuu2;
  String? actividadEconomicaCiuu3;
  String? codigoUsa;
  String? apnfd;
  String? actividadEconomicaRealizaCiuu1;
  String? actividadEconomicaRealizaCiuu2;
  String? actividadEconomicaRealizaCiuu3;
  String? tieneIdentificacionEstadosUnidos;
  String? tieneVinculoEstadosUnidos;
  String? vinculoEstadosUnidosDescripcion;
  String? ejerceActividadApfnd;
  String? medidasConocimientoCodigo;
  String? nombreEmpleadoFamiliar;
  DateTime? fechaSolicitud;
  int? cuotaClientePuedePagar;

  SolicitudReprestamoHnLocalDb({
    required this.id,
    this.uuid,
    this.origenSolicitudCodigo,
    this.cedula,
    this.monto,
    this.monedaCodigo,
    this.propositoCodigo,
    this.frecuenciaCodigo,
    this.cuota,
    this.beneficiarioSeguro,
    this.cedulaBeneficiarioSeguro,
    this.parentescoBeneficiarioSeguroCodigo,
    this.productoCodigo,
    this.observacion,
    this.ubicacionLongitud,
    this.ubicacionLatitud,
    this.ubicacion,
    this.esPeps,
    this.nombreDeEntidadPeps,
    this.paisPeps,
    this.periodoPeps,
    this.cargoOficialPeps,
    this.tieneFamiliarPeps,
    this.nombreFamiliarPeps2,
    this.parentescoFamiliarPeps2Codigo,
    this.cargoFamiliarPeps2,
    this.nombreEntidadPeps2,
    this.periodoPeps2,
    this.paisPeps2,
    this.tipoDocumentoCodigo,
    this.celularReprestamo,
    this.esFamiliarEmpleado,
    this.nombreFamiliar,
    this.cedulaFamiliar,
    this.plazoSolicitud,
    this.fechaPrimerPagoSolicitud,
    this.tipoPersonaCodigo,
    this.cargaAnalisisAutomatico,
    this.motivoRevisionCodigo,
    this.actividadEconomicaCiuu1,
    this.actividadEconomicaCiuu2,
    this.actividadEconomicaCiuu3,
    this.codigoUsa,
    this.apnfd,
    this.actividadEconomicaRealizaCiuu1,
    this.actividadEconomicaRealizaCiuu2,
    this.actividadEconomicaRealizaCiuu3,
    this.tieneIdentificacionEstadosUnidos,
    this.tieneVinculoEstadosUnidos,
    this.vinculoEstadosUnidosDescripcion,
    this.ejerceActividadApfnd,
    this.medidasConocimientoCodigo,
    this.nombreEmpleadoFamiliar,
    this.fechaSolicitud,
    this.cuotaClientePuedePagar,
  });
}

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
  String? monedaCodigoNombre;
  String? propositoCodigo;
  String? propositoCodigoNombre;
  String? frecuenciaCodigo;
  String? frecuenciaCodigoNombre;
  double? cuota;
  String? beneficiarioSeguro;
  String? cedulaBeneficiarioSeguro;
  String? parentescoBeneficiarioSeguroCodigo;
  String? productoCodigo;
  String? productoCodigoNombre;
  String? observacion;
  String? ubicacionLongitud;
  String? ubicacionLatitud;
  String? ubicacion;
  String? ubicacionNombre;
  String? esPeps;
  String? nombreDeEntidadPeps;
  String? paisPeps;
  String? paisPepsNombre;
  String? periodoPeps;
  String? cargoOficialPeps;
  String? tieneFamiliarPeps;
  String? nombreFamiliarPeps2;
  String? parentescoFamiliarPeps2Codigo;
  String? parentescoFamiliarPeps2CodigoNombre;
  String? cargoFamiliarPeps2;
  String? nombreEntidadPeps2;
  String? periodoPeps2;
  String? paisPeps2;
  String? paisPeps2Nombre;
  String? tipoDocumentoCodigo;
  String? tipoDocumentoCodigoNombre;
  String? celularReprestamo;
  String? esFamiliarEmpleado;
  String? nombreFamiliar;
  String? cedulaFamiliar;
  int? plazoSolicitud;
  DateTime? fechaPrimerPagoSolicitud;
  String? tipoPersonaCodigo;
  String? tipoPersonaCodigoNombre;
  bool? cargaAnalisisAutomatico;
  String? motivoRevisionCodigo;
  String? actividadEconomicaCiuu1;
  String? actividadEconomicaCiuu1Nombre;
  String? actividadEconomicaCiuu2;
  String? actividadEconomicaCiuu2Nombre;
  String? actividadEconomicaCiuu3;
  String? actividadEconomicaCiuu3Nombre;
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
  String? nombreCompleto;
  String? descripcionDestino;
  bool isDone = false;
  String? errorMsg;
  DateTime createdAt = DateTime.now();
  String? nombreCompletoCliente;
  DateTime? fechaDesembolso;
  double? montoMinimo;
  double? montoMaximo;
  double? tasaInteres;
  String? frecuenciaPagoMeses;
  bool hasVerified = false;

  SolicitudReprestamoHnLocalDb({
    required this.id,
    this.uuid,
    this.origenSolicitudCodigo,
    this.cedula,
    this.monto,
    this.monedaCodigo,
    this.monedaCodigoNombre,
    this.propositoCodigo,
    this.propositoCodigoNombre,
    this.frecuenciaCodigo,
    this.frecuenciaCodigoNombre,
    this.cuota,
    this.beneficiarioSeguro,
    this.cedulaBeneficiarioSeguro,
    this.parentescoBeneficiarioSeguroCodigo,
    this.productoCodigo,
    this.productoCodigoNombre,
    this.observacion,
    this.ubicacionLongitud,
    this.ubicacionLatitud,
    this.ubicacion,
    this.ubicacionNombre,
    this.esPeps,
    this.nombreDeEntidadPeps,
    this.paisPeps,
    this.paisPepsNombre,
    this.periodoPeps,
    this.cargoOficialPeps,
    this.tieneFamiliarPeps,
    this.nombreFamiliarPeps2,
    this.parentescoFamiliarPeps2Codigo,
    this.parentescoFamiliarPeps2CodigoNombre,
    this.cargoFamiliarPeps2,
    this.nombreEntidadPeps2,
    this.periodoPeps2,
    this.paisPeps2,
    this.paisPeps2Nombre,
    this.tipoDocumentoCodigo,
    this.tipoDocumentoCodigoNombre,
    this.celularReprestamo,
    this.esFamiliarEmpleado,
    this.nombreFamiliar,
    this.cedulaFamiliar,
    this.plazoSolicitud,
    this.fechaPrimerPagoSolicitud,
    this.tipoPersonaCodigo,
    this.tipoPersonaCodigoNombre,
    this.cargaAnalisisAutomatico,
    this.motivoRevisionCodigo,
    this.actividadEconomicaCiuu1,
    this.actividadEconomicaCiuu1Nombre,
    this.actividadEconomicaCiuu2,
    this.actividadEconomicaCiuu2Nombre,
    this.actividadEconomicaCiuu3,
    this.actividadEconomicaCiuu3Nombre,
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
    this.nombreCompleto,
    this.descripcionDestino,
    this.isDone = false,
    this.errorMsg,
    this.nombreCompletoCliente,
    this.fechaDesembolso,
    this.montoMinimo,
    this.montoMaximo,
    this.tasaInteres,
    this.frecuenciaPagoMeses,
    this.hasVerified = false,
  });
}

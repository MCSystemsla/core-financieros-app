// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:objectbox/objectbox.dart';

@Entity()
class SolicitudNuevaMenorHnLocalDb {
  @Id(assignable: true) // Campo ID para asignación manual o automática.
  int id = 0;
  String? uuid;
  String? database;
  String? origenSolicitudCodigo;
  String? nombre1;
  String? apellido1;
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
  String? profesion;
  String? ocupacion;
  String? condicionCasaCodigo;
  int? anosResidirCasa;
  int? monto;
  String? monedaCodigo;
  String? propositoCodigo;
  String? frecuenciaCodigo;
  int? cuota;
  String? sectorCodigo;
  String? nombreNegocio;
  String? tiempoFuncionamientoNegocio;
  String? direccionNegocio;
  String? barrioNegocio;
  String? municipioNegocioCodigo;
  String? condicionNegocioCodigo;
  String? horarioTrabajo;
  String? horarioVisita;
  int? personasACargo;
  String? estadoCivilCodigo;
  String? nombreConyugue;
  String? trabajaConyugue;
  String? trabajoConyugue;
  String? direccionTrabajoConyugue;
  String? telefonoTrabajoConyugue;
  String? productoCodigo;
  String? observacion;
  String? sucursal;
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
  String? parentescoFamiliarPeps2Codigo;
  String? cargoFamiliarPeps2;
  String? nombreEntidadPeps2;
  String? periodoPeps2;
  String? paisPeps2;
  String? esFamiliarEmpleado;
  String? nombreFamiliar;
  String? cedulaFamiliar;
  String? tipoDocumentoCodigo;
  String? tipoPersonaCodigo;
  int? plazoSolicitud;
  DateTime? fechaPrimerPagoSolicitud;
  bool? isOffline;
  String? codigoUsa;
  String? nombre3;
  String? apellido3;
  String? rtn;
  String? telefonoNegocio;
  String? celularNegocio;
  String? actividadDescripcionConyugue;
  int? exeperiencia;
  String? puestoNegocio;
  String? actividadEconomicaCnbs1Codigo;
  String? actividadEconomicaCnbs2Codigo;
  String? actividaEconomicaDescipcion1;
  String? actividaEconomicaDescipcion2;
  String? actividaEconomicaDescipcion3;
  String? ejerceApnfd;
  String? esApnfd;
  String? nacinalidadCodigo;
  String? nacinalidad2Codigo;
  String? nacinalidad3Codigo;
  String? departamentoDestinoCodigo;
  String? tipoPersonaCnbsCodigo;
  String? tipoClienteCodigo;
  String? aldeaDestinoCodigo;
  String? municipioDestinoCodigo;
  String? aldeaNegocioCodigo;
  String? departamentoNegocioCodigo;
  String? nivelAproximadoIngresosCodigo;
  String? documentoConyuge;
  String? ocupacionCodigo;
  String? profesionCodigo;
  String? aldeaCasaCodigo;
  String? ubicacionCodigo;
  String? medidasConocimientoCodigo;
  String? caserioCasa;
  String? caserioNegocio;
  String? caserioDestino;
  String? barrioDestino;
  String? descripcionDestino;
  int? ingresosNetos;
  String? nombre2;
  String? apellido2;
  String? email;
  SolicitudNuevaMenorHnLocalDb({
    required this.id,
    this.uuid,
    this.database,
    this.origenSolicitudCodigo,
    this.nombre1,
    this.apellido1,
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
    this.profesion,
    this.ocupacion,
    this.condicionCasaCodigo,
    this.anosResidirCasa,
    this.monto,
    this.monedaCodigo,
    this.propositoCodigo,
    this.frecuenciaCodigo,
    this.cuota,
    this.sectorCodigo,
    this.nombreNegocio,
    this.tiempoFuncionamientoNegocio,
    this.direccionNegocio,
    this.barrioNegocio,
    this.municipioNegocioCodigo,
    this.condicionNegocioCodigo,
    this.horarioTrabajo,
    this.horarioVisita,
    this.personasACargo,
    this.estadoCivilCodigo,
    this.nombreConyugue,
    this.trabajaConyugue,
    this.trabajoConyugue,
    this.direccionTrabajoConyugue,
    this.telefonoTrabajoConyugue,
    this.productoCodigo,
    this.observacion,
    this.sucursal,
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
    this.parentescoFamiliarPeps2Codigo,
    this.cargoFamiliarPeps2,
    this.nombreEntidadPeps2,
    this.periodoPeps2,
    this.paisPeps2,
    this.esFamiliarEmpleado,
    this.nombreFamiliar,
    this.cedulaFamiliar,
    this.tipoDocumentoCodigo,
    this.tipoPersonaCodigo,
    this.plazoSolicitud,
    this.fechaPrimerPagoSolicitud,
    this.isOffline,
    this.codigoUsa,
    this.nombre3,
    this.apellido3,
    this.rtn,
    this.telefonoNegocio,
    this.celularNegocio,
    this.actividadDescripcionConyugue,
    this.exeperiencia,
    this.puestoNegocio,
    this.actividadEconomicaCnbs1Codigo,
    this.actividadEconomicaCnbs2Codigo,
    this.actividaEconomicaDescipcion1,
    this.actividaEconomicaDescipcion2,
    this.actividaEconomicaDescipcion3,
    this.ejerceApnfd,
    this.esApnfd,
    this.nacinalidadCodigo,
    this.nacinalidad2Codigo,
    this.nacinalidad3Codigo,
    this.departamentoDestinoCodigo,
    this.tipoPersonaCnbsCodigo,
    this.tipoClienteCodigo,
    this.aldeaDestinoCodigo,
    this.municipioDestinoCodigo,
    this.aldeaNegocioCodigo,
    this.departamentoNegocioCodigo,
    this.nivelAproximadoIngresosCodigo,
    this.documentoConyuge,
    this.ocupacionCodigo,
    this.profesionCodigo,
    this.aldeaCasaCodigo,
    this.ubicacionCodigo,
    this.medidasConocimientoCodigo,
    this.caserioCasa,
    this.caserioNegocio,
    this.caserioDestino,
    this.barrioDestino,
    this.descripcionDestino,
    this.ingresosNetos,
    this.nombre2,
    this.apellido2,
    this.email,
  });
}

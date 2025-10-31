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
  String? paisEmisorCedulaCodigoNombre;
  DateTime? fechaEmisionCedula;
  DateTime? fechaVencimientoCedula;
  DateTime? fechaNacimiento;
  String? telefono;
  String? celular;
  String? direccionCasa;
  String? barrioCasa;
  String? municipioCasaCodigo;
  String? municipioCasaCodigoNombre;
  String? departamentoCasaCodigo;
  String? departamentoCasaCodigoNombre;
  String? paisCasaCodigo;
  String? paisCasaCodigoNombre;
  String? profesion;
  String? profesionNombre;
  String? ocupacion;
  String? ocupacionNombre;
  String? condicionCasaCodigo;
  String? condicionCasaCodigoNombre;
  int? anosResidirCasa;
  int? monto;
  String? monedaCodigo;
  String? monedaCodigoNombre;
  String? propositoCodigo;
  String? propositoCodigoNombre;
  String? frecuenciaCodigo;
  String? frecuenciaCodigoNombre;
  int? cuota;
  String? sectorCodigo;
  String? sectorCodigoNombre;
  String? nombreNegocio;
  String? tiempoFuncionamientoNegocio;
  String? direccionNegocio;
  String? barrioNegocio;
  String? municipioNegocioCodigo;
  String? municipioNegocioCodigoNombre;
  String? condicionNegocioCodigo;
  String? condicionNegocioCodigoNombre;
  String? horarioTrabajo;
  String? horarioVisita;
  int? personasACargo;
  String? estadoCivilCodigo;
  String? estadoCivilCodigoNombre;
  String? nombreConyugue;
  String? trabajaConyugue;
  String? trabajoConyugue;
  String? direccionTrabajoConyugue;
  String? telefonoTrabajoConyugue;
  String? productoCodigo;
  String? productoCodigoNombre;
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
  String? parentescoFamiliarPeps2CodigoNombre;
  String? cargoFamiliarPeps2;
  String? nombreEntidadPeps2;
  String? periodoPeps2;
  String? paisPeps2;
  String? esFamiliarEmpleado;
  String? nombreFamiliar;
  String? cedulaFamiliar;
  String? tipoDocumentoCodigo;
  String? tipoDocumentoCodigoNombre;
  String? tipoPersonaCodigo;
  String? tipoPersonaCodigoNombre;
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
  String? actividadEconomicaCnbs1CodigoNombre;
  String? actividadEconomicaCnbs2Codigo;
  String? actividadEconomicaCnbs2CodigoNombre;
  String? actividaEconomicaDescipcion1;
  String? actividaEconomicaDescipcion2;
  String? actividaEconomicaDescipcion3;
  String? ejerceApnfd;
  String? esApnfd;
  String? nacinalidadCodigo;
  String? nacinalidadCodigoNombre;
  String? nacinalidad2Codigo;
  String? nacinalidad2CodigoNombre;
  String? nacinalidad3Codigo;
  String? nacinalidad3CodigoNombre;
  String? departamentoDestinoCodigo;
  String? departamentoDestinoCodigoNombre;
  String? tipoPersonaCnbsCodigo;
  String? tipoPersonaCnbsCodigoNombre;
  String? tipoClienteCodigo;
  String? tipoClienteCodigoNombre;
  String? aldeaDestinoCodigo;
  String? aldeaDestinoCodigoNombre;
  String? municipioDestinoCodigo;
  String? municipioDestinoCodigoNombre;
  String? aldeaNegocioCodigo;
  String? aldeaNegocioCodigoNombre;
  String? departamentoNegocioCodigo;
  String? departamentoNegocioCodigoNombre;
  String? nivelAproximadoIngresosCodigo;
  String? documentoConyuge;
  String? ocupacionCodigo;
  String? ocupacionCodigoNombre;
  String? profesionCodigo;
  String? profesionCodigoNombre;
  String? aldeaCasaCodigo;
  String? aldeaCasaCodigoNombre;
  String? ubicacionCodigo;
  String? ubicacionCodigoNombre;
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
  String? actividadEconomicaCnbs3Codigo;
  bool isDone = false;
  DateTime createdAt = DateTime.now();
  String? frecuenciaMeses;
  DateTime? fechaDesembolso;
  double? tasaInteres;
  double? montoMaximo;
  double? montoMinimo;
  String? tieneVinculosUsa;
  bool hasVerified = false;
  SolicitudNuevaMenorHnLocalDb({
    required this.id,
    this.uuid,
    this.database,
    this.origenSolicitudCodigo,
    this.nombre1,
    this.apellido1,
    this.cedula,
    this.paisEmisorCedulaCodigo,
    this.paisEmisorCedulaCodigoNombre,
    this.fechaEmisionCedula,
    this.fechaVencimientoCedula,
    this.fechaNacimiento,
    this.telefono,
    this.celular,
    this.direccionCasa,
    this.barrioCasa,
    this.municipioCasaCodigo,
    this.municipioCasaCodigoNombre,
    this.departamentoCasaCodigo,
    this.departamentoCasaCodigoNombre,
    this.paisCasaCodigo,
    this.paisCasaCodigoNombre,
    this.profesion,
    this.profesionNombre,
    this.ocupacion,
    this.ocupacionNombre,
    this.condicionCasaCodigo,
    this.condicionCasaCodigoNombre,
    this.anosResidirCasa,
    this.monto,
    this.monedaCodigo,
    this.monedaCodigoNombre,
    this.propositoCodigo,
    this.propositoCodigoNombre,
    this.frecuenciaCodigo,
    this.frecuenciaCodigoNombre,
    this.cuota,
    this.sectorCodigo,
    this.sectorCodigoNombre,
    this.nombreNegocio,
    this.tiempoFuncionamientoNegocio,
    this.direccionNegocio,
    this.barrioNegocio,
    this.municipioNegocioCodigo,
    this.municipioNegocioCodigoNombre,
    this.condicionNegocioCodigo,
    this.condicionNegocioCodigoNombre,
    this.horarioTrabajo,
    this.horarioVisita,
    this.personasACargo,
    this.estadoCivilCodigo,
    this.estadoCivilCodigoNombre,
    this.nombreConyugue,
    this.trabajaConyugue,
    this.trabajoConyugue,
    this.direccionTrabajoConyugue,
    this.telefonoTrabajoConyugue,
    this.productoCodigo,
    this.productoCodigoNombre,
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
    this.parentescoFamiliarPeps2CodigoNombre,
    this.cargoFamiliarPeps2,
    this.nombreEntidadPeps2,
    this.periodoPeps2,
    this.paisPeps2,
    this.esFamiliarEmpleado,
    this.nombreFamiliar,
    this.cedulaFamiliar,
    this.tipoDocumentoCodigo,
    this.tipoDocumentoCodigoNombre,
    this.tipoPersonaCodigo,
    this.tipoPersonaCodigoNombre,
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
    this.actividadEconomicaCnbs1CodigoNombre,
    this.actividadEconomicaCnbs2Codigo,
    this.actividadEconomicaCnbs2CodigoNombre,
    this.actividaEconomicaDescipcion1,
    this.actividaEconomicaDescipcion2,
    this.actividaEconomicaDescipcion3,
    this.ejerceApnfd,
    this.esApnfd,
    this.nacinalidadCodigo,
    this.nacinalidadCodigoNombre,
    this.nacinalidad2Codigo,
    this.nacinalidad2CodigoNombre,
    this.nacinalidad3Codigo,
    this.nacinalidad3CodigoNombre,
    this.departamentoDestinoCodigo,
    this.departamentoDestinoCodigoNombre,
    this.tipoPersonaCnbsCodigo,
    this.tipoPersonaCnbsCodigoNombre,
    this.tipoClienteCodigo,
    this.tipoClienteCodigoNombre,
    this.aldeaDestinoCodigo,
    this.aldeaDestinoCodigoNombre,
    this.municipioDestinoCodigo,
    this.municipioDestinoCodigoNombre,
    this.aldeaNegocioCodigo,
    this.aldeaNegocioCodigoNombre,
    this.departamentoNegocioCodigo,
    this.departamentoNegocioCodigoNombre,
    this.nivelAproximadoIngresosCodigo,
    this.documentoConyuge,
    this.ocupacionCodigo,
    this.ocupacionCodigoNombre,
    this.profesionCodigo,
    this.profesionCodigoNombre,
    this.aldeaCasaCodigo,
    this.aldeaCasaCodigoNombre,
    this.ubicacionCodigo,
    this.ubicacionCodigoNombre,
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
    this.actividadEconomicaCnbs3Codigo,
    this.isDone = false,
    this.frecuenciaMeses,
    this.fechaDesembolso,
    this.tasaInteres,
    this.montoMaximo,
    this.montoMinimo,
    this.tieneVinculosUsa,
    this.hasVerified = false,
  });
}

import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/historial_crediticio/historial_crediticio.dart';

String solicitudNuevaMenorHnToJson(SolicitudNuevaMenorHn data) =>
    json.encode(data.toJson());

class SolicitudNuevaMenorHn {
  final String database;
  final String origenSolicitudCodigo;
  final String nombre1;
  final String apellido1;
  final String cedula;
  final String paisEmisorCedulaCodigo;
  final DateTime? fechaEmisionCedula;
  final DateTime fechaVencimientoCedula;
  final DateTime fechaNacimiento;
  final String telefono;
  final String celular;
  final String direccionCasa;
  final String barrioCasa;
  final String municipioCasaCodigo;
  final String departamentoCasaCodigo;
  final String paisCasaCodigo;
  final String profesion;
  final String ocupacion;
  final String condicionCasaCodigo;
  final int anosResidirCasa;
  final int monto;
  final String monedaCodigo;
  final String propositoCodigo;
  final String frecuenciaCodigo;
  final int cuota;
  final String sectorCodigo;
  final String nombreNegocio;
  final String tiempoFuncionamientoNegocio;
  final String direccionNegocio;
  final String barrioNegocio;
  final String municipioNegocioCodigo;
  final String condicionNegocioCodigo;
  final String horarioTrabajo;
  final String horarioVisita;
  final int personasACargo;
  final String estadoCivilCodigo;
  final String nombreConyugue;
  final bool trabajaConyugue;
  final String trabajoConyugue;
  final String direccionTrabajoConyugue;
  final String telefonoTrabajoConyugue;
  final String productoCodigo;
  final String observacion;
  final String sucursal;
  final String ubicacionLongitud;
  final String ubicacionLatitud;
  final String escolaridadCodigo;
  final int cantidadHijos;
  final String nombrePublico;
  final String sexoCodigo;
  final String paisNacimientoCodigo;
  final String nacionalidadConyugue;
  final String ubicacion;
  final bool espeps;
  final String nombreDeEntidadPeps;
  final String paisPeps;
  final String periodoPeps;
  final String cargoOficialPeps;
  final bool tieneFamiliarPeps;
  final String nombreFamiliarPeps2;
  final String parentescoFamiliarPeps2Codigo;
  final String cargoFamiliarPeps2;
  final String nombreEntidadPeps2;
  final String periodoPeps2;
  final String paisPeps2;
  final bool esFamiliarEmpleado;
  final String nombreFamiliar;
  final String cedulaFamiliar;
  final String tipoDocumentoCodigo;
  final String tipoPersonaCodigo;
  final int plazoSolicitud;
  final DateTime fechaPrimerPagoSolicitud;
  final bool isOffline;
  final String codigoUsa;
  final String nombre3;
  final String apellido3;
  final String rtn;
  final String telefonoNegocio;
  final String celularNegocio;
  final String actividadDescripcionConyugue;
  final int exeperiencia;
  final String puestoNegocio;
  final String actividadEconomicaCnbs1Codigo;
  final String actividadEconomicaCnbs2Codigo;
  final String actividaEconomicaDescipcion1;
  final String actividaEconomicaDescipcion2;
  final String actividaEconomicaDescipcion3;
  final bool ejerceApnfd;
  final bool esApnfd;
  final String nacinalidadCodigo;
  final String nacinalidad2Codigo;
  final String nacinalidad3Codigo;
  final String departamentoDestinoCodigo;
  final String tipoPersonaCnbsCodigo;
  final String tipoClienteCodigo;
  final String aldeaDestinoCodigo;
  final String municipioDestinoCodigo;
  final String aldeaNegocioCodigo;
  final String departamentoNegocioCodigo;
  final String nivelAproximadoIngresosCodigo;
  final String documentoConyuge;
  final String ocupacionCodigo;
  final String profesionCodigo;
  final String aldeaCasaCodigo;
  final String ubicacionCodigo;
  final String medidasConocimientoCodigo;
  final String caserioCasa;
  final String caserioNegocio;
  final String caserioDestino;
  final String barrioDestino;
  final String descripcionDestino;
  final int ingresosNetos;
  final String nombre2;
  final String apellido2;
  final String email;
  final String actividadEconomicaCnbs3Codigo;
  final String nombreCompletoConyugue;
  final List<HistorialCredito> historialCredito;
  SolicitudNuevaMenorHn({
    required this.actividadEconomicaCnbs3Codigo,
    required this.database,
    required this.origenSolicitudCodigo,
    required this.nombre1,
    required this.apellido1,
    required this.cedula,
    required this.paisEmisorCedulaCodigo,
    this.fechaEmisionCedula,
    required this.fechaVencimientoCedula,
    required this.fechaNacimiento,
    required this.telefono,
    required this.celular,
    required this.direccionCasa,
    required this.barrioCasa,
    required this.municipioCasaCodigo,
    required this.departamentoCasaCodigo,
    required this.paisCasaCodigo,
    required this.profesion,
    required this.ocupacion,
    required this.condicionCasaCodigo,
    required this.anosResidirCasa,
    required this.monto,
    required this.monedaCodigo,
    required this.propositoCodigo,
    required this.frecuenciaCodigo,
    required this.cuota,
    required this.sectorCodigo,
    required this.nombreNegocio,
    required this.tiempoFuncionamientoNegocio,
    required this.direccionNegocio,
    required this.barrioNegocio,
    required this.municipioNegocioCodigo,
    required this.condicionNegocioCodigo,
    required this.horarioTrabajo,
    required this.horarioVisita,
    required this.personasACargo,
    required this.estadoCivilCodigo,
    required this.nombreConyugue,
    required this.trabajaConyugue,
    required this.trabajoConyugue,
    required this.direccionTrabajoConyugue,
    required this.telefonoTrabajoConyugue,
    required this.productoCodigo,
    required this.observacion,
    required this.sucursal,
    required this.ubicacionLongitud,
    required this.ubicacionLatitud,
    required this.escolaridadCodigo,
    required this.cantidadHijos,
    required this.nombrePublico,
    required this.sexoCodigo,
    required this.paisNacimientoCodigo,
    required this.nacionalidadConyugue,
    required this.ubicacion,
    required this.espeps,
    required this.nombreDeEntidadPeps,
    required this.paisPeps,
    required this.periodoPeps,
    required this.cargoOficialPeps,
    required this.tieneFamiliarPeps,
    required this.nombreFamiliarPeps2,
    required this.parentescoFamiliarPeps2Codigo,
    required this.cargoFamiliarPeps2,
    required this.nombreEntidadPeps2,
    required this.periodoPeps2,
    required this.paisPeps2,
    required this.esFamiliarEmpleado,
    required this.nombreFamiliar,
    required this.cedulaFamiliar,
    required this.tipoDocumentoCodigo,
    required this.tipoPersonaCodigo,
    required this.plazoSolicitud,
    required this.fechaPrimerPagoSolicitud,
    required this.isOffline,
    required this.codigoUsa,
    required this.nombre3,
    required this.apellido3,
    required this.rtn,
    required this.telefonoNegocio,
    required this.celularNegocio,
    required this.actividadDescripcionConyugue,
    required this.exeperiencia,
    required this.puestoNegocio,
    required this.actividadEconomicaCnbs1Codigo,
    required this.actividadEconomicaCnbs2Codigo,
    required this.actividaEconomicaDescipcion1,
    required this.actividaEconomicaDescipcion2,
    required this.actividaEconomicaDescipcion3,
    required this.ejerceApnfd,
    required this.esApnfd,
    required this.nacinalidadCodigo,
    required this.nacinalidad2Codigo,
    required this.nacinalidad3Codigo,
    required this.departamentoDestinoCodigo,
    required this.tipoPersonaCnbsCodigo,
    required this.tipoClienteCodigo,
    required this.aldeaDestinoCodigo,
    required this.municipioDestinoCodigo,
    required this.aldeaNegocioCodigo,
    required this.departamentoNegocioCodigo,
    required this.nivelAproximadoIngresosCodigo,
    required this.documentoConyuge,
    required this.ocupacionCodigo,
    required this.profesionCodigo,
    required this.aldeaCasaCodigo,
    required this.ubicacionCodigo,
    required this.medidasConocimientoCodigo,
    required this.caserioCasa,
    required this.caserioNegocio,
    required this.caserioDestino,
    required this.barrioDestino,
    required this.descripcionDestino,
    required this.ingresosNetos,
    required this.nombre2,
    required this.apellido2,
    required this.email,
    required this.historialCredito,
    required this.nombreCompletoConyugue,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'database': LocalStorage().database,
      'OrigenSolicitudCodigo': 'APPMOVIL',
      'Nombre1': nombre1,
      'Apellido1': apellido1,
      'Cedula': cedula,
      'PaisEmisorCedulaCodigo': paisEmisorCedulaCodigo,
      'FechaEmisionCedula': fechaEmisionCedula?.toUtc().toIso8601String() ??
          DateTime.now().toUtc().toIso8601String(),
      'FechaVencimientoCedula':
          fechaVencimientoCedula.toUtc().toIso8601String(),
      'FechaNacimiento': fechaNacimiento.toUtc().toIso8601String(),
      'Telefono': telefono,
      'Celular': celular,
      'DireccionCasa': direccionCasa,
      'BarrioCasa': barrioCasa,
      'MunicipioCasaCodigo': municipioCasaCodigo,
      'DepartamentoCasaCodigo': departamentoCasaCodigo,
      'PaisCasaCodigo': paisCasaCodigo,
      'Profesion': profesion,
      'Ocupacion': ocupacion,
      'CondicionCasaCodigo': condicionCasaCodigo,
      'AnosResidirCasa': anosResidirCasa,
      'Monto': monto,
      'MonedaCodigo': monedaCodigo,
      'PropositoCodigo': propositoCodigo,
      'FrecuenciaCodigo': frecuenciaCodigo,
      'Cuota': cuota,
      'SectorCodigo': sectorCodigo,
      'NombreNegocio': nombreNegocio,
      'TiempoFuncionamientoNegocio': tiempoFuncionamientoNegocio,
      'DireccionNegocio': direccionNegocio,
      'BarrioNegocio': barrioNegocio,
      'MunicipioNegocioCodigo': municipioNegocioCodigo,
      'CondicionNegocioCodigo': condicionNegocioCodigo,
      'HorarioTrabajo': horarioTrabajo,
      'HorarioVisita': horarioVisita,
      'PersonasACargo': personasACargo,
      'EstadoCivilCodigo': estadoCivilCodigo,
      'NombreConyugue': nombreCompletoConyugue,
      'TrabajaConyugue': trabajaConyugue,
      'TrabajoConyugue': trabajoConyugue,
      'DireccionTrabajoConyugue': direccionTrabajoConyugue,
      'TelefonoTrabajoConyugue': telefonoTrabajoConyugue,
      'ProductoCodigo': productoCodigo,
      'Observacion': observacion,
      'Sucursal': sucursal,
      'UbicacionLongitud': '1.23323434',
      'UbicacionLatitud': '1.23323434',
      'EscolaridadCodigo': escolaridadCodigo,
      'CantidadHijos': cantidadHijos,
      'NombrePublico': nombrePublico,
      'SexoCodigo': sexoCodigo,
      'PaisNacimientoCodigo': paisNacimientoCodigo,
      'NacionalidadConyugue': nacionalidadConyugue,
      'Ubicacion': ubicacion,
      'ESPEPS': espeps,
      'NombreDeEntidadPeps': nombreDeEntidadPeps,
      'PaisPeps': paisPeps,
      'PeriodoPeps': periodoPeps,
      'CargoOficialPeps': cargoOficialPeps,
      'TieneFamiliarPeps': tieneFamiliarPeps,
      'NombreFamiliarPeps2': nombreFamiliarPeps2,
      'ParentescoFamiliarPeps2Codigo': parentescoFamiliarPeps2Codigo,
      'CargoFamiliarPeps2': cargoFamiliarPeps2,
      'NombreEntidadPeps2': nombreEntidadPeps2,
      'PeriodoPeps2': periodoPeps2,
      'PaisPeps2': paisPeps2,
      'EsFamiliarEmpleado': esFamiliarEmpleado,
      'NombreFamiliar': nombreFamiliar,
      'CedulaFamiliar': cedulaFamiliar,
      'TipoDocumentoCodigo': tipoDocumentoCodigo,
      'TipoPersonaCodigo': tipoPersonaCodigo,
      'PlazoSolicitud': plazoSolicitud,
      'FechaPrimerPagoSolicitud':
          fechaPrimerPagoSolicitud.toUtc().toIso8601String(),
      'IsOffline': isOffline,
      'CodigoUSA': codigoUsa,
      'Nombre3': nombre3,
      'Apellido3': apellido3,
      'RTN': rtn,
      'TelefonoNegocio': telefonoNegocio,
      'CelularNegocio': celularNegocio,
      'ActividadDescripcionConyuge': actividadDescripcionConyugue,
      'experiencia': exeperiencia.toString(),
      'puestoNegocio': puestoNegocio,
      'ActividadEconomicaCNBS1Codigo': actividadEconomicaCnbs1Codigo,
      'ActividadEconomicaCNBS2Codigo': actividadEconomicaCnbs2Codigo,
      'ActividadEconomicaCNBS3Codigo': actividadEconomicaCnbs3Codigo,
      'ActividadEconomicaDescripcion1': actividaEconomicaDescipcion1,
      'ActividadEconomicaDescripcion2': actividaEconomicaDescipcion2,
      'ActividadEconomicaDescripcion3 ': actividaEconomicaDescipcion3,
      'EjerceAPNFD': ejerceApnfd,
      'EsAPNFD': esApnfd,
      'NacinalidadCodigo': nacinalidadCodigo,
      'Nacinalidad2Codigo': nacinalidad2Codigo,
      'Nacinalidad3Codigo': nacinalidad3Codigo,
      'DepartamentoDestinoCodigo': departamentoDestinoCodigo,
      'TipoPersonaCNBSCodigo': tipoPersonaCnbsCodigo,
      'TipoClienteCodigo': tipoClienteCodigo,
      'AldeaDestinoCodigo': aldeaDestinoCodigo,
      'MunicipioDestinoCodigo': municipioDestinoCodigo,
      'AldeaNegocioCodigo': aldeaNegocioCodigo,
      'DepartamentoNegocioCodigo': departamentoNegocioCodigo,
      'NivelAproximadoIngresosCodigo': nivelAproximadoIngresosCodigo,
      'DocumentoConyuge': documentoConyuge,
      'OcupacionCodigo': ocupacionCodigo,
      'ProfesionCodigo': profesionCodigo,
      'AldeaCasaCodigo': aldeaCasaCodigo,
      'UbicacionCodigo': ubicacionCodigo,
      'MedidasConocimientoCodigo': 'NORM',
      'CaserioCasa': caserioCasa,
      'CaserioNegocio': caserioNegocio,
      'CaserioDestino': caserioDestino,
      'BarrioDestino': barrioDestino,
      'DescripcionDestino': descripcionDestino,
      'IngresosNetos': ingresosNetos,
      'Nombre2': nombre2,
      'Apellido2': apellido2,
      'Email': email,
      'historialCredito':
          List<dynamic>.from(historialCredito.map((x) => x.toJson())),
    };
    data.removeWhere(
      (key, value) => value == null || value == '',
    );
    return data;
  }
}

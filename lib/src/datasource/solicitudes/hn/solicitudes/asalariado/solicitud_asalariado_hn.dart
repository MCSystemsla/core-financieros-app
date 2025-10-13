import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String solicitudAsalariadoHnToJson(SolicitudAsalariadoHn data) =>
    json.encode(data.toJson());

class SolicitudAsalariadoHn {
  final String database;
  final bool isOffline;
  final String origenSolicitudCodigo;
  final String nombre1;
  final String nombre2;
  final String apellido1;
  final String apellido2;
  final String cedula;
  final String paisEmisorCedulaCodigo;
  final DateTime fechaEmisionCedula;
  final DateTime fechaVencimientoCedula;
  final DateTime fechaNacimiento;
  final String telefono;
  final String celular;
  final String direccionCasa;
  final String barrioCasa;
  final String municipioCasaCodigo;
  final String departamentoCasaCodigo;
  final String paisCasaCodigo;
  final String nacinalidad;
  final String condicionCasaCodigo;
  final int anosResidirCasa;
  final String email;
  final int monto;
  final String monedaCodigo;
  final String propositoCodigo;
  final String frecuenciaCodigo;
  final int cuota;
  final String sectorCodigo;
  final int personasACargo;
  final String estadoCivilCodigo;
  final String nombreConyugue;
  final bool trabajaConyugue;
  final String trabajoConyugue;
  final String direccionTrabajoConyugue;
  final String telefonoTrabajoConyugue;
  final String productoCodigo;
  final String observacion;
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
  final String parentescoFamiliarPeps2;
  final String cargoFamiliarPeps2;
  final String nombreEntidadPeps2;
  final String periodoPeps2;
  final String paisPeps2;
  final String actividadPredominanteCodigo;
  final bool esFamiliarEmpleado;
  final String nombreFamiliar;
  final String cedulaFamiliar;
  final String tipoDocumentoCodigo;
  final String tipoPersonaCodigo;
  final int plazoSolicitud;
  final DateTime fechaPrimerPagoSolicitud;
  final String nombreTrabajo;
  final String direccionTrabajo;
  final String barrioTrabajo;
  final String cargo;
  final String direccionFamiliarCercano;
  final String fuenteOtrosIngresos;
  final String fuenteOtrosIngresosConyugue;
  final String lugarTrabajoAnterior;
  final String nombreFamiliarCercano;
  final String parentescoFamiliarCercanoCodigo;
  final int otrosIngresosConyugue;
  final int otrosIngresosCordoba;
  final String profesionConyugue;
  final int salarioNetoCordoba;
  final int sueldoMesConyugue;
  final String telefonoFamiliarCercano;
  final String telefonoTrabajo;
  final String tiempoLaborar;
  final String tiempoLaborarConyugue;
  final int totalIngresoMes;
  final int totalIngresoMesConyugue;
  final String rtn;
  final String codigoUsa;
  final String tipoPersonaCnbsidCodigo;
  final String estatusClienteCodigo;
  final String tipoClienteCodigo;
  final String actividadEconomicaCiuu1Codigo;
  final String actividadEconomicaCiuu2Codigo;
  final String actividadEconomicaCiuu3Codigo;
  final String nivelAproximadoDeIngresosCodigo;
  final String ocupacionCodigo;
  final String profesionCodigo;
  final String actividadEconomicaDescripcion1;
  final String actividadEconomicaDescripcion2;
  final String actividadEconomicaDescripcion3;
  final String ejerceApnfd;
  final String esApnfd;
  final String paisDestinoCodigo;
  final String departamentoDestinoCodigo;
  final String municipioDestinoId;
  final String aldeaDestinoCodigo;
  final String caserioDestino;
  final String barrioDestino;
  final String caseriCasa;
  final String aldeaCodigo;

  SolicitudAsalariadoHn({
    required this.database,
    required this.isOffline,
    required this.origenSolicitudCodigo,
    required this.nombre1,
    required this.nombre2,
    required this.apellido1,
    required this.apellido2,
    required this.cedula,
    required this.paisEmisorCedulaCodigo,
    required this.fechaEmisionCedula,
    required this.fechaVencimientoCedula,
    required this.fechaNacimiento,
    required this.telefono,
    required this.celular,
    required this.direccionCasa,
    required this.barrioCasa,
    required this.municipioCasaCodigo,
    required this.departamentoCasaCodigo,
    required this.paisCasaCodigo,
    required this.nacinalidad,
    required this.condicionCasaCodigo,
    required this.anosResidirCasa,
    required this.email,
    required this.monto,
    required this.monedaCodigo,
    required this.propositoCodigo,
    required this.frecuenciaCodigo,
    required this.cuota,
    required this.sectorCodigo,
    required this.personasACargo,
    required this.estadoCivilCodigo,
    required this.nombreConyugue,
    required this.trabajaConyugue,
    required this.trabajoConyugue,
    required this.direccionTrabajoConyugue,
    required this.telefonoTrabajoConyugue,
    required this.productoCodigo,
    required this.observacion,
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
    required this.parentescoFamiliarPeps2,
    required this.cargoFamiliarPeps2,
    required this.nombreEntidadPeps2,
    required this.periodoPeps2,
    required this.paisPeps2,
    required this.actividadPredominanteCodigo,
    required this.esFamiliarEmpleado,
    required this.nombreFamiliar,
    required this.cedulaFamiliar,
    required this.tipoDocumentoCodigo,
    required this.tipoPersonaCodigo,
    required this.plazoSolicitud,
    required this.fechaPrimerPagoSolicitud,
    required this.nombreTrabajo,
    required this.direccionTrabajo,
    required this.barrioTrabajo,
    required this.cargo,
    required this.direccionFamiliarCercano,
    required this.fuenteOtrosIngresos,
    required this.fuenteOtrosIngresosConyugue,
    required this.lugarTrabajoAnterior,
    required this.nombreFamiliarCercano,
    required this.parentescoFamiliarCercanoCodigo,
    required this.otrosIngresosConyugue,
    required this.otrosIngresosCordoba,
    required this.profesionConyugue,
    required this.salarioNetoCordoba,
    required this.sueldoMesConyugue,
    required this.telefonoFamiliarCercano,
    required this.telefonoTrabajo,
    required this.tiempoLaborar,
    required this.tiempoLaborarConyugue,
    required this.totalIngresoMes,
    required this.totalIngresoMesConyugue,
    required this.rtn,
    required this.codigoUsa,
    required this.tipoPersonaCnbsidCodigo,
    required this.estatusClienteCodigo,
    required this.tipoClienteCodigo,
    required this.actividadEconomicaCiuu1Codigo,
    required this.actividadEconomicaCiuu2Codigo,
    required this.actividadEconomicaCiuu3Codigo,
    required this.nivelAproximadoDeIngresosCodigo,
    required this.ocupacionCodigo,
    required this.profesionCodigo,
    required this.actividadEconomicaDescripcion1,
    required this.actividadEconomicaDescripcion2,
    required this.actividadEconomicaDescripcion3,
    required this.ejerceApnfd,
    required this.esApnfd,
    required this.paisDestinoCodigo,
    required this.departamentoDestinoCodigo,
    required this.municipioDestinoId,
    required this.aldeaDestinoCodigo,
    required this.caserioDestino,
    required this.barrioDestino,
    required this.caseriCasa,
    required this.aldeaCodigo,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'database': LocalStorage().database,
      'IsOffline': isOffline,
      'OrigenSolicitudCodigo': 'APPMOVIL',
      'Nombre1': nombre1,
      'Nombre2': nombre2,
      'Apellido1': apellido1,
      'Apellido2': apellido2,
      'Cedula': cedula,
      'PaisEmisorCedulaCodigo': paisEmisorCedulaCodigo,
      'FechaEmisionCedula': fechaEmisionCedula.toUtc().toIso8601String(),
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
      'Nacinalidad': nacinalidad,
      'CondicionCasaCodigo': condicionCasaCodigo,
      'AnosResidirCasa': anosResidirCasa,
      'Email': email,
      'Monto': monto,
      'MonedaCodigo': monedaCodigo,
      'PropositoCodigo': propositoCodigo,
      'FrecuenciaCodigo': frecuenciaCodigo,
      'Cuota': cuota,
      'SectorCodigo': sectorCodigo,
      'PersonasACargo': personasACargo,
      'EstadoCivilCodigo': estadoCivilCodigo,
      'NombreConyugue': nombreConyugue,
      'TrabajaConyugue': trabajaConyugue,
      'TrabajoConyugue': trabajoConyugue,
      'DireccionTrabajoConyugue': direccionTrabajoConyugue,
      'TelefonoTrabajoConyugue': telefonoTrabajoConyugue,
      'ProductoCodigo': productoCodigo,
      'Observacion': observacion,
      'UbicacionLongitud': ubicacionLongitud,
      'UbicacionLatitud': ubicacionLatitud,
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
      'ParentescoFamiliarPeps2': parentescoFamiliarPeps2,
      'CargoFamiliarPeps2': cargoFamiliarPeps2,
      'NombreEntidadPeps2': nombreEntidadPeps2,
      'PeriodoPeps2': periodoPeps2,
      'PaisPeps2': paisPeps2,
      'ActividadPredominanteCodigo': actividadPredominanteCodigo,
      'EsFamiliarEmpleado': esFamiliarEmpleado,
      'NombreFamiliar': nombreFamiliar,
      'CedulaFamiliar': cedulaFamiliar,
      'TipoDocumentoCodigo': tipoDocumentoCodigo,
      'TipoPersonaCodigo': tipoPersonaCodigo,
      'PlazoSolicitud': plazoSolicitud,
      'FechaPrimerPagoSolicitud':
          fechaPrimerPagoSolicitud.toUtc().toIso8601String(),
      'NombreTrabajo': nombreTrabajo,
      'DireccionTrabajo': direccionTrabajo,
      'BarrioTrabajo': barrioTrabajo,
      'Cargo': cargo,
      'DireccionFamiliarCercano': direccionFamiliarCercano,
      'FuenteOtrosIngresos': fuenteOtrosIngresos,
      'FuenteOtrosIngresosConyugue': fuenteOtrosIngresosConyugue,
      'LugarTrabajoAnterior': lugarTrabajoAnterior,
      'NombreFamiliarCercano': nombreFamiliarCercano,
      'ParentescoFamiliarCercanoCodigo': parentescoFamiliarCercanoCodigo,
      'OtrosIngresosConyugue': otrosIngresosConyugue,
      'OtrosIngresosCordoba': otrosIngresosCordoba,
      'ProfesionConyugue': profesionConyugue,
      'SalarioNetoCordoba': salarioNetoCordoba,
      'SueldoMesConyugue': sueldoMesConyugue,
      'TelefonoFamiliarCercano': telefonoFamiliarCercano,
      'TelefonoTrabajo': telefonoTrabajo,
      'TiempoLaborar': tiempoLaborar,
      'TiempoLaborarConyugue': tiempoLaborarConyugue,
      'TotalIngresoMes': totalIngresoMes,
      'TotalIngresoMesConyugue': totalIngresoMesConyugue,
      'RTN': rtn,
      'CodigoUSA': codigoUsa,
      'TipoPersonaCNBSIDCodigo': tipoPersonaCnbsidCodigo,
      'EstatusClienteCodigo': estatusClienteCodigo,
      'TipoClienteCodigo': tipoClienteCodigo,
      'ActividadEconomicaCIUU1Codigo': actividadEconomicaCiuu1Codigo,
      'ActividadEconomicaCIUU2Codigo': actividadEconomicaCiuu2Codigo,
      'ActividadEconomicaCIUU3Codigo': actividadEconomicaCiuu3Codigo,
      'NivelAproximadoDeIngresosCodigo': nivelAproximadoDeIngresosCodigo,
      'OcupacionCodigo': ocupacionCodigo,
      'ProfesionCodigo': profesionCodigo,
      'ActividadEconomicaDescripcion1': actividadEconomicaDescripcion1,
      'ActividadEconomicaDescripcion2': actividadEconomicaDescripcion2,
      'ActividadEconomicaDescripcion3': actividadEconomicaDescripcion3,
      'EjerceAPNFD': ejerceApnfd,
      'EsAPNFD': esApnfd,
      'PaisDestinoCodigo': paisDestinoCodigo,
      'DepartamentoDestinoCodigo': departamentoDestinoCodigo,
      'MunicipioDestinoID': municipioDestinoId,
      'AldeaDestinoCodigo': aldeaDestinoCodigo,
      'CaserioDestino': caserioDestino,
      'BarrioDestino': barrioDestino,
      'CaseriCasa': caseriCasa,
      'AldeaCodigo': aldeaCodigo,
    };
    data.removeWhere(
      (key, value) => value == null || value == '',
    );
    return data;
  }
}

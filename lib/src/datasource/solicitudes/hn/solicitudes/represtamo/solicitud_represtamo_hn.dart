import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String solicitudReprestamoHnToJson(SolicitudReprestamoHn data) =>
    json.encode(data.toJson());

class SolicitudReprestamoHn {
  final String origenSolicitudCodigo;
  final String cedula;
  final double monto;
  final String monedaCodigo;
  final String propositoCodigo;
  final String frecuenciaCodigo;
  final double cuota;
  final String beneficiarioSeguro;
  final String cedulaBeneficiarioSeguro;
  final String parentescoBeneficiarioSeguroCodigo;
  final String productoCodigo;
  final String observacion;
  final String ubicacionLongitud;
  final String ubicacionLatitud;
  final String ubicacion;
  final bool esPeps;
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
  final String tipoDocumentoCodigo;
  final String celularReprestamo;
  final bool esFamiliarEmpleado;
  final String nombreFamiliar;
  final String cedulaFamiliar;
  final int plazoSolicitud;
  final DateTime fechaPrimerPagoSolicitud;
  final String tipoPersonaCodigo;
  final bool cargaAnalisisAutomatico;
  final String motivoRevisionCodigo;
  final String actividadEconomicaCiuu1;
  final String actividadEconomicaCiuu2;
  final String actividadEconomicaCiuu3;
  final String codigoUsa;
  final bool apnfd;
  final bool apnfd2;
  final bool apnfd3;
  final String actividadEconomicaRealizaCiuu1;
  final String actividadEconomicaRealizaCiuu2;
  final String actividadEconomicaRealizaCiuu3;
  final String ejerceEconomicaRealizaCiuu1Codigo;
  final String ejerceEconomicaRealizaCiuu2Codigo;
  final String ejerceEconomicaRealizaCiuu3Codigo;
  final bool tieneIdentificacionEstadosUnidos;
  final bool tieneVinculoEstadosUnidos;
  final String vinculoEstadosUnidosDescripcion;
  final bool ejerceActividadApfnd;
  final String medidasConocimientoCodigo;
  final String nombreEmpleadoFamiliar;

  SolicitudReprestamoHn({
    required this.origenSolicitudCodigo,
    required this.cedula,
    required this.monto,
    required this.monedaCodigo,
    required this.propositoCodigo,
    required this.frecuenciaCodigo,
    required this.cuota,
    required this.beneficiarioSeguro,
    required this.cedulaBeneficiarioSeguro,
    required this.parentescoBeneficiarioSeguroCodigo,
    required this.productoCodigo,
    required this.observacion,
    required this.ubicacionLongitud,
    required this.ubicacionLatitud,
    required this.ubicacion,
    required this.esPeps,
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
    required this.tipoDocumentoCodigo,
    required this.celularReprestamo,
    required this.esFamiliarEmpleado,
    required this.nombreFamiliar,
    required this.cedulaFamiliar,
    required this.plazoSolicitud,
    required this.fechaPrimerPagoSolicitud,
    required this.tipoPersonaCodigo,
    required this.cargaAnalisisAutomatico,
    required this.motivoRevisionCodigo,
    required this.actividadEconomicaCiuu1,
    required this.actividadEconomicaCiuu2,
    required this.actividadEconomicaCiuu3,
    required this.codigoUsa,
    required this.apnfd,
    required this.apnfd2,
    required this.apnfd3,
    required this.actividadEconomicaRealizaCiuu1,
    required this.actividadEconomicaRealizaCiuu2,
    required this.actividadEconomicaRealizaCiuu3,
    required this.ejerceEconomicaRealizaCiuu1Codigo,
    required this.ejerceEconomicaRealizaCiuu2Codigo,
    required this.ejerceEconomicaRealizaCiuu3Codigo,
    required this.tieneIdentificacionEstadosUnidos,
    required this.tieneVinculoEstadosUnidos,
    required this.vinculoEstadosUnidosDescripcion,
    required this.ejerceActividadApfnd,
    required this.medidasConocimientoCodigo,
    required this.nombreEmpleadoFamiliar,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'database': LocalStorage().database,
      'OrigenSolicitudCodigo': 'APPMOVIL',
      'Cedula': cedula,
      'Monto': monto,
      'MonedaCodigo': monedaCodigo,
      'PropositoCodigo': propositoCodigo,
      'FrecuenciaCodigo': frecuenciaCodigo,
      'Cuota': cuota,
      'BeneficiarioSeguro': beneficiarioSeguro,
      'CedulaBeneficiarioSeguro': cedulaBeneficiarioSeguro,
      'ParentescoBeneficiarioSeguroCodigo': parentescoBeneficiarioSeguroCodigo,
      'ProductoCodigo': productoCodigo,
      'Observacion': observacion,
      'UbicacionLongitud': '1.2233232',
      'UbicacionLatitud': '1.2233232',
      'Ubicacion': ubicacion,
      'EsPEPS': esPeps,
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
      'TipoDocumentoCodigo': tipoDocumentoCodigo,
      'CelularReprestamo': celularReprestamo,
      'EsFamiliarEmpleado': esFamiliarEmpleado,
      'NombreFamiliar': nombreFamiliar,
      'CedulaFamiliar': cedulaFamiliar,
      'PlazoSolicitud': plazoSolicitud,
      'FechaPrimerPagoSolicitud':
          fechaPrimerPagoSolicitud.toUtc().toIso8601String(),
      'TipoPersonaCodigo': tipoPersonaCodigo,
      'CargaAnalisisAutomatico': cargaAnalisisAutomatico,
      'MotivoRevisionCodigo': motivoRevisionCodigo,
      'ActividadEconomicaCIUU1': actividadEconomicaCiuu1,
      'ActividadEconomicaCIUU2': actividadEconomicaCiuu2,
      'ActividadEconomicaCIUU3': actividadEconomicaCiuu3,
      'CodigoUSA': codigoUsa,
      'APNFD': apnfd,
      'APNFD2': apnfd2,
      'APNFD3': apnfd3,
      'ActividadEconomicaRealizaCIUU1': actividadEconomicaRealizaCiuu1,
      'ActividadEconomicaRealizaCIUU2': actividadEconomicaRealizaCiuu2,
      'ActividadEconomicaRealizaCIUU3': actividadEconomicaRealizaCiuu3,
      'EjerceEconomicaRealizaCiuu1Codigo': ejerceEconomicaRealizaCiuu1Codigo,
      'EjerceEconomicaRealizaCiuu2Codigo': ejerceEconomicaRealizaCiuu2Codigo,
      'EjerceEconomicaRealizaCiuu3Codigo': ejerceEconomicaRealizaCiuu3Codigo,
      'TieneIdentificacionEstadosUnidos': tieneIdentificacionEstadosUnidos,
      'TieneVinculoEstadosUnidos': tieneVinculoEstadosUnidos,
      'VinculoEstadosUnidosDescripcion': vinculoEstadosUnidosDescripcion,
      'EjerceActividadAPFND': ejerceActividadApfnd,
      'MedidasConocimientoCodigo': medidasConocimientoCodigo,
      'NombreEmpleadoFamiliar': nombreEmpleadoFamiliar,
    };
    data.removeWhere(
      (key, value) => value == null || value == '',
    );
    return data;
  }
}

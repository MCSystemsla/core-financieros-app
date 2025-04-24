import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String solicitudReprestamoToJson(SolicitudReprestamo data) =>
    json.encode(data.toJson());

class SolicitudReprestamo {
  final String username;
  final String userIp;
  final String database;
  final String objOrigenSolicitudId;
  final String cedula;
  final int monto;
  final String objMonedaId;
  final String objPropositoId;
  final String objFrecuenciaId;
  final int cuota;
  final String objActividadId;
  final String objActividadId1;
  final String objActividadId2;
  final String objSectorId;
  final String beneficiarioSeguro;
  final String cedulaBeneficiarioSeguro;
  final String objParentescoBeneficiarioSeguroId;
  final String objProductoId;
  final String observacion;
  final String ubicacionLongitud;
  final String ubicacionLatitud;
  final String sucursal;
  final String ubicacion;
  final bool esPeps;
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
  final String objRubroActividad;
  final String objActividadPredominante;
  final String objTipoDocumentoId;
  final String objRubroActividad2;
  final String objRubroActividad3;
  final String objRubroActividadPredominante;
  final String tipoPersona;
  final String objTipoPersonaId;
  final String telefonoBeneficiario;
  final String celularReprestamo;
  final bool esFamiliarEmpleado;
  final String nombreFamiliar;
  final String cedulaFamiliar;
  final int plazoSolicitud;
  final DateTime fechaPrimerPagoSolicitud;

  SolicitudReprestamo({
    required this.username,
    required this.userIp,
    required this.database,
    required this.objOrigenSolicitudId,
    required this.cedula,
    required this.monto,
    required this.objMonedaId,
    required this.objPropositoId,
    required this.objFrecuenciaId,
    required this.cuota,
    required this.objActividadId,
    required this.objActividadId1,
    required this.objActividadId2,
    required this.objSectorId,
    required this.beneficiarioSeguro,
    required this.cedulaBeneficiarioSeguro,
    required this.objParentescoBeneficiarioSeguroId,
    required this.objProductoId,
    required this.observacion,
    required this.ubicacionLongitud,
    required this.ubicacionLatitud,
    required this.sucursal,
    required this.ubicacion,
    required this.esPeps,
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
    required this.objRubroActividad,
    required this.objActividadPredominante,
    required this.objTipoDocumentoId,
    required this.objRubroActividad2,
    required this.objRubroActividad3,
    required this.objRubroActividadPredominante,
    required this.tipoPersona,
    required this.objTipoPersonaId,
    required this.telefonoBeneficiario,
    required this.esFamiliarEmpleado,
    required this.nombreFamiliar,
    required this.cedulaFamiliar,
    required this.plazoSolicitud,
    required this.celularReprestamo,
    required this.fechaPrimerPagoSolicitud,
  });

  Map<String, dynamic> toJson() => {
        'objClienteID': 35280,
        'objOrigenSolicitudID': 'APPMOVIL',
        'database': LocalStorage().database,
        'Cedula': cedula,
        'Monto': monto,
        'objMonedaID': objMonedaId,
        'objPropositoID': objPropositoId,
        'objFrecuenciaID': objFrecuenciaId,
        'Cuota': cuota,
        'objActividadID': objActividadId,
        'objActividadID1': objActividadId1,
        'objActividadID2': objActividadId2,
        'objSectorID': objSectorId,
        'BeneficiarioSeguro': beneficiarioSeguro,
        'CedulaBeneficiarioSeguro': cedulaBeneficiarioSeguro,
        'objParentescoBeneficiarioSeguroID': objParentescoBeneficiarioSeguroId,
        'objProductoID': objProductoId,
        'Observacion': observacion,
        'UbicacionLongitud': ubicacionLongitud,
        'UbicacionLatitud': ubicacionLatitud,
        'Sucursal': sucursal,
        'Ubicacion': ubicacion,
        'EsPEPS': esPeps,
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
        'objRubroActividad': objRubroActividad,
        'objActividadPredominante': objActividadPredominante,
        'objTipoDocumentoID': objTipoDocumentoId,
        'objRubroActividad2': objRubroActividad2,
        'objRubroActividad3': objRubroActividad3,
        'objRubroActividadPredominante': objRubroActividadPredominante,
        'TipoPersona': tipoPersona,
        'objTipoPersonaID': objTipoPersonaId,
        'TelefonoBeneficiario': telefonoBeneficiario,
        'EsFamiliarEmpleado': esFamiliarEmpleado,
        'NombreFamiliar': nombreFamiliar,
        'CedulaFamiliar': cedulaFamiliar,
        'PlazoSolicitud': plazoSolicitud,
        'CelularReprestamo': celularReprestamo,
        'FechaPrimerPagoSolicitud': fechaPrimerPagoSolicitud.toIso8601String(),
      };
}

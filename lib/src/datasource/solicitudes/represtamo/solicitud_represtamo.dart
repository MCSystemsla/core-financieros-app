import 'dart:convert';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

String solicitudReprestamoToJson(SolicitudReprestamo data) =>
    json.encode(data.toJson());

class SolicitudReprestamo {
  final String database;
  final DateTime fecha;
  final String objOrigenSolicitudId;
  final int objClienteId;
  final double monto;
  final String objMonedaId;
  final String objPropositoId;
  final String objFrecuenciaId;
  final double cuota;
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
  final String ubicacionGradosLongitud;
  final String ubicacionGradosLatitud;
  final String sucursal;
  final String usuarioCreacion;
  final DateTime fechaCreacion;
  final String maquinaCreacion;
  final String usuarioModificacion;
  final DateTime fechaModificacion;
  final String maquinaModificacion;
  final DateTime fechaAprobacion;
  final String usuarioAprobacion;
  final DateTime fechaARevision;
  final String ubicacion;
  final bool esPeps;
  final String nombreDeEntidadPeps;
  final String paisPeps;
  final String periodoPeps;
  final String cargoOficialPeps;
  final bool tieneFamiliarPeps;
  final dynamic nombreFamiliarPeps2;
  final dynamic parentescoFamiliarPeps2;
  final dynamic cargoFamiliarPeps2;
  final dynamic nombreEntidadPeps2;
  final dynamic periodoPeps2;
  final dynamic paisPeps2;
  final String objRubroActividad;
  final String objActividadPredominante;
  final String objTipoDocumentoId;
  final String objRubroActividad2;
  final String objRubroActividad3;
  final String objRubroActividadPredominante;
  final dynamic tipoPersona;
  final String objTipoPersonaId;
  final String objPremioSolicitudId;
  final String telefonoBeneficiario;
  final String objMotivoRechazoSauid;
  final String objCategoriaRechazoSauId;
  final String celularRepresntamo;
  final String estadoSms;
  final String referenciaSms;
  final bool esFamiliarEmpleado;
  final String nombreFamiliar;
  final String cedulaFamiliar;
  final bool cargaAnalisisAutomatico;
  final String objMotivoRevisionId;
  final int plazoSolicitud;
  final String celularReprestamo;
  final DateTime fechaPrimerPagoSolicitud;

  SolicitudReprestamo({
    required this.database,
    required this.fecha,
    required this.objOrigenSolicitudId,
    required this.objClienteId,
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
    required this.ubicacionGradosLongitud,
    required this.ubicacionGradosLatitud,
    required this.sucursal,
    required this.usuarioCreacion,
    required this.fechaCreacion,
    required this.maquinaCreacion,
    required this.usuarioModificacion,
    required this.fechaModificacion,
    required this.maquinaModificacion,
    required this.fechaAprobacion,
    required this.usuarioAprobacion,
    required this.fechaARevision,
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
    required this.objPremioSolicitudId,
    required this.telefonoBeneficiario,
    required this.objMotivoRechazoSauid,
    required this.objCategoriaRechazoSauId,
    required this.celularRepresntamo,
    required this.estadoSms,
    required this.referenciaSms,
    required this.esFamiliarEmpleado,
    required this.nombreFamiliar,
    required this.cedulaFamiliar,
    required this.cargaAnalisisAutomatico,
    required this.objMotivoRevisionId,
    required this.plazoSolicitud,
    required this.celularReprestamo,
    required this.fechaPrimerPagoSolicitud,
  });

  Map<String, dynamic> toJson() => {
        'database': LocalStorage().database,
        'Fecha': fecha.toIso8601String(),
        'objOrigenSolicitudID': objOrigenSolicitudId,
        'objClienteID': objClienteId,
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
        'UbicacionGradosLongitud': ubicacionGradosLongitud,
        'UbicacionGradosLatitud': ubicacionGradosLatitud,
        'Sucursal': sucursal,
        'UsuarioCreacion': usuarioCreacion,
        'FechaCreacion': fechaCreacion.toIso8601String(),
        'MaquinaCreacion': maquinaCreacion,
        'UsuarioModificacion': usuarioModificacion,
        'FechaModificacion': fechaModificacion.toIso8601String(),
        'MaquinaModificacion': maquinaModificacion,
        'FechaAprobacion': fechaAprobacion.toIso8601String(),
        'UsuarioAprobacion': usuarioAprobacion,
        'FechaARevision': fechaARevision.toIso8601String(),
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
        'objPremioSolicitudId': objPremioSolicitudId,
        'TelefonoBeneficiario': telefonoBeneficiario,
        'objMotivoRechazoSAUID': objMotivoRechazoSauid,
        'objCategoriaRechazoSAUId': objCategoriaRechazoSauId,
        'CelularRepresntamo': celularRepresntamo,
        'EstadoSMS': estadoSms,
        'ReferenciaSMS': referenciaSms,
        'EsFamiliarEmpleado': esFamiliarEmpleado,
        'NombreFamiliar': nombreFamiliar,
        'CedulaFamiliar': cedulaFamiliar,
        'CargaAnalisisAutomatico': cargaAnalisisAutomatico,
        'objMotivoRevisionID': objMotivoRevisionId,
        'PlazoSolicitud': plazoSolicitud,
        'CelularReprestamo': celularReprestamo,
        'FechaPrimerPagoSolicitud': fechaPrimerPagoSolicitud.toIso8601String(),
      };
}

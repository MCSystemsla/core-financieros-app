// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitud_represtamo_cubit.dart';

class SolicitudReprestamoState extends Equatable {
  final Status status;
  final String errorMsg;
  final String database;
  final String fecha;
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
  final String fechaCreacion;
  final String maquinaCreacion;
  final String usuarioModificacion;
  final String fechaModificacion;
  final String maquinaModificacion;
  final String fechaAprobacion;
  final String usuarioAprobacion;
  final String fechaARevision;
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
  final String fechaPrimerPagoSolicitud;
  const SolicitudReprestamoState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.database = '',
    this.fecha = '',
    this.objOrigenSolicitudId = '',
    this.objClienteId = 0,
    this.monto = 0.0,
    this.objMonedaId = '',
    this.objPropositoId = '',
    this.objFrecuenciaId = '',
    this.cuota = 0.0,
    this.objActividadId = '',
    this.objActividadId1 = '',
    this.objActividadId2 = '',
    this.objSectorId = '',
    this.beneficiarioSeguro = '',
    this.cedulaBeneficiarioSeguro = '',
    this.objParentescoBeneficiarioSeguroId = '',
    this.objProductoId = '',
    this.observacion = '',
    this.ubicacionLongitud = '',
    this.ubicacionLatitud = '',
    this.ubicacionGradosLongitud = '',
    this.ubicacionGradosLatitud = '',
    this.sucursal = '',
    this.usuarioCreacion = '',
    this.fechaCreacion = '',
    this.maquinaCreacion = '',
    this.usuarioModificacion = '',
    this.fechaModificacion = '',
    this.maquinaModificacion = '',
    this.fechaAprobacion = '',
    this.usuarioAprobacion = '',
    this.fechaARevision = '',
    this.ubicacion = '',
    this.esPeps = false,
    this.nombreDeEntidadPeps = '',
    this.paisPeps = '',
    this.periodoPeps = '',
    this.cargoOficialPeps = '',
    this.tieneFamiliarPeps = false,
    this.nombreFamiliarPeps2 = '',
    this.parentescoFamiliarPeps2 = '',
    this.cargoFamiliarPeps2 = '',
    this.nombreEntidadPeps2 = '',
    this.periodoPeps2 = '',
    this.paisPeps2 = '',
    this.objRubroActividad = '',
    this.objActividadPredominante = '',
    this.objTipoDocumentoId = '',
    this.objRubroActividad2 = '',
    this.objRubroActividad3 = '',
    this.objRubroActividadPredominante = '',
    this.tipoPersona = '',
    this.objTipoPersonaId = '',
    this.objPremioSolicitudId = '',
    this.telefonoBeneficiario = '',
    this.objMotivoRechazoSauid = '',
    this.objCategoriaRechazoSauId = '',
    this.celularRepresntamo = '',
    this.estadoSms = '',
    this.referenciaSms = '',
    this.esFamiliarEmpleado = false,
    this.nombreFamiliar = '',
    this.cedulaFamiliar = '',
    this.cargaAnalisisAutomatico = false,
    this.objMotivoRevisionId = '',
    this.plazoSolicitud = 0,
    this.celularReprestamo = '',
    this.fechaPrimerPagoSolicitud = '',
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        database,
        fecha,
        objOrigenSolicitudId,
        objClienteId,
        monto,
        objMonedaId,
        objPropositoId,
        objFrecuenciaId,
        cuota,
        objActividadId,
        objActividadId1,
        objActividadId2,
        objSectorId,
        beneficiarioSeguro,
        cedulaBeneficiarioSeguro,
        objParentescoBeneficiarioSeguroId,
        objProductoId,
        observacion,
        ubicacionLongitud,
        ubicacionLatitud,
        ubicacionGradosLongitud,
        ubicacionGradosLatitud,
        sucursal,
        usuarioCreacion,
        fechaCreacion,
        maquinaCreacion,
        usuarioModificacion,
        fechaModificacion,
        maquinaModificacion,
        fechaAprobacion,
        usuarioAprobacion,
        fechaARevision,
        ubicacion,
        esPeps,
        nombreDeEntidadPeps,
        paisPeps,
        periodoPeps,
        cargoOficialPeps,
        tieneFamiliarPeps,
        nombreFamiliarPeps2,
        parentescoFamiliarPeps2,
        cargoFamiliarPeps2,
        nombreEntidadPeps2,
        periodoPeps2,
        paisPeps2,
        objRubroActividad,
        objActividadPredominante,
        objTipoDocumentoId,
        objRubroActividad2,
        objRubroActividad3,
        objRubroActividadPredominante,
        tipoPersona,
        objTipoPersonaId,
        objPremioSolicitudId,
        telefonoBeneficiario,
        objMotivoRechazoSauid,
        objCategoriaRechazoSauId,
        celularRepresntamo,
        estadoSms,
        referenciaSms,
        esFamiliarEmpleado,
        nombreFamiliar,
        cedulaFamiliar,
        cargaAnalisisAutomatico,
        objMotivoRevisionId,
        plazoSolicitud,
        celularReprestamo,
        fechaPrimerPagoSolicitud,
      ];

  SolicitudReprestamoState copyWith({
    Status? status,
    String? errorMsg,
    String? database,
    String? fecha,
    String? objOrigenSolicitudId,
    int? objClienteId,
    double? monto,
    String? objMonedaId,
    String? objPropositoId,
    String? objFrecuenciaId,
    double? cuota,
    String? objActividadId,
    String? objActividadId1,
    String? objActividadId2,
    String? objSectorId,
    String? beneficiarioSeguro,
    String? cedulaBeneficiarioSeguro,
    String? objParentescoBeneficiarioSeguroId,
    String? objProductoId,
    String? observacion,
    String? ubicacionLongitud,
    String? ubicacionLatitud,
    String? ubicacionGradosLongitud,
    String? ubicacionGradosLatitud,
    String? sucursal,
    String? usuarioCreacion,
    String? fechaCreacion,
    String? maquinaCreacion,
    String? usuarioModificacion,
    String? fechaModificacion,
    String? maquinaModificacion,
    String? fechaAprobacion,
    String? usuarioAprobacion,
    String? fechaARevision,
    String? ubicacion,
    bool? esPeps,
    String? nombreDeEntidadPeps,
    String? paisPeps,
    String? periodoPeps,
    String? cargoOficialPeps,
    bool? tieneFamiliarPeps,
    String? nombreFamiliarPeps2,
    String? parentescoFamiliarPeps2,
    String? cargoFamiliarPeps2,
    String? nombreEntidadPeps2,
    String? periodoPeps2,
    String? paisPeps2,
    String? objRubroActividad,
    String? objActividadPredominante,
    String? objTipoDocumentoId,
    String? objRubroActividad2,
    String? objRubroActividad3,
    String? objRubroActividadPredominante,
    String? tipoPersona,
    String? objTipoPersonaId,
    String? objPremioSolicitudId,
    String? telefonoBeneficiario,
    String? objMotivoRechazoSauid,
    String? objCategoriaRechazoSauId,
    String? celularRepresntamo,
    String? estadoSms,
    String? referenciaSms,
    bool? esFamiliarEmpleado,
    String? nombreFamiliar,
    String? cedulaFamiliar,
    bool? cargaAnalisisAutomatico,
    String? objMotivoRevisionId,
    int? plazoSolicitud,
    String? celularReprestamo,
    String? fechaPrimerPagoSolicitud,
  }) {
    return SolicitudReprestamoState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      database: database ?? this.database,
      fecha: fecha ?? this.fecha,
      objOrigenSolicitudId: objOrigenSolicitudId ?? this.objOrigenSolicitudId,
      objClienteId: objClienteId ?? this.objClienteId,
      monto: monto ?? this.monto,
      objMonedaId: objMonedaId ?? this.objMonedaId,
      objPropositoId: objPropositoId ?? this.objPropositoId,
      objFrecuenciaId: objFrecuenciaId ?? this.objFrecuenciaId,
      cuota: cuota ?? this.cuota,
      objActividadId: objActividadId ?? this.objActividadId,
      objActividadId1: objActividadId1 ?? this.objActividadId1,
      objActividadId2: objActividadId2 ?? this.objActividadId2,
      objSectorId: objSectorId ?? this.objSectorId,
      beneficiarioSeguro: beneficiarioSeguro ?? this.beneficiarioSeguro,
      cedulaBeneficiarioSeguro:
          cedulaBeneficiarioSeguro ?? this.cedulaBeneficiarioSeguro,
      objParentescoBeneficiarioSeguroId: objParentescoBeneficiarioSeguroId ??
          this.objParentescoBeneficiarioSeguroId,
      objProductoId: objProductoId ?? this.objProductoId,
      observacion: observacion ?? this.observacion,
      ubicacionLongitud: ubicacionLongitud ?? this.ubicacionLongitud,
      ubicacionLatitud: ubicacionLatitud ?? this.ubicacionLatitud,
      ubicacionGradosLongitud:
          ubicacionGradosLongitud ?? this.ubicacionGradosLongitud,
      ubicacionGradosLatitud:
          ubicacionGradosLatitud ?? this.ubicacionGradosLatitud,
      sucursal: sucursal ?? this.sucursal,
      usuarioCreacion: usuarioCreacion ?? this.usuarioCreacion,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      maquinaCreacion: maquinaCreacion ?? this.maquinaCreacion,
      usuarioModificacion: usuarioModificacion ?? this.usuarioModificacion,
      fechaModificacion: fechaModificacion ?? this.fechaModificacion,
      maquinaModificacion: maquinaModificacion ?? this.maquinaModificacion,
      fechaAprobacion: fechaAprobacion ?? this.fechaAprobacion,
      usuarioAprobacion: usuarioAprobacion ?? this.usuarioAprobacion,
      fechaARevision: fechaARevision ?? this.fechaARevision,
      ubicacion: ubicacion ?? this.ubicacion,
      esPeps: esPeps ?? this.esPeps,
      nombreDeEntidadPeps: nombreDeEntidadPeps ?? this.nombreDeEntidadPeps,
      paisPeps: paisPeps ?? this.paisPeps,
      periodoPeps: periodoPeps ?? this.periodoPeps,
      cargoOficialPeps: cargoOficialPeps ?? this.cargoOficialPeps,
      tieneFamiliarPeps: tieneFamiliarPeps ?? this.tieneFamiliarPeps,
      nombreFamiliarPeps2: nombreFamiliarPeps2 ?? this.nombreFamiliarPeps2,
      parentescoFamiliarPeps2:
          parentescoFamiliarPeps2 ?? this.parentescoFamiliarPeps2,
      cargoFamiliarPeps2: cargoFamiliarPeps2 ?? this.cargoFamiliarPeps2,
      nombreEntidadPeps2: nombreEntidadPeps2 ?? this.nombreEntidadPeps2,
      periodoPeps2: periodoPeps2 ?? this.periodoPeps2,
      paisPeps2: paisPeps2 ?? this.paisPeps2,
      objRubroActividad: objRubroActividad ?? this.objRubroActividad,
      objActividadPredominante:
          objActividadPredominante ?? this.objActividadPredominante,
      objTipoDocumentoId: objTipoDocumentoId ?? this.objTipoDocumentoId,
      objRubroActividad2: objRubroActividad2 ?? this.objRubroActividad2,
      objRubroActividad3: objRubroActividad3 ?? this.objRubroActividad3,
      objRubroActividadPredominante:
          objRubroActividadPredominante ?? this.objRubroActividadPredominante,
      tipoPersona: tipoPersona ?? this.tipoPersona,
      objTipoPersonaId: objTipoPersonaId ?? this.objTipoPersonaId,
      objPremioSolicitudId: objPremioSolicitudId ?? this.objPremioSolicitudId,
      telefonoBeneficiario: telefonoBeneficiario ?? this.telefonoBeneficiario,
      objMotivoRechazoSauid:
          objMotivoRechazoSauid ?? this.objMotivoRechazoSauid,
      objCategoriaRechazoSauId:
          objCategoriaRechazoSauId ?? this.objCategoriaRechazoSauId,
      celularRepresntamo: celularRepresntamo ?? this.celularRepresntamo,
      estadoSms: estadoSms ?? this.estadoSms,
      referenciaSms: referenciaSms ?? this.referenciaSms,
      esFamiliarEmpleado: esFamiliarEmpleado ?? this.esFamiliarEmpleado,
      nombreFamiliar: nombreFamiliar ?? this.nombreFamiliar,
      cedulaFamiliar: cedulaFamiliar ?? this.cedulaFamiliar,
      cargaAnalisisAutomatico:
          cargaAnalisisAutomatico ?? this.cargaAnalisisAutomatico,
      objMotivoRevisionId: objMotivoRevisionId ?? this.objMotivoRevisionId,
      plazoSolicitud: plazoSolicitud ?? this.plazoSolicitud,
      celularReprestamo: celularReprestamo ?? this.celularReprestamo,
      fechaPrimerPagoSolicitud:
          fechaPrimerPagoSolicitud ?? this.fechaPrimerPagoSolicitud,
    );
  }
}

final class SolicitudReprestamoInitial extends SolicitudReprestamoState {}

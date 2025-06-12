// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitud_represtamo_cubit.dart';

class SolicitudReprestamoState extends Equatable {
  final bool isDone;
  final bool hasVerified;
  final String successMsg;
  final int idLocalResponse;
  final double tasaInteres;
  final String fechaDesembolso;
  final Status status;
  final String errorMsg;
  final String username;
  final String userIp;
  final String database;
  final String objOrigenSolicitudId;
  final String cedula;
  final int monto;
  final String objMonedaId;
  final String objPropositoId;
  final String objFrecuenciaId;
  final String objFrecuenciaIdVer;
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
  final String fechaPrimerPagoSolicitud;
  final bool isOffline;
  final String objOrigenSolicitudIdVer;
  final String objMonedaIdVer;
  final String objPropositoIdVer;
  final String objFrecuenciaIdVer2;
  final String objActividadIdVer;
  final String objActividadId1Ver;
  final String objActividadId2Ver;
  final String objSectorIdVer;
  final String objParentescoBeneficiarioSeguroIdVer;
  final String objProductoIdVer;
  final String objRubroActividadVer;
  final String objActividadPredominanteVer;
  final String objTipoDocumentoIdVer;
  final String objRubroActividad2Ver;
  final String objRubroActividad3Ver;
  final String objRubroActividadPredominanteVer;
  final String objTipoPersonaIdVer;
  final String parentescoFamiliar;
  final String parentescoFamiliarVer;
  final String cedulaFrontPath;
  final String cedulaBackPath;
  const SolicitudReprestamoState({
    this.cedulaBackPath = '',
    this.cedulaFrontPath = '',
    this.objOrigenSolicitudIdVer = '',
    this.objMonedaIdVer = '',
    this.objPropositoIdVer = '',
    this.objFrecuenciaIdVer2 = '',
    this.objActividadIdVer = '',
    this.objActividadId1Ver = '',
    this.objActividadId2Ver = '',
    this.objSectorIdVer = '',
    this.objParentescoBeneficiarioSeguroIdVer = '',
    this.objProductoIdVer = '',
    this.objRubroActividadVer = '',
    this.objActividadPredominanteVer = '',
    this.objTipoDocumentoIdVer = '',
    this.objRubroActividad2Ver = '',
    this.objRubroActividad3Ver = '',
    this.objRubroActividadPredominanteVer = '',
    this.objTipoPersonaIdVer = '',
    this.parentescoFamiliar = '',
    this.parentescoFamiliarVer = '',
    this.objFrecuenciaIdVer = '',
    this.isOffline = false,
    this.hasVerified = false,
    this.isDone = false,
    this.successMsg = '',
    this.tasaInteres = 0.00,
    this.fechaDesembolso = '',
    this.idLocalResponse = 0,
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.database = '',
    this.objOrigenSolicitudId = '',
    this.cedula = '',
    this.monto = 0,
    this.objMonedaId = '',
    this.objPropositoId = '',
    this.objFrecuenciaId = '',
    this.cuota = 0,
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
    this.sucursal = '',
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
    this.telefonoBeneficiario = '',
    this.esFamiliarEmpleado = false,
    this.nombreFamiliar = '',
    this.cedulaFamiliar = '',
    this.plazoSolicitud = 0,
    this.celularReprestamo = '',
    this.fechaPrimerPagoSolicitud = '',
    this.userIp = '',
    this.username = '',
  });

  @override
  List<Object> get props => [
        cedulaBackPath,
        cedulaFrontPath,
        objOrigenSolicitudIdVer,
        objMonedaIdVer,
        objPropositoIdVer,
        objFrecuenciaIdVer2,
        objActividadIdVer,
        objActividadId1Ver,
        objActividadId2Ver,
        objSectorIdVer,
        objParentescoBeneficiarioSeguroIdVer,
        objProductoIdVer,
        objRubroActividadVer,
        objActividadPredominanteVer,
        objTipoDocumentoIdVer,
        objRubroActividad2Ver,
        objRubroActividad3Ver,
        objRubroActividadPredominanteVer,
        objTipoPersonaIdVer,
        parentescoFamiliar,
        parentescoFamiliarVer,
        objFrecuenciaIdVer,
        isOffline,
        hasVerified,
        isDone,
        successMsg,
        tasaInteres,
        fechaDesembolso,
        idLocalResponse,
        status,
        errorMsg,
        database,
        objOrigenSolicitudId,
        cedula,
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
        sucursal,
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
        telefonoBeneficiario,
        esFamiliarEmpleado,
        nombreFamiliar,
        cedulaFamiliar,
        plazoSolicitud,
        celularReprestamo,
        fechaPrimerPagoSolicitud,
      ];

  SolicitudReprestamoState copyWith({
    bool? isDone,
    bool? hasVerified,
    String? successMsg,
    int? idLocalResponse,
    double? tasaInteres,
    String? fechaDesembolso,
    Status? status,
    String? errorMsg,
    String? username,
    String? userIp,
    String? database,
    String? objOrigenSolicitudId,
    String? cedula,
    int? monto,
    String? objMonedaId,
    String? objPropositoId,
    String? objFrecuenciaId,
    String? objFrecuenciaIdVer,
    int? cuota,
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
    String? sucursal,
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
    String? telefonoBeneficiario,
    String? celularReprestamo,
    bool? esFamiliarEmpleado,
    String? nombreFamiliar,
    String? cedulaFamiliar,
    int? plazoSolicitud,
    String? fechaPrimerPagoSolicitud,
    bool? isOffline,
    String? objOrigenSolicitudIdVer,
    String? objMonedaIdVer,
    String? objPropositoIdVer,
    String? objFrecuenciaIdVer2,
    String? objActividadIdVer,
    String? objActividadId1Ver,
    String? objActividadId2Ver,
    String? objSectorIdVer,
    String? objParentescoBeneficiarioSeguroIdVer,
    String? objProductoIdVer,
    String? objRubroActividadVer,
    String? objActividadPredominanteVer,
    String? objTipoDocumentoIdVer,
    String? objRubroActividad2Ver,
    String? objRubroActividad3Ver,
    String? objRubroActividadPredominanteVer,
    String? objTipoPersonaIdVer,
    String? parentescoFamiliar,
    String? parentescoFamiliarVer,
    String? cedulaFrontPath,
    String? cedulaBackPath,
  }) {
    return SolicitudReprestamoState(
      isDone: isDone ?? this.isDone,
      hasVerified: hasVerified ?? this.hasVerified,
      successMsg: successMsg ?? this.successMsg,
      idLocalResponse: idLocalResponse ?? this.idLocalResponse,
      tasaInteres: tasaInteres ?? this.tasaInteres,
      fechaDesembolso: fechaDesembolso ?? this.fechaDesembolso,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      username: username ?? this.username,
      userIp: userIp ?? this.userIp,
      database: database ?? this.database,
      objOrigenSolicitudId: objOrigenSolicitudId ?? this.objOrigenSolicitudId,
      cedula: cedula ?? this.cedula,
      monto: monto ?? this.monto,
      objMonedaId: objMonedaId ?? this.objMonedaId,
      objPropositoId: objPropositoId ?? this.objPropositoId,
      objFrecuenciaId: objFrecuenciaId ?? this.objFrecuenciaId,
      objFrecuenciaIdVer: objFrecuenciaIdVer ?? this.objFrecuenciaIdVer,
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
      sucursal: sucursal ?? this.sucursal,
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
      telefonoBeneficiario: telefonoBeneficiario ?? this.telefonoBeneficiario,
      celularReprestamo: celularReprestamo ?? this.celularReprestamo,
      esFamiliarEmpleado: esFamiliarEmpleado ?? this.esFamiliarEmpleado,
      nombreFamiliar: nombreFamiliar ?? this.nombreFamiliar,
      cedulaFamiliar: cedulaFamiliar ?? this.cedulaFamiliar,
      plazoSolicitud: plazoSolicitud ?? this.plazoSolicitud,
      fechaPrimerPagoSolicitud:
          fechaPrimerPagoSolicitud ?? this.fechaPrimerPagoSolicitud,
      isOffline: isOffline ?? this.isOffline,
      objOrigenSolicitudIdVer:
          objOrigenSolicitudIdVer ?? this.objOrigenSolicitudIdVer,
      objMonedaIdVer: objMonedaIdVer ?? this.objMonedaIdVer,
      objPropositoIdVer: objPropositoIdVer ?? this.objPropositoIdVer,
      objFrecuenciaIdVer2: objFrecuenciaIdVer2 ?? this.objFrecuenciaIdVer2,
      objActividadIdVer: objActividadIdVer ?? this.objActividadIdVer,
      objActividadId1Ver: objActividadId1Ver ?? this.objActividadId1Ver,
      objActividadId2Ver: objActividadId2Ver ?? this.objActividadId2Ver,
      objSectorIdVer: objSectorIdVer ?? this.objSectorIdVer,
      objParentescoBeneficiarioSeguroIdVer:
          objParentescoBeneficiarioSeguroIdVer ??
              this.objParentescoBeneficiarioSeguroIdVer,
      objProductoIdVer: objProductoIdVer ?? this.objProductoIdVer,
      objRubroActividadVer: objRubroActividadVer ?? this.objRubroActividadVer,
      objActividadPredominanteVer:
          objActividadPredominanteVer ?? this.objActividadPredominanteVer,
      objTipoDocumentoIdVer:
          objTipoDocumentoIdVer ?? this.objTipoDocumentoIdVer,
      objRubroActividad2Ver:
          objRubroActividad2Ver ?? this.objRubroActividad2Ver,
      objRubroActividad3Ver:
          objRubroActividad3Ver ?? this.objRubroActividad3Ver,
      objRubroActividadPredominanteVer: objRubroActividadPredominanteVer ??
          this.objRubroActividadPredominanteVer,
      objTipoPersonaIdVer: objTipoPersonaIdVer ?? this.objTipoPersonaIdVer,
      parentescoFamiliar: parentescoFamiliar ?? this.parentescoFamiliar,
      parentescoFamiliarVer:
          parentescoFamiliarVer ?? this.parentescoFamiliarVer,
      cedulaFrontPath: cedulaFrontPath ?? this.cedulaFrontPath,
      cedulaBackPath: cedulaBackPath ?? this.cedulaBackPath,
    );
  }
}

final class SolicitudReprestamoInitial extends SolicitudReprestamoState {}

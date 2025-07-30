// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitud_asalariado_cubit.dart';

class SolicitudAsalariadoState extends Equatable {
  final String numeroSolicitud;
  final String? uuid;
  final bool hasVerified;
  final bool isOffline;
  final bool isDone;
  final int idLocalResponse;
  final Status status;
  final String errorMsg;
  final String successMsg;
  final String objOrigenSolicitudId;
  final String database;
  final String nombre1;
  final String nombre2;
  final String apellido1;
  final String apellido2;
  final String cedula;
  final String objPaisEmisorCedula;
  final String fechaEmisionCedula;
  final String fechaVencimientoCedula;
  final String fechaNacimiento;
  final String telefono;
  final String celular;
  final String direccionCasa;
  final String barrioCasa;
  final String objMunicipioCasaId;
  final String objDepartamentoCasaId;
  final String objPaisCasaId;
  final String profesion;
  final String ocupacion;
  final String nacionalidad;
  final String objCondicionCasaId;
  final int anosResidirCasa;
  final String email;
  final double monto;
  final String objMonedaId;
  final String objPropositoId;
  final String objFrecuenciaId;
  final double cuota;
  final String objSectorId;
  final int personasACargo;
  final String objEstadoCivilId;
  final String nombreConyugue;
  final bool trabajaConyugue;
  final String trabajoConyugue;
  final String direccionTrabajoConyugue;
  final String telefonoTrabajoConyugue;
  final String beneficiarioSeguro;
  final String cedulaBeneficiarioSeguro;
  final String objParentescoBeneficiarioSeguroId;
  final String objEstadoSolicitudId;
  final String objOficialCreditoId;
  final String objProductoId;
  final String observacion;
  final String sucursal;
  final String ubicacionLongitud;
  final String ubicacionLatitud;
  final String ubicacionGradosLongitud;
  final String ubicacionGradosLatitud;
  final String objEscolaridadId;
  final int cantidadHijos;
  final String nombrePublico;
  final String objSexoId;
  final String objPaisNacimientoId;
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
  final String objRubroActividad;
  final String objActividadPredominante;
  final bool esFamiliarEmpleado;
  final String nombreFamiliar;
  final String cedulaFamiliar;
  final String objTipoDocumentoId;
  final String objRubroActividad2;
  final String objRubroActividad3;
  final String objRubroActividadPredominante;
  final String tipoPersona;
  final String objTipoPersonaId;
  final String telefonoBeneficiario;
  final String codigoRed;
  final int plazoSolicitud;
  final String fechaPrimerPagoSolicitud;
  final String nombreTrabajo;
  final String direccionTrabajo;
  final String barrioTrabajo;
  final String objActividadEconomicaId;
  final String objActividadEconomicaId1;
  final String objActividadEconomicaId2;
  final String cargo;
  final String direccionFamiliarCercano;
  final String duenoVivienda;
  final String fechaVenceAvaluoAsalariado;
  final String fuenteOtrosIngresos;
  final String fuenteOtrosIngresosConyugue;
  final String lugarTrabajoAnterior;
  final String nombreFamiliarCercano;
  final String objParentescoFamiliarCercanoId;
  final double otrosIngresosConyugue;
  final double otrosIngresosCordoba;
  final int pagoAlquiler;
  final String profesionConyugue;
  final double salarioNetoCordoba;
  final double sueldoMesConyugue;
  final String telefonoFamiliarCercano;
  final String telefonoTrabajo;
  final String tiempoLaborar;
  final String tiempoLaborarConyugue;
  final double totalIngresoMes;
  final double totalIngresoMesConyugue;
  final String fechaDesembolso;
  final double tasaInteres;
  final int montoMinimo;
  final int montoMaximo;
  final String objOrigenSolicitudIdVer;
  final String objPaisEmisorCedulaVer;
  final String objMunicipioCasaIdVer;
  final String objDepartamentoCasaIdVer;
  final String objPaisCasaIdVer;
  final String objCondicionCasaIdVer;
  final String objMonedaIdVer;
  final String objPropositoIdVer;
  final String objFrecuenciaIdVer;
  final String objSectorIdVer;
  final String objEstadoCivilIdVer;
  final String objParentescoBeneficiarioSeguroIdVer;
  final String objEstadoSolicitudIdVer;
  final String objOficialCreditoIdVer;
  final String objProductoIdVer;
  final String objEscolaridadIdVer;
  final String objSexoIdVer;
  final String objPaisNacimientoIdVer;
  final String objRubroActividadVer;
  final String objActividadPredominanteVer;
  final String objTipoDocumentoIdVer;
  final String objRubroActividad2Ver;
  final String objRubroActividad3Ver;
  final String objRubroActividadPredominanteVer;
  final String objTipoPersonaIdVer;
  final String objActividadEconomicaIdVer;
  final String objActividadEconomicaId1Ver;
  final String objActividadEconomicaId2Ver;
  final String objParentescoFamiliarCercanoIdVer;
  final String cedulaFrontPath;
  final String cedulaBackPath;
  final String frecuenciaPagoMeses;
  final String createdAt;
  const SolicitudAsalariadoState({
    this.uuid,
    this.frecuenciaPagoMeses = '',
    this.numeroSolicitud = '',
    this.createdAt = '',
    this.cedulaFrontPath = '',
    this.cedulaBackPath = '',
    this.objOrigenSolicitudIdVer = '',
    this.objPaisEmisorCedulaVer = '',
    this.objMunicipioCasaIdVer = '',
    this.objDepartamentoCasaIdVer = '',
    this.objPaisCasaIdVer = '',
    this.objCondicionCasaIdVer = '',
    this.objMonedaIdVer = '',
    this.objPropositoIdVer = '',
    this.objFrecuenciaIdVer = '',
    this.objSectorIdVer = '',
    this.objEstadoCivilIdVer = '',
    this.objParentescoBeneficiarioSeguroIdVer = '',
    this.objEstadoSolicitudIdVer = '',
    this.objOficialCreditoIdVer = '',
    this.objProductoIdVer = '',
    this.objEscolaridadIdVer = '',
    this.objSexoIdVer = '',
    this.objPaisNacimientoIdVer = '',
    this.objRubroActividadVer = '',
    this.objActividadPredominanteVer = '',
    this.objTipoDocumentoIdVer = '',
    this.objRubroActividad2Ver = '',
    this.objRubroActividad3Ver = '',
    this.objRubroActividadPredominanteVer = '',
    this.objTipoPersonaIdVer = '',
    this.objActividadEconomicaIdVer = '',
    this.objActividadEconomicaId1Ver = '',
    this.objActividadEconomicaId2Ver = '',
    this.objParentescoFamiliarCercanoIdVer = '',
    this.fechaDesembolso = '',
    this.tasaInteres = 0.0,
    this.montoMinimo = 0,
    this.montoMaximo = 0,
    this.hasVerified = false,
    this.isOffline = false,
    this.isDone = false,
    this.idLocalResponse = 0,
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.successMsg = '',
    this.objOrigenSolicitudId = '',
    this.database = '',
    this.nombre1 = '',
    this.nombre2 = '',
    this.apellido1 = '',
    this.apellido2 = '',
    this.cedula = '',
    this.objPaisEmisorCedula = '',
    this.fechaEmisionCedula = '',
    this.fechaVencimientoCedula = '',
    this.fechaNacimiento = '',
    this.telefono = '',
    this.celular = '',
    this.direccionCasa = '',
    this.barrioCasa = '',
    this.objMunicipioCasaId = '',
    this.objDepartamentoCasaId = '',
    this.objPaisCasaId = '',
    this.profesion = '',
    this.ocupacion = '',
    this.nacionalidad = '',
    this.objCondicionCasaId = '',
    this.anosResidirCasa = 0,
    this.email = '',
    this.monto = 0.0,
    this.objMonedaId = '',
    this.objPropositoId = '',
    this.objFrecuenciaId = '',
    this.cuota = 0.0,
    this.objSectorId = '',
    this.personasACargo = 0,
    this.objEstadoCivilId = '',
    this.nombreConyugue = '',
    this.trabajaConyugue = false,
    this.trabajoConyugue = '',
    this.direccionTrabajoConyugue = '',
    this.telefonoTrabajoConyugue = '',
    this.beneficiarioSeguro = '',
    this.cedulaBeneficiarioSeguro = '',
    this.objParentescoBeneficiarioSeguroId = '',
    this.objEstadoSolicitudId = '',
    this.objOficialCreditoId = '',
    this.objProductoId = '',
    this.observacion = '',
    this.sucursal = '',
    this.ubicacionLongitud = '',
    this.ubicacionLatitud = '',
    this.ubicacionGradosLongitud = '',
    this.ubicacionGradosLatitud = '',
    this.objEscolaridadId = '',
    this.cantidadHijos = 0,
    this.nombrePublico = '',
    this.objSexoId = '',
    this.objPaisNacimientoId = '',
    this.nacionalidadConyugue = '',
    this.ubicacion = '',
    this.espeps = false,
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
    this.esFamiliarEmpleado = false,
    this.nombreFamiliar = '',
    this.cedulaFamiliar = '',
    this.objTipoDocumentoId = '',
    this.objRubroActividad2 = '',
    this.objRubroActividad3 = '',
    this.objRubroActividadPredominante = '',
    this.tipoPersona = '',
    this.objTipoPersonaId = '',
    this.telefonoBeneficiario = '',
    this.codigoRed = '',
    this.plazoSolicitud = 0,
    this.fechaPrimerPagoSolicitud = '',
    this.nombreTrabajo = '',
    this.direccionTrabajo = '',
    this.barrioTrabajo = '',
    this.objActividadEconomicaId = '',
    this.objActividadEconomicaId1 = '',
    this.objActividadEconomicaId2 = '',
    this.cargo = '',
    this.direccionFamiliarCercano = '',
    this.duenoVivienda = '',
    this.fechaVenceAvaluoAsalariado = '',
    this.fuenteOtrosIngresos = '',
    this.fuenteOtrosIngresosConyugue = '',
    this.lugarTrabajoAnterior = '',
    this.nombreFamiliarCercano = '',
    this.objParentescoFamiliarCercanoId = '',
    this.otrosIngresosConyugue = 0.0,
    this.otrosIngresosCordoba = 0.0,
    this.pagoAlquiler = 0,
    this.profesionConyugue = '',
    this.salarioNetoCordoba = 0.0,
    this.sueldoMesConyugue = 0.0,
    this.telefonoFamiliarCercano = '',
    this.telefonoTrabajo = '',
    this.tiempoLaborar = '0',
    this.tiempoLaborarConyugue = '',
    this.totalIngresoMes = 0.0,
    this.totalIngresoMesConyugue = 0.0,
  });

  @override
  List<Object> get props => [
        createdAt,
        frecuenciaPagoMeses,
        cedulaFrontPath,
        cedulaBackPath,
        fechaDesembolso,
        tasaInteres,
        montoMinimo,
        montoMaximo,
        hasVerified,
        isOffline,
        isDone,
        idLocalResponse,
        successMsg,
        errorMsg,
        status,
        objOrigenSolicitudId,
        database,
        nombre1,
        nombre2,
        apellido1,
        apellido2,
        cedula,
        objPaisEmisorCedula,
        fechaEmisionCedula,
        fechaVencimientoCedula,
        fechaNacimiento,
        telefono,
        celular,
        direccionCasa,
        barrioCasa,
        objMunicipioCasaId,
        objDepartamentoCasaId,
        objPaisCasaId,
        profesion,
        ocupacion,
        nacionalidad,
        objCondicionCasaId,
        anosResidirCasa,
        email,
        monto,
        objMonedaId,
        objPropositoId,
        objFrecuenciaId,
        cuota,
        objSectorId,
        personasACargo,
        objEstadoCivilId,
        nombreConyugue,
        trabajaConyugue,
        trabajoConyugue,
        direccionTrabajoConyugue,
        telefonoTrabajoConyugue,
        beneficiarioSeguro,
        cedulaBeneficiarioSeguro,
        objParentescoBeneficiarioSeguroId,
        objEstadoSolicitudId,
        objOficialCreditoId,
        objProductoId,
        observacion,
        sucursal,
        ubicacionLongitud,
        ubicacionLatitud,
        ubicacionGradosLongitud,
        ubicacionGradosLatitud,
        objEscolaridadId,
        cantidadHijos,
        nombrePublico,
        objSexoId,
        objPaisNacimientoId,
        nacionalidadConyugue,
        ubicacion,
        espeps,
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
        esFamiliarEmpleado,
        nombreFamiliar,
        cedulaFamiliar,
        objTipoDocumentoId,
        objRubroActividad2,
        objRubroActividad3,
        objRubroActividadPredominante,
        tipoPersona,
        objTipoPersonaId,
        telefonoBeneficiario,
        codigoRed,
        plazoSolicitud,
        fechaPrimerPagoSolicitud,
        nombreTrabajo,
        direccionTrabajo,
        barrioTrabajo,
        objActividadEconomicaId,
        objActividadEconomicaId1,
        objActividadEconomicaId2,
        cargo,
        direccionFamiliarCercano,
        duenoVivienda,
        fechaVenceAvaluoAsalariado,
        fuenteOtrosIngresos,
        fuenteOtrosIngresosConyugue,
        lugarTrabajoAnterior,
        nombreFamiliarCercano,
        objParentescoFamiliarCercanoId,
        otrosIngresosConyugue,
        otrosIngresosCordoba,
        pagoAlquiler,
        profesionConyugue,
        salarioNetoCordoba,
        sueldoMesConyugue,
        telefonoFamiliarCercano,
        telefonoTrabajo,
        tiempoLaborar,
        tiempoLaborarConyugue,
        totalIngresoMes,
        totalIngresoMesConyugue,
      ];

  SolicitudAsalariadoState copyWith({
    String? numeroSolicitud,
    String? uuid,
    bool? hasVerified,
    bool? isOffline,
    bool? isDone,
    int? idLocalResponse,
    Status? status,
    String? errorMsg,
    String? successMsg,
    String? objOrigenSolicitudId,
    String? database,
    String? nombre1,
    String? nombre2,
    String? apellido1,
    String? apellido2,
    String? cedula,
    String? objPaisEmisorCedula,
    String? fechaEmisionCedula,
    String? fechaVencimientoCedula,
    String? fechaNacimiento,
    String? telefono,
    String? celular,
    String? direccionCasa,
    String? barrioCasa,
    String? objMunicipioCasaId,
    String? objDepartamentoCasaId,
    String? objPaisCasaId,
    String? profesion,
    String? ocupacion,
    String? nacionalidad,
    String? objCondicionCasaId,
    int? anosResidirCasa,
    String? email,
    double? monto,
    String? objMonedaId,
    String? objPropositoId,
    String? objFrecuenciaId,
    double? cuota,
    String? objSectorId,
    int? personasACargo,
    String? objEstadoCivilId,
    String? nombreConyugue,
    bool? trabajaConyugue,
    String? trabajoConyugue,
    String? direccionTrabajoConyugue,
    String? telefonoTrabajoConyugue,
    String? beneficiarioSeguro,
    String? cedulaBeneficiarioSeguro,
    String? objParentescoBeneficiarioSeguroId,
    String? objEstadoSolicitudId,
    String? objOficialCreditoId,
    String? objProductoId,
    String? observacion,
    String? sucursal,
    String? ubicacionLongitud,
    String? ubicacionLatitud,
    String? ubicacionGradosLongitud,
    String? ubicacionGradosLatitud,
    String? objEscolaridadId,
    int? cantidadHijos,
    String? nombrePublico,
    String? objSexoId,
    String? objPaisNacimientoId,
    String? nacionalidadConyugue,
    String? ubicacion,
    bool? espeps,
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
    bool? esFamiliarEmpleado,
    String? nombreFamiliar,
    String? cedulaFamiliar,
    String? objTipoDocumentoId,
    String? objRubroActividad2,
    String? objRubroActividad3,
    String? objRubroActividadPredominante,
    String? tipoPersona,
    String? objTipoPersonaId,
    String? telefonoBeneficiario,
    String? codigoRed,
    int? plazoSolicitud,
    String? fechaPrimerPagoSolicitud,
    String? nombreTrabajo,
    String? direccionTrabajo,
    String? barrioTrabajo,
    String? objActividadEconomicaId,
    String? objActividadEconomicaId1,
    String? objActividadEconomicaId2,
    String? cargo,
    String? direccionFamiliarCercano,
    String? duenoVivienda,
    String? fechaVenceAvaluoAsalariado,
    String? fuenteOtrosIngresos,
    String? fuenteOtrosIngresosConyugue,
    String? lugarTrabajoAnterior,
    String? nombreFamiliarCercano,
    String? objParentescoFamiliarCercanoId,
    double? otrosIngresosConyugue,
    double? otrosIngresosCordoba,
    int? pagoAlquiler,
    String? profesionConyugue,
    double? salarioNetoCordoba,
    double? sueldoMesConyugue,
    String? telefonoFamiliarCercano,
    String? telefonoTrabajo,
    String? tiempoLaborar,
    String? tiempoLaborarConyugue,
    double? totalIngresoMes,
    double? totalIngresoMesConyugue,
    String? fechaDesembolso,
    double? tasaInteres,
    int? montoMinimo,
    int? montoMaximo,
    String? objOrigenSolicitudIdVer,
    String? objPaisEmisorCedulaVer,
    String? objMunicipioCasaIdVer,
    String? objDepartamentoCasaIdVer,
    String? objPaisCasaIdVer,
    String? objCondicionCasaIdVer,
    String? objMonedaIdVer,
    String? objPropositoIdVer,
    String? objFrecuenciaIdVer,
    String? objSectorIdVer,
    String? objEstadoCivilIdVer,
    String? objParentescoBeneficiarioSeguroIdVer,
    String? objEstadoSolicitudIdVer,
    String? objOficialCreditoIdVer,
    String? objProductoIdVer,
    String? objEscolaridadIdVer,
    String? objSexoIdVer,
    String? objPaisNacimientoIdVer,
    String? objRubroActividadVer,
    String? objActividadPredominanteVer,
    String? objTipoDocumentoIdVer,
    String? objRubroActividad2Ver,
    String? objRubroActividad3Ver,
    String? objRubroActividadPredominanteVer,
    String? objTipoPersonaIdVer,
    String? objActividadEconomicaIdVer,
    String? objActividadEconomicaId1Ver,
    String? objActividadEconomicaId2Ver,
    String? objParentescoFamiliarCercanoIdVer,
    String? cedulaFrontPath,
    String? cedulaBackPath,
    String? frecuenciaPagoMeses,
    String? createdAt,
  }) {
    return SolicitudAsalariadoState(
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      uuid: uuid ?? this.uuid,
      hasVerified: hasVerified ?? this.hasVerified,
      isOffline: isOffline ?? this.isOffline,
      isDone: isDone ?? this.isDone,
      idLocalResponse: idLocalResponse ?? this.idLocalResponse,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      successMsg: successMsg ?? this.successMsg,
      objOrigenSolicitudId: objOrigenSolicitudId ?? this.objOrigenSolicitudId,
      database: database ?? this.database,
      nombre1: nombre1 ?? this.nombre1,
      nombre2: nombre2 ?? this.nombre2,
      apellido1: apellido1 ?? this.apellido1,
      apellido2: apellido2 ?? this.apellido2,
      cedula: cedula ?? this.cedula,
      objPaisEmisorCedula: objPaisEmisorCedula ?? this.objPaisEmisorCedula,
      fechaEmisionCedula: fechaEmisionCedula ?? this.fechaEmisionCedula,
      fechaVencimientoCedula:
          fechaVencimientoCedula ?? this.fechaVencimientoCedula,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      telefono: telefono ?? this.telefono,
      celular: celular ?? this.celular,
      direccionCasa: direccionCasa ?? this.direccionCasa,
      barrioCasa: barrioCasa ?? this.barrioCasa,
      objMunicipioCasaId: objMunicipioCasaId ?? this.objMunicipioCasaId,
      objDepartamentoCasaId:
          objDepartamentoCasaId ?? this.objDepartamentoCasaId,
      objPaisCasaId: objPaisCasaId ?? this.objPaisCasaId,
      profesion: profesion ?? this.profesion,
      ocupacion: ocupacion ?? this.ocupacion,
      nacionalidad: nacionalidad ?? this.nacionalidad,
      objCondicionCasaId: objCondicionCasaId ?? this.objCondicionCasaId,
      anosResidirCasa: anosResidirCasa ?? this.anosResidirCasa,
      email: email ?? this.email,
      monto: monto ?? this.monto,
      objMonedaId: objMonedaId ?? this.objMonedaId,
      objPropositoId: objPropositoId ?? this.objPropositoId,
      objFrecuenciaId: objFrecuenciaId ?? this.objFrecuenciaId,
      cuota: cuota ?? this.cuota,
      objSectorId: objSectorId ?? this.objSectorId,
      personasACargo: personasACargo ?? this.personasACargo,
      objEstadoCivilId: objEstadoCivilId ?? this.objEstadoCivilId,
      nombreConyugue: nombreConyugue ?? this.nombreConyugue,
      trabajaConyugue: trabajaConyugue ?? this.trabajaConyugue,
      trabajoConyugue: trabajoConyugue ?? this.trabajoConyugue,
      direccionTrabajoConyugue:
          direccionTrabajoConyugue ?? this.direccionTrabajoConyugue,
      telefonoTrabajoConyugue:
          telefonoTrabajoConyugue ?? this.telefonoTrabajoConyugue,
      beneficiarioSeguro: beneficiarioSeguro ?? this.beneficiarioSeguro,
      cedulaBeneficiarioSeguro:
          cedulaBeneficiarioSeguro ?? this.cedulaBeneficiarioSeguro,
      objParentescoBeneficiarioSeguroId: objParentescoBeneficiarioSeguroId ??
          this.objParentescoBeneficiarioSeguroId,
      objEstadoSolicitudId: objEstadoSolicitudId ?? this.objEstadoSolicitudId,
      objOficialCreditoId: objOficialCreditoId ?? this.objOficialCreditoId,
      objProductoId: objProductoId ?? this.objProductoId,
      observacion: observacion ?? this.observacion,
      sucursal: sucursal ?? this.sucursal,
      ubicacionLongitud: ubicacionLongitud ?? this.ubicacionLongitud,
      ubicacionLatitud: ubicacionLatitud ?? this.ubicacionLatitud,
      ubicacionGradosLongitud:
          ubicacionGradosLongitud ?? this.ubicacionGradosLongitud,
      ubicacionGradosLatitud:
          ubicacionGradosLatitud ?? this.ubicacionGradosLatitud,
      objEscolaridadId: objEscolaridadId ?? this.objEscolaridadId,
      cantidadHijos: cantidadHijos ?? this.cantidadHijos,
      nombrePublico: nombrePublico ?? this.nombrePublico,
      objSexoId: objSexoId ?? this.objSexoId,
      objPaisNacimientoId: objPaisNacimientoId ?? this.objPaisNacimientoId,
      nacionalidadConyugue: nacionalidadConyugue ?? this.nacionalidadConyugue,
      ubicacion: ubicacion ?? this.ubicacion,
      espeps: espeps ?? this.espeps,
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
      esFamiliarEmpleado: esFamiliarEmpleado ?? this.esFamiliarEmpleado,
      nombreFamiliar: nombreFamiliar ?? this.nombreFamiliar,
      cedulaFamiliar: cedulaFamiliar ?? this.cedulaFamiliar,
      objTipoDocumentoId: objTipoDocumentoId ?? this.objTipoDocumentoId,
      objRubroActividad2: objRubroActividad2 ?? this.objRubroActividad2,
      objRubroActividad3: objRubroActividad3 ?? this.objRubroActividad3,
      objRubroActividadPredominante:
          objRubroActividadPredominante ?? this.objRubroActividadPredominante,
      tipoPersona: tipoPersona ?? this.tipoPersona,
      objTipoPersonaId: objTipoPersonaId ?? this.objTipoPersonaId,
      telefonoBeneficiario: telefonoBeneficiario ?? this.telefonoBeneficiario,
      codigoRed: codigoRed ?? this.codigoRed,
      plazoSolicitud: plazoSolicitud ?? this.plazoSolicitud,
      fechaPrimerPagoSolicitud:
          fechaPrimerPagoSolicitud ?? this.fechaPrimerPagoSolicitud,
      nombreTrabajo: nombreTrabajo ?? this.nombreTrabajo,
      direccionTrabajo: direccionTrabajo ?? this.direccionTrabajo,
      barrioTrabajo: barrioTrabajo ?? this.barrioTrabajo,
      objActividadEconomicaId:
          objActividadEconomicaId ?? this.objActividadEconomicaId,
      objActividadEconomicaId1:
          objActividadEconomicaId1 ?? this.objActividadEconomicaId1,
      objActividadEconomicaId2:
          objActividadEconomicaId2 ?? this.objActividadEconomicaId2,
      cargo: cargo ?? this.cargo,
      direccionFamiliarCercano:
          direccionFamiliarCercano ?? this.direccionFamiliarCercano,
      duenoVivienda: duenoVivienda ?? this.duenoVivienda,
      fechaVenceAvaluoAsalariado:
          fechaVenceAvaluoAsalariado ?? this.fechaVenceAvaluoAsalariado,
      fuenteOtrosIngresos: fuenteOtrosIngresos ?? this.fuenteOtrosIngresos,
      fuenteOtrosIngresosConyugue:
          fuenteOtrosIngresosConyugue ?? this.fuenteOtrosIngresosConyugue,
      lugarTrabajoAnterior: lugarTrabajoAnterior ?? this.lugarTrabajoAnterior,
      nombreFamiliarCercano:
          nombreFamiliarCercano ?? this.nombreFamiliarCercano,
      objParentescoFamiliarCercanoId:
          objParentescoFamiliarCercanoId ?? this.objParentescoFamiliarCercanoId,
      otrosIngresosConyugue:
          otrosIngresosConyugue ?? this.otrosIngresosConyugue,
      otrosIngresosCordoba: otrosIngresosCordoba ?? this.otrosIngresosCordoba,
      pagoAlquiler: pagoAlquiler ?? this.pagoAlquiler,
      profesionConyugue: profesionConyugue ?? this.profesionConyugue,
      salarioNetoCordoba: salarioNetoCordoba ?? this.salarioNetoCordoba,
      sueldoMesConyugue: sueldoMesConyugue ?? this.sueldoMesConyugue,
      telefonoFamiliarCercano:
          telefonoFamiliarCercano ?? this.telefonoFamiliarCercano,
      telefonoTrabajo: telefonoTrabajo ?? this.telefonoTrabajo,
      tiempoLaborar: tiempoLaborar ?? this.tiempoLaborar,
      tiempoLaborarConyugue:
          tiempoLaborarConyugue ?? this.tiempoLaborarConyugue,
      totalIngresoMes: totalIngresoMes ?? this.totalIngresoMes,
      totalIngresoMesConyugue:
          totalIngresoMesConyugue ?? this.totalIngresoMesConyugue,
      fechaDesembolso: fechaDesembolso ?? this.fechaDesembolso,
      tasaInteres: tasaInteres ?? this.tasaInteres,
      montoMinimo: montoMinimo ?? this.montoMinimo,
      montoMaximo: montoMaximo ?? this.montoMaximo,
      objOrigenSolicitudIdVer:
          objOrigenSolicitudIdVer ?? this.objOrigenSolicitudIdVer,
      objPaisEmisorCedulaVer:
          objPaisEmisorCedulaVer ?? this.objPaisEmisorCedulaVer,
      objMunicipioCasaIdVer:
          objMunicipioCasaIdVer ?? this.objMunicipioCasaIdVer,
      objDepartamentoCasaIdVer:
          objDepartamentoCasaIdVer ?? this.objDepartamentoCasaIdVer,
      objPaisCasaIdVer: objPaisCasaIdVer ?? this.objPaisCasaIdVer,
      objCondicionCasaIdVer:
          objCondicionCasaIdVer ?? this.objCondicionCasaIdVer,
      objMonedaIdVer: objMonedaIdVer ?? this.objMonedaIdVer,
      objPropositoIdVer: objPropositoIdVer ?? this.objPropositoIdVer,
      objFrecuenciaIdVer: objFrecuenciaIdVer ?? this.objFrecuenciaIdVer,
      objSectorIdVer: objSectorIdVer ?? this.objSectorIdVer,
      objEstadoCivilIdVer: objEstadoCivilIdVer ?? this.objEstadoCivilIdVer,
      objParentescoBeneficiarioSeguroIdVer:
          objParentescoBeneficiarioSeguroIdVer ??
              this.objParentescoBeneficiarioSeguroIdVer,
      objEstadoSolicitudIdVer:
          objEstadoSolicitudIdVer ?? this.objEstadoSolicitudIdVer,
      objOficialCreditoIdVer:
          objOficialCreditoIdVer ?? this.objOficialCreditoIdVer,
      objProductoIdVer: objProductoIdVer ?? this.objProductoIdVer,
      objEscolaridadIdVer: objEscolaridadIdVer ?? this.objEscolaridadIdVer,
      objSexoIdVer: objSexoIdVer ?? this.objSexoIdVer,
      objPaisNacimientoIdVer:
          objPaisNacimientoIdVer ?? this.objPaisNacimientoIdVer,
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
      objActividadEconomicaIdVer:
          objActividadEconomicaIdVer ?? this.objActividadEconomicaIdVer,
      objActividadEconomicaId1Ver:
          objActividadEconomicaId1Ver ?? this.objActividadEconomicaId1Ver,
      objActividadEconomicaId2Ver:
          objActividadEconomicaId2Ver ?? this.objActividadEconomicaId2Ver,
      objParentescoFamiliarCercanoIdVer: objParentescoFamiliarCercanoIdVer ??
          this.objParentescoFamiliarCercanoIdVer,
      cedulaFrontPath: cedulaFrontPath ?? this.cedulaFrontPath,
      cedulaBackPath: cedulaBackPath ?? this.cedulaBackPath,
      frecuenciaPagoMeses: frecuenciaPagoMeses ?? this.frecuenciaPagoMeses,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

final class SolicitudAsalariadoInitial extends SolicitudAsalariadoState {}

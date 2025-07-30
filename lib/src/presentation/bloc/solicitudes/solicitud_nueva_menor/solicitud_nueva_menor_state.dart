// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitud_nueva_menor_cubit.dart';

class SolicitudNuevaMenorState extends Equatable {
  final String numeroSolicitud;
  final String? uuid;
  final String frecuenciaPagoMeses;
  final String departamentoNegocio;
  final String departamentoNegocioVer;
  final String onSuccessMsg;
  final bool hasVerified;
  final int idLocalResponse;
  final String errorMsg;
  final Status status;
  final String objOrigenSolicitudId;
  final String objOrigenSolicitudIdVer;
  final String nombre1;
  final String nombre2;
  final String apellido1;
  final String apellido2;
  final String cedula;
  final String objPaisEmisorCedula;
  final String objPaisEmisorCedulaVer;
  final String fechaEmisionCedula;
  final String fechaVencimientoCedula;
  final String fechaNacimiento;
  final String telefono;
  final String celular;
  final String direccionCasa;
  final String barrioCasa;
  final String objMunicipioCasaId;
  final String objMunicipioCasaIdVer;
  final String objDepartamentoCasaId;
  final String objDepartamentoCasaIdVer;
  final String objPaisCasaId;
  final String objPaisCasaIdVer;
  final String profesion;
  final String ocupacion;
  final String nacionalidad;
  final String objCondicionCasaId;
  final String objCondicionCasaIdVer;
  final int anosResidirCasa;
  final String email;
  final int monto;
  final String objMonedaId;
  final String objMonedaIdVer;
  final String objPropositoId;
  final String objPropositoIdVer;
  final String objFrecuenciaId;
  final String objFrecuenciaIdVer;
  final int cuota;
  final String objActividadId;
  final String objActividadIdVer;
  final String objActividadId1;
  final String objActividadId1Ver;
  final String objActividadId2;
  final String objActividadId2Ver;
  final String objSectorId;
  final String objSectorIdVer;
  final String nombreNegocio;
  final String tiempoFuncionamientoNegocio;
  final String direccionNegocio;
  final String barrioNegocio;
  final String objMunicipioNegocioId;
  final String objMunicipioNegocioIdVer;
  final String objCondicionNegocioId;
  final String objCondicionNegocioIdVer;
  final String horarioTrabajo;
  final String horarioVisita;
  final int personasACargo;
  final String objEstadoCivilId;
  final String objEstadoCivilIdVer;
  final String nombreConyugue;
  final bool trabajaConyugue;
  final String trabajoConyugue;
  final String direccionTrabajoConyugue;
  final String telefonoTrabajoConyugue;
  final String beneficiarioSeguro;
  final String cedulaBeneficiarioSeguro;
  final String objParentescoBeneficiarioSeguroId;
  final String objParentescoBeneficiarioSeguroIdVer;
  final String beneficiarioSeguro1;
  final String cedulaBeneficiarioSeguro1;
  final String objParentescoBeneficiarioSeguroId1;
  final String objParentescoBeneficiarioSeguroId1Ver;
  final String objEstadoSolicitudId;
  final String objEstadoSolicitudIdVer;
  final String objOficialCreditoId;
  final String objOficialCreditoIdVer;
  final String objProductoId;
  final String objProductoIdVer;
  final String observacion;
  final String sucursal;
  final String ubicacionLongitud;
  final String ubicacionLatitud;
  final String ubicacionGradosLongitud;
  final String ubicacionGradosLatitud;
  final String objEscolaridadId;
  final String objEscolaridadIdVer;
  final int cantidadHijos;
  final String nombrePublico;
  final String objSexoId;
  final String objSexoIdVer;
  final String objPaisNacimientoId;
  final String objPaisNacimientoIdVer;
  final String nacionalidadConyugue;
  final String database;
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
  final String objRubroActividadVer;
  final String objActividadPredominante;
  final String objActividadPredominanteVer;
  final bool esFamiliarEmpleado;
  final String nombreFamiliar;
  final String cedulaFamiliar;
  final String objTipoDocumentoId;
  final String objTipoDocumentoIdVer;
  final String objRubroActividad2;
  final String objRubroActividad2Ver;
  final String objRubroActividad3;
  final String objRubroActividad3Ver;
  final String objRubroActividadPredominante;
  final String objRubroActividadPredominanteVer;
  final String tipoPersona;
  final String objTipoPersonaId;
  final String objTipoPersonaIdVer;
  final String telefonoBeneficiario;
  final String telefonoBeneficiarioSeguro1;
  final int plazoSolicitud;
  final String fechaPrimerPagoSolicitud;
  final double prestamoInteres;
  final String fechaDesembolso;
  final String createdAt;
  final bool isDone;
  final int montoMinimo;
  final int montoMaximo;
  final String cedulaFrontPath;
  final String cedulaBackPath;
  final String paisPepsVer;
  final String parentescoFamiliarPeps2Ver;
  final String paisPeps2Ver;
  final String nacionalidadConyugueVer;
  final bool isOffline;
  const SolicitudNuevaMenorState({
    this.isOffline = false,
    this.numeroSolicitud = '',
    this.departamentoNegocio = '',
    this.departamentoNegocioVer = '',
    this.nacionalidadConyugueVer = '',
    this.paisPeps2Ver = '',
    this.parentescoFamiliarPeps2Ver = '',
    this.paisPepsVer = '',
    this.frecuenciaPagoMeses = '0',
    this.uuid,
    this.cedulaFrontPath = '',
    this.cedulaBackPath = '',
    this.montoMinimo = 0,
    this.montoMaximo = 0,
    this.onSuccessMsg = '',
    this.hasVerified = false,
    this.isDone = false,
    this.idLocalResponse = 0,
    this.createdAt = '',
    this.errorMsg = '',
    this.status = Status.notStarted,
    this.objOrigenSolicitudId = '',
    this.objOrigenSolicitudIdVer = '',
    this.nombre1 = '',
    this.nombre2 = '',
    this.apellido1 = '',
    this.apellido2 = '',
    this.cedula = '',
    this.objPaisEmisorCedula = '',
    this.objPaisEmisorCedulaVer = '',
    this.fechaEmisionCedula = '',
    this.fechaVencimientoCedula = '',
    this.fechaNacimiento = '',
    this.telefono = '',
    this.celular = '',
    this.direccionCasa = '',
    this.barrioCasa = '',
    this.objMunicipioCasaId = '',
    this.objMunicipioCasaIdVer = '',
    this.objDepartamentoCasaId = '',
    this.objDepartamentoCasaIdVer = '',
    this.objPaisCasaId = '',
    this.objPaisCasaIdVer = '',
    this.profesion = '',
    this.ocupacion = '',
    this.nacionalidad = '',
    this.objCondicionCasaId = '',
    this.objCondicionCasaIdVer = '',
    this.anosResidirCasa = 0,
    this.email = '',
    this.monto = 0,
    this.objMonedaId = '',
    this.objMonedaIdVer = '',
    this.objPropositoId = '',
    this.objPropositoIdVer = '',
    this.objFrecuenciaId = '',
    this.objFrecuenciaIdVer = '',
    this.cuota = 0,
    this.objActividadId = '',
    this.objActividadIdVer = '',
    this.objActividadId1 = '',
    this.objActividadId1Ver = '',
    this.objActividadId2 = '',
    this.objActividadId2Ver = '',
    this.objSectorId = '',
    this.objSectorIdVer = '',
    this.nombreNegocio = '',
    this.tiempoFuncionamientoNegocio = '',
    this.direccionNegocio = '',
    this.barrioNegocio = '',
    this.objMunicipioNegocioId = '',
    this.objMunicipioNegocioIdVer = '',
    this.objCondicionNegocioId = '',
    this.objCondicionNegocioIdVer = '',
    this.horarioTrabajo = '',
    this.horarioVisita = '',
    this.personasACargo = 0,
    this.objEstadoCivilId = '',
    this.objEstadoCivilIdVer = '',
    this.nombreConyugue = '',
    this.trabajaConyugue = false,
    this.trabajoConyugue = '',
    this.direccionTrabajoConyugue = '',
    this.telefonoTrabajoConyugue = '',
    this.beneficiarioSeguro = '',
    this.cedulaBeneficiarioSeguro = '',
    this.objParentescoBeneficiarioSeguroId = '',
    this.objParentescoBeneficiarioSeguroIdVer = '',
    this.beneficiarioSeguro1 = '',
    this.cedulaBeneficiarioSeguro1 = '',
    this.objParentescoBeneficiarioSeguroId1 = '',
    this.objParentescoBeneficiarioSeguroId1Ver = '',
    this.objEstadoSolicitudId = '',
    this.objEstadoSolicitudIdVer = '',
    this.objOficialCreditoId = '',
    this.objOficialCreditoIdVer = '',
    this.objProductoId = '',
    this.objProductoIdVer = '',
    this.observacion = '',
    this.sucursal = '',
    this.ubicacionLongitud = '',
    this.ubicacionLatitud = '',
    this.ubicacionGradosLongitud = '',
    this.ubicacionGradosLatitud = '',
    this.objEscolaridadId = '',
    this.objEscolaridadIdVer = '',
    this.cantidadHijos = 0,
    this.nombrePublico = '',
    this.objSexoId = '',
    this.objSexoIdVer = '',
    this.objPaisNacimientoId = '',
    this.objPaisNacimientoIdVer = '',
    this.nacionalidadConyugue = '',
    this.database = '',
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
    this.objRubroActividadVer = '',
    this.objActividadPredominante = '',
    this.objActividadPredominanteVer = '',
    this.esFamiliarEmpleado = false,
    this.nombreFamiliar = '',
    this.cedulaFamiliar = '',
    this.objTipoDocumentoId = '',
    this.objTipoDocumentoIdVer = '',
    this.objRubroActividad2 = '',
    this.objRubroActividad2Ver = '',
    this.objRubroActividad3 = '',
    this.objRubroActividad3Ver = '',
    this.objRubroActividadPredominante = '',
    this.objRubroActividadPredominanteVer = '',
    this.tipoPersona = '',
    this.objTipoPersonaId = '',
    this.objTipoPersonaIdVer = '',
    this.telefonoBeneficiario = '',
    this.telefonoBeneficiarioSeguro1 = '',
    this.plazoSolicitud = 0,
    this.fechaPrimerPagoSolicitud = '',
    this.prestamoInteres = 0,
    this.fechaDesembolso = '',
  });

  @override
  List<Object> get props => [
        departamentoNegocio,
        departamentoNegocioVer,
        frecuenciaPagoMeses,
        cedulaFrontPath,
        cedulaBackPath,
        onSuccessMsg,
        hasVerified,
        idLocalResponse,
        errorMsg,
        status,
        objOrigenSolicitudId,
        objOrigenSolicitudIdVer,
        nombre1,
        nombre2,
        apellido1,
        apellido2,
        cedula,
        objPaisEmisorCedula,
        objPaisEmisorCedulaVer,
        fechaEmisionCedula,
        fechaVencimientoCedula,
        fechaNacimiento,
        telefono,
        celular,
        direccionCasa,
        barrioCasa,
        objMunicipioCasaId,
        objMunicipioCasaIdVer,
        objDepartamentoCasaId,
        objDepartamentoCasaIdVer,
        objPaisCasaId,
        objPaisCasaIdVer,
        profesion,
        ocupacion,
        nacionalidad,
        objCondicionCasaId,
        objCondicionCasaIdVer,
        anosResidirCasa,
        email,
        monto,
        objMonedaId,
        objMonedaIdVer,
        objPropositoId,
        objPropositoIdVer,
        objFrecuenciaId,
        objFrecuenciaIdVer,
        cuota,
        objActividadId,
        objActividadIdVer,
        objActividadId1,
        objActividadId1Ver,
        objActividadId2,
        objActividadId2Ver,
        objSectorId,
        objSectorIdVer,
        nombreNegocio,
        tiempoFuncionamientoNegocio,
        direccionNegocio,
        barrioNegocio,
        objMunicipioNegocioId,
        objMunicipioNegocioIdVer,
        objCondicionNegocioId,
        objCondicionNegocioIdVer,
        horarioTrabajo,
        horarioVisita,
        personasACargo,
        objEstadoCivilId,
        objEstadoCivilIdVer,
        nombreConyugue,
        trabajaConyugue,
        trabajoConyugue,
        direccionTrabajoConyugue,
        telefonoTrabajoConyugue,
        beneficiarioSeguro,
        cedulaBeneficiarioSeguro,
        objParentescoBeneficiarioSeguroId,
        objParentescoBeneficiarioSeguroIdVer,
        beneficiarioSeguro1,
        cedulaBeneficiarioSeguro1,
        objParentescoBeneficiarioSeguroId1,
        objParentescoBeneficiarioSeguroId1Ver,
        objEstadoSolicitudId,
        objEstadoSolicitudIdVer,
        objOficialCreditoId,
        objOficialCreditoIdVer,
        objProductoId,
        objProductoIdVer,
        observacion,
        sucursal,
        ubicacionLongitud,
        ubicacionLatitud,
        ubicacionGradosLongitud,
        ubicacionGradosLatitud,
        objEscolaridadId,
        objEscolaridadIdVer,
        cantidadHijos,
        nombrePublico,
        objSexoId,
        objSexoIdVer,
        objPaisNacimientoId,
        objPaisNacimientoIdVer,
        nacionalidadConyugue,
        database,
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
        objRubroActividadVer,
        objActividadPredominante,
        objActividadPredominanteVer,
        esFamiliarEmpleado,
        nombreFamiliar,
        cedulaFamiliar,
        objTipoDocumentoId,
        objTipoDocumentoIdVer,
        objRubroActividad2,
        objRubroActividad2Ver,
        objRubroActividad3,
        objRubroActividad3Ver,
        objRubroActividadPredominante,
        objRubroActividadPredominanteVer,
        tipoPersona,
        objTipoPersonaId,
        objTipoPersonaIdVer,
        telefonoBeneficiario,
        telefonoBeneficiarioSeguro1,
        plazoSolicitud,
        fechaPrimerPagoSolicitud,
        prestamoInteres,
        fechaDesembolso,
        createdAt,
        isDone
      ];

  SolicitudNuevaMenorState copyWith({
    String? numeroSolicitud,
    String? uuid,
    String? frecuenciaPagoMeses,
    String? departamentoNegocio,
    String? departamentoNegocioVer,
    String? onSuccessMsg,
    bool? hasVerified,
    int? idLocalResponse,
    String? errorMsg,
    Status? status,
    String? objOrigenSolicitudId,
    String? objOrigenSolicitudIdVer,
    String? nombre1,
    String? nombre2,
    String? apellido1,
    String? apellido2,
    String? cedula,
    String? objPaisEmisorCedula,
    String? objPaisEmisorCedulaVer,
    String? fechaEmisionCedula,
    String? fechaVencimientoCedula,
    String? fechaNacimiento,
    String? telefono,
    String? celular,
    String? direccionCasa,
    String? barrioCasa,
    String? objMunicipioCasaId,
    String? objMunicipioCasaIdVer,
    String? objDepartamentoCasaId,
    String? objDepartamentoCasaIdVer,
    String? objPaisCasaId,
    String? objPaisCasaIdVer,
    String? profesion,
    String? ocupacion,
    String? nacionalidad,
    String? objCondicionCasaId,
    String? objCondicionCasaIdVer,
    int? anosResidirCasa,
    String? email,
    int? monto,
    String? objMonedaId,
    String? objMonedaIdVer,
    String? objPropositoId,
    String? objPropositoIdVer,
    String? objFrecuenciaId,
    String? objFrecuenciaIdVer,
    int? cuota,
    String? objActividadId,
    String? objActividadIdVer,
    String? objActividadId1,
    String? objActividadId1Ver,
    String? objActividadId2,
    String? objActividadId2Ver,
    String? objSectorId,
    String? objSectorIdVer,
    String? nombreNegocio,
    String? tiempoFuncionamientoNegocio,
    String? direccionNegocio,
    String? barrioNegocio,
    String? objMunicipioNegocioId,
    String? objMunicipioNegocioIdVer,
    String? objCondicionNegocioId,
    String? objCondicionNegocioIdVer,
    String? horarioTrabajo,
    String? horarioVisita,
    int? personasACargo,
    String? objEstadoCivilId,
    String? objEstadoCivilIdVer,
    String? nombreConyugue,
    bool? trabajaConyugue,
    String? trabajoConyugue,
    String? direccionTrabajoConyugue,
    String? telefonoTrabajoConyugue,
    String? beneficiarioSeguro,
    String? cedulaBeneficiarioSeguro,
    String? objParentescoBeneficiarioSeguroId,
    String? objParentescoBeneficiarioSeguroIdVer,
    String? beneficiarioSeguro1,
    String? cedulaBeneficiarioSeguro1,
    String? objParentescoBeneficiarioSeguroId1,
    String? objParentescoBeneficiarioSeguroId1Ver,
    String? objEstadoSolicitudId,
    String? objEstadoSolicitudIdVer,
    String? objOficialCreditoId,
    String? objOficialCreditoIdVer,
    String? objProductoId,
    String? objProductoIdVer,
    String? observacion,
    String? sucursal,
    String? ubicacionLongitud,
    String? ubicacionLatitud,
    String? ubicacionGradosLongitud,
    String? ubicacionGradosLatitud,
    String? objEscolaridadId,
    String? objEscolaridadIdVer,
    int? cantidadHijos,
    String? nombrePublico,
    String? objSexoId,
    String? objSexoIdVer,
    String? objPaisNacimientoId,
    String? objPaisNacimientoIdVer,
    String? nacionalidadConyugue,
    String? database,
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
    String? objRubroActividadVer,
    String? objActividadPredominante,
    String? objActividadPredominanteVer,
    bool? esFamiliarEmpleado,
    String? nombreFamiliar,
    String? cedulaFamiliar,
    String? objTipoDocumentoId,
    String? objTipoDocumentoIdVer,
    String? objRubroActividad2,
    String? objRubroActividad2Ver,
    String? objRubroActividad3,
    String? objRubroActividad3Ver,
    String? objRubroActividadPredominante,
    String? objRubroActividadPredominanteVer,
    String? tipoPersona,
    String? objTipoPersonaId,
    String? objTipoPersonaIdVer,
    String? telefonoBeneficiario,
    String? telefonoBeneficiarioSeguro1,
    int? plazoSolicitud,
    String? fechaPrimerPagoSolicitud,
    double? prestamoInteres,
    String? fechaDesembolso,
    String? createdAt,
    bool? isDone,
    int? montoMinimo,
    int? montoMaximo,
    String? cedulaFrontPath,
    String? cedulaBackPath,
    String? paisPepsVer,
    String? parentescoFamiliarPeps2Ver,
    String? paisPeps2Ver,
    String? nacionalidadConyugueVer,
    bool? isOffline,
  }) {
    return SolicitudNuevaMenorState(
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      uuid: uuid ?? this.uuid,
      frecuenciaPagoMeses: frecuenciaPagoMeses ?? this.frecuenciaPagoMeses,
      departamentoNegocio: departamentoNegocio ?? this.departamentoNegocio,
      departamentoNegocioVer:
          departamentoNegocioVer ?? this.departamentoNegocioVer,
      onSuccessMsg: onSuccessMsg ?? this.onSuccessMsg,
      hasVerified: hasVerified ?? this.hasVerified,
      idLocalResponse: idLocalResponse ?? this.idLocalResponse,
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
      objOrigenSolicitudId: objOrigenSolicitudId ?? this.objOrigenSolicitudId,
      objOrigenSolicitudIdVer:
          objOrigenSolicitudIdVer ?? this.objOrigenSolicitudIdVer,
      nombre1: nombre1 ?? this.nombre1,
      nombre2: nombre2 ?? this.nombre2,
      apellido1: apellido1 ?? this.apellido1,
      apellido2: apellido2 ?? this.apellido2,
      cedula: cedula ?? this.cedula,
      objPaisEmisorCedula: objPaisEmisorCedula ?? this.objPaisEmisorCedula,
      objPaisEmisorCedulaVer:
          objPaisEmisorCedulaVer ?? this.objPaisEmisorCedulaVer,
      fechaEmisionCedula: fechaEmisionCedula ?? this.fechaEmisionCedula,
      fechaVencimientoCedula:
          fechaVencimientoCedula ?? this.fechaVencimientoCedula,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      telefono: telefono ?? this.telefono,
      celular: celular ?? this.celular,
      direccionCasa: direccionCasa ?? this.direccionCasa,
      barrioCasa: barrioCasa ?? this.barrioCasa,
      objMunicipioCasaId: objMunicipioCasaId ?? this.objMunicipioCasaId,
      objMunicipioCasaIdVer:
          objMunicipioCasaIdVer ?? this.objMunicipioCasaIdVer,
      objDepartamentoCasaId:
          objDepartamentoCasaId ?? this.objDepartamentoCasaId,
      objDepartamentoCasaIdVer:
          objDepartamentoCasaIdVer ?? this.objDepartamentoCasaIdVer,
      objPaisCasaId: objPaisCasaId ?? this.objPaisCasaId,
      objPaisCasaIdVer: objPaisCasaIdVer ?? this.objPaisCasaIdVer,
      profesion: profesion ?? this.profesion,
      ocupacion: ocupacion ?? this.ocupacion,
      nacionalidad: nacionalidad ?? this.nacionalidad,
      objCondicionCasaId: objCondicionCasaId ?? this.objCondicionCasaId,
      objCondicionCasaIdVer:
          objCondicionCasaIdVer ?? this.objCondicionCasaIdVer,
      anosResidirCasa: anosResidirCasa ?? this.anosResidirCasa,
      email: email ?? this.email,
      monto: monto ?? this.monto,
      objMonedaId: objMonedaId ?? this.objMonedaId,
      objMonedaIdVer: objMonedaIdVer ?? this.objMonedaIdVer,
      objPropositoId: objPropositoId ?? this.objPropositoId,
      objPropositoIdVer: objPropositoIdVer ?? this.objPropositoIdVer,
      objFrecuenciaId: objFrecuenciaId ?? this.objFrecuenciaId,
      objFrecuenciaIdVer: objFrecuenciaIdVer ?? this.objFrecuenciaIdVer,
      cuota: cuota ?? this.cuota,
      objActividadId: objActividadId ?? this.objActividadId,
      objActividadIdVer: objActividadIdVer ?? this.objActividadIdVer,
      objActividadId1: objActividadId1 ?? this.objActividadId1,
      objActividadId1Ver: objActividadId1Ver ?? this.objActividadId1Ver,
      objActividadId2: objActividadId2 ?? this.objActividadId2,
      objActividadId2Ver: objActividadId2Ver ?? this.objActividadId2Ver,
      objSectorId: objSectorId ?? this.objSectorId,
      objSectorIdVer: objSectorIdVer ?? this.objSectorIdVer,
      nombreNegocio: nombreNegocio ?? this.nombreNegocio,
      tiempoFuncionamientoNegocio:
          tiempoFuncionamientoNegocio ?? this.tiempoFuncionamientoNegocio,
      direccionNegocio: direccionNegocio ?? this.direccionNegocio,
      barrioNegocio: barrioNegocio ?? this.barrioNegocio,
      objMunicipioNegocioId:
          objMunicipioNegocioId ?? this.objMunicipioNegocioId,
      objMunicipioNegocioIdVer:
          objMunicipioNegocioIdVer ?? this.objMunicipioNegocioIdVer,
      objCondicionNegocioId:
          objCondicionNegocioId ?? this.objCondicionNegocioId,
      objCondicionNegocioIdVer:
          objCondicionNegocioIdVer ?? this.objCondicionNegocioIdVer,
      horarioTrabajo: horarioTrabajo ?? this.horarioTrabajo,
      horarioVisita: horarioVisita ?? this.horarioVisita,
      personasACargo: personasACargo ?? this.personasACargo,
      objEstadoCivilId: objEstadoCivilId ?? this.objEstadoCivilId,
      objEstadoCivilIdVer: objEstadoCivilIdVer ?? this.objEstadoCivilIdVer,
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
      objParentescoBeneficiarioSeguroIdVer:
          objParentescoBeneficiarioSeguroIdVer ??
              this.objParentescoBeneficiarioSeguroIdVer,
      beneficiarioSeguro1: beneficiarioSeguro1 ?? this.beneficiarioSeguro1,
      cedulaBeneficiarioSeguro1:
          cedulaBeneficiarioSeguro1 ?? this.cedulaBeneficiarioSeguro1,
      objParentescoBeneficiarioSeguroId1: objParentescoBeneficiarioSeguroId1 ??
          this.objParentescoBeneficiarioSeguroId1,
      objParentescoBeneficiarioSeguroId1Ver:
          objParentescoBeneficiarioSeguroId1Ver ??
              this.objParentescoBeneficiarioSeguroId1Ver,
      objEstadoSolicitudId: objEstadoSolicitudId ?? this.objEstadoSolicitudId,
      objEstadoSolicitudIdVer:
          objEstadoSolicitudIdVer ?? this.objEstadoSolicitudIdVer,
      objOficialCreditoId: objOficialCreditoId ?? this.objOficialCreditoId,
      objOficialCreditoIdVer:
          objOficialCreditoIdVer ?? this.objOficialCreditoIdVer,
      objProductoId: objProductoId ?? this.objProductoId,
      objProductoIdVer: objProductoIdVer ?? this.objProductoIdVer,
      observacion: observacion ?? this.observacion,
      sucursal: sucursal ?? this.sucursal,
      ubicacionLongitud: ubicacionLongitud ?? this.ubicacionLongitud,
      ubicacionLatitud: ubicacionLatitud ?? this.ubicacionLatitud,
      ubicacionGradosLongitud:
          ubicacionGradosLongitud ?? this.ubicacionGradosLongitud,
      ubicacionGradosLatitud:
          ubicacionGradosLatitud ?? this.ubicacionGradosLatitud,
      objEscolaridadId: objEscolaridadId ?? this.objEscolaridadId,
      objEscolaridadIdVer: objEscolaridadIdVer ?? this.objEscolaridadIdVer,
      cantidadHijos: cantidadHijos ?? this.cantidadHijos,
      nombrePublico: nombrePublico ?? this.nombrePublico,
      objSexoId: objSexoId ?? this.objSexoId,
      objSexoIdVer: objSexoIdVer ?? this.objSexoIdVer,
      objPaisNacimientoId: objPaisNacimientoId ?? this.objPaisNacimientoId,
      objPaisNacimientoIdVer:
          objPaisNacimientoIdVer ?? this.objPaisNacimientoIdVer,
      nacionalidadConyugue: nacionalidadConyugue ?? this.nacionalidadConyugue,
      database: database ?? this.database,
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
      objRubroActividadVer: objRubroActividadVer ?? this.objRubroActividadVer,
      objActividadPredominante:
          objActividadPredominante ?? this.objActividadPredominante,
      objActividadPredominanteVer:
          objActividadPredominanteVer ?? this.objActividadPredominanteVer,
      esFamiliarEmpleado: esFamiliarEmpleado ?? this.esFamiliarEmpleado,
      nombreFamiliar: nombreFamiliar ?? this.nombreFamiliar,
      cedulaFamiliar: cedulaFamiliar ?? this.cedulaFamiliar,
      objTipoDocumentoId: objTipoDocumentoId ?? this.objTipoDocumentoId,
      objTipoDocumentoIdVer:
          objTipoDocumentoIdVer ?? this.objTipoDocumentoIdVer,
      objRubroActividad2: objRubroActividad2 ?? this.objRubroActividad2,
      objRubroActividad2Ver:
          objRubroActividad2Ver ?? this.objRubroActividad2Ver,
      objRubroActividad3: objRubroActividad3 ?? this.objRubroActividad3,
      objRubroActividad3Ver:
          objRubroActividad3Ver ?? this.objRubroActividad3Ver,
      objRubroActividadPredominante:
          objRubroActividadPredominante ?? this.objRubroActividadPredominante,
      objRubroActividadPredominanteVer: objRubroActividadPredominanteVer ??
          this.objRubroActividadPredominanteVer,
      tipoPersona: tipoPersona ?? this.tipoPersona,
      objTipoPersonaId: objTipoPersonaId ?? this.objTipoPersonaId,
      objTipoPersonaIdVer: objTipoPersonaIdVer ?? this.objTipoPersonaIdVer,
      telefonoBeneficiario: telefonoBeneficiario ?? this.telefonoBeneficiario,
      telefonoBeneficiarioSeguro1:
          telefonoBeneficiarioSeguro1 ?? this.telefonoBeneficiarioSeguro1,
      plazoSolicitud: plazoSolicitud ?? this.plazoSolicitud,
      fechaPrimerPagoSolicitud:
          fechaPrimerPagoSolicitud ?? this.fechaPrimerPagoSolicitud,
      prestamoInteres: prestamoInteres ?? this.prestamoInteres,
      fechaDesembolso: fechaDesembolso ?? this.fechaDesembolso,
      createdAt: createdAt ?? this.createdAt,
      isDone: isDone ?? this.isDone,
      montoMinimo: montoMinimo ?? this.montoMinimo,
      montoMaximo: montoMaximo ?? this.montoMaximo,
      cedulaFrontPath: cedulaFrontPath ?? this.cedulaFrontPath,
      cedulaBackPath: cedulaBackPath ?? this.cedulaBackPath,
      paisPepsVer: paisPepsVer ?? this.paisPepsVer,
      parentescoFamiliarPeps2Ver:
          parentescoFamiliarPeps2Ver ?? this.parentescoFamiliarPeps2Ver,
      paisPeps2Ver: paisPeps2Ver ?? this.paisPeps2Ver,
      nacionalidadConyugueVer:
          nacionalidadConyugueVer ?? this.nacionalidadConyugueVer,
      isOffline: isOffline ?? this.isOffline,
    );
  }
}

final class SolicitudNuevaMenorInitial extends SolicitudNuevaMenorState {}

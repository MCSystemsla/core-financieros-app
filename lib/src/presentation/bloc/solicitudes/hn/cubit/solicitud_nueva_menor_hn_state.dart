// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitud_nueva_menor_hn_cubit.dart';

class SolicitudNuevaMenorHnState extends Equatable {
  final String idSolicitud;
  final String esGrupal;
  final String cargoGrupoCodigo;
  final String cargoGrupoNombre;
  final String grupoCodigo;
  final String grupoCodigoNombre;
  final List<HistorialCredito> historialCredito;
  final String actividadEconomicaCnbs1CodigoNombre;
  final String actividadEconomicaCnbs2CodigoNombre;
  final String aldeaCasaCodigoNombre;
  final String paisCasaCodigoNombre;
  final String paisEmisorCedulaCodigoNombre;
  final String aldeaDestinoCodigoNombre;
  final String municipioDestinoCodigoNombre;
  final String aldeaNegocioCodigoNombre;
  final String departamentoNegocioCodigoNombre;
  final String ocupacionCodigoNombre;
  final String profesionCodigoNombre;
  final String ubicacionCodigoNombre;
  final String condicionCasaCodigoNombre;
  final String condicionNegocioCodigoNombre;
  final String departamentoCasaCodigoNombre;
  final String departamentoDestinoCodigoNombre;
  final String estadoCivilCodigoNombre;
  final String frecuenciaCodigoNombre;
  final String monedaCodigoNombre;
  final String municipioCasaCodigoNombre;
  final String municipioNegocioCodigoNombre;
  final String nacinalidad2CodigoNombre;
  final String nacinalidadCodigoNombre;
  final String nacinalidad3CodigoNombre;
  final String ocupacionNombre;
  final String parentescoFamiliarPeps2CodigoNombre;
  final String productoCodigoNombre;
  final String profesionNombre;
  final String propositoCodigoNombre;
  final String sectorCodigoNombre;
  final String tipoClienteCodigoNombre;
  final String tipoDocumentoCodigoNombre;
  final String tipoPersonaCodigoNombre;
  final String tipoPersonaCnbsCodigoNombre;
  final double montoMinimo;
  final double montoMaximo;
  final String tieneVinculosUsa;
  final String frecuenciaMeses;
  final double tasaInteres;
  final String actividadEconomicaCnbs3Codigo;
  final String numeroSolicitud;
  final String email;
  final String nombre2;
  final String apellido2;
  final String cedulaFrontPath;
  final String cedulaBackPath;
  final int idLocalResponse;
  final String? uuid;
  final Status status;
  final String errorMsg;
  final String database;
  final String origenSolicitudCodigo;
  final String nombre1;
  final String apellido1;
  final String cedula;
  final String paisEmisorCedulaCodigo;
  final String fechaEmisionCedula;
  final String fechaVencimientoCedula;
  final String fechaNacimiento;
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
  final double cuota;
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
  final String trabajaConyugue;
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
  final String espeps;
  final String nombreDeEntidadPeps;
  final String paisPeps;
  final String periodoPeps;
  final String cargoOficialPeps;
  final String tieneFamiliarPeps;
  final String nombreFamiliarPeps2;
  final String parentescoFamiliarPeps2Codigo;
  final String cargoFamiliarPeps2;
  final String nombreEntidadPeps2;
  final String periodoPeps2;
  final String paisPeps2;
  final String esFamiliarEmpleado;
  final String nombreFamiliar;
  final String cedulaFamiliar;
  final String tipoDocumentoCodigo;
  final String tipoPersonaCodigo;
  final int plazoSolicitud;
  final String fechaPrimerPagoSolicitud;
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
  final String ejerceApnfd;
  final String esApnfd;
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
  final String fechaDesembolso;
  final bool isDone;
  final String apellidosConyugue;
  final String tipoDocumentoConyugue;
  final double cuotaWithDecimal;
  final ClientSignatureStatus clientSignatureStatus;

  const SolicitudNuevaMenorHnState({
    this.cuotaWithDecimal = 0,
    this.idSolicitud = '',
    this.grupoCodigoNombre = '',
    this.cargoGrupoNombre = '',
    this.esGrupal = '',
    this.cargoGrupoCodigo = '',
    this.grupoCodigo = '',
    this.historialCredito = const [],
    this.actividadEconomicaCnbs1CodigoNombre = '',
    this.actividadEconomicaCnbs2CodigoNombre = '',
    this.aldeaCasaCodigoNombre = '',
    this.paisCasaCodigoNombre = '',
    this.paisEmisorCedulaCodigoNombre = '',
    this.aldeaDestinoCodigoNombre = '',
    this.municipioDestinoCodigoNombre = '',
    this.aldeaNegocioCodigoNombre = '',
    this.departamentoNegocioCodigoNombre = '',
    this.ocupacionCodigoNombre = '',
    this.profesionCodigoNombre = '',
    this.ubicacionCodigoNombre = '',
    this.condicionCasaCodigoNombre = '',
    this.condicionNegocioCodigoNombre = '',
    this.departamentoCasaCodigoNombre = '',
    this.departamentoDestinoCodigoNombre = '',
    this.estadoCivilCodigoNombre = '',
    this.frecuenciaCodigoNombre = '',
    this.monedaCodigoNombre = '',
    this.municipioCasaCodigoNombre = '',
    this.municipioNegocioCodigoNombre = '',
    this.nacinalidad2CodigoNombre = '',
    this.nacinalidadCodigoNombre = '',
    this.nacinalidad3CodigoNombre = '',
    this.ocupacionNombre = '',
    this.parentescoFamiliarPeps2CodigoNombre = '',
    this.productoCodigoNombre = '',
    this.profesionNombre = '',
    this.propositoCodigoNombre = '',
    this.sectorCodigoNombre = '',
    this.tipoClienteCodigoNombre = '',
    this.tipoDocumentoCodigoNombre = '',
    this.tipoPersonaCodigoNombre = '',
    this.tipoPersonaCnbsCodigoNombre = '',
    this.isDone = false,
    this.tieneVinculosUsa = '',
    this.frecuenciaMeses = '',
    this.tasaInteres = 0,
    this.montoMinimo = 0,
    this.montoMaximo = 0,
    this.actividadEconomicaCnbs3Codigo = '',
    this.numeroSolicitud = '',
    this.email = '',
    this.nombre2 = '',
    this.apellido2 = '',
    this.cedulaFrontPath = '',
    this.cedulaBackPath = '',
    this.idLocalResponse = 0,
    this.uuid,
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.database = '',
    this.origenSolicitudCodigo = '',
    this.nombre1 = '',
    this.apellido1 = '',
    this.cedula = '',
    this.paisEmisorCedulaCodigo = '',
    this.fechaEmisionCedula = '',
    this.fechaVencimientoCedula = '',
    this.fechaNacimiento = '',
    this.telefono = '',
    this.celular = '',
    this.direccionCasa = '',
    this.barrioCasa = '',
    this.municipioCasaCodigo = '',
    this.departamentoCasaCodigo = '',
    this.paisCasaCodigo = '',
    this.profesion = '',
    this.ocupacion = '',
    this.condicionCasaCodigo = '',
    this.anosResidirCasa = 0,
    this.monto = 0,
    this.monedaCodigo = '',
    this.propositoCodigo = '',
    this.frecuenciaCodigo = '',
    this.cuota = 0,
    this.sectorCodigo = '',
    this.nombreNegocio = '',
    this.tiempoFuncionamientoNegocio = '',
    this.direccionNegocio = '',
    this.barrioNegocio = '',
    this.municipioNegocioCodigo = '',
    this.condicionNegocioCodigo = '',
    this.horarioTrabajo = '',
    this.horarioVisita = '',
    this.personasACargo = 0,
    this.estadoCivilCodigo = '',
    this.nombreConyugue = '',
    this.trabajaConyugue = '',
    this.trabajoConyugue = '',
    this.direccionTrabajoConyugue = '',
    this.telefonoTrabajoConyugue = '',
    this.productoCodigo = '',
    this.observacion = '',
    this.sucursal = '',
    this.ubicacionLongitud = '',
    this.ubicacionLatitud = '',
    this.escolaridadCodigo = '',
    this.cantidadHijos = 0,
    this.nombrePublico = '',
    this.sexoCodigo = '',
    this.paisNacimientoCodigo = '',
    this.nacionalidadConyugue = '',
    this.ubicacion = '',
    this.espeps = '',
    this.nombreDeEntidadPeps = '',
    this.paisPeps = '',
    this.periodoPeps = '',
    this.cargoOficialPeps = '',
    this.tieneFamiliarPeps = '',
    this.nombreFamiliarPeps2 = '',
    this.parentescoFamiliarPeps2Codigo = '',
    this.cargoFamiliarPeps2 = '',
    this.nombreEntidadPeps2 = '',
    this.periodoPeps2 = '',
    this.paisPeps2 = '',
    this.esFamiliarEmpleado = '',
    this.nombreFamiliar = '',
    this.cedulaFamiliar = '',
    this.tipoDocumentoCodigo = '',
    this.tipoPersonaCodigo = '',
    this.plazoSolicitud = 0,
    this.fechaPrimerPagoSolicitud = '',
    this.isOffline = false,
    this.codigoUsa = '',
    this.nombre3 = '',
    this.apellido3 = '',
    this.rtn = '',
    this.telefonoNegocio = '',
    this.celularNegocio = '',
    this.actividadDescripcionConyugue = '',
    this.exeperiencia = 0,
    this.puestoNegocio = '',
    this.actividadEconomicaCnbs1Codigo = '',
    this.actividadEconomicaCnbs2Codigo = '',
    this.actividaEconomicaDescipcion1 = '',
    this.actividaEconomicaDescipcion2 = '',
    this.actividaEconomicaDescipcion3 = '',
    this.ejerceApnfd = '',
    this.esApnfd = '',
    this.nacinalidadCodigo = '',
    this.nacinalidad2Codigo = '',
    this.nacinalidad3Codigo = '',
    this.departamentoDestinoCodigo = '',
    this.tipoPersonaCnbsCodigo = '',
    this.tipoClienteCodigo = '',
    this.aldeaDestinoCodigo = '',
    this.municipioDestinoCodigo = '',
    this.aldeaNegocioCodigo = '',
    this.departamentoNegocioCodigo = '',
    this.nivelAproximadoIngresosCodigo = '',
    this.documentoConyuge = '',
    this.ocupacionCodigo = '',
    this.profesionCodigo = '',
    this.aldeaCasaCodigo = '',
    this.ubicacionCodigo = '',
    this.medidasConocimientoCodigo = '',
    this.caserioCasa = '',
    this.caserioNegocio = '',
    this.caserioDestino = '',
    this.barrioDestino = '',
    this.descripcionDestino = '',
    this.ingresosNetos = 0,
    this.fechaDesembolso = '',
    this.apellidosConyugue = '',
    this.tipoDocumentoConyugue = '',
    this.clientSignatureStatus = ClientSignatureStatus.unknown,
  });

  @override
  List<Object> get props => [
        cuotaWithDecimal,
        idSolicitud,
        grupoCodigoNombre,
        cargoGrupoNombre,
        esGrupal,
        cargoGrupoCodigo,
        grupoCodigo,
        apellidosConyugue,
        historialCredito,
        actividadEconomicaCnbs1CodigoNombre,
        actividadEconomicaCnbs2CodigoNombre,
        aldeaCasaCodigoNombre,
        paisCasaCodigoNombre,
        paisEmisorCedulaCodigoNombre,
        aldeaDestinoCodigoNombre,
        municipioDestinoCodigoNombre,
        aldeaNegocioCodigoNombre,
        departamentoNegocioCodigoNombre,
        ocupacionCodigoNombre,
        profesionCodigoNombre,
        ubicacionCodigoNombre,
        condicionCasaCodigoNombre,
        condicionNegocioCodigoNombre,
        departamentoCasaCodigoNombre,
        departamentoDestinoCodigoNombre,
        estadoCivilCodigoNombre,
        frecuenciaCodigoNombre,
        monedaCodigoNombre,
        municipioCasaCodigoNombre,
        municipioNegocioCodigoNombre,
        nacinalidad2CodigoNombre,
        nacinalidadCodigoNombre,
        nacinalidad3CodigoNombre,
        ocupacionNombre,
        parentescoFamiliarPeps2CodigoNombre,
        productoCodigoNombre,
        profesionNombre,
        propositoCodigoNombre,
        sectorCodigoNombre,
        tipoClienteCodigoNombre,
        tipoDocumentoCodigoNombre,
        tipoPersonaCodigoNombre,
        tipoPersonaCnbsCodigoNombre,
        isDone,
        tieneVinculosUsa,
        frecuenciaMeses,
        tasaInteres,
        montoMinimo,
        montoMaximo,
        fechaDesembolso,
        actividadEconomicaCnbs3Codigo,
        numeroSolicitud,
        email,
        nombre2,
        apellido2,
        cedulaFrontPath,
        cedulaBackPath,
        idLocalResponse,
        status,
        errorMsg,
        database,
        origenSolicitudCodigo,
        nombre1,
        apellido1,
        cedula,
        paisEmisorCedulaCodigo,
        fechaEmisionCedula,
        fechaVencimientoCedula,
        fechaNacimiento,
        telefono,
        celular,
        direccionCasa,
        barrioCasa,
        municipioCasaCodigo,
        departamentoCasaCodigo,
        paisCasaCodigo,
        profesion,
        ocupacion,
        condicionCasaCodigo,
        anosResidirCasa,
        monto,
        monedaCodigo,
        propositoCodigo,
        frecuenciaCodigo,
        cuota,
        sectorCodigo,
        nombreNegocio,
        tiempoFuncionamientoNegocio,
        direccionNegocio,
        barrioNegocio,
        municipioNegocioCodigo,
        condicionNegocioCodigo,
        horarioTrabajo,
        horarioVisita,
        personasACargo,
        estadoCivilCodigo,
        nombreConyugue,
        trabajaConyugue,
        trabajoConyugue,
        direccionTrabajoConyugue,
        telefonoTrabajoConyugue,
        productoCodigo,
        observacion,
        sucursal,
        ubicacionLongitud,
        ubicacionLatitud,
        escolaridadCodigo,
        cantidadHijos,
        nombrePublico,
        sexoCodigo,
        paisNacimientoCodigo,
        nacionalidadConyugue,
        ubicacion,
        espeps,
        nombreDeEntidadPeps,
        paisPeps,
        periodoPeps,
        cargoOficialPeps,
        tieneFamiliarPeps,
        nombreFamiliarPeps2,
        parentescoFamiliarPeps2Codigo,
        cargoFamiliarPeps2,
        nombreEntidadPeps2,
        periodoPeps2,
        paisPeps2,
        esFamiliarEmpleado,
        nombreFamiliar,
        cedulaFamiliar,
        tipoDocumentoCodigo,
        tipoPersonaCodigo,
        plazoSolicitud,
        fechaPrimerPagoSolicitud,
        isOffline,
        codigoUsa,
        nombre3,
        apellido3,
        rtn,
        telefonoNegocio,
        celularNegocio,
        actividadDescripcionConyugue,
        exeperiencia,
        puestoNegocio,
        actividadEconomicaCnbs1Codigo,
        actividadEconomicaCnbs2Codigo,
        actividaEconomicaDescipcion1,
        actividaEconomicaDescipcion2,
        actividaEconomicaDescipcion3,
        ejerceApnfd,
        esApnfd,
        nacinalidadCodigo,
        nacinalidad2Codigo,
        nacinalidad3Codigo,
        departamentoDestinoCodigo,
        tipoPersonaCnbsCodigo,
        tipoClienteCodigo,
        aldeaDestinoCodigo,
        municipioDestinoCodigo,
        aldeaNegocioCodigo,
        departamentoNegocioCodigo,
        nivelAproximadoIngresosCodigo,
        documentoConyuge,
        ocupacionCodigo,
        profesionCodigo,
        aldeaCasaCodigo,
        ubicacionCodigo,
        medidasConocimientoCodigo,
        caserioCasa,
        caserioNegocio,
        caserioDestino,
        barrioDestino,
        descripcionDestino,
        ingresosNetos,
        tipoDocumentoConyugue,
        clientSignatureStatus,
      ];

  SolicitudNuevaMenorHnState copyWith({
    String? idSolicitud,
    String? esGrupal,
    String? cargoGrupoCodigo,
    String? cargoGrupoNombre,
    String? grupoCodigo,
    String? grupoCodigoNombre,
    List<HistorialCredito>? historialCredito,
    String? actividadEconomicaCnbs1CodigoNombre,
    String? actividadEconomicaCnbs2CodigoNombre,
    String? aldeaCasaCodigoNombre,
    String? paisCasaCodigoNombre,
    String? paisEmisorCedulaCodigoNombre,
    String? aldeaDestinoCodigoNombre,
    String? municipioDestinoCodigoNombre,
    String? aldeaNegocioCodigoNombre,
    String? departamentoNegocioCodigoNombre,
    String? ocupacionCodigoNombre,
    String? profesionCodigoNombre,
    String? ubicacionCodigoNombre,
    String? condicionCasaCodigoNombre,
    String? condicionNegocioCodigoNombre,
    String? departamentoCasaCodigoNombre,
    String? departamentoDestinoCodigoNombre,
    String? estadoCivilCodigoNombre,
    String? frecuenciaCodigoNombre,
    String? monedaCodigoNombre,
    String? municipioCasaCodigoNombre,
    String? municipioNegocioCodigoNombre,
    String? nacinalidad2CodigoNombre,
    String? nacinalidadCodigoNombre,
    String? nacinalidad3CodigoNombre,
    String? ocupacionNombre,
    String? parentescoFamiliarPeps2CodigoNombre,
    String? productoCodigoNombre,
    String? profesionNombre,
    String? propositoCodigoNombre,
    String? sectorCodigoNombre,
    String? tipoClienteCodigoNombre,
    String? tipoDocumentoCodigoNombre,
    String? tipoPersonaCodigoNombre,
    String? tipoPersonaCnbsCodigoNombre,
    double? montoMinimo,
    double? montoMaximo,
    String? tieneVinculosUsa,
    String? frecuenciaMeses,
    double? tasaInteres,
    String? actividadEconomicaCnbs3Codigo,
    String? numeroSolicitud,
    String? email,
    String? nombre2,
    String? apellido2,
    String? cedulaFrontPath,
    String? cedulaBackPath,
    int? idLocalResponse,
    String? uuid,
    Status? status,
    String? errorMsg,
    String? database,
    String? origenSolicitudCodigo,
    String? nombre1,
    String? apellido1,
    String? cedula,
    String? paisEmisorCedulaCodigo,
    String? fechaEmisionCedula,
    String? fechaVencimientoCedula,
    String? fechaNacimiento,
    String? telefono,
    String? celular,
    String? direccionCasa,
    String? barrioCasa,
    String? municipioCasaCodigo,
    String? departamentoCasaCodigo,
    String? paisCasaCodigo,
    String? profesion,
    String? ocupacion,
    String? condicionCasaCodigo,
    int? anosResidirCasa,
    int? monto,
    String? monedaCodigo,
    String? propositoCodigo,
    String? frecuenciaCodigo,
    double? cuota,
    String? sectorCodigo,
    String? nombreNegocio,
    String? tiempoFuncionamientoNegocio,
    String? direccionNegocio,
    String? barrioNegocio,
    String? municipioNegocioCodigo,
    String? condicionNegocioCodigo,
    String? horarioTrabajo,
    String? horarioVisita,
    int? personasACargo,
    String? estadoCivilCodigo,
    String? nombreConyugue,
    String? trabajaConyugue,
    String? trabajoConyugue,
    String? direccionTrabajoConyugue,
    String? telefonoTrabajoConyugue,
    String? productoCodigo,
    String? observacion,
    String? sucursal,
    String? ubicacionLongitud,
    String? ubicacionLatitud,
    String? escolaridadCodigo,
    int? cantidadHijos,
    String? nombrePublico,
    String? sexoCodigo,
    String? paisNacimientoCodigo,
    String? nacionalidadConyugue,
    String? ubicacion,
    String? espeps,
    String? nombreDeEntidadPeps,
    String? paisPeps,
    String? periodoPeps,
    String? cargoOficialPeps,
    String? tieneFamiliarPeps,
    String? nombreFamiliarPeps2,
    String? parentescoFamiliarPeps2Codigo,
    String? cargoFamiliarPeps2,
    String? nombreEntidadPeps2,
    String? periodoPeps2,
    String? paisPeps2,
    String? esFamiliarEmpleado,
    String? nombreFamiliar,
    String? cedulaFamiliar,
    String? tipoDocumentoCodigo,
    String? tipoPersonaCodigo,
    int? plazoSolicitud,
    String? fechaPrimerPagoSolicitud,
    bool? isOffline,
    String? codigoUsa,
    String? nombre3,
    String? apellido3,
    String? rtn,
    String? telefonoNegocio,
    String? celularNegocio,
    String? actividadDescripcionConyugue,
    int? exeperiencia,
    String? puestoNegocio,
    String? actividadEconomicaCnbs1Codigo,
    String? actividadEconomicaCnbs2Codigo,
    String? actividaEconomicaDescipcion1,
    String? actividaEconomicaDescipcion2,
    String? actividaEconomicaDescipcion3,
    String? ejerceApnfd,
    String? esApnfd,
    String? nacinalidadCodigo,
    String? nacinalidad2Codigo,
    String? nacinalidad3Codigo,
    String? departamentoDestinoCodigo,
    String? tipoPersonaCnbsCodigo,
    String? tipoClienteCodigo,
    String? aldeaDestinoCodigo,
    String? municipioDestinoCodigo,
    String? aldeaNegocioCodigo,
    String? departamentoNegocioCodigo,
    String? nivelAproximadoIngresosCodigo,
    String? documentoConyuge,
    String? ocupacionCodigo,
    String? profesionCodigo,
    String? aldeaCasaCodigo,
    String? ubicacionCodigo,
    String? medidasConocimientoCodigo,
    String? caserioCasa,
    String? caserioNegocio,
    String? caserioDestino,
    String? barrioDestino,
    String? descripcionDestino,
    int? ingresosNetos,
    String? fechaDesembolso,
    bool? isDone,
    String? apellidosConyugue,
    String? tipoDocumentoConyugue,
    double? cuotaWithDecimal,
    ClientSignatureStatus? clientSignatureStatus,
  }) {
    return SolicitudNuevaMenorHnState(
      idSolicitud: idSolicitud ?? this.idSolicitud,
      esGrupal: esGrupal ?? this.esGrupal,
      cargoGrupoCodigo: cargoGrupoCodigo ?? this.cargoGrupoCodigo,
      cargoGrupoNombre: cargoGrupoNombre ?? this.cargoGrupoNombre,
      grupoCodigo: grupoCodigo ?? this.grupoCodigo,
      grupoCodigoNombre: grupoCodigoNombre ?? this.grupoCodigoNombre,
      historialCredito: historialCredito ?? this.historialCredito,
      actividadEconomicaCnbs1CodigoNombre:
          actividadEconomicaCnbs1CodigoNombre ??
              this.actividadEconomicaCnbs1CodigoNombre,
      actividadEconomicaCnbs2CodigoNombre:
          actividadEconomicaCnbs2CodigoNombre ??
              this.actividadEconomicaCnbs2CodigoNombre,
      aldeaCasaCodigoNombre:
          aldeaCasaCodigoNombre ?? this.aldeaCasaCodigoNombre,
      paisCasaCodigoNombre: paisCasaCodigoNombre ?? this.paisCasaCodigoNombre,
      paisEmisorCedulaCodigoNombre:
          paisEmisorCedulaCodigoNombre ?? this.paisEmisorCedulaCodigoNombre,
      aldeaDestinoCodigoNombre:
          aldeaDestinoCodigoNombre ?? this.aldeaDestinoCodigoNombre,
      municipioDestinoCodigoNombre:
          municipioDestinoCodigoNombre ?? this.municipioDestinoCodigoNombre,
      aldeaNegocioCodigoNombre:
          aldeaNegocioCodigoNombre ?? this.aldeaNegocioCodigoNombre,
      departamentoNegocioCodigoNombre: departamentoNegocioCodigoNombre ??
          this.departamentoNegocioCodigoNombre,
      ocupacionCodigoNombre:
          ocupacionCodigoNombre ?? this.ocupacionCodigoNombre,
      profesionCodigoNombre:
          profesionCodigoNombre ?? this.profesionCodigoNombre,
      ubicacionCodigoNombre:
          ubicacionCodigoNombre ?? this.ubicacionCodigoNombre,
      condicionCasaCodigoNombre:
          condicionCasaCodigoNombre ?? this.condicionCasaCodigoNombre,
      condicionNegocioCodigoNombre:
          condicionNegocioCodigoNombre ?? this.condicionNegocioCodigoNombre,
      departamentoCasaCodigoNombre:
          departamentoCasaCodigoNombre ?? this.departamentoCasaCodigoNombre,
      departamentoDestinoCodigoNombre: departamentoDestinoCodigoNombre ??
          this.departamentoDestinoCodigoNombre,
      estadoCivilCodigoNombre:
          estadoCivilCodigoNombre ?? this.estadoCivilCodigoNombre,
      frecuenciaCodigoNombre:
          frecuenciaCodigoNombre ?? this.frecuenciaCodigoNombre,
      monedaCodigoNombre: monedaCodigoNombre ?? this.monedaCodigoNombre,
      municipioCasaCodigoNombre:
          municipioCasaCodigoNombre ?? this.municipioCasaCodigoNombre,
      municipioNegocioCodigoNombre:
          municipioNegocioCodigoNombre ?? this.municipioNegocioCodigoNombre,
      nacinalidad2CodigoNombre:
          nacinalidad2CodigoNombre ?? this.nacinalidad2CodigoNombre,
      nacinalidadCodigoNombre:
          nacinalidadCodigoNombre ?? this.nacinalidadCodigoNombre,
      nacinalidad3CodigoNombre:
          nacinalidad3CodigoNombre ?? this.nacinalidad3CodigoNombre,
      ocupacionNombre: ocupacionNombre ?? this.ocupacionNombre,
      parentescoFamiliarPeps2CodigoNombre:
          parentescoFamiliarPeps2CodigoNombre ??
              this.parentescoFamiliarPeps2CodigoNombre,
      productoCodigoNombre: productoCodigoNombre ?? this.productoCodigoNombre,
      profesionNombre: profesionNombre ?? this.profesionNombre,
      propositoCodigoNombre:
          propositoCodigoNombre ?? this.propositoCodigoNombre,
      sectorCodigoNombre: sectorCodigoNombre ?? this.sectorCodigoNombre,
      tipoClienteCodigoNombre:
          tipoClienteCodigoNombre ?? this.tipoClienteCodigoNombre,
      tipoDocumentoCodigoNombre:
          tipoDocumentoCodigoNombre ?? this.tipoDocumentoCodigoNombre,
      tipoPersonaCodigoNombre:
          tipoPersonaCodigoNombre ?? this.tipoPersonaCodigoNombre,
      tipoPersonaCnbsCodigoNombre:
          tipoPersonaCnbsCodigoNombre ?? this.tipoPersonaCnbsCodigoNombre,
      montoMinimo: montoMinimo ?? this.montoMinimo,
      montoMaximo: montoMaximo ?? this.montoMaximo,
      tieneVinculosUsa: tieneVinculosUsa ?? this.tieneVinculosUsa,
      frecuenciaMeses: frecuenciaMeses ?? this.frecuenciaMeses,
      tasaInteres: tasaInteres ?? this.tasaInteres,
      actividadEconomicaCnbs3Codigo:
          actividadEconomicaCnbs3Codigo ?? this.actividadEconomicaCnbs3Codigo,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      email: email ?? this.email,
      nombre2: nombre2 ?? this.nombre2,
      apellido2: apellido2 ?? this.apellido2,
      cedulaFrontPath: cedulaFrontPath ?? this.cedulaFrontPath,
      cedulaBackPath: cedulaBackPath ?? this.cedulaBackPath,
      idLocalResponse: idLocalResponse ?? this.idLocalResponse,
      uuid: uuid ?? this.uuid,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      database: database ?? this.database,
      origenSolicitudCodigo:
          origenSolicitudCodigo ?? this.origenSolicitudCodigo,
      nombre1: nombre1 ?? this.nombre1,
      apellido1: apellido1 ?? this.apellido1,
      cedula: cedula ?? this.cedula,
      paisEmisorCedulaCodigo:
          paisEmisorCedulaCodigo ?? this.paisEmisorCedulaCodigo,
      fechaEmisionCedula: fechaEmisionCedula ?? this.fechaEmisionCedula,
      fechaVencimientoCedula:
          fechaVencimientoCedula ?? this.fechaVencimientoCedula,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      telefono: telefono ?? this.telefono,
      celular: celular ?? this.celular,
      direccionCasa: direccionCasa ?? this.direccionCasa,
      barrioCasa: barrioCasa ?? this.barrioCasa,
      municipioCasaCodigo: municipioCasaCodigo ?? this.municipioCasaCodigo,
      departamentoCasaCodigo:
          departamentoCasaCodigo ?? this.departamentoCasaCodigo,
      paisCasaCodigo: paisCasaCodigo ?? this.paisCasaCodigo,
      profesion: profesion ?? this.profesion,
      ocupacion: ocupacion ?? this.ocupacion,
      condicionCasaCodigo: condicionCasaCodigo ?? this.condicionCasaCodigo,
      anosResidirCasa: anosResidirCasa ?? this.anosResidirCasa,
      monto: monto ?? this.monto,
      monedaCodigo: monedaCodigo ?? this.monedaCodigo,
      propositoCodigo: propositoCodigo ?? this.propositoCodigo,
      frecuenciaCodigo: frecuenciaCodigo ?? this.frecuenciaCodigo,
      cuota: cuota ?? this.cuota,
      sectorCodigo: sectorCodigo ?? this.sectorCodigo,
      nombreNegocio: nombreNegocio ?? this.nombreNegocio,
      tiempoFuncionamientoNegocio:
          tiempoFuncionamientoNegocio ?? this.tiempoFuncionamientoNegocio,
      direccionNegocio: direccionNegocio ?? this.direccionNegocio,
      barrioNegocio: barrioNegocio ?? this.barrioNegocio,
      municipioNegocioCodigo:
          municipioNegocioCodigo ?? this.municipioNegocioCodigo,
      condicionNegocioCodigo:
          condicionNegocioCodigo ?? this.condicionNegocioCodigo,
      horarioTrabajo: horarioTrabajo ?? this.horarioTrabajo,
      horarioVisita: horarioVisita ?? this.horarioVisita,
      personasACargo: personasACargo ?? this.personasACargo,
      estadoCivilCodigo: estadoCivilCodigo ?? this.estadoCivilCodigo,
      nombreConyugue: nombreConyugue ?? this.nombreConyugue,
      trabajaConyugue: trabajaConyugue ?? this.trabajaConyugue,
      trabajoConyugue: trabajoConyugue ?? this.trabajoConyugue,
      direccionTrabajoConyugue:
          direccionTrabajoConyugue ?? this.direccionTrabajoConyugue,
      telefonoTrabajoConyugue:
          telefonoTrabajoConyugue ?? this.telefonoTrabajoConyugue,
      productoCodigo: productoCodigo ?? this.productoCodigo,
      observacion: observacion ?? this.observacion,
      sucursal: sucursal ?? this.sucursal,
      ubicacionLongitud: ubicacionLongitud ?? this.ubicacionLongitud,
      ubicacionLatitud: ubicacionLatitud ?? this.ubicacionLatitud,
      escolaridadCodigo: escolaridadCodigo ?? this.escolaridadCodigo,
      cantidadHijos: cantidadHijos ?? this.cantidadHijos,
      nombrePublico: nombrePublico ?? this.nombrePublico,
      sexoCodigo: sexoCodigo ?? this.sexoCodigo,
      paisNacimientoCodigo: paisNacimientoCodigo ?? this.paisNacimientoCodigo,
      nacionalidadConyugue: nacionalidadConyugue ?? this.nacionalidadConyugue,
      ubicacion: ubicacion ?? this.ubicacion,
      espeps: espeps ?? this.espeps,
      nombreDeEntidadPeps: nombreDeEntidadPeps ?? this.nombreDeEntidadPeps,
      paisPeps: paisPeps ?? this.paisPeps,
      periodoPeps: periodoPeps ?? this.periodoPeps,
      cargoOficialPeps: cargoOficialPeps ?? this.cargoOficialPeps,
      tieneFamiliarPeps: tieneFamiliarPeps ?? this.tieneFamiliarPeps,
      nombreFamiliarPeps2: nombreFamiliarPeps2 ?? this.nombreFamiliarPeps2,
      parentescoFamiliarPeps2Codigo:
          parentescoFamiliarPeps2Codigo ?? this.parentescoFamiliarPeps2Codigo,
      cargoFamiliarPeps2: cargoFamiliarPeps2 ?? this.cargoFamiliarPeps2,
      nombreEntidadPeps2: nombreEntidadPeps2 ?? this.nombreEntidadPeps2,
      periodoPeps2: periodoPeps2 ?? this.periodoPeps2,
      paisPeps2: paisPeps2 ?? this.paisPeps2,
      esFamiliarEmpleado: esFamiliarEmpleado ?? this.esFamiliarEmpleado,
      nombreFamiliar: nombreFamiliar ?? this.nombreFamiliar,
      cedulaFamiliar: cedulaFamiliar ?? this.cedulaFamiliar,
      tipoDocumentoCodigo: tipoDocumentoCodigo ?? this.tipoDocumentoCodigo,
      tipoPersonaCodigo: tipoPersonaCodigo ?? this.tipoPersonaCodigo,
      plazoSolicitud: plazoSolicitud ?? this.plazoSolicitud,
      fechaPrimerPagoSolicitud:
          fechaPrimerPagoSolicitud ?? this.fechaPrimerPagoSolicitud,
      isOffline: isOffline ?? this.isOffline,
      codigoUsa: codigoUsa ?? this.codigoUsa,
      nombre3: nombre3 ?? this.nombre3,
      apellido3: apellido3 ?? this.apellido3,
      rtn: rtn ?? this.rtn,
      telefonoNegocio: telefonoNegocio ?? this.telefonoNegocio,
      celularNegocio: celularNegocio ?? this.celularNegocio,
      actividadDescripcionConyugue:
          actividadDescripcionConyugue ?? this.actividadDescripcionConyugue,
      exeperiencia: exeperiencia ?? this.exeperiencia,
      puestoNegocio: puestoNegocio ?? this.puestoNegocio,
      actividadEconomicaCnbs1Codigo:
          actividadEconomicaCnbs1Codigo ?? this.actividadEconomicaCnbs1Codigo,
      actividadEconomicaCnbs2Codigo:
          actividadEconomicaCnbs2Codigo ?? this.actividadEconomicaCnbs2Codigo,
      actividaEconomicaDescipcion1:
          actividaEconomicaDescipcion1 ?? this.actividaEconomicaDescipcion1,
      actividaEconomicaDescipcion2:
          actividaEconomicaDescipcion2 ?? this.actividaEconomicaDescipcion2,
      actividaEconomicaDescipcion3:
          actividaEconomicaDescipcion3 ?? this.actividaEconomicaDescipcion3,
      ejerceApnfd: ejerceApnfd ?? this.ejerceApnfd,
      esApnfd: esApnfd ?? this.esApnfd,
      nacinalidadCodigo: nacinalidadCodigo ?? this.nacinalidadCodigo,
      nacinalidad2Codigo: nacinalidad2Codigo ?? this.nacinalidad2Codigo,
      nacinalidad3Codigo: nacinalidad3Codigo ?? this.nacinalidad3Codigo,
      departamentoDestinoCodigo:
          departamentoDestinoCodigo ?? this.departamentoDestinoCodigo,
      tipoPersonaCnbsCodigo:
          tipoPersonaCnbsCodigo ?? this.tipoPersonaCnbsCodigo,
      tipoClienteCodigo: tipoClienteCodigo ?? this.tipoClienteCodigo,
      aldeaDestinoCodigo: aldeaDestinoCodigo ?? this.aldeaDestinoCodigo,
      municipioDestinoCodigo:
          municipioDestinoCodigo ?? this.municipioDestinoCodigo,
      aldeaNegocioCodigo: aldeaNegocioCodigo ?? this.aldeaNegocioCodigo,
      departamentoNegocioCodigo:
          departamentoNegocioCodigo ?? this.departamentoNegocioCodigo,
      nivelAproximadoIngresosCodigo:
          nivelAproximadoIngresosCodigo ?? this.nivelAproximadoIngresosCodigo,
      documentoConyuge: documentoConyuge ?? this.documentoConyuge,
      ocupacionCodigo: ocupacionCodigo ?? this.ocupacionCodigo,
      profesionCodigo: profesionCodigo ?? this.profesionCodigo,
      aldeaCasaCodigo: aldeaCasaCodigo ?? this.aldeaCasaCodigo,
      ubicacionCodigo: ubicacionCodigo ?? this.ubicacionCodigo,
      medidasConocimientoCodigo:
          medidasConocimientoCodigo ?? this.medidasConocimientoCodigo,
      caserioCasa: caserioCasa ?? this.caserioCasa,
      caserioNegocio: caserioNegocio ?? this.caserioNegocio,
      caserioDestino: caserioDestino ?? this.caserioDestino,
      barrioDestino: barrioDestino ?? this.barrioDestino,
      descripcionDestino: descripcionDestino ?? this.descripcionDestino,
      ingresosNetos: ingresosNetos ?? this.ingresosNetos,
      fechaDesembolso: fechaDesembolso ?? this.fechaDesembolso,
      isDone: isDone ?? this.isDone,
      apellidosConyugue: apellidosConyugue ?? this.apellidosConyugue,
      tipoDocumentoConyugue:
          tipoDocumentoConyugue ?? this.tipoDocumentoConyugue,
      cuotaWithDecimal: cuotaWithDecimal ?? this.cuotaWithDecimal,
      clientSignatureStatus:
          clientSignatureStatus ?? this.clientSignatureStatus,
    );
  }
}

final class SolicitudNuevaMenorHnInitial extends SolicitudNuevaMenorHnState {}

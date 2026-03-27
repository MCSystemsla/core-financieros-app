// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'update_solicitud_nueva_menor_cubit.dart';

class UpdateSolicitudNuevaMenorState extends Equatable {
  final Status status;
  final Status updateStatus;
  final String errorMsg;
  final String id;
  final String origenSolicitudCodigo;
  final String origenSolicitudNombre;
  final String nombre1;
  final String nombre2;
  final String apellido1;
  final String apellido2;
  final String cedula;
  final String paisEmisorCedulaCodigo;
  final String paisEmisorCedulaNombre;
  final String tipoDocumentoCodigo;
  final String tipoDocumentoNombre;
  final String tipoDocumentoConyugeCodigo;
  final String tipoDocumentoConyugeNombre;
  final String nombrePublico;
  final String fechaEmisionCedula;
  final String fechaVencimientoCedula;
  final String fechaNacimiento;
  final String telefono;
  final String celular;
  final String direccionCasa;
  final String barrioCasa;
  final String municipioCasaCodigo;
  final String municipioCasaNombre;
  final String departamentoCasaCodigo;
  final String departamentoCasaNombre;
  final String paisCasaCodigo;
  final String paisCasaNombre;
  final String nacionalidad;
  final String condicionCasaCodigo;
  final String condicionCasaNombre;
  final int anosResidirCasa;
  final String email;
  final int monto;
  final String monedaCodigo;
  final String monedaNombre;
  final String propositoCodigo;
  final String propositoNombre;
  final String descripcionDestino;
  final String frecuenciaCodigo;
  final String frecuenciaNombre;
  final int cuota;
  final String sectorCodigo;
  final String sectorNombre;
  final int personasACargo;
  final String estadoCivilCodigo;
  final String estadoCivilNombre;
  final String nombreConyugue;
  final bool trabajaConyugue;
  final String trabajoConyugue;
  final String direccionTrabajoConyugue;
  final String telefonoTrabajoConyugue;
  final String productoCodigo;
  final String productoNombre;
  final String observacion;
  final String ubicacionLongitud;
  final String ubicacionLatitud;
  final String escolaridadCodigo;
  final String escolaridadNombre;
  final int cantidadHijos;
  final String sexoCodigo;
  final String sexoNombre;
  final String paisNacimientoCodigo;
  final String paisNacimientoNombre;
  final String nacionalidadConyugue;
  final String ubicacion;
  final bool esPeps;
  final String nombreDeEntidadPeps;
  final String paisPeps;
  final String periodoPeps;
  final String cargoOficialPeps;
  final bool tieneFamiliarPeps;
  final String nombreFamiliarPeps2;
  final String parentescoFamiliarPeps2Codigo;
  final String parentescoFamiliarPeps2Nombre;
  final String cargoFamiliarPeps2;
  final String nombreEntidadPeps2;
  final String periodoPeps2;
  final String paisPeps2;
  final String actividadPredominanteCodigo;
  final String actividadPredominanteNombre;
  final bool esFamiliarEmpleado;
  final String nombreFamiliar;
  final String cedulaFamiliar;
  final String tipoPersonaCodigo;
  final String tipoPersonaNombre;
  final int plazoSolicitud;
  final String fechaPrimerPagoSolicitud;
  final String rtn;
  final String codigoUsa;
  final String tipoClienteCodigo;
  final String tipoClienteNombre;
  final String actividadEconomicaCiuu1Codigo;
  final String actividadEconomicaCiuu1Nombre;
  final String actividadEconomicaCiuu2Codigo;
  final String actividadEconomicaCiuu2Nombre;
  final String actividadEconomicaCiuu3Codigo;
  final String actividadEconomicaCiuu3Nombre;
  final String ocupacionCodigo;
  final String ocupacionNombre;
  final String profesionCodigo;
  final String profesionNombre;
  final String actividadEconomicaDescripcion1;
  final String actividadEconomicaDescripcion2;
  final String actividadEconomicaDescripcion3;
  final bool ejerceApnfd;
  final bool esApnfd;
  final String paisDestinoCodigo;
  final String paisDestinoNombre;
  final String departamentoDestinoCodigo;
  final String departamentoDestinoNombre;
  final String municipioDestinoCodigo;
  final String municipioDestinoNombre;
  final String aldeaDestinoCodigo;
  final String aldeaDestinoNombre;
  final String caserioDestino;
  final String barrioDestino;
  final String caserioCasa;
  final String aldeaCodigo;
  final String aldeaNombre;
  final String nombreNegocio;
  final String direccionNegocio;
  final String barrioNegocio;
  final String caserioNegocio;
  final String paisNegocioCodigo;
  final String paisNegocioNombre;
  final String departamentoNegocioCodigo;
  final String departamentoNegocioNombre;
  final String municipioNegocioCodigo;
  final String municipioNegocioNombre;
  final String aldeaNegocioCodigo;
  final String aldeaNegocioNombre;
  final String condicionNegocioCodigo;
  final String condicionNegocioNombre;
  final String telefonoNegocio;
  final String celularNegocio;
  final String tiempoFuncionamientoNegocio;
  final String puestoNegocio;
  final String horarioTrabajo;
  final String experiencia;
  final String horarioVisita;
  final int ingresosNetos;
  final int grupoCicloId;
  final String cicloEstadoNombre;
  final String cicloEstadoCodigo;
  final String grupoNombre;
  final String grupoCodigo;
  final String nombre3;
  final String apellido3;
  final String nacionalidad2Codigo;
  final String nacionalidad3Codigo;
  final String nacionalidad2Nombre;
  final String nacionalidad3Nombre;
  final String tipoPersonaCNBSCodigo;
  final String tipoPersonaCNBSNombre;
  final String cargoGrupoCodigo;
  final String cargoGrupoNombre;
  final String actividadDescripcionConyuge;
  final String documentoConyuge;
  final String cargo;
  final String direccionTrabajo;
  final String barrioTrabajo;
  final String telefonoTrabajo;
  final String tiempoLaboral;
  final String lugarTrabajoAnterior;
  final int salarioNetoCordoba;
  final int totalIngresoMes;
  final String fuenteOtrosIngresos;
  final String nombreTrabajo;
  final int otrosIngresosCordoba;
  final String tiempoLaborarConyugue;
  final String profesionConyugue;
  final int sueldoMesConyugue;
  final int otrosIngresosConyugue;
  final String fuenteOtrosIngresosConyugue;
  final String nombreFamiliarCercano;
  final String direccionFamiliarCercano;
  final String telefonoFamiliarCercano;
  final List<HistorialCredito> historialCredito;
  final double ingresoMensualConyuge;
  final int aniosLugarTrabajoConyuge;
  final String medidasConocimientoCodigo;
  final String medidasConocimientoNombre;
  final String paisTrabajoCodigo;
  final String paisTrabajoNombre;
  final String departamentoTrabajoCodigo;
  final String departamentoTrabajoNombre;
  final String municipioTrabajoCodigo;
  final String municipioTrabajoNombre;
  final String aldeaTrabajoCodigo;
  final String aldeaTrabajoNombre;
  final String caserioTrabajo;
  final double otrosIngresos;
  final double salarioNetoMensual;
  final double salarioNetoMensualConyuge;
  final String telefonoConyuge;
  final String cedulaConyuge;

  const UpdateSolicitudNuevaMenorState({
    this.status = Status.notStarted,
    this.updateStatus = Status.notStarted,
    this.errorMsg = '',
    this.id = '',
    this.origenSolicitudCodigo = '',
    this.origenSolicitudNombre = '',
    this.nombre1 = '',
    this.nombre2 = '',
    this.apellido1 = '',
    this.apellido2 = '',
    this.cedula = '',
    this.paisEmisorCedulaCodigo = '',
    this.paisEmisorCedulaNombre = '',
    this.tipoDocumentoCodigo = '',
    this.tipoDocumentoNombre = '',
    this.tipoDocumentoConyugeCodigo = '',
    this.tipoDocumentoConyugeNombre = '',
    this.nombrePublico = '',
    this.fechaEmisionCedula = '',
    this.fechaVencimientoCedula = '',
    this.fechaNacimiento = '',
    this.telefono = '',
    this.celular = '',
    this.direccionCasa = '',
    this.barrioCasa = '',
    this.municipioCasaCodigo = '',
    this.municipioCasaNombre = '',
    this.departamentoCasaCodigo = '',
    this.departamentoCasaNombre = '',
    this.paisCasaCodigo = '',
    this.paisCasaNombre = '',
    this.nacionalidad = '',
    this.condicionCasaCodigo = '',
    this.condicionCasaNombre = '',
    this.anosResidirCasa = 0,
    this.email = '',
    this.monto = 0,
    this.monedaCodigo = '',
    this.monedaNombre = '',
    this.propositoCodigo = '',
    this.propositoNombre = '',
    this.descripcionDestino = '',
    this.frecuenciaCodigo = '',
    this.frecuenciaNombre = '',
    this.cuota = 0,
    this.sectorCodigo = '',
    this.sectorNombre = '',
    this.personasACargo = 0,
    this.estadoCivilCodigo = '',
    this.estadoCivilNombre = '',
    this.nombreConyugue = '',
    this.trabajaConyugue = false,
    this.trabajoConyugue = '',
    this.direccionTrabajoConyugue = '',
    this.telefonoTrabajoConyugue = '',
    this.productoCodigo = '',
    this.productoNombre = '',
    this.observacion = '',
    this.ubicacionLongitud = '',
    this.ubicacionLatitud = '',
    this.escolaridadCodigo = '',
    this.escolaridadNombre = '',
    this.cantidadHijos = 0,
    this.sexoCodigo = '',
    this.sexoNombre = '',
    this.paisNacimientoCodigo = '',
    this.paisNacimientoNombre = '',
    this.nacionalidadConyugue = '',
    this.ubicacion = '',
    this.esPeps = false,
    this.nombreDeEntidadPeps = '',
    this.paisPeps = '',
    this.periodoPeps = '',
    this.cargoOficialPeps = '',
    this.tieneFamiliarPeps = false,
    this.nombreFamiliarPeps2 = '',
    this.parentescoFamiliarPeps2Codigo = '',
    this.parentescoFamiliarPeps2Nombre = '',
    this.cargoFamiliarPeps2 = '',
    this.nombreEntidadPeps2 = '',
    this.periodoPeps2 = '',
    this.paisPeps2 = '',
    this.actividadPredominanteCodigo = '',
    this.actividadPredominanteNombre = '',
    this.esFamiliarEmpleado = false,
    this.nombreFamiliar = '',
    this.cedulaFamiliar = '',
    this.tipoPersonaCodigo = '',
    this.tipoPersonaNombre = '',
    this.plazoSolicitud = 0,
    this.fechaPrimerPagoSolicitud = '',
    this.rtn = '',
    this.codigoUsa = '',
    this.tipoClienteCodigo = '',
    this.tipoClienteNombre = '',
    this.actividadEconomicaCiuu1Codigo = '',
    this.actividadEconomicaCiuu1Nombre = '',
    this.actividadEconomicaCiuu2Codigo = '',
    this.actividadEconomicaCiuu2Nombre = '',
    this.actividadEconomicaCiuu3Codigo = '',
    this.actividadEconomicaCiuu3Nombre = '',
    this.ocupacionCodigo = '',
    this.ocupacionNombre = '',
    this.profesionCodigo = '',
    this.profesionNombre = '',
    this.actividadEconomicaDescripcion1 = '',
    this.actividadEconomicaDescripcion2 = '',
    this.actividadEconomicaDescripcion3 = '',
    this.ejerceApnfd = false,
    this.esApnfd = false,
    this.paisDestinoCodigo = '',
    this.paisDestinoNombre = '',
    this.departamentoDestinoCodigo = '',
    this.departamentoDestinoNombre = '',
    this.municipioDestinoCodigo = '',
    this.municipioDestinoNombre = '',
    this.aldeaDestinoCodigo = '',
    this.aldeaDestinoNombre = '',
    this.caserioDestino = '',
    this.barrioDestino = '',
    this.caserioCasa = '',
    this.aldeaCodigo = '',
    this.aldeaNombre = '',
    this.nombreNegocio = '',
    this.direccionNegocio = '',
    this.barrioNegocio = '',
    this.caserioNegocio = '',
    this.paisNegocioCodigo = '',
    this.paisNegocioNombre = '',
    this.departamentoNegocioCodigo = '',
    this.departamentoNegocioNombre = '',
    this.municipioNegocioCodigo = '',
    this.municipioNegocioNombre = '',
    this.aldeaNegocioCodigo = '',
    this.aldeaNegocioNombre = '',
    this.condicionNegocioCodigo = '',
    this.condicionNegocioNombre = '',
    this.telefonoNegocio = '',
    this.celularNegocio = '',
    this.tiempoFuncionamientoNegocio = '',
    this.puestoNegocio = '',
    this.horarioTrabajo = '',
    this.experiencia = '',
    this.horarioVisita = '',
    this.ingresosNetos = 0,
    this.grupoCicloId = 0,
    this.cicloEstadoNombre = '',
    this.cicloEstadoCodigo = '',
    this.grupoNombre = '',
    this.grupoCodigo = '',
    this.nombre3 = '',
    this.apellido3 = '',
    this.nacionalidad2Codigo = '',
    this.nacionalidad3Codigo = '',
    this.nacionalidad2Nombre = '',
    this.nacionalidad3Nombre = '',
    this.tipoPersonaCNBSCodigo = '',
    this.tipoPersonaCNBSNombre = '',
    this.cargoGrupoCodigo = '',
    this.cargoGrupoNombre = '',
    this.actividadDescripcionConyuge = '',
    this.documentoConyuge = '',
    this.historialCredito = const [],
    this.cargo = '',
    this.direccionTrabajo = '',
    this.barrioTrabajo = '',
    this.telefonoTrabajo = '',
    this.tiempoLaboral = '',
    this.lugarTrabajoAnterior = '',
    this.salarioNetoCordoba = 0,
    this.totalIngresoMes = 0,
    this.fuenteOtrosIngresos = '',
    this.nombreTrabajo = '',
    this.otrosIngresosCordoba = 0,
    this.profesionConyugue = '',
    this.tiempoLaborarConyugue = '',
    this.sueldoMesConyugue = 0,
    this.otrosIngresosConyugue = 0,
    this.fuenteOtrosIngresosConyugue = '',
    this.nombreFamiliarCercano = '',
    this.direccionFamiliarCercano = '',
    this.telefonoFamiliarCercano = '',
    this.ingresoMensualConyuge = 0,
    this.aniosLugarTrabajoConyuge = 0,
    this.medidasConocimientoCodigo = '',
    this.medidasConocimientoNombre = '',
    this.paisTrabajoCodigo = '',
    this.paisTrabajoNombre = '',
    this.departamentoTrabajoCodigo = '',
    this.departamentoTrabajoNombre = '',
    this.municipioTrabajoCodigo = '',
    this.municipioTrabajoNombre = '',
    this.aldeaTrabajoCodigo = '',
    this.aldeaTrabajoNombre = '',
    this.caserioTrabajo = '',
    this.otrosIngresos = 0,
    this.salarioNetoMensual = 0,
    this.salarioNetoMensualConyuge = 0,
    this.telefonoConyuge = '',
    this.cedulaConyuge = '',
  });

  @override
  List<Object> get props => [
        nombreFamiliarCercano,
        direccionFamiliarCercano,
        telefonoFamiliarCercano,
        fuenteOtrosIngresosConyugue,
        tiempoLaborarConyugue,
        profesionConyugue,
        otrosIngresosCordoba,
        nombreTrabajo,
        cargo,
        direccionTrabajo,
        barrioTrabajo,
        telefonoTrabajo,
        tiempoLaboral,
        lugarTrabajoAnterior,
        salarioNetoCordoba,
        totalIngresoMes,
        fuenteOtrosIngresos,
        historialCredito,
        actividadDescripcionConyuge,
        documentoConyuge,
        updateStatus,
        status,
        errorMsg,
        id,
        origenSolicitudCodigo,
        origenSolicitudNombre,
        nombre1,
        nombre2,
        apellido1,
        apellido2,
        cedula,
        paisEmisorCedulaCodigo,
        paisEmisorCedulaNombre,
        tipoDocumentoCodigo,
        tipoDocumentoNombre,
        tipoDocumentoConyugeCodigo,
        tipoDocumentoConyugeNombre,
        nombrePublico,
        fechaEmisionCedula,
        fechaVencimientoCedula,
        fechaNacimiento,
        telefono,
        celular,
        direccionCasa,
        barrioCasa,
        municipioCasaCodigo,
        municipioCasaNombre,
        departamentoCasaCodigo,
        departamentoCasaNombre,
        paisCasaCodigo,
        paisCasaNombre,
        nacionalidad,
        condicionCasaCodigo,
        condicionCasaNombre,
        anosResidirCasa,
        email,
        monto,
        monedaCodigo,
        monedaNombre,
        propositoCodigo,
        propositoNombre,
        descripcionDestino,
        frecuenciaCodigo,
        frecuenciaNombre,
        cuota,
        sectorCodigo,
        sectorNombre,
        personasACargo,
        estadoCivilCodigo,
        estadoCivilNombre,
        nombreConyugue,
        trabajaConyugue,
        trabajoConyugue,
        direccionTrabajoConyugue,
        telefonoTrabajoConyugue,
        productoCodigo,
        productoNombre,
        observacion,
        ubicacionLongitud,
        ubicacionLatitud,
        escolaridadCodigo,
        escolaridadNombre,
        cantidadHijos,
        sexoCodigo,
        sexoNombre,
        paisNacimientoCodigo,
        paisNacimientoNombre,
        nacionalidadConyugue,
        ubicacion,
        esPeps,
        nombreDeEntidadPeps,
        paisPeps,
        periodoPeps,
        cargoOficialPeps,
        tieneFamiliarPeps,
        nombreFamiliarPeps2,
        parentescoFamiliarPeps2Codigo,
        parentescoFamiliarPeps2Nombre,
        cargoFamiliarPeps2,
        nombreEntidadPeps2,
        periodoPeps2,
        paisPeps2,
        actividadPredominanteCodigo,
        actividadPredominanteNombre,
        esFamiliarEmpleado,
        nombreFamiliar,
        cedulaFamiliar,
        tipoPersonaCodigo,
        tipoPersonaNombre,
        plazoSolicitud,
        fechaPrimerPagoSolicitud,
        rtn,
        codigoUsa,
        tipoClienteCodigo,
        tipoClienteNombre,
        actividadEconomicaCiuu1Codigo,
        actividadEconomicaCiuu1Nombre,
        actividadEconomicaCiuu2Codigo,
        actividadEconomicaCiuu2Nombre,
        actividadEconomicaCiuu3Codigo,
        actividadEconomicaCiuu3Nombre,
        ocupacionCodigo,
        ocupacionNombre,
        profesionCodigo,
        profesionNombre,
        actividadEconomicaDescripcion1,
        actividadEconomicaDescripcion2,
        actividadEconomicaDescripcion3,
        ejerceApnfd,
        esApnfd,
        paisDestinoCodigo,
        paisDestinoNombre,
        departamentoDestinoCodigo,
        departamentoDestinoNombre,
        municipioDestinoCodigo,
        municipioDestinoNombre,
        aldeaDestinoCodigo,
        aldeaDestinoNombre,
        caserioDestino,
        barrioDestino,
        caserioCasa,
        aldeaCodigo,
        aldeaNombre,
        nombreNegocio,
        direccionNegocio,
        barrioNegocio,
        caserioNegocio,
        paisNegocioCodigo,
        paisNegocioNombre,
        departamentoNegocioCodigo,
        departamentoNegocioNombre,
        municipioNegocioCodigo,
        municipioNegocioNombre,
        aldeaNegocioCodigo,
        aldeaNegocioNombre,
        condicionNegocioCodigo,
        condicionNegocioNombre,
        telefonoNegocio,
        celularNegocio,
        tiempoFuncionamientoNegocio,
        puestoNegocio,
        horarioTrabajo,
        experiencia,
        horarioVisita,
        ingresosNetos,
        grupoCicloId,
        cicloEstadoNombre,
        cicloEstadoCodigo,
        grupoNombre,
        grupoCodigo,
        nombre3,
        apellido3,
        nacionalidad2Codigo,
        nacionalidad3Codigo,
        nacionalidad2Nombre,
        nacionalidad3Nombre,
        tipoPersonaCNBSCodigo,
        tipoPersonaCNBSNombre,
        cargoGrupoCodigo,
        cargoGrupoNombre,
        otrosIngresosConyugue,
        ingresoMensualConyuge,
        aniosLugarTrabajoConyuge,
        medidasConocimientoCodigo,
        medidasConocimientoNombre,
        paisTrabajoCodigo,
        paisTrabajoNombre,
        departamentoTrabajoCodigo,
        departamentoTrabajoNombre,
        municipioTrabajoCodigo,
        municipioTrabajoNombre,
        aldeaTrabajoCodigo,
        aldeaTrabajoNombre,
        caserioTrabajo,
        otrosIngresos,
        salarioNetoMensual,
        salarioNetoMensualConyuge,
        telefonoConyuge,
        cedulaConyuge,
      ];

  UpdateSolicitudNuevaMenorState copyWith({
    Status? status,
    Status? updateStatus,
    String? errorMsg,
    String? id,
    String? origenSolicitudCodigo,
    String? origenSolicitudNombre,
    String? nombre1,
    String? nombre2,
    String? apellido1,
    String? apellido2,
    String? cedula,
    String? paisEmisorCedulaCodigo,
    String? paisEmisorCedulaNombre,
    String? tipoDocumentoCodigo,
    String? tipoDocumentoNombre,
    String? tipoDocumentoConyugeCodigo,
    String? tipoDocumentoConyugeNombre,
    String? nombrePublico,
    String? fechaEmisionCedula,
    String? fechaVencimientoCedula,
    String? fechaNacimiento,
    String? telefono,
    String? celular,
    String? direccionCasa,
    String? barrioCasa,
    String? municipioCasaCodigo,
    String? municipioCasaNombre,
    String? departamentoCasaCodigo,
    String? departamentoCasaNombre,
    String? paisCasaCodigo,
    String? paisCasaNombre,
    String? nacionalidad,
    String? condicionCasaCodigo,
    String? condicionCasaNombre,
    int? anosResidirCasa,
    String? email,
    int? monto,
    String? monedaCodigo,
    String? monedaNombre,
    String? propositoCodigo,
    String? propositoNombre,
    String? descripcionDestino,
    String? frecuenciaCodigo,
    String? frecuenciaNombre,
    int? cuota,
    String? sectorCodigo,
    String? sectorNombre,
    int? personasACargo,
    String? estadoCivilCodigo,
    String? estadoCivilNombre,
    String? nombreConyugue,
    bool? trabajaConyugue,
    String? trabajoConyugue,
    String? direccionTrabajoConyugue,
    String? telefonoTrabajoConyugue,
    String? productoCodigo,
    String? productoNombre,
    String? observacion,
    String? ubicacionLongitud,
    String? ubicacionLatitud,
    String? escolaridadCodigo,
    String? escolaridadNombre,
    int? cantidadHijos,
    String? sexoCodigo,
    String? sexoNombre,
    String? paisNacimientoCodigo,
    String? paisNacimientoNombre,
    String? nacionalidadConyugue,
    String? ubicacion,
    bool? esPeps,
    String? nombreDeEntidadPeps,
    String? paisPeps,
    String? periodoPeps,
    String? cargoOficialPeps,
    bool? tieneFamiliarPeps,
    String? nombreFamiliarPeps2,
    String? parentescoFamiliarPeps2Codigo,
    String? parentescoFamiliarPeps2Nombre,
    String? cargoFamiliarPeps2,
    String? nombreEntidadPeps2,
    String? periodoPeps2,
    String? paisPeps2,
    String? actividadPredominanteCodigo,
    String? actividadPredominanteNombre,
    bool? esFamiliarEmpleado,
    String? nombreFamiliar,
    String? cedulaFamiliar,
    String? tipoPersonaCodigo,
    String? tipoPersonaNombre,
    int? plazoSolicitud,
    String? fechaPrimerPagoSolicitud,
    String? rtn,
    String? codigoUsa,
    String? tipoClienteCodigo,
    String? tipoClienteNombre,
    String? actividadEconomicaCiuu1Codigo,
    String? actividadEconomicaCiuu1Nombre,
    String? actividadEconomicaCiuu2Codigo,
    String? actividadEconomicaCiuu2Nombre,
    String? actividadEconomicaCiuu3Codigo,
    String? actividadEconomicaCiuu3Nombre,
    String? ocupacionCodigo,
    String? ocupacionNombre,
    String? profesionCodigo,
    String? profesionNombre,
    String? actividadEconomicaDescripcion1,
    String? actividadEconomicaDescripcion2,
    String? actividadEconomicaDescripcion3,
    bool? ejerceApnfd,
    bool? esApnfd,
    String? paisDestinoCodigo,
    String? paisDestinoNombre,
    String? departamentoDestinoCodigo,
    String? departamentoDestinoNombre,
    String? municipioDestinoCodigo,
    String? municipioDestinoNombre,
    String? aldeaDestinoCodigo,
    String? aldeaDestinoNombre,
    String? caserioDestino,
    String? barrioDestino,
    String? caserioCasa,
    String? aldeaCodigo,
    String? aldeaNombre,
    String? nombreNegocio,
    String? direccionNegocio,
    String? barrioNegocio,
    String? caserioNegocio,
    String? paisNegocioCodigo,
    String? paisNegocioNombre,
    String? departamentoNegocioCodigo,
    String? departamentoNegocioNombre,
    String? municipioNegocioCodigo,
    String? municipioNegocioNombre,
    String? aldeaNegocioCodigo,
    String? aldeaNegocioNombre,
    String? condicionNegocioCodigo,
    String? condicionNegocioNombre,
    String? telefonoNegocio,
    String? celularNegocio,
    String? tiempoFuncionamientoNegocio,
    String? puestoNegocio,
    String? horarioTrabajo,
    String? experiencia,
    String? horarioVisita,
    int? ingresosNetos,
    int? grupoCicloId,
    String? cicloEstadoNombre,
    String? cicloEstadoCodigo,
    String? grupoNombre,
    String? grupoCodigo,
    String? nombre3,
    String? apellido3,
    String? nacionalidad2Codigo,
    String? nacionalidad3Codigo,
    String? nacionalidad2Nombre,
    String? nacionalidad3Nombre,
    String? tipoPersonaCNBSCodigo,
    String? tipoPersonaCNBSNombre,
    String? cargoGrupoCodigo,
    String? cargoGrupoNombre,
    String? actividadDescripcionConyuge,
    String? documentoConyuge,
    String? cargo,
    String? direccionTrabajo,
    String? barrioTrabajo,
    String? telefonoTrabajo,
    String? tiempoLaboral,
    String? lugarTrabajoAnterior,
    int? salarioNetoCordoba,
    int? totalIngresoMes,
    String? fuenteOtrosIngresos,
    String? nombreTrabajo,
    int? otrosIngresosCordoba,
    String? tiempoLaborarConyugue,
    String? profesionConyugue,
    int? sueldoMesConyugue,
    int? otrosIngresosConyugue,
    String? fuenteOtrosIngresosConyugue,
    String? nombreFamiliarCercano,
    String? direccionFamiliarCercano,
    String? telefonoFamiliarCercano,
    List<HistorialCredito>? historialCredito,
    double? ingresoMensualConyuge,
    int? aniosLugarTrabajoConyuge,
    String? medidasConocimientoCodigo,
    String? medidasConocimientoNombre,
    String? paisTrabajoCodigo,
    String? paisTrabajoNombre,
    String? departamentoTrabajoCodigo,
    String? departamentoTrabajoNombre,
    String? municipioTrabajoCodigo,
    String? municipioTrabajoNombre,
    String? aldeaTrabajoCodigo,
    String? aldeaTrabajoNombre,
    String? caserioTrabajo,
    double? otrosIngresos,
    double? salarioNetoMensual,
    double? salarioNetoMensualConyuge,
    String? telefonoConyuge,
    String? cedulaConyuge,
  }) {
    return UpdateSolicitudNuevaMenorState(
      status: status ?? this.status,
      updateStatus: updateStatus ?? this.updateStatus,
      errorMsg: errorMsg ?? this.errorMsg,
      id: id ?? this.id,
      origenSolicitudCodigo:
          origenSolicitudCodigo ?? this.origenSolicitudCodigo,
      origenSolicitudNombre:
          origenSolicitudNombre ?? this.origenSolicitudNombre,
      nombre1: nombre1 ?? this.nombre1,
      nombre2: nombre2 ?? this.nombre2,
      apellido1: apellido1 ?? this.apellido1,
      apellido2: apellido2 ?? this.apellido2,
      cedula: cedula ?? this.cedula,
      paisEmisorCedulaCodigo:
          paisEmisorCedulaCodigo ?? this.paisEmisorCedulaCodigo,
      paisEmisorCedulaNombre:
          paisEmisorCedulaNombre ?? this.paisEmisorCedulaNombre,
      tipoDocumentoCodigo: tipoDocumentoCodigo ?? this.tipoDocumentoCodigo,
      tipoDocumentoNombre: tipoDocumentoNombre ?? this.tipoDocumentoNombre,
      tipoDocumentoConyugeCodigo:
          tipoDocumentoConyugeCodigo ?? this.tipoDocumentoConyugeCodigo,
      tipoDocumentoConyugeNombre:
          tipoDocumentoConyugeNombre ?? this.tipoDocumentoConyugeNombre,
      nombrePublico: nombrePublico ?? this.nombrePublico,
      fechaEmisionCedula: fechaEmisionCedula ?? this.fechaEmisionCedula,
      fechaVencimientoCedula:
          fechaVencimientoCedula ?? this.fechaVencimientoCedula,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      telefono: telefono ?? this.telefono,
      celular: celular ?? this.celular,
      direccionCasa: direccionCasa ?? this.direccionCasa,
      barrioCasa: barrioCasa ?? this.barrioCasa,
      municipioCasaCodigo: municipioCasaCodigo ?? this.municipioCasaCodigo,
      municipioCasaNombre: municipioCasaNombre ?? this.municipioCasaNombre,
      departamentoCasaCodigo:
          departamentoCasaCodigo ?? this.departamentoCasaCodigo,
      departamentoCasaNombre:
          departamentoCasaNombre ?? this.departamentoCasaNombre,
      paisCasaCodigo: paisCasaCodigo ?? this.paisCasaCodigo,
      paisCasaNombre: paisCasaNombre ?? this.paisCasaNombre,
      nacionalidad: nacionalidad ?? this.nacionalidad,
      condicionCasaCodigo: condicionCasaCodigo ?? this.condicionCasaCodigo,
      condicionCasaNombre: condicionCasaNombre ?? this.condicionCasaNombre,
      anosResidirCasa: anosResidirCasa ?? this.anosResidirCasa,
      email: email ?? this.email,
      monto: monto ?? this.monto,
      monedaCodigo: monedaCodigo ?? this.monedaCodigo,
      monedaNombre: monedaNombre ?? this.monedaNombre,
      propositoCodigo: propositoCodigo ?? this.propositoCodigo,
      propositoNombre: propositoNombre ?? this.propositoNombre,
      descripcionDestino: descripcionDestino ?? this.descripcionDestino,
      frecuenciaCodigo: frecuenciaCodigo ?? this.frecuenciaCodigo,
      frecuenciaNombre: frecuenciaNombre ?? this.frecuenciaNombre,
      cuota: cuota ?? this.cuota,
      sectorCodigo: sectorCodigo ?? this.sectorCodigo,
      sectorNombre: sectorNombre ?? this.sectorNombre,
      personasACargo: personasACargo ?? this.personasACargo,
      estadoCivilCodigo: estadoCivilCodigo ?? this.estadoCivilCodigo,
      estadoCivilNombre: estadoCivilNombre ?? this.estadoCivilNombre,
      nombreConyugue: nombreConyugue ?? this.nombreConyugue,
      trabajaConyugue: trabajaConyugue ?? this.trabajaConyugue,
      trabajoConyugue: trabajoConyugue ?? this.trabajoConyugue,
      direccionTrabajoConyugue:
          direccionTrabajoConyugue ?? this.direccionTrabajoConyugue,
      telefonoTrabajoConyugue:
          telefonoTrabajoConyugue ?? this.telefonoTrabajoConyugue,
      productoCodigo: productoCodigo ?? this.productoCodigo,
      productoNombre: productoNombre ?? this.productoNombre,
      observacion: observacion ?? this.observacion,
      ubicacionLongitud: ubicacionLongitud ?? this.ubicacionLongitud,
      ubicacionLatitud: ubicacionLatitud ?? this.ubicacionLatitud,
      escolaridadCodigo: escolaridadCodigo ?? this.escolaridadCodigo,
      escolaridadNombre: escolaridadNombre ?? this.escolaridadNombre,
      cantidadHijos: cantidadHijos ?? this.cantidadHijos,
      sexoCodigo: sexoCodigo ?? this.sexoCodigo,
      sexoNombre: sexoNombre ?? this.sexoNombre,
      paisNacimientoCodigo: paisNacimientoCodigo ?? this.paisNacimientoCodigo,
      paisNacimientoNombre: paisNacimientoNombre ?? this.paisNacimientoNombre,
      nacionalidadConyugue: nacionalidadConyugue ?? this.nacionalidadConyugue,
      ubicacion: ubicacion ?? this.ubicacion,
      esPeps: esPeps ?? this.esPeps,
      nombreDeEntidadPeps: nombreDeEntidadPeps ?? this.nombreDeEntidadPeps,
      paisPeps: paisPeps ?? this.paisPeps,
      periodoPeps: periodoPeps ?? this.periodoPeps,
      cargoOficialPeps: cargoOficialPeps ?? this.cargoOficialPeps,
      tieneFamiliarPeps: tieneFamiliarPeps ?? this.tieneFamiliarPeps,
      nombreFamiliarPeps2: nombreFamiliarPeps2 ?? this.nombreFamiliarPeps2,
      parentescoFamiliarPeps2Codigo:
          parentescoFamiliarPeps2Codigo ?? this.parentescoFamiliarPeps2Codigo,
      parentescoFamiliarPeps2Nombre:
          parentescoFamiliarPeps2Nombre ?? this.parentescoFamiliarPeps2Nombre,
      cargoFamiliarPeps2: cargoFamiliarPeps2 ?? this.cargoFamiliarPeps2,
      nombreEntidadPeps2: nombreEntidadPeps2 ?? this.nombreEntidadPeps2,
      periodoPeps2: periodoPeps2 ?? this.periodoPeps2,
      paisPeps2: paisPeps2 ?? this.paisPeps2,
      actividadPredominanteCodigo:
          actividadPredominanteCodigo ?? this.actividadPredominanteCodigo,
      actividadPredominanteNombre:
          actividadPredominanteNombre ?? this.actividadPredominanteNombre,
      esFamiliarEmpleado: esFamiliarEmpleado ?? this.esFamiliarEmpleado,
      nombreFamiliar: nombreFamiliar ?? this.nombreFamiliar,
      cedulaFamiliar: cedulaFamiliar ?? this.cedulaFamiliar,
      tipoPersonaCodigo: tipoPersonaCodigo ?? this.tipoPersonaCodigo,
      tipoPersonaNombre: tipoPersonaNombre ?? this.tipoPersonaNombre,
      plazoSolicitud: plazoSolicitud ?? this.plazoSolicitud,
      fechaPrimerPagoSolicitud:
          fechaPrimerPagoSolicitud ?? this.fechaPrimerPagoSolicitud,
      rtn: rtn ?? this.rtn,
      codigoUsa: codigoUsa ?? this.codigoUsa,
      tipoClienteCodigo: tipoClienteCodigo ?? this.tipoClienteCodigo,
      tipoClienteNombre: tipoClienteNombre ?? this.tipoClienteNombre,
      actividadEconomicaCiuu1Codigo:
          actividadEconomicaCiuu1Codigo ?? this.actividadEconomicaCiuu1Codigo,
      actividadEconomicaCiuu1Nombre:
          actividadEconomicaCiuu1Nombre ?? this.actividadEconomicaCiuu1Nombre,
      actividadEconomicaCiuu2Codigo:
          actividadEconomicaCiuu2Codigo ?? this.actividadEconomicaCiuu2Codigo,
      actividadEconomicaCiuu2Nombre:
          actividadEconomicaCiuu2Nombre ?? this.actividadEconomicaCiuu2Nombre,
      actividadEconomicaCiuu3Codigo:
          actividadEconomicaCiuu3Codigo ?? this.actividadEconomicaCiuu3Codigo,
      actividadEconomicaCiuu3Nombre:
          actividadEconomicaCiuu3Nombre ?? this.actividadEconomicaCiuu3Nombre,
      ocupacionCodigo: ocupacionCodigo ?? this.ocupacionCodigo,
      ocupacionNombre: ocupacionNombre ?? this.ocupacionNombre,
      profesionCodigo: profesionCodigo ?? this.profesionCodigo,
      profesionNombre: profesionNombre ?? this.profesionNombre,
      actividadEconomicaDescripcion1:
          actividadEconomicaDescripcion1 ?? this.actividadEconomicaDescripcion1,
      actividadEconomicaDescripcion2:
          actividadEconomicaDescripcion2 ?? this.actividadEconomicaDescripcion2,
      actividadEconomicaDescripcion3:
          actividadEconomicaDescripcion3 ?? this.actividadEconomicaDescripcion3,
      ejerceApnfd: ejerceApnfd ?? this.ejerceApnfd,
      esApnfd: esApnfd ?? this.esApnfd,
      paisDestinoCodigo: paisDestinoCodigo ?? this.paisDestinoCodigo,
      paisDestinoNombre: paisDestinoNombre ?? this.paisDestinoNombre,
      departamentoDestinoCodigo:
          departamentoDestinoCodigo ?? this.departamentoDestinoCodigo,
      departamentoDestinoNombre:
          departamentoDestinoNombre ?? this.departamentoDestinoNombre,
      municipioDestinoCodigo:
          municipioDestinoCodigo ?? this.municipioDestinoCodigo,
      municipioDestinoNombre:
          municipioDestinoNombre ?? this.municipioDestinoNombre,
      aldeaDestinoCodigo: aldeaDestinoCodigo ?? this.aldeaDestinoCodigo,
      aldeaDestinoNombre: aldeaDestinoNombre ?? this.aldeaDestinoNombre,
      caserioDestino: caserioDestino ?? this.caserioDestino,
      barrioDestino: barrioDestino ?? this.barrioDestino,
      caserioCasa: caserioCasa ?? this.caserioCasa,
      aldeaCodigo: aldeaCodigo ?? this.aldeaCodigo,
      aldeaNombre: aldeaNombre ?? this.aldeaNombre,
      nombreNegocio: nombreNegocio ?? this.nombreNegocio,
      direccionNegocio: direccionNegocio ?? this.direccionNegocio,
      barrioNegocio: barrioNegocio ?? this.barrioNegocio,
      caserioNegocio: caserioNegocio ?? this.caserioNegocio,
      paisNegocioCodigo: paisNegocioCodigo ?? this.paisNegocioCodigo,
      paisNegocioNombre: paisNegocioNombre ?? this.paisNegocioNombre,
      departamentoNegocioCodigo:
          departamentoNegocioCodigo ?? this.departamentoNegocioCodigo,
      departamentoNegocioNombre:
          departamentoNegocioNombre ?? this.departamentoNegocioNombre,
      municipioNegocioCodigo:
          municipioNegocioCodigo ?? this.municipioNegocioCodigo,
      municipioNegocioNombre:
          municipioNegocioNombre ?? this.municipioNegocioNombre,
      aldeaNegocioCodigo: aldeaNegocioCodigo ?? this.aldeaNegocioCodigo,
      aldeaNegocioNombre: aldeaNegocioNombre ?? this.aldeaNegocioNombre,
      condicionNegocioCodigo:
          condicionNegocioCodigo ?? this.condicionNegocioCodigo,
      condicionNegocioNombre:
          condicionNegocioNombre ?? this.condicionNegocioNombre,
      telefonoNegocio: telefonoNegocio ?? this.telefonoNegocio,
      celularNegocio: celularNegocio ?? this.celularNegocio,
      tiempoFuncionamientoNegocio:
          tiempoFuncionamientoNegocio ?? this.tiempoFuncionamientoNegocio,
      puestoNegocio: puestoNegocio ?? this.puestoNegocio,
      horarioTrabajo: horarioTrabajo ?? this.horarioTrabajo,
      experiencia: experiencia ?? this.experiencia,
      horarioVisita: horarioVisita ?? this.horarioVisita,
      ingresosNetos: ingresosNetos ?? this.ingresosNetos,
      grupoCicloId: grupoCicloId ?? this.grupoCicloId,
      cicloEstadoNombre: cicloEstadoNombre ?? this.cicloEstadoNombre,
      cicloEstadoCodigo: cicloEstadoCodigo ?? this.cicloEstadoCodigo,
      grupoNombre: grupoNombre ?? this.grupoNombre,
      grupoCodigo: grupoCodigo ?? this.grupoCodigo,
      nombre3: nombre3 ?? this.nombre3,
      apellido3: apellido3 ?? this.apellido3,
      nacionalidad2Codigo: nacionalidad2Codigo ?? this.nacionalidad2Codigo,
      nacionalidad3Codigo: nacionalidad3Codigo ?? this.nacionalidad3Codigo,
      nacionalidad2Nombre: nacionalidad2Nombre ?? this.nacionalidad2Nombre,
      nacionalidad3Nombre: nacionalidad3Nombre ?? this.nacionalidad3Nombre,
      tipoPersonaCNBSCodigo:
          tipoPersonaCNBSCodigo ?? this.tipoPersonaCNBSCodigo,
      tipoPersonaCNBSNombre:
          tipoPersonaCNBSNombre ?? this.tipoPersonaCNBSNombre,
      cargoGrupoCodigo: cargoGrupoCodigo ?? this.cargoGrupoCodigo,
      cargoGrupoNombre: cargoGrupoNombre ?? this.cargoGrupoNombre,
      actividadDescripcionConyuge:
          actividadDescripcionConyuge ?? this.actividadDescripcionConyuge,
      documentoConyuge: documentoConyuge ?? this.documentoConyuge,
      cargo: cargo ?? this.cargo,
      direccionTrabajo: direccionTrabajo ?? this.direccionTrabajo,
      barrioTrabajo: barrioTrabajo ?? this.barrioTrabajo,
      telefonoTrabajo: telefonoTrabajo ?? this.telefonoTrabajo,
      tiempoLaboral: tiempoLaboral ?? this.tiempoLaboral,
      lugarTrabajoAnterior: lugarTrabajoAnterior ?? this.lugarTrabajoAnterior,
      salarioNetoCordoba: salarioNetoCordoba ?? this.salarioNetoCordoba,
      totalIngresoMes: totalIngresoMes ?? this.totalIngresoMes,
      fuenteOtrosIngresos: fuenteOtrosIngresos ?? this.fuenteOtrosIngresos,
      nombreTrabajo: nombreTrabajo ?? this.nombreTrabajo,
      otrosIngresosCordoba: otrosIngresosCordoba ?? this.otrosIngresosCordoba,
      tiempoLaborarConyugue:
          tiempoLaborarConyugue ?? this.tiempoLaborarConyugue,
      profesionConyugue: profesionConyugue ?? this.profesionConyugue,
      sueldoMesConyugue: sueldoMesConyugue ?? this.sueldoMesConyugue,
      otrosIngresosConyugue:
          otrosIngresosConyugue ?? this.otrosIngresosConyugue,
      fuenteOtrosIngresosConyugue:
          fuenteOtrosIngresosConyugue ?? this.fuenteOtrosIngresosConyugue,
      nombreFamiliarCercano:
          nombreFamiliarCercano ?? this.nombreFamiliarCercano,
      direccionFamiliarCercano:
          direccionFamiliarCercano ?? this.direccionFamiliarCercano,
      telefonoFamiliarCercano:
          telefonoFamiliarCercano ?? this.telefonoFamiliarCercano,
      historialCredito: historialCredito ?? this.historialCredito,
      ingresoMensualConyuge:
          ingresoMensualConyuge ?? this.ingresoMensualConyuge,
      aniosLugarTrabajoConyuge:
          aniosLugarTrabajoConyuge ?? this.aniosLugarTrabajoConyuge,
      medidasConocimientoCodigo:
          medidasConocimientoCodigo ?? this.medidasConocimientoCodigo,
      medidasConocimientoNombre:
          medidasConocimientoNombre ?? this.medidasConocimientoNombre,
      paisTrabajoCodigo: paisTrabajoCodigo ?? this.paisTrabajoCodigo,
      paisTrabajoNombre: paisTrabajoNombre ?? this.paisTrabajoNombre,
      departamentoTrabajoCodigo:
          departamentoTrabajoCodigo ?? this.departamentoTrabajoCodigo,
      departamentoTrabajoNombre:
          departamentoTrabajoNombre ?? this.departamentoTrabajoNombre,
      municipioTrabajoCodigo:
          municipioTrabajoCodigo ?? this.municipioTrabajoCodigo,
      municipioTrabajoNombre:
          municipioTrabajoNombre ?? this.municipioTrabajoNombre,
      aldeaTrabajoCodigo: aldeaTrabajoCodigo ?? this.aldeaTrabajoCodigo,
      aldeaTrabajoNombre: aldeaTrabajoNombre ?? this.aldeaTrabajoNombre,
      caserioTrabajo: caserioTrabajo ?? this.caserioTrabajo,
      otrosIngresos: otrosIngresos ?? this.otrosIngresos,
      salarioNetoMensual: salarioNetoMensual ?? this.salarioNetoMensual,
      salarioNetoMensualConyuge:
          salarioNetoMensualConyuge ?? this.salarioNetoMensualConyuge,
      telefonoConyuge: telefonoConyuge ?? this.telefonoConyuge,
      cedulaConyuge: cedulaConyuge ?? this.cedulaConyuge,
    );
  }
}

final class UpdateSolicitudNuevaMenorInitial
    extends UpdateSolicitudNuevaMenorState {}

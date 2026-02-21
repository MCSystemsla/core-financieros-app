// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitud_aslariado_hn_cubit.dart';

class SolicitudAslariadoHnState extends Equatable {
  final String idSolicitud;
  final String frecuenciaMeses;
  final double tasaInteres;
  final String fechaDesembolso;
  final bool isDone;
  final String tieneVinculosUsa;
  final String imagenFrontal;
  final String imagenTrasera;
  final String numeroSolicitud;
  final String? uuid;
  final int? idLocalResponse;
  final String errorMsg;
  final Status status;
  final String database;
  final bool isOffline;
  final String origenSolicitudCodigo;
  final String nombre1;
  final String nombre2;
  final String apellido1;
  final String apellido2;
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
  final String trabajaConyugue;
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
  final String espeps;
  final String nombreDeEntidadPeps;
  final String paisPeps;
  final String periodoPeps;
  final String cargoOficialPeps;
  final String tieneFamiliarPeps;
  final String nombreFamiliarPeps2;
  final String parentescoFamiliarPeps2;
  final String cargoFamiliarPeps2;
  final String nombreEntidadPeps2;
  final String periodoPeps2;
  final String paisPeps2;
  final String actividadPredominanteCodigo;
  final String esFamiliarEmpleado;
  final String nombreFamiliar;
  final String cedulaFamiliar;
  final String tipoDocumentoCodigo;
  final String tipoPersonaCodigo;
  final int plazoSolicitud;
  final String fechaPrimerPagoSolicitud;
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
  final String descripcionDestino;
  final List<HistorialCredito> historialCredito;
  final String cedulaConyuge;
  final String tipoDocumentoConyugeCodigo;
  final double cuotaWithDecimal;
  const SolicitudAslariadoHnState({
    this.cuotaWithDecimal = 0,
    this.idSolicitud = '',
    this.frecuenciaMeses = '',
    this.tasaInteres = 0,
    this.fechaDesembolso = '',
    this.isDone = false,
    this.tieneVinculosUsa = '',
    this.imagenFrontal = '',
    this.imagenTrasera = '',
    this.numeroSolicitud = '',
    this.uuid = '',
    this.idLocalResponse = 0,
    this.errorMsg = '',
    this.status = Status.notStarted,
    this.database = '',
    this.isOffline = false,
    this.origenSolicitudCodigo = '',
    this.nombre1 = '',
    this.nombre2 = '',
    this.apellido1 = '',
    this.apellido2 = '',
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
    this.nacinalidad = '',
    this.condicionCasaCodigo = '',
    this.anosResidirCasa = 0,
    this.email = '',
    this.monto = 0,
    this.monedaCodigo = '',
    this.propositoCodigo = '',
    this.frecuenciaCodigo = '',
    this.cuota = 0,
    this.sectorCodigo = '',
    this.personasACargo = 0,
    this.estadoCivilCodigo = '',
    this.nombreConyugue = '',
    this.trabajaConyugue = '',
    this.trabajoConyugue = '',
    this.direccionTrabajoConyugue = '',
    this.telefonoTrabajoConyugue = '',
    this.productoCodigo = '',
    this.observacion = '',
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
    this.parentescoFamiliarPeps2 = '',
    this.cargoFamiliarPeps2 = '',
    this.nombreEntidadPeps2 = '',
    this.periodoPeps2 = '',
    this.paisPeps2 = '',
    this.actividadPredominanteCodigo = '',
    this.esFamiliarEmpleado = '',
    this.nombreFamiliar = '',
    this.cedulaFamiliar = '',
    this.tipoDocumentoCodigo = '',
    this.tipoPersonaCodigo = '',
    this.plazoSolicitud = 0,
    this.fechaPrimerPagoSolicitud = '',
    this.nombreTrabajo = '',
    this.direccionTrabajo = '',
    this.barrioTrabajo = '',
    this.cargo = '',
    this.direccionFamiliarCercano = '',
    this.fuenteOtrosIngresos = '',
    this.fuenteOtrosIngresosConyugue = '',
    this.lugarTrabajoAnterior = '',
    this.nombreFamiliarCercano = '',
    this.parentescoFamiliarCercanoCodigo = '',
    this.otrosIngresosConyugue = 0,
    this.otrosIngresosCordoba = 0,
    this.profesionConyugue = '',
    this.salarioNetoCordoba = 0,
    this.sueldoMesConyugue = 0,
    this.telefonoFamiliarCercano = '',
    this.telefonoTrabajo = '',
    this.tiempoLaborar = '',
    this.tiempoLaborarConyugue = '',
    this.totalIngresoMes = 0,
    this.totalIngresoMesConyugue = 0,
    this.rtn = '',
    this.codigoUsa = '',
    this.tipoPersonaCnbsidCodigo = '',
    this.estatusClienteCodigo = '',
    this.tipoClienteCodigo = '',
    this.actividadEconomicaCiuu1Codigo = '',
    this.actividadEconomicaCiuu2Codigo = '',
    this.actividadEconomicaCiuu3Codigo = '',
    this.nivelAproximadoDeIngresosCodigo = '',
    this.ocupacionCodigo = '',
    this.profesionCodigo = '',
    this.actividadEconomicaDescripcion1 = '',
    this.actividadEconomicaDescripcion2 = '',
    this.actividadEconomicaDescripcion3 = '',
    this.ejerceApnfd = '',
    this.esApnfd = '',
    this.paisDestinoCodigo = '',
    this.departamentoDestinoCodigo = '',
    this.municipioDestinoId = '',
    this.aldeaDestinoCodigo = '',
    this.caserioDestino = '',
    this.barrioDestino = '',
    this.caseriCasa = '',
    this.aldeaCodigo = '',
    this.descripcionDestino = '',
    this.historialCredito = const [],
    this.cedulaConyuge = '',
    this.tipoDocumentoConyugeCodigo = '',
  });

  @override
  List<Object> get props => [
        cuotaWithDecimal,
        idSolicitud,
        historialCredito,
        frecuenciaMeses,
        tasaInteres,
        fechaDesembolso,
        isDone,
        tieneVinculosUsa,
        descripcionDestino,
        imagenFrontal,
        imagenTrasera,
        numeroSolicitud,
        errorMsg,
        status,
        isOffline,
        origenSolicitudCodigo,
        nombre1,
        nombre2,
        apellido1,
        apellido2,
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
        nacinalidad,
        condicionCasaCodigo,
        anosResidirCasa,
        email,
        monto,
        monedaCodigo,
        propositoCodigo,
        frecuenciaCodigo,
        cuota,
        sectorCodigo,
        personasACargo,
        estadoCivilCodigo,
        nombreConyugue,
        trabajaConyugue,
        trabajoConyugue,
        direccionTrabajoConyugue,
        telefonoTrabajoConyugue,
        productoCodigo,
        observacion,
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
        parentescoFamiliarPeps2,
        cargoFamiliarPeps2,
        nombreEntidadPeps2,
        periodoPeps2,
        paisPeps2,
        actividadPredominanteCodigo,
        esFamiliarEmpleado,
        nombreFamiliar,
        cedulaFamiliar,
        tipoDocumentoCodigo,
        tipoPersonaCodigo,
        plazoSolicitud,
        fechaPrimerPagoSolicitud,
        nombreTrabajo,
        direccionTrabajo,
        barrioTrabajo,
        cargo,
        direccionFamiliarCercano,
        fuenteOtrosIngresos,
        fuenteOtrosIngresosConyugue,
        lugarTrabajoAnterior,
        nombreFamiliarCercano,
        parentescoFamiliarCercanoCodigo,
        otrosIngresosConyugue,
        otrosIngresosCordoba,
        profesionConyugue,
        salarioNetoCordoba,
        sueldoMesConyugue,
        telefonoFamiliarCercano,
        telefonoTrabajo,
        tiempoLaborar,
        tiempoLaborarConyugue,
        totalIngresoMes,
        totalIngresoMesConyugue,
        rtn,
        codigoUsa,
        tipoPersonaCnbsidCodigo,
        estatusClienteCodigo,
        tipoClienteCodigo,
        actividadEconomicaCiuu1Codigo,
        actividadEconomicaCiuu2Codigo,
        actividadEconomicaCiuu3Codigo,
        nivelAproximadoDeIngresosCodigo,
        ocupacionCodigo,
        profesionCodigo,
        actividadEconomicaDescripcion1,
        actividadEconomicaDescripcion2,
        actividadEconomicaDescripcion3,
        ejerceApnfd,
        esApnfd,
        paisDestinoCodigo,
        departamentoDestinoCodigo,
        municipioDestinoId,
        aldeaDestinoCodigo,
        caserioDestino,
        barrioDestino,
        caseriCasa,
        aldeaCodigo,
        cedulaConyuge,
        tipoDocumentoConyugeCodigo,
      ];

  SolicitudAslariadoHnState copyWith({
    String? idSolicitud,
    String? frecuenciaMeses,
    double? tasaInteres,
    String? fechaDesembolso,
    bool? isDone,
    String? tieneVinculosUsa,
    String? imagenFrontal,
    String? imagenTrasera,
    String? numeroSolicitud,
    String? uuid,
    int? idLocalResponse,
    String? errorMsg,
    Status? status,
    String? database,
    bool? isOffline,
    String? origenSolicitudCodigo,
    String? nombre1,
    String? nombre2,
    String? apellido1,
    String? apellido2,
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
    String? nacinalidad,
    String? condicionCasaCodigo,
    int? anosResidirCasa,
    String? email,
    int? monto,
    String? monedaCodigo,
    String? propositoCodigo,
    String? frecuenciaCodigo,
    int? cuota,
    String? sectorCodigo,
    int? personasACargo,
    String? estadoCivilCodigo,
    String? nombreConyugue,
    String? trabajaConyugue,
    String? trabajoConyugue,
    String? direccionTrabajoConyugue,
    String? telefonoTrabajoConyugue,
    String? productoCodigo,
    String? observacion,
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
    String? parentescoFamiliarPeps2,
    String? cargoFamiliarPeps2,
    String? nombreEntidadPeps2,
    String? periodoPeps2,
    String? paisPeps2,
    String? actividadPredominanteCodigo,
    String? esFamiliarEmpleado,
    String? nombreFamiliar,
    String? cedulaFamiliar,
    String? tipoDocumentoCodigo,
    String? tipoPersonaCodigo,
    int? plazoSolicitud,
    String? fechaPrimerPagoSolicitud,
    String? nombreTrabajo,
    String? direccionTrabajo,
    String? barrioTrabajo,
    String? cargo,
    String? direccionFamiliarCercano,
    String? fuenteOtrosIngresos,
    String? fuenteOtrosIngresosConyugue,
    String? lugarTrabajoAnterior,
    String? nombreFamiliarCercano,
    String? parentescoFamiliarCercanoCodigo,
    int? otrosIngresosConyugue,
    int? otrosIngresosCordoba,
    String? profesionConyugue,
    int? salarioNetoCordoba,
    int? sueldoMesConyugue,
    String? telefonoFamiliarCercano,
    String? telefonoTrabajo,
    String? tiempoLaborar,
    String? tiempoLaborarConyugue,
    int? totalIngresoMes,
    int? totalIngresoMesConyugue,
    String? rtn,
    String? codigoUsa,
    String? tipoPersonaCnbsidCodigo,
    String? estatusClienteCodigo,
    String? tipoClienteCodigo,
    String? actividadEconomicaCiuu1Codigo,
    String? actividadEconomicaCiuu2Codigo,
    String? actividadEconomicaCiuu3Codigo,
    String? nivelAproximadoDeIngresosCodigo,
    String? ocupacionCodigo,
    String? profesionCodigo,
    String? actividadEconomicaDescripcion1,
    String? actividadEconomicaDescripcion2,
    String? actividadEconomicaDescripcion3,
    String? ejerceApnfd,
    String? esApnfd,
    String? paisDestinoCodigo,
    String? departamentoDestinoCodigo,
    String? municipioDestinoId,
    String? aldeaDestinoCodigo,
    String? caserioDestino,
    String? barrioDestino,
    String? caseriCasa,
    String? aldeaCodigo,
    String? descripcionDestino,
    List<HistorialCredito>? historialCredito,
    String? cedulaConyuge,
    String? tipoDocumentoConyugeCodigo,
    double? cuotaWithDecimal,
  }) {
    return SolicitudAslariadoHnState(
      idSolicitud: idSolicitud ?? this.idSolicitud,
      frecuenciaMeses: frecuenciaMeses ?? this.frecuenciaMeses,
      tasaInteres: tasaInteres ?? this.tasaInteres,
      fechaDesembolso: fechaDesembolso ?? this.fechaDesembolso,
      isDone: isDone ?? this.isDone,
      tieneVinculosUsa: tieneVinculosUsa ?? this.tieneVinculosUsa,
      imagenFrontal: imagenFrontal ?? this.imagenFrontal,
      imagenTrasera: imagenTrasera ?? this.imagenTrasera,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      uuid: uuid ?? this.uuid,
      idLocalResponse: idLocalResponse ?? this.idLocalResponse,
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
      database: database ?? this.database,
      isOffline: isOffline ?? this.isOffline,
      origenSolicitudCodigo:
          origenSolicitudCodigo ?? this.origenSolicitudCodigo,
      nombre1: nombre1 ?? this.nombre1,
      nombre2: nombre2 ?? this.nombre2,
      apellido1: apellido1 ?? this.apellido1,
      apellido2: apellido2 ?? this.apellido2,
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
      nacinalidad: nacinalidad ?? this.nacinalidad,
      condicionCasaCodigo: condicionCasaCodigo ?? this.condicionCasaCodigo,
      anosResidirCasa: anosResidirCasa ?? this.anosResidirCasa,
      email: email ?? this.email,
      monto: monto ?? this.monto,
      monedaCodigo: monedaCodigo ?? this.monedaCodigo,
      propositoCodigo: propositoCodigo ?? this.propositoCodigo,
      frecuenciaCodigo: frecuenciaCodigo ?? this.frecuenciaCodigo,
      cuota: cuota ?? this.cuota,
      sectorCodigo: sectorCodigo ?? this.sectorCodigo,
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
      parentescoFamiliarPeps2:
          parentescoFamiliarPeps2 ?? this.parentescoFamiliarPeps2,
      cargoFamiliarPeps2: cargoFamiliarPeps2 ?? this.cargoFamiliarPeps2,
      nombreEntidadPeps2: nombreEntidadPeps2 ?? this.nombreEntidadPeps2,
      periodoPeps2: periodoPeps2 ?? this.periodoPeps2,
      paisPeps2: paisPeps2 ?? this.paisPeps2,
      actividadPredominanteCodigo:
          actividadPredominanteCodigo ?? this.actividadPredominanteCodigo,
      esFamiliarEmpleado: esFamiliarEmpleado ?? this.esFamiliarEmpleado,
      nombreFamiliar: nombreFamiliar ?? this.nombreFamiliar,
      cedulaFamiliar: cedulaFamiliar ?? this.cedulaFamiliar,
      tipoDocumentoCodigo: tipoDocumentoCodigo ?? this.tipoDocumentoCodigo,
      tipoPersonaCodigo: tipoPersonaCodigo ?? this.tipoPersonaCodigo,
      plazoSolicitud: plazoSolicitud ?? this.plazoSolicitud,
      fechaPrimerPagoSolicitud:
          fechaPrimerPagoSolicitud ?? this.fechaPrimerPagoSolicitud,
      nombreTrabajo: nombreTrabajo ?? this.nombreTrabajo,
      direccionTrabajo: direccionTrabajo ?? this.direccionTrabajo,
      barrioTrabajo: barrioTrabajo ?? this.barrioTrabajo,
      cargo: cargo ?? this.cargo,
      direccionFamiliarCercano:
          direccionFamiliarCercano ?? this.direccionFamiliarCercano,
      fuenteOtrosIngresos: fuenteOtrosIngresos ?? this.fuenteOtrosIngresos,
      fuenteOtrosIngresosConyugue:
          fuenteOtrosIngresosConyugue ?? this.fuenteOtrosIngresosConyugue,
      lugarTrabajoAnterior: lugarTrabajoAnterior ?? this.lugarTrabajoAnterior,
      nombreFamiliarCercano:
          nombreFamiliarCercano ?? this.nombreFamiliarCercano,
      parentescoFamiliarCercanoCodigo: parentescoFamiliarCercanoCodigo ??
          this.parentescoFamiliarCercanoCodigo,
      otrosIngresosConyugue:
          otrosIngresosConyugue ?? this.otrosIngresosConyugue,
      otrosIngresosCordoba: otrosIngresosCordoba ?? this.otrosIngresosCordoba,
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
      rtn: rtn ?? this.rtn,
      codigoUsa: codigoUsa ?? this.codigoUsa,
      tipoPersonaCnbsidCodigo:
          tipoPersonaCnbsidCodigo ?? this.tipoPersonaCnbsidCodigo,
      estatusClienteCodigo: estatusClienteCodigo ?? this.estatusClienteCodigo,
      tipoClienteCodigo: tipoClienteCodigo ?? this.tipoClienteCodigo,
      actividadEconomicaCiuu1Codigo:
          actividadEconomicaCiuu1Codigo ?? this.actividadEconomicaCiuu1Codigo,
      actividadEconomicaCiuu2Codigo:
          actividadEconomicaCiuu2Codigo ?? this.actividadEconomicaCiuu2Codigo,
      actividadEconomicaCiuu3Codigo:
          actividadEconomicaCiuu3Codigo ?? this.actividadEconomicaCiuu3Codigo,
      nivelAproximadoDeIngresosCodigo: nivelAproximadoDeIngresosCodigo ??
          this.nivelAproximadoDeIngresosCodigo,
      ocupacionCodigo: ocupacionCodigo ?? this.ocupacionCodigo,
      profesionCodigo: profesionCodigo ?? this.profesionCodigo,
      actividadEconomicaDescripcion1:
          actividadEconomicaDescripcion1 ?? this.actividadEconomicaDescripcion1,
      actividadEconomicaDescripcion2:
          actividadEconomicaDescripcion2 ?? this.actividadEconomicaDescripcion2,
      actividadEconomicaDescripcion3:
          actividadEconomicaDescripcion3 ?? this.actividadEconomicaDescripcion3,
      ejerceApnfd: ejerceApnfd ?? this.ejerceApnfd,
      esApnfd: esApnfd ?? this.esApnfd,
      paisDestinoCodigo: paisDestinoCodigo ?? this.paisDestinoCodigo,
      departamentoDestinoCodigo:
          departamentoDestinoCodigo ?? this.departamentoDestinoCodigo,
      municipioDestinoId: municipioDestinoId ?? this.municipioDestinoId,
      aldeaDestinoCodigo: aldeaDestinoCodigo ?? this.aldeaDestinoCodigo,
      caserioDestino: caserioDestino ?? this.caserioDestino,
      barrioDestino: barrioDestino ?? this.barrioDestino,
      caseriCasa: caseriCasa ?? this.caseriCasa,
      aldeaCodigo: aldeaCodigo ?? this.aldeaCodigo,
      descripcionDestino: descripcionDestino ?? this.descripcionDestino,
      historialCredito: historialCredito ?? this.historialCredito,
      cedulaConyuge: cedulaConyuge ?? this.cedulaConyuge,
      tipoDocumentoConyugeCodigo:
          tipoDocumentoConyugeCodigo ?? this.tipoDocumentoConyugeCodigo,
      cuotaWithDecimal: cuotaWithDecimal ?? this.cuotaWithDecimal,
    );
  }
}

final class SolicitudAslariadoHnInitial extends SolicitudAslariadoHnState {}

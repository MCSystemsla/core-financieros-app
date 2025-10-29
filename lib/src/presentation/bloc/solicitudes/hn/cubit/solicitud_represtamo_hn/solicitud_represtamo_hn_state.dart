// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitud_represtamo_hn_cubit.dart';

class SolicitudReprestamoHnState extends Equatable {
  final String cedulaFrontPath;
  final String cedulaBackPath;
  final bool isDone;
  final String frecuenciaPagoMeses;
  final String fechaDesembolso;
  final double tasaInteres;
  final double montoMinimo;
  final double montoMaximo;
  final String descripcionDestino;
  final String nombreCompleto;
  final String errorMsg;
  final int idLocalResponse;
  final String? uuid;
  final Status status;
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
  final String esPeps;
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
  final String tipoDocumentoCodigo;
  final String celularReprestamo;
  final String esFamiliarEmpleado;
  final String nombreFamiliar;
  final String cedulaFamiliar;
  final int plazoSolicitud;
  final String fechaPrimerPagoSolicitud;
  final String tipoPersonaCodigo;
  final String cargaAnalisisAutomatico;
  final String motivoRevisionCodigo;
  final String actividadEconomicaCiuu1;
  final String actividadEconomicaCiuu2;
  final String actividadEconomicaCiuu3;
  final String codigoUsa;
  final String apnfd;
  final String actividadEconomicaRealizaCiuu1;
  final String actividadEconomicaRealizaCiuu2;
  final String actividadEconomicaRealizaCiuu3;
  final String tieneIdentificacionEstadosUnidos;
  final String tieneVinculoEstadosUnidos;
  final String vinculoEstadosUnidosDescripcion;
  final String ejerceActividadApfnd;
  final String medidasConocimientoCodigo;
  final String nombreEmpleadoFamiliar;
  const SolicitudReprestamoHnState({
    this.cedulaFrontPath = '',
    this.cedulaBackPath = '',
    this.isDone = false,
    this.frecuenciaPagoMeses = '',
    this.fechaDesembolso = '',
    this.tasaInteres = 0,
    this.montoMinimo = 0,
    this.montoMaximo = 0,
    this.descripcionDestino = '',
    this.nombreCompleto = '',
    this.errorMsg = '',
    this.idLocalResponse = 0,
    this.uuid,
    this.status = Status.notStarted,
    this.origenSolicitudCodigo = '',
    this.cedula = '',
    this.monto = 0,
    this.monedaCodigo = '',
    this.propositoCodigo = '',
    this.frecuenciaCodigo = '',
    this.cuota = 0,
    this.beneficiarioSeguro = '',
    this.cedulaBeneficiarioSeguro = '',
    this.parentescoBeneficiarioSeguroCodigo = '',
    this.productoCodigo = '',
    this.observacion = '',
    this.ubicacionLongitud = '',
    this.ubicacionLatitud = '',
    this.ubicacion = '',
    this.esPeps = '',
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
    this.tipoDocumentoCodigo = '',
    this.celularReprestamo = '',
    this.esFamiliarEmpleado = '',
    this.nombreFamiliar = '',
    this.cedulaFamiliar = '',
    this.plazoSolicitud = 0,
    this.fechaPrimerPagoSolicitud = '',
    this.tipoPersonaCodigo = '',
    this.cargaAnalisisAutomatico = '',
    this.motivoRevisionCodigo = '',
    this.actividadEconomicaCiuu1 = '',
    this.actividadEconomicaCiuu2 = '',
    this.actividadEconomicaCiuu3 = '',
    this.codigoUsa = '',
    this.apnfd = '',
    this.actividadEconomicaRealizaCiuu1 = '',
    this.actividadEconomicaRealizaCiuu2 = '',
    this.actividadEconomicaRealizaCiuu3 = '',
    this.tieneIdentificacionEstadosUnidos = '',
    this.tieneVinculoEstadosUnidos = '',
    this.vinculoEstadosUnidosDescripcion = '',
    this.ejerceActividadApfnd = '',
    this.medidasConocimientoCodigo = '',
    this.nombreEmpleadoFamiliar = '',
  });

  @override
  List<Object> get props => [
        cedulaFrontPath,
        cedulaBackPath,
        frecuenciaPagoMeses,
        fechaDesembolso,
        tasaInteres,
        montoMinimo,
        montoMaximo,
        descripcionDestino,
        nombreCompleto,
        errorMsg,
        idLocalResponse,
        status,
        origenSolicitudCodigo,
        cedula,
        monto,
        monedaCodigo,
        propositoCodigo,
        frecuenciaCodigo,
        cuota,
        beneficiarioSeguro,
        cedulaBeneficiarioSeguro,
        parentescoBeneficiarioSeguroCodigo,
        productoCodigo,
        observacion,
        ubicacionLongitud,
        ubicacionLatitud,
        ubicacion,
        esPeps,
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
        tipoDocumentoCodigo,
        celularReprestamo,
        esFamiliarEmpleado,
        nombreFamiliar,
        cedulaFamiliar,
        plazoSolicitud,
        fechaPrimerPagoSolicitud,
        tipoPersonaCodigo,
        cargaAnalisisAutomatico,
        motivoRevisionCodigo,
        actividadEconomicaCiuu1,
        actividadEconomicaCiuu2,
        actividadEconomicaCiuu3,
        codigoUsa,
        apnfd,
        actividadEconomicaRealizaCiuu1,
        actividadEconomicaRealizaCiuu2,
        actividadEconomicaRealizaCiuu3,
        tieneIdentificacionEstadosUnidos,
        tieneVinculoEstadosUnidos,
        vinculoEstadosUnidosDescripcion,
        ejerceActividadApfnd,
        medidasConocimientoCodigo,
        nombreEmpleadoFamiliar,
        isDone,
      ];

  SolicitudReprestamoHnState copyWith({
    String? cedulaFrontPath,
    String? cedulaBackPath,
    bool? isDone,
    String? frecuenciaPagoMeses,
    String? fechaDesembolso,
    double? tasaInteres,
    double? montoMinimo,
    double? montoMaximo,
    String? descripcionDestino,
    String? nombreCompleto,
    String? errorMsg,
    int? idLocalResponse,
    String? uuid,
    Status? status,
    String? origenSolicitudCodigo,
    String? cedula,
    double? monto,
    String? monedaCodigo,
    String? propositoCodigo,
    String? frecuenciaCodigo,
    double? cuota,
    String? beneficiarioSeguro,
    String? cedulaBeneficiarioSeguro,
    String? parentescoBeneficiarioSeguroCodigo,
    String? productoCodigo,
    String? observacion,
    String? ubicacionLongitud,
    String? ubicacionLatitud,
    String? ubicacion,
    String? esPeps,
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
    String? tipoDocumentoCodigo,
    String? celularReprestamo,
    String? esFamiliarEmpleado,
    String? nombreFamiliar,
    String? cedulaFamiliar,
    int? plazoSolicitud,
    String? fechaPrimerPagoSolicitud,
    String? tipoPersonaCodigo,
    String? cargaAnalisisAutomatico,
    String? motivoRevisionCodigo,
    String? actividadEconomicaCiuu1,
    String? actividadEconomicaCiuu2,
    String? actividadEconomicaCiuu3,
    String? codigoUsa,
    String? apnfd,
    String? actividadEconomicaRealizaCiuu1,
    String? actividadEconomicaRealizaCiuu2,
    String? actividadEconomicaRealizaCiuu3,
    String? tieneIdentificacionEstadosUnidos,
    String? tieneVinculoEstadosUnidos,
    String? vinculoEstadosUnidosDescripcion,
    String? ejerceActividadApfnd,
    String? medidasConocimientoCodigo,
    String? nombreEmpleadoFamiliar,
  }) {
    return SolicitudReprestamoHnState(
      cedulaFrontPath: cedulaFrontPath ?? this.cedulaFrontPath,
      cedulaBackPath: cedulaBackPath ?? this.cedulaBackPath,
      isDone: isDone ?? this.isDone,
      frecuenciaPagoMeses: frecuenciaPagoMeses ?? this.frecuenciaPagoMeses,
      fechaDesembolso: fechaDesembolso ?? this.fechaDesembolso,
      tasaInteres: tasaInteres ?? this.tasaInteres,
      montoMinimo: montoMinimo ?? this.montoMinimo,
      montoMaximo: montoMaximo ?? this.montoMaximo,
      descripcionDestino: descripcionDestino ?? this.descripcionDestino,
      nombreCompleto: nombreCompleto ?? this.nombreCompleto,
      errorMsg: errorMsg ?? this.errorMsg,
      idLocalResponse: idLocalResponse ?? this.idLocalResponse,
      uuid: uuid ?? this.uuid,
      status: status ?? this.status,
      origenSolicitudCodigo:
          origenSolicitudCodigo ?? this.origenSolicitudCodigo,
      cedula: cedula ?? this.cedula,
      monto: monto ?? this.monto,
      monedaCodigo: monedaCodigo ?? this.monedaCodigo,
      propositoCodigo: propositoCodigo ?? this.propositoCodigo,
      frecuenciaCodigo: frecuenciaCodigo ?? this.frecuenciaCodigo,
      cuota: cuota ?? this.cuota,
      beneficiarioSeguro: beneficiarioSeguro ?? this.beneficiarioSeguro,
      cedulaBeneficiarioSeguro:
          cedulaBeneficiarioSeguro ?? this.cedulaBeneficiarioSeguro,
      parentescoBeneficiarioSeguroCodigo: parentescoBeneficiarioSeguroCodigo ??
          this.parentescoBeneficiarioSeguroCodigo,
      productoCodigo: productoCodigo ?? this.productoCodigo,
      observacion: observacion ?? this.observacion,
      ubicacionLongitud: ubicacionLongitud ?? this.ubicacionLongitud,
      ubicacionLatitud: ubicacionLatitud ?? this.ubicacionLatitud,
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
      cargoFamiliarPeps2: cargoFamiliarPeps2 ?? this.cargoFamiliarPeps2,
      nombreEntidadPeps2: nombreEntidadPeps2 ?? this.nombreEntidadPeps2,
      periodoPeps2: periodoPeps2 ?? this.periodoPeps2,
      paisPeps2: paisPeps2 ?? this.paisPeps2,
      tipoDocumentoCodigo: tipoDocumentoCodigo ?? this.tipoDocumentoCodigo,
      celularReprestamo: celularReprestamo ?? this.celularReprestamo,
      esFamiliarEmpleado: esFamiliarEmpleado ?? this.esFamiliarEmpleado,
      nombreFamiliar: nombreFamiliar ?? this.nombreFamiliar,
      cedulaFamiliar: cedulaFamiliar ?? this.cedulaFamiliar,
      plazoSolicitud: plazoSolicitud ?? this.plazoSolicitud,
      fechaPrimerPagoSolicitud:
          fechaPrimerPagoSolicitud ?? this.fechaPrimerPagoSolicitud,
      tipoPersonaCodigo: tipoPersonaCodigo ?? this.tipoPersonaCodigo,
      cargaAnalisisAutomatico:
          cargaAnalisisAutomatico ?? this.cargaAnalisisAutomatico,
      motivoRevisionCodigo: motivoRevisionCodigo ?? this.motivoRevisionCodigo,
      actividadEconomicaCiuu1:
          actividadEconomicaCiuu1 ?? this.actividadEconomicaCiuu1,
      actividadEconomicaCiuu2:
          actividadEconomicaCiuu2 ?? this.actividadEconomicaCiuu2,
      actividadEconomicaCiuu3:
          actividadEconomicaCiuu3 ?? this.actividadEconomicaCiuu3,
      codigoUsa: codigoUsa ?? this.codigoUsa,
      apnfd: apnfd ?? this.apnfd,
      actividadEconomicaRealizaCiuu1:
          actividadEconomicaRealizaCiuu1 ?? this.actividadEconomicaRealizaCiuu1,
      actividadEconomicaRealizaCiuu2:
          actividadEconomicaRealizaCiuu2 ?? this.actividadEconomicaRealizaCiuu2,
      actividadEconomicaRealizaCiuu3:
          actividadEconomicaRealizaCiuu3 ?? this.actividadEconomicaRealizaCiuu3,
      tieneIdentificacionEstadosUnidos: tieneIdentificacionEstadosUnidos ??
          this.tieneIdentificacionEstadosUnidos,
      tieneVinculoEstadosUnidos:
          tieneVinculoEstadosUnidos ?? this.tieneVinculoEstadosUnidos,
      vinculoEstadosUnidosDescripcion: vinculoEstadosUnidosDescripcion ??
          this.vinculoEstadosUnidosDescripcion,
      ejerceActividadApfnd: ejerceActividadApfnd ?? this.ejerceActividadApfnd,
      medidasConocimientoCodigo:
          medidasConocimientoCodigo ?? this.medidasConocimientoCodigo,
      nombreEmpleadoFamiliar:
          nombreEmpleadoFamiliar ?? this.nombreEmpleadoFamiliar,
    );
  }
}

final class SolicitudReprestamoHnInitial extends SolicitudReprestamoHnState {}

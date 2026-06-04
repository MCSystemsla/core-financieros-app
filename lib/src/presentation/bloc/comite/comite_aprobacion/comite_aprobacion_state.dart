// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comite_aprobacion_cubit.dart';

class ComiteAprobacionState extends Equatable {
  final String respMsg;
  final String errorMsg;
  final Status status;
  final bool isMenorMil;
  final String estadoSolicitudCodigo;
  final int numeroSolicitud;
  final bool alVencimiento;
  final String fromaPagoCodigo;
  final String periodicidadPrinicipalCodigo;
  final String periodicidadInteresCodigo;
  final String tipoSolicitudCodigo;
  final String fechaAprobacion;
  final String observacion;
  final bool aprobacionDigital;
  final bool esRecalculado;
  final String productoCodigo;
  final double monto;
  final double montoSeguro;
  final double porcentajeComision;
  final int plazo;
  final String sectorCodigo;
  final String actividadCodigo;
  final String fuenteFinanciamientoCodigo;
  final double tasaInteresCorriente;
  final int tasaInteresMoratorio;
  final String monedaDesembolsoCodigo;
  final String tipoDesembolsoCodigo;
  final int promotorId;
  final bool esReestructurado;
  final bool comisionFinanciada;
  final bool cuotaNivelada;
  final double montoSinComision;
  final int periodoGracia;
  final bool esRetencion;
  final double seguroMemorialMensual;
  final double porcentajeSaldoDeudorAprobado;
  final int montoTelemedicinaAprobada;
  final double porcentajeAgricolaAprobado;
  final double tasaMillarSeguroMapfre;
  final String numeroBienAdj;
  final String tipoCreditoNombre;
  final String tipoProgramaCodigo;
  final String tipoComiteAprobacionCodigo;
  final List<ComiteAprovedResponsable> responsables;
  final int grupoID;
  final bool esUltimoRegistro;
  final bool esAprobacionMasiva;

  const ComiteAprobacionState({
    this.grupoID = 0,
    this.responsables = const [],
    this.respMsg = '',
    this.isMenorMil = false,
    this.esRecalculado = false,
    this.aprobacionDigital = false,
    this.alVencimiento = false,
    this.estadoSolicitudCodigo = '',
    this.numeroSolicitud = 0,
    this.fromaPagoCodigo = '',
    this.periodicidadPrinicipalCodigo = '',
    this.periodicidadInteresCodigo = '',
    this.tipoSolicitudCodigo = '',
    this.fechaAprobacion = '',
    this.observacion = '',
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.productoCodigo = '',
    this.monto = 0,
    this.montoSeguro = 0,
    this.porcentajeComision = 0,
    this.plazo = 0,
    this.sectorCodigo = '',
    this.actividadCodigo = '',
    this.fuenteFinanciamientoCodigo = '',
    this.tasaInteresCorriente = 0,
    this.tasaInteresMoratorio = 0,
    this.monedaDesembolsoCodigo = '',
    this.tipoDesembolsoCodigo = '',
    this.promotorId = 0,
    this.esReestructurado = false,
    this.comisionFinanciada = false,
    this.cuotaNivelada = false,
    this.montoSinComision = 0,
    this.periodoGracia = 0,
    this.esRetencion = false,
    this.seguroMemorialMensual = 0,
    this.porcentajeSaldoDeudorAprobado = 0,
    this.montoTelemedicinaAprobada = 0,
    this.porcentajeAgricolaAprobado = 0,
    this.tasaMillarSeguroMapfre = 0,
    this.numeroBienAdj = '',
    this.tipoCreditoNombre = '',
    this.tipoProgramaCodigo = '',
    this.tipoComiteAprobacionCodigo = '',
    this.esUltimoRegistro = false,
    this.esAprobacionMasiva = false,
  });

  @override
  List<Object> get props => [
        responsables,
        respMsg,
        errorMsg,
        isMenorMil,
        esRecalculado,
        aprobacionDigital,
        estadoSolicitudCodigo,
        numeroSolicitud,
        alVencimiento,
        fromaPagoCodigo,
        periodicidadPrinicipalCodigo,
        periodicidadInteresCodigo,
        tipoSolicitudCodigo,
        fechaAprobacion,
        observacion,
        status,
        productoCodigo,
        monto,
        montoSeguro,
        porcentajeComision,
        plazo,
        sectorCodigo,
        actividadCodigo,
        fuenteFinanciamientoCodigo,
        tasaInteresCorriente,
        tasaInteresMoratorio,
        monedaDesembolsoCodigo,
        tipoDesembolsoCodigo,
        promotorId,
        esReestructurado,
        comisionFinanciada,
        cuotaNivelada,
        montoSinComision,
        periodoGracia,
        esRetencion,
        seguroMemorialMensual,
        porcentajeSaldoDeudorAprobado,
        montoTelemedicinaAprobada,
        porcentajeAgricolaAprobado,
        tasaMillarSeguroMapfre,
        numeroBienAdj,
        tipoCreditoNombre,
        tipoProgramaCodigo,
        tipoComiteAprobacionCodigo,
        grupoID,
        esUltimoRegistro,
        esAprobacionMasiva,
      ];

  ComiteAprobacionState copyWith({
    String? respMsg,
    String? errorMsg,
    Status? status,
    bool? isMenorMil,
    String? estadoSolicitudCodigo,
    int? numeroSolicitud,
    bool? alVencimiento,
    String? fromaPagoCodigo,
    String? periodicidadPrinicipalCodigo,
    String? periodicidadInteresCodigo,
    String? tipoSolicitudCodigo,
    String? fechaAprobacion,
    String? observacion,
    bool? aprobacionDigital,
    bool? esRecalculado,
    String? productoCodigo,
    double? monto,
    double? montoSeguro,
    double? porcentajeComision,
    int? plazo,
    String? sectorCodigo,
    String? actividadCodigo,
    String? fuenteFinanciamientoCodigo,
    double? tasaInteresCorriente,
    int? tasaInteresMoratorio,
    String? monedaDesembolsoCodigo,
    String? tipoDesembolsoCodigo,
    int? promotorId,
    bool? esReestructurado,
    bool? comisionFinanciada,
    bool? cuotaNivelada,
    double? montoSinComision,
    int? periodoGracia,
    bool? esRetencion,
    double? seguroMemorialMensual,
    double? porcentajeSaldoDeudorAprobado,
    int? montoTelemedicinaAprobada,
    double? porcentajeAgricolaAprobado,
    double? tasaMillarSeguroMapfre,
    String? numeroBienAdj,
    String? tipoCreditoNombre,
    String? tipoProgramaCodigo,
    String? tipoComiteAprobacionCodigo,
    List<ComiteAprovedResponsable>? responsables,
    int? grupoID,
    bool? esUltimoRegistro,
    bool? esAprobacionMasiva,
  }) {
    return ComiteAprobacionState(
      respMsg: respMsg ?? this.respMsg,
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
      isMenorMil: isMenorMil ?? this.isMenorMil,
      estadoSolicitudCodigo:
          estadoSolicitudCodigo ?? this.estadoSolicitudCodigo,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      alVencimiento: alVencimiento ?? this.alVencimiento,
      fromaPagoCodigo: fromaPagoCodigo ?? this.fromaPagoCodigo,
      periodicidadPrinicipalCodigo:
          periodicidadPrinicipalCodigo ?? this.periodicidadPrinicipalCodigo,
      periodicidadInteresCodigo:
          periodicidadInteresCodigo ?? this.periodicidadInteresCodigo,
      tipoSolicitudCodigo: tipoSolicitudCodigo ?? this.tipoSolicitudCodigo,
      fechaAprobacion: fechaAprobacion ?? this.fechaAprobacion,
      observacion: observacion ?? this.observacion,
      aprobacionDigital: aprobacionDigital ?? this.aprobacionDigital,
      esRecalculado: esRecalculado ?? this.esRecalculado,
      productoCodigo: productoCodigo ?? this.productoCodigo,
      monto: monto ?? this.monto,
      montoSeguro: montoSeguro ?? this.montoSeguro,
      porcentajeComision: porcentajeComision ?? this.porcentajeComision,
      plazo: plazo ?? this.plazo,
      sectorCodigo: sectorCodigo ?? this.sectorCodigo,
      actividadCodigo: actividadCodigo ?? this.actividadCodigo,
      fuenteFinanciamientoCodigo:
          fuenteFinanciamientoCodigo ?? this.fuenteFinanciamientoCodigo,
      tasaInteresCorriente: tasaInteresCorriente ?? this.tasaInteresCorriente,
      tasaInteresMoratorio: tasaInteresMoratorio ?? this.tasaInteresMoratorio,
      monedaDesembolsoCodigo:
          monedaDesembolsoCodigo ?? this.monedaDesembolsoCodigo,
      tipoDesembolsoCodigo: tipoDesembolsoCodigo ?? this.tipoDesembolsoCodigo,
      promotorId: promotorId ?? this.promotorId,
      esReestructurado: esReestructurado ?? this.esReestructurado,
      comisionFinanciada: comisionFinanciada ?? this.comisionFinanciada,
      cuotaNivelada: cuotaNivelada ?? this.cuotaNivelada,
      montoSinComision: montoSinComision ?? this.montoSinComision,
      periodoGracia: periodoGracia ?? this.periodoGracia,
      esRetencion: esRetencion ?? this.esRetencion,
      seguroMemorialMensual:
          seguroMemorialMensual ?? this.seguroMemorialMensual,
      porcentajeSaldoDeudorAprobado:
          porcentajeSaldoDeudorAprobado ?? this.porcentajeSaldoDeudorAprobado,
      montoTelemedicinaAprobada:
          montoTelemedicinaAprobada ?? this.montoTelemedicinaAprobada,
      porcentajeAgricolaAprobado:
          porcentajeAgricolaAprobado ?? this.porcentajeAgricolaAprobado,
      tasaMillarSeguroMapfre:
          tasaMillarSeguroMapfre ?? this.tasaMillarSeguroMapfre,
      numeroBienAdj: numeroBienAdj ?? this.numeroBienAdj,
      tipoCreditoNombre: tipoCreditoNombre ?? this.tipoCreditoNombre,
      tipoProgramaCodigo: tipoProgramaCodigo ?? this.tipoProgramaCodigo,
      tipoComiteAprobacionCodigo:
          tipoComiteAprobacionCodigo ?? this.tipoComiteAprobacionCodigo,
      responsables: responsables ?? this.responsables,
      grupoID: grupoID ?? this.grupoID,
      esUltimoRegistro: esUltimoRegistro ?? this.esUltimoRegistro,
      esAprobacionMasiva: esAprobacionMasiva ?? this.esAprobacionMasiva,
    );
  }
}

final class ComiteAprobacionInitial extends ComiteAprobacionState {}

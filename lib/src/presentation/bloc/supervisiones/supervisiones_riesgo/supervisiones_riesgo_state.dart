// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'supervisiones_riesgo_cubit.dart';

class SupervisionesRiesgoState extends Equatable {
  final Status status;
  final String errorMsg;
  final int numeroSolicitud;
  final bool todaDocumentacionDdc;
  final bool garantiaPoliticaVigente;
  final bool evaluacionFinanciera;
  final bool filtracionListasRiesgo;
  final bool pic;
  final bool centralesRiesgo;
  final bool documentosLegibles;
  final bool informeSupervisionCreditoCoordinador;
  final String conclusiones;
  final String observaciones;
  final String tipoSolicitud;
  const SupervisionesRiesgoState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.numeroSolicitud = 0,
    this.todaDocumentacionDdc = false,
    this.garantiaPoliticaVigente = false,
    this.evaluacionFinanciera = false,
    this.filtracionListasRiesgo = false,
    this.pic = false,
    this.centralesRiesgo = false,
    this.documentosLegibles = false,
    this.informeSupervisionCreditoCoordinador = false,
    this.conclusiones = '',
    this.observaciones = '',
    this.tipoSolicitud = '',
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        numeroSolicitud,
        todaDocumentacionDdc,
        garantiaPoliticaVigente,
        evaluacionFinanciera,
        filtracionListasRiesgo,
        pic,
        centralesRiesgo,
        documentosLegibles,
        informeSupervisionCreditoCoordinador,
        conclusiones,
        observaciones,
        tipoSolicitud,
      ];

  SupervisionesRiesgoState copyWith({
    Status? status,
    String? errorMsg,
    int? numeroSolicitud,
    bool? todaDocumentacionDdc,
    bool? garantiaPoliticaVigente,
    bool? evaluacionFinanciera,
    bool? filtracionListasRiesgo,
    bool? pic,
    bool? centralesRiesgo,
    bool? documentosLegibles,
    bool? informeSupervisionCreditoCoordinador,
    String? conclusiones,
    String? observaciones,
    String? tipoSolicitud,
  }) {
    return SupervisionesRiesgoState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      todaDocumentacionDdc: todaDocumentacionDdc ?? this.todaDocumentacionDdc,
      garantiaPoliticaVigente:
          garantiaPoliticaVigente ?? this.garantiaPoliticaVigente,
      evaluacionFinanciera: evaluacionFinanciera ?? this.evaluacionFinanciera,
      filtracionListasRiesgo:
          filtracionListasRiesgo ?? this.filtracionListasRiesgo,
      pic: pic ?? this.pic,
      centralesRiesgo: centralesRiesgo ?? this.centralesRiesgo,
      documentosLegibles: documentosLegibles ?? this.documentosLegibles,
      informeSupervisionCreditoCoordinador:
          informeSupervisionCreditoCoordinador ??
              this.informeSupervisionCreditoCoordinador,
      conclusiones: conclusiones ?? this.conclusiones,
      observaciones: observaciones ?? this.observaciones,
      tipoSolicitud: tipoSolicitud ?? this.tipoSolicitud,
    );
  }
}

final class SupervisionesRiesgoInitial extends SupervisionesRiesgoState {}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitudes_by_estado_ni_cubit.dart';

class SolicitudesByEstadoNiState extends Equatable {
  final Status status;
  final String errorMsg;
  final List<SolicitudEstado> solicitudes;
  final EstadoCredito estadoCredito;
  final bool isAsignadaToAsesorCredito;
  final bool hasMore;
  final String numeroSolicitud;
  final String cedulaCliente;
  final bool isNumeroSolicitudFilter;
  final bool isCedulaSolicitudFilter;
  final int pagina;
  final bool isLoadingMore;
  const SolicitudesByEstadoNiState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.solicitudes = const [],
    this.estadoCredito = EstadoCredito.registrada,
    this.isAsignadaToAsesorCredito = false,
    this.hasMore = false,
    this.isNumeroSolicitudFilter = false,
    this.isCedulaSolicitudFilter = false,
    this.numeroSolicitud = '',
    this.cedulaCliente = '',
    this.pagina = 1,
    this.isLoadingMore = false,
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        solicitudes,
        estadoCredito,
        isAsignadaToAsesorCredito,
        hasMore,
        isNumeroSolicitudFilter,
        isCedulaSolicitudFilter,
        numeroSolicitud,
        cedulaCliente,
        pagina,
        isLoadingMore,
      ];

  SolicitudesByEstadoNiState copyWith({
    Status? status,
    String? errorMsg,
    List<SolicitudEstado>? solicitudes,
    EstadoCredito? estadoCredito,
    bool? isAsignadaToAsesorCredito,
    bool? hasMore,
    String? numeroSolicitud,
    String? cedulaCliente,
    bool? isNumeroSolicitudFilter,
    bool? isCedulaSolicitudFilter,
    int? pagina,
    bool? isLoadingMore,
  }) {
    return SolicitudesByEstadoNiState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      solicitudes: solicitudes ?? this.solicitudes,
      estadoCredito: estadoCredito ?? this.estadoCredito,
      isAsignadaToAsesorCredito:
          isAsignadaToAsesorCredito ?? this.isAsignadaToAsesorCredito,
      hasMore: hasMore ?? this.hasMore,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      cedulaCliente: cedulaCliente ?? this.cedulaCliente,
      isNumeroSolicitudFilter:
          isNumeroSolicitudFilter ?? this.isNumeroSolicitudFilter,
      isCedulaSolicitudFilter:
          isCedulaSolicitudFilter ?? this.isCedulaSolicitudFilter,
      pagina: pagina ?? this.pagina,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

final class SolicitudesByEstadoNiInitial extends SolicitudesByEstadoNiState {}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comite_solicitudes_cubit.dart';

class ComiteSolicitudesState extends Equatable {
  final Status status;
  final List<ComiteOnSolicitudData> data;
  final String errorMsg;
  final String nombrePromotorFilter;
  final String cedulaClienteFilter;
  final int numeroSolicitudFilter;
  final int numeroActaFilter;
  final bool isNumeroSolicitudFilter;
  final bool isCedulaSolicitudFilter;
  final bool isNumeroActaFilter;
  final bool isNombrePromotorFilter;
  final OrderType ordenType;

  const ComiteSolicitudesState({
    this.status = Status.notStarted,
    this.data = const [],
    this.errorMsg = '',
    this.nombrePromotorFilter = '',
    this.numeroSolicitudFilter = 0,
    this.cedulaClienteFilter = '',
    this.numeroActaFilter = 0,
    this.isNumeroSolicitudFilter = false,
    this.isCedulaSolicitudFilter = false,
    this.isNumeroActaFilter = false,
    this.isNombrePromotorFilter = false,
    this.ordenType = OrderType.ascending,
  });

  @override
  List<Object> get props => [
        status,
        data,
        errorMsg,
        nombrePromotorFilter,
        numeroSolicitudFilter,
        cedulaClienteFilter,
        numeroActaFilter,
        isNumeroSolicitudFilter,
        isCedulaSolicitudFilter,
        isNumeroActaFilter,
        isNombrePromotorFilter,
        ordenType,
      ];

  ComiteSolicitudesState copyWith({
    Status? status,
    List<ComiteOnSolicitudData>? data,
    String? errorMsg,
    String? nombrePromotorFilter,
    String? cedulaClienteFilter,
    int? numeroSolicitudFilter,
    int? numeroActaFilter,
    bool? isNumeroSolicitudFilter,
    bool? isCedulaSolicitudFilter,
    bool? isNumeroActaFilter,
    bool? isNombrePromotorFilter,
    OrderType? ordenType,
  }) {
    return ComiteSolicitudesState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMsg: errorMsg ?? this.errorMsg,
      nombrePromotorFilter: nombrePromotorFilter ?? this.nombrePromotorFilter,
      cedulaClienteFilter: cedulaClienteFilter ?? this.cedulaClienteFilter,
      numeroSolicitudFilter:
          numeroSolicitudFilter ?? this.numeroSolicitudFilter,
      numeroActaFilter: numeroActaFilter ?? this.numeroActaFilter,
      isNumeroSolicitudFilter:
          isNumeroSolicitudFilter ?? this.isNumeroSolicitudFilter,
      isCedulaSolicitudFilter:
          isCedulaSolicitudFilter ?? this.isCedulaSolicitudFilter,
      isNumeroActaFilter: isNumeroActaFilter ?? this.isNumeroActaFilter,
      isNombrePromotorFilter:
          isNombrePromotorFilter ?? this.isNombrePromotorFilter,
      ordenType: ordenType ?? this.ordenType,
    );
  }
}

final class ComiteSolicitudesInitial extends ComiteSolicitudesState {}

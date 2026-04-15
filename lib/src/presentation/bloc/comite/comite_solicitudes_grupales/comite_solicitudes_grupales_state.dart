// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comite_solicitudes_grupales_cubit.dart';

class ComiteSolicitudesGrupalesState extends Equatable {
  final Status status;
  final String errorMsg;
  final int numeroSolicitud;
  final String documentoCliente;
  final String nombrePromotor;
  final int numeroActa;
  final OrderType orderType;
  final List<ComiteGrupalResponseItem> data;
  final num montoTotalGrupo;
  const ComiteSolicitudesGrupalesState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.numeroSolicitud = 0,
    this.documentoCliente = '',
    this.nombrePromotor = '',
    this.numeroActa = 0,
    this.orderType = OrderType.descending,
    this.data = const [],
    this.montoTotalGrupo = 0,
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        numeroSolicitud,
        documentoCliente,
        nombrePromotor,
        numeroActa,
        orderType,
        data,
        montoTotalGrupo,
      ];

  ComiteSolicitudesGrupalesState copyWith({
    Status? status,
    String? errorMsg,
    int? numeroSolicitud,
    String? documentoCliente,
    String? nombrePromotor,
    int? numeroActa,
    OrderType? orderType,
    List<ComiteGrupalResponseItem>? data,
    num? montoTotalGrupo,
  }) {
    return ComiteSolicitudesGrupalesState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      documentoCliente: documentoCliente ?? this.documentoCliente,
      nombrePromotor: nombrePromotor ?? this.nombrePromotor,
      numeroActa: numeroActa ?? this.numeroActa,
      orderType: orderType ?? this.orderType,
      data: data ?? this.data,
      montoTotalGrupo: montoTotalGrupo ?? this.montoTotalGrupo,
    );
  }
}

final class ComiteSolicitudesGrupalesInitial
    extends ComiteSolicitudesGrupalesState {}

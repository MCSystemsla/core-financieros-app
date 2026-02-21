// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comite_solicitudes_cubit.dart';

class ComiteSolicitudesState extends Equatable {
  final Status status;
  final List<ComiteOnSolicitudData> data;
  final String errorMsg;
  final String nombrePromotor;
  const ComiteSolicitudesState({
    this.status = Status.inProgress,
    this.data = const [],
    this.errorMsg = '',
    this.nombrePromotor = '',
  });

  @override
  List<Object> get props => [
        status,
        data,
        errorMsg,
        nombrePromotor,
      ];

  ComiteSolicitudesState copyWith({
    Status? status,
    List<ComiteOnSolicitudData>? data,
    String? errorMsg,
    String? nombrePromotor,
  }) {
    return ComiteSolicitudesState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMsg: errorMsg ?? this.errorMsg,
      nombrePromotor: nombrePromotor ?? this.nombrePromotor,
    );
  }
}

final class ComiteSolicitudesInitial extends ComiteSolicitudesState {}

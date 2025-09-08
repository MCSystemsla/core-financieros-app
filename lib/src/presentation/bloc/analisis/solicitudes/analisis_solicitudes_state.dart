// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_solicitudes_cubit.dart';

class AnalisisSolicitudesState extends Equatable {
  final Status status;
  final List<SolicitudEstado> data;
  final String errorMsg;
  const AnalisisSolicitudesState({
    this.status = Status.notStarted,
    this.data = const [],
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [status, data, errorMsg];

  AnalisisSolicitudesState copyWith({
    Status? status,
    List<SolicitudEstado>? data,
    String? errorMsg,
  }) {
    return AnalisisSolicitudesState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class AnalisisSolicitudesInitial extends AnalisisSolicitudesState {}

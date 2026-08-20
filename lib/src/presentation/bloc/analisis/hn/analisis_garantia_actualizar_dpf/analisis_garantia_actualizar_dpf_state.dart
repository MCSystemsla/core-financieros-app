// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_garantia_actualizar_dpf_cubit.dart';

class AnalisisGarantiaActualizarDpfState extends Equatable {
  final Status status;
  final String errorMsg;

  const AnalisisGarantiaActualizarDpfState({
    this.status = Status.notStarted,
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
      ];

  AnalisisGarantiaActualizarDpfState copyWith({
    Status? status,
    String? errorMsg,
  }) {
    return AnalisisGarantiaActualizarDpfState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class AnalisisGarantiaActualizarDpfInitial
    extends AnalisisGarantiaActualizarDpfState {}

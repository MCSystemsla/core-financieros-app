// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cargos_disponibles_cubit.dart';

class CargosDisponiblesState extends Equatable {
  final Status status;
  final String errorMsg;
  final List<CargosDisponibleData> data;
  const CargosDisponiblesState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.data = const [],
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        data,
      ];

  CargosDisponiblesState copyWith({
    Status? status,
    String? errorMsg,
    List<CargosDisponibleData>? data,
  }) {
    return CargosDisponiblesState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      data: data ?? this.data,
    );
  }
}

final class CargosDisponiblesInitial extends CargosDisponiblesState {}

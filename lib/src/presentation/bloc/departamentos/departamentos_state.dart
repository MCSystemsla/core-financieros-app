// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'departamentos_cubit.dart';

class DepartamentosState extends Equatable {
  final List<Departamento> departamentos;
  final Status status;
  const DepartamentosState({
    this.departamentos = const [],
    this.status = Status.notStarted,
  });

  @override
  List<Object> get props => [departamentos, status];

  DepartamentosState copyWith({
    List<Departamento>? departamentos,
    Status? status,
  }) {
    return DepartamentosState(
      departamentos: departamentos ?? this.departamentos,
      status: status ?? this.status,
    );
  }
}

final class DepartamentosInitial extends DepartamentosState {}

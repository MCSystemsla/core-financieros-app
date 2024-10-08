// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comunidades_cubit.dart';

class ComunidadesState extends Equatable {
  final Status status;
  final List<MapaTipoComunidad> comunidades;
  const ComunidadesState({
    this.comunidades = const [],
    this.status = Status.notStarted,
  });

  @override
  List<Object> get props => [status, comunidades];

  ComunidadesState copyWith({
    Status? status,
    List<MapaTipoComunidad>? comunidades,
  }) {
    return ComunidadesState(
      status: status ?? this.status,
      comunidades: comunidades ?? this.comunidades,
    );
  }
}

final class ComunidadesInitial extends ComunidadesState {}

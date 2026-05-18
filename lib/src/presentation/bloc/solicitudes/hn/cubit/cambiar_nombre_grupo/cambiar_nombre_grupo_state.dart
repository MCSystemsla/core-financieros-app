// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cambiar_nombre_grupo_cubit.dart';

class CambiarNombreGrupoState extends Equatable {
  final Status status;
  final String errorMsg;
  final String successMessage;
  const CambiarNombreGrupoState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.successMessage = '',
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        successMessage,
      ];

  CambiarNombreGrupoState copyWith({
    Status? status,
    String? errorMsg,
    String? successMessage,
  }) {
    return CambiarNombreGrupoState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}

final class CambiarNombreGrupoInitial extends CambiarNombreGrupoState {}

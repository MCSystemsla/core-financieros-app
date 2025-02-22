// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recurrente_estandar_confirmation_cubit.dart';

class RecurrenteEstandarConfirmationState extends Equatable {
  final Status status;
  final RecurrenteEstandarDbLocal? recurrenteEstandarModel;
  const RecurrenteEstandarConfirmationState({
    this.status = Status.notStarted,
    this.recurrenteEstandarModel,
  });

  @override
  List<Object> get props => [];

  RecurrenteEstandarConfirmationState copyWith({
    Status? status,
    RecurrenteEstandarDbLocal? recurrenteEstandarModel,
  }) {
    return RecurrenteEstandarConfirmationState(
      status: status ?? this.status,
      recurrenteEstandarModel:
          recurrenteEstandarModel ?? this.recurrenteEstandarModel,
    );
  }
}

final class RecurrenteEstandarConfirmationInitial
    extends RecurrenteEstandarConfirmationState {}

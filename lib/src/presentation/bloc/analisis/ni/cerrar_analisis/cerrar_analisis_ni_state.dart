// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cerrar_analisis_ni_cubit.dart';

class CerrarAnalisisNiState extends Equatable {
  final Status status;
  final String errorMsg;
  final int currentNumeroSolicitud;
  const CerrarAnalisisNiState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.currentNumeroSolicitud = 0,
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        currentNumeroSolicitud,
      ];

  CerrarAnalisisNiState copyWith({
    Status? status,
    String? errorMsg,
    int? currentNumeroSolicitud,
  }) {
    return CerrarAnalisisNiState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      currentNumeroSolicitud:
          currentNumeroSolicitud ?? this.currentNumeroSolicitud,
    );
  }
}

final class CerrarAnalisisNiInitial extends CerrarAnalisisNiState {}

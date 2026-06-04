// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'represta_user_by_cedula_cubit.dart';

class ReprestaUserByCedulaState extends Equatable {
  final String id;
  final String nombreCompleto;
  final String cedula;
  final String tipoDocumento;
  final String tipoPersona;
  final String paisEmisorDocumento;
  final String fechaVencimientoDocumento;
  final String fechaEmisionDocumento;
  final String errorMsg;
  final Status status;

  const ReprestaUserByCedulaState({
    this.id = '',
    this.nombreCompleto = '',
    this.cedula = '',
    this.tipoDocumento = '',
    this.tipoPersona = '',
    this.paisEmisorDocumento = '',
    this.fechaVencimientoDocumento = '',
    this.fechaEmisionDocumento = '',
    this.errorMsg = '',
    this.status = Status.notStarted,
  });

  @override
  List<Object> get props => [
        id,
        nombreCompleto,
        cedula,
        tipoDocumento,
        tipoPersona,
        paisEmisorDocumento,
        fechaVencimientoDocumento,
        fechaEmisionDocumento,
        errorMsg,
        status,
      ];

  ReprestaUserByCedulaState copyWith({
    String? id,
    String? nombreCompleto,
    String? cedula,
    String? tipoDocumento,
    String? tipoPersona,
    String? paisEmisorDocumento,
    String? fechaVencimientoDocumento,
    String? fechaEmisionDocumento,
    String? errorMsg,
    Status? status,
  }) {
    return ReprestaUserByCedulaState(
      id: id ?? this.id,
      nombreCompleto: nombreCompleto ?? this.nombreCompleto,
      cedula: cedula ?? this.cedula,
      tipoDocumento: tipoDocumento ?? this.tipoDocumento,
      tipoPersona: tipoPersona ?? this.tipoPersona,
      paisEmisorDocumento: paisEmisorDocumento ?? this.paisEmisorDocumento,
      fechaVencimientoDocumento:
          fechaVencimientoDocumento ?? this.fechaVencimientoDocumento,
      fechaEmisionDocumento:
          fechaEmisionDocumento ?? this.fechaEmisionDocumento,
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
    );
  }
}

final class ReprestaUserByCedulaInitial extends ReprestaUserByCedulaState {}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_by_document_represtamo_cubit.dart';

class UserByDocumentReprestamoState extends Equatable {
  final Status status;
  final String errorMsg;
  final String id;
  final String nombreCompleto;
  final String cedula;
  final String tipoDocumento;
  final String tipoPersona;
  final String paisEmisorCedula;
  final String fechaVencimientoCedula;
  final String fechaEmisionCedula;
  const UserByDocumentReprestamoState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.id = '',
    this.nombreCompleto = '',
    this.cedula = '',
    this.tipoDocumento = '',
    this.tipoPersona = '',
    this.paisEmisorCedula = '',
    this.fechaVencimientoCedula = '',
    this.fechaEmisionCedula = '',
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        id,
        nombreCompleto,
        cedula,
        tipoDocumento,
        tipoPersona,
        paisEmisorCedula,
        fechaVencimientoCedula,
        fechaEmisionCedula,
      ];

  UserByDocumentReprestamoState copyWith({
    Status? status,
    String? errorMsg,
    String? id,
    String? nombreCompleto,
    String? cedula,
    String? tipoDocumento,
    String? tipoPersona,
    String? paisEmisorCedula,
    String? fechaVencimientoCedula,
    String? fechaEmisionCedula,
  }) {
    return UserByDocumentReprestamoState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      id: id ?? this.id,
      nombreCompleto: nombreCompleto ?? this.nombreCompleto,
      cedula: cedula ?? this.cedula,
      tipoDocumento: tipoDocumento ?? this.tipoDocumento,
      tipoPersona: tipoPersona ?? this.tipoPersona,
      paisEmisorCedula: paisEmisorCedula ?? this.paisEmisorCedula,
      fechaVencimientoCedula:
          fechaVencimientoCedula ?? this.fechaVencimientoCedula,
      fechaEmisionCedula: fechaEmisionCedula ?? this.fechaEmisionCedula,
    );
  }
}

final class UserByDocumentReprestamoInitial
    extends UserByDocumentReprestamoState {}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_by_document_asalariado_cubit.dart';

class UserByDocumentAsalariadoState extends Equatable {
  final String errorMsg;
  final UserByDocumentStatus status;
  final String cedula;
  final String primerNombre;
  final String segundoNombre;
  final String primerApellido;
  final String segundoApellido;
  final String fechaNacimiento;
  final String sexo;
  final String pais;
  final String departamento;
  final String municipio;
  final String direccion;
  final String fechaEmision;
  final String fechaExpira;
  final String tipoDocumento;
  final bool esRecurrente;
  const UserByDocumentAsalariadoState({
    this.errorMsg = '',
    this.status = UserByDocumentStatus.notStarted,
    this.cedula = '',
    this.primerNombre = '',
    this.segundoNombre = '',
    this.primerApellido = '',
    this.segundoApellido = '',
    this.fechaNacimiento = '',
    this.sexo = '',
    this.pais = '',
    this.departamento = '',
    this.municipio = '',
    this.direccion = '',
    this.fechaEmision = '',
    this.fechaExpira = '',
    this.tipoDocumento = '',
    this.esRecurrente = false,
  });

  @override
  List<Object> get props => [
        esRecurrente,
        errorMsg,
        status,
        cedula,
        primerNombre,
        segundoNombre,
        primerApellido,
        segundoApellido,
        fechaNacimiento,
        sexo,
        pais,
        departamento,
        municipio,
        direccion,
        fechaEmision,
        fechaExpira,
        tipoDocumento,
      ];

  UserByDocumentAsalariadoState copyWith({
    String? errorMsg,
    UserByDocumentStatus? status,
    String? cedula,
    String? primerNombre,
    String? segundoNombre,
    String? primerApellido,
    String? segundoApellido,
    String? fechaNacimiento,
    String? sexo,
    String? pais,
    String? departamento,
    String? municipio,
    String? direccion,
    String? fechaEmision,
    String? fechaExpira,
    String? tipoDocumento,
    bool? esRecurrente,
  }) {
    return UserByDocumentAsalariadoState(
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
      cedula: cedula ?? this.cedula,
      primerNombre: primerNombre ?? this.primerNombre,
      segundoNombre: segundoNombre ?? this.segundoNombre,
      primerApellido: primerApellido ?? this.primerApellido,
      segundoApellido: segundoApellido ?? this.segundoApellido,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      sexo: sexo ?? this.sexo,
      pais: pais ?? this.pais,
      departamento: departamento ?? this.departamento,
      municipio: municipio ?? this.municipio,
      direccion: direccion ?? this.direccion,
      fechaEmision: fechaEmision ?? this.fechaEmision,
      fechaExpira: fechaExpira ?? this.fechaExpira,
      tipoDocumento: tipoDocumento ?? this.tipoDocumento,
      esRecurrente: esRecurrente ?? this.esRecurrente,
    );
  }
}

final class UserByDocumentAsalariadoInitial
    extends UserByDocumentAsalariadoState {}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_search_by_document_cubit.dart';

class AnalisisSearchByDocumentState extends Equatable {
  final UserByDocumentStatus status;
  final String errorMsg;
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
  const AnalisisSearchByDocumentState({
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
    this.status = UserByDocumentStatus.notStarted,
    this.errorMsg = '',
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
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

  AnalisisSearchByDocumentState copyWith({
    UserByDocumentStatus? status,
    String? errorMsg,
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
  }) {
    return AnalisisSearchByDocumentState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
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
    );
  }
}

final class AnalisisSearchByDocumentInitial
    extends AnalisisSearchByDocumentState {}

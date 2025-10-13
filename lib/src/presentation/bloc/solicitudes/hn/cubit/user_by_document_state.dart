part of 'user_by_document_cubit.dart';

class UserByDocumentState extends Equatable {
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
  const UserByDocumentState({
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
  });

  @override
  List<Object> get props => [];
}

final class UserByDocumentInitial extends UserByDocumentState {}

import 'dart:convert';

DepartamentosResponse departamentosResponseFromJson(String str) =>
    DepartamentosResponse.fromJson(json.decode(str));

class DepartamentosResponse {
  List<Departamento> departamentos;

  DepartamentosResponse({
    required this.departamentos,
  });

  factory DepartamentosResponse.fromJson(Map<String, dynamic> json) =>
      DepartamentosResponse(
        departamentos: List<Departamento>.from(
            json['departamentos'].map((x) => Departamento.fromJson(x))),
      );
}

class Departamento {
  String nombre;
  String valor;

  Departamento({
    required this.nombre,
    required this.valor,
  });

  factory Departamento.fromJson(Map<String, dynamic> json) => Departamento(
        nombre: json['nombre'],
        valor: json['valor'],
      );
}

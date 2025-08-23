import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/nuevamenor/analisis_nueva_menor.dart';

class AnalisisGetNuevaMenorByNumeroSolicitud extends Endpoint {
  final String numeroSolicitud;
  AnalisisGetNuevaMenorByNumeroSolicitud({
    required this.numeroSolicitud,
  });
  @override
  Method get method => Method.get;

  @override
  String get path => '/analisis_solicitud/obtener-solicitud-by-numero';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
        'NumeroSolicitud': numeroSolicitud,
      };
}

class CreateAnalisisGetNuevaMenorByNumeroSolicitud extends Endpoint {
  final AnalisisNuevaMenorData analisisSolicitudNuevaMenor;
  final String numeroSolicitud;
  CreateAnalisisGetNuevaMenorByNumeroSolicitud({
    required this.analisisSolicitudNuevaMenor,
    required this.numeroSolicitud,
  });
  @override
  Method get method => Method.post;

  @override
  String get path =>
      '/analisis_solicitud/create-analisis-solicitud-menor-a-mil';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => {
        'database': LocalStorage().database,
        'NumeroSolicitud': numeroSolicitud,
        ...analisisSolicitudNuevaMenor.toJson(),
      };
}

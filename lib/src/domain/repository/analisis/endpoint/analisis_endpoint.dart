import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

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

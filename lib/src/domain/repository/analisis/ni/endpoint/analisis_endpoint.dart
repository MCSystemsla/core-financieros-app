import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/ni/nuevamenor/analisis_nueva_menor.dart';

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
        'NumeroSolicitud': int.tryParse(numeroSolicitud) ?? 0,
        ...analisisSolicitudNuevaMenor.toJson(),
      };
}

class CloseAnalisisEndpointNi extends Endpoint {
  final int numeroSolicitud;
  final String tipoSolicitud;

  CloseAnalisisEndpointNi({
    required this.numeroSolicitud,
    required this.tipoSolicitud,
  });

  @override
  Method get method => Method.patch;

  @override
  String get path => '/cartera/solicitudes/general/analisis/cerrar';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => {
        'NumeroSolicitud': numeroSolicitud,
        'TipoSolicitud': tipoSolicitud,
        'database': LocalStorage().database,
      };
}

class GetAnalisisChecksEndpointNi extends Endpoint {
  final int numeroSolicitud;
  final String tipoSolicitud;
  final String cedulaCliente;
  final bool esGrupal;

  GetAnalisisChecksEndpointNi({
    required this.numeroSolicitud,
    required this.tipoSolicitud,
    required this.cedulaCliente,
    required this.esGrupal,
  });

  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/solicitudes/general/analisis/checks';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'NumeroSolicitud': numeroSolicitud.toString(),
        'database': LocalStorage().database,
        'TipoSolicitud': tipoSolicitud,
        'DocumentoCliente': cedulaCliente,
        'EsGrupal': esGrupal.toString(),
      };
}

class UpdateAnalisisGetNuevaMenorByNumeroSolicitud extends Endpoint {
  final AnalisisNuevaMenorData analisisSolicitudNuevaMenor;
  final String numeroSolicitud;
  UpdateAnalisisGetNuevaMenorByNumeroSolicitud({
    required this.analisisSolicitudNuevaMenor,
    required this.numeroSolicitud,
  });
  @override
  Method get method => Method.patch;

  @override
  String get path =>
      '/analisis_solicitud/update-analisis-solicitud-menor-a-mil';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => {
        'database': LocalStorage().database,
        'NumeroSolicitud': int.tryParse(numeroSolicitud) ?? 0,
        ...analisisSolicitudNuevaMenor.toJson(),
      };
}

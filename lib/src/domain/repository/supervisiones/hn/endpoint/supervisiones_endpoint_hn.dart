import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/create_supervision_coordinador.dart';

class GetSolicitudesByNumeroOrCedulaEndpointHN extends Endpoint {
  final int? numeroSolicitud;
  final String? cedulaIdentidad;
  GetSolicitudesByNumeroOrCedulaEndpointHN({
    this.numeroSolicitud,
    this.cedulaIdentidad,
  });
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/supervisiones/obtener-data-solicitud';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
        if (numeroSolicitud != null)
          'NumeroSolicitud': numeroSolicitud.toString(),
        if (cedulaIdentidad != null) 'CedulaIdentidad': cedulaIdentidad,
      };
}

class CreateSupervisionCoordinadorEndpointHN extends Endpoint {
  final CreateSupervisionCoordinador createSupervisionCoordinador;

  CreateSupervisionCoordinadorEndpointHN({
    required this.createSupervisionCoordinador,
  });
  @override
  Method get method => Method.post;

  @override
  String get path => '/cartera/supervisiones/create-supervision-coordinador';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => createSupervisionCoordinador.toJson();
}

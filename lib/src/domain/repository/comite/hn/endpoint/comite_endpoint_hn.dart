import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';

class ComiteObtenerDataSolicitudEndpointHN extends Endpoint {
  final int numeroSolicitud;
  final String tipoSolicitud;

  ComiteObtenerDataSolicitudEndpointHN({
    required this.numeroSolicitud,
    required this.tipoSolicitud,
  });

  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/comite/obtener-data-solicitud';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'NumeroSolicitud': numeroSolicitud.toString(),
        'TipoSolicitud': tipoSolicitud,
        'database': LocalStorage().database,
      };
}

import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/solicitud_asalariado_hn.dart';

class CrearSolciitudAsalariadoHNEndpoint extends Endpoint {
  final SolicitudAsalariadoHn solicitud;

  CrearSolciitudAsalariadoHNEndpoint({
    required this.solicitud,
  });
  @override
  Method get method => Method.post;

  @override
  String get path => '/solicitud-asalariado/crear';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => solicitud.toJson();
}

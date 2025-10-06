import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/solicitud_asalariado_hn.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/endpoint/solicitudes_credito_hn_endpoint.dart';
import 'package:logger/logger.dart';

abstract class SolicitudesCreditoHnRepository {
  Future<void> createSolicitudAsalariado({
    required SolicitudAsalariadoHn solicitud,
  });
}

class SolicitudesCreditoHnRepositoryImpl
    implements SolicitudesCreditoHnRepository {
  final _api = global<APIRepository>();
  final _logger = Logger();
  @override
  Future<void> createSolicitudAsalariado({
    required SolicitudAsalariadoHn solicitud,
  }) async {
    final endpoint = CrearSolciitudAsalariadoHNEndpoint(
      solicitud: solicitud,
    );
    try {
      await _api.request(endpoint: endpoint);
      _logger.i(endpoint.body);
    } catch (e) {
      _logger.e(e.toString());
    }
  }
}

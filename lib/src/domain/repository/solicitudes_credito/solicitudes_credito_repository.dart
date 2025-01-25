import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/nueva_menor/solicitud_nueva_menor.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/endpoint/solicitudes_credito_endpoint.dart';
import 'package:logger/logger.dart';

abstract class SolicitudesCreditoRepository {
  Future<(bool, String)> createSolicitudCreditoNuevaMenor({
    required SolicitudNuevaMenor solicitudNuevaMenor,
  });
}

class SolicitudCreditoRepositoryImpl implements SolicitudesCreditoRepository {
  final _api = global<APIRepository>();
  final _logger = Logger();
  @override
  Future<(bool, String)> createSolicitudCreditoNuevaMenor({
    required SolicitudNuevaMenor solicitudNuevaMenor,
  }) async {
    final endpoint = SolicitudesCreditoNuevaMenorEndpoint(
      solicitudNuevaMenor: solicitudNuevaMenor,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) return (false, resp['message'] as String);
      _logger.i(resp);
      return (true, resp.toString());
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }
}

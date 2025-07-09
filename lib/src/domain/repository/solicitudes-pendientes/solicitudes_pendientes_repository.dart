import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/config/helpers/error_handler/http_error_handler.dart';
import 'package:core_financiero_app/src/domain/entities/responses/socilitudes_pendientes_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes-pendientes/endpoint/socilitudes_pendientes_endpoint.dart';
import 'package:logger/logger.dart';

abstract class SolicitudesPendientesRepository {
  Future<SolicitudesPendienteResponse> getSolicitudesPendientes();
}

class SolicitudesPendientesRepositoryImpl
    extends SolicitudesPendientesRepository {
  final _api = global<APIRepository>();
  final _logger = Logger();

  @override
  Future<SolicitudesPendienteResponse> getSolicitudesPendientes() async {
    final endpoint = SolicitudesPendientesEndpoints();
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        final (errorMsg, status) = getErrorMessage(
          resp,
          errorMsg: 'No se puedieron obtener las solicitudes pendientes',
        );
        throw AppException(optionalMsg: '$errorMsg - $status');
      }
      final data = SolicitudesPendienteResponse.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}

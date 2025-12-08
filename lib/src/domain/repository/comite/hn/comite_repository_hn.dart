import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/config/helpers/error_handler/http_error_handler.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_solicitud_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/endpoint/comite_endpoint_hn.dart';
import 'package:logger/logger.dart';

abstract class ComiteRepositoryHN {
  Future<ComiteSolicitudResponse> obtenerDataSolicitud({
    required int numeroSolicitud,
    required String tipoSolicitud,
  });
}

class ComiteRepositoryHNImpl implements ComiteRepositoryHN {
  final _logger = Logger();
  final _api = global<APIRepository>();
  @override
  Future<ComiteSolicitudResponse> obtenerDataSolicitud({
    required int numeroSolicitud,
    required String tipoSolicitud,
  }) async {
    final endpoint = ComiteObtenerDataSolicitudEndpointHN(
      numeroSolicitud: numeroSolicitud,
      tipoSolicitud: tipoSolicitud,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);

      if (resp['statusCode'] != 200) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }
      final data = ComiteSolicitudResponse.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}

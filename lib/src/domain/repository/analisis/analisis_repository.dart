import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/datasource/analisis/nuevamenor/analisis_nueva_menor.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/endpoint/analisis_endpoint.dart';
import 'package:logger/web.dart';

abstract class AnalisisRepository {
  Future<AnalisisSolicitudNuevaMenorResponse> getSolicitudByNumeroSolicitud(
      {required String numeroSolicitud});
}

class AnalisisRepositoryImpl implements AnalisisRepository {
  final _logger = Logger();
  final _api = global<APIRepository>();

  @override
  Future<AnalisisSolicitudNuevaMenorResponse> getSolicitudByNumeroSolicitud({
    required String numeroSolicitud,
  }) async {
    final endpoint = AnalisisGetNuevaMenorByNumeroSolicitud(
      numeroSolicitud: numeroSolicitud,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        throw AppException(optionalMsg: resp.toString());
      }
      final data = AnalisisSolicitudNuevaMenorResponse.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}

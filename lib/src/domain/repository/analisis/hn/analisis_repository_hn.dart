import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/config/helpers/error_handler/http_error_handler.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_asalariado_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_represtamo_hn.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/endpoint/analisis_endpoint_hn.dart';
import 'package:logger/logger.dart';

abstract class AnalisisRepositoryHn {
  Future<void> createAnalisisNuevaMayorMil({
    required AnalisisNuevaMayorMilHn analisisSolicitudNuevaMenor,
  });
  Future<void> createAnalisisAsalariado({
    required AnalisisAsalariadoHn analisisSolicitudAsalariado,
  });
  Future<void> createAnalisisReprestamo({
    required AnalisisReprestamoHn analisisSolicitudReprestamo,
  });
}

class AnalisisRepositoryHNImpl extends AnalisisRepositoryHn {
  final _logger = Logger();
  final _api = global<APIRepository>();
  @override
  Future<void> createAnalisisNuevaMayorMil({
    required AnalisisNuevaMayorMilHn analisisSolicitudNuevaMenor,
  }) async {
    final endpoint = CreateAnalisisNuevaMayorMilHNEndpoint(
      analisisSolicitudNuevaMenor: analisisSolicitudNuevaMenor,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> createAnalisisAsalariado({
    required AnalisisAsalariadoHn analisisSolicitudAsalariado,
  }) async {
    final endpoint = CreateAnalisisAsalariadoEndpoint(
      analisisSolicitudAsalariado: analisisSolicitudAsalariado,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> createAnalisisReprestamo({
    required AnalisisReprestamoHn analisisSolicitudReprestamo,
  }) async {
    final endpoint = CreateAnalisisReprestamoEndpoint(
      analisisSolicitudReprestamo: analisisSolicitudReprestamo,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}

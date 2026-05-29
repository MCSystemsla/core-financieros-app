import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/config/helpers/error_handler/http_error_handler.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/create_supervision_coordinador.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/create_supervision_credito.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/create_supervision_regional.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/create_supervision_riesgo.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_montos_analisis_response.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/supervisiones/hn/endpoint/supervisiones_endpoint_hn.dart';
import 'package:logger/logger.dart';

abstract class SupervisionesRepositoryHn {
  Future<SupervisionesResponse> getSupervisionesByNumeroOrCedula({
    int? numeroSolicitud,
    String? cedulaIdentidad,
  });
  Future<CreateSupervisionCoordinadorEndpointHN> createSupervisionCoordinador({
    required CreateSupervisionCoordinador createSupervisionCoordinador,
  });
  Future<SupervisionesMontosAnalisisResponse> getMontosSupervisores({
    required int numeroSolicitud,
  });
  Future<void> createSupervisionCredito({
    required CreateSupervisionCredito createSupervisionCredito,
  });
  Future<void> createSupervisionRiesgo({
    required CreateSupervisionRiesgo createSupervisionRiesgo,
  });
  Future<void> createSupervisionRegional({
    required CreateSupervisionRegional createSupervisionRegional,
  });
}

class SupervisionesRepositoryHnImpl implements SupervisionesRepositoryHn {
  final _logger = Logger();
  final _api = global<APIRepository>();
  @override
  Future<SupervisionesResponse> getSupervisionesByNumeroOrCedula({
    int? numeroSolicitud,
    String? cedulaIdentidad,
  }) async {
    final endpoint = GetSolicitudesByNumeroOrCedulaEndpointHN(
      numeroSolicitud: numeroSolicitud,
      cedulaIdentidad: cedulaIdentidad,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }

      final data = SupervisionesResponse.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<CreateSupervisionCoordinadorEndpointHN> createSupervisionCoordinador({
    required CreateSupervisionCoordinador createSupervisionCoordinador,
  }) async {
    final endpoint = CreateSupervisionCoordinadorEndpointHN(
      createSupervisionCoordinador: createSupervisionCoordinador,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }
      return endpoint;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<SupervisionesMontosAnalisisResponse> getMontosSupervisores({
    required int numeroSolicitud,
  }) async {
    final endpoint = ObtenerMontosSupervisoresEndpointHN(
      numeroSolicitud: numeroSolicitud,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }
      final data = SupervisionesMontosAnalisisResponse.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> createSupervisionCredito({
    required CreateSupervisionCredito createSupervisionCredito,
  }) async {
    final endpoint = CreateSupervisionCreditoEndpointHN(
      createSupervisionCredito: createSupervisionCredito,
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
  Future<void> createSupervisionRiesgo({
    required CreateSupervisionRiesgo createSupervisionRiesgo,
  }) async {
    final endpoint = CreateSupervisionRiesgoEndpointHN(
      createSupervisionRiesgo: createSupervisionRiesgo,
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
  Future<void> createSupervisionRegional({
    required CreateSupervisionRegional createSupervisionRegional,
  }) async {
    final endpoint = CreateSupervisionRegionalEndpointHN(
      createSupervisionRegional: createSupervisionRegional,
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

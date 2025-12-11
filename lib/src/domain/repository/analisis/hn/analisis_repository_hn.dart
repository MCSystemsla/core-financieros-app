import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/config/helpers/error_handler/http_error_handler.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_asalariado_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_checks_response.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_represtamo_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores/analisis_fiadores_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores/analisis_fiadores_search_client_by_document.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_dpfs_response_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_credito_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_data_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/plan_inversion/analisis_plan_inversion.dart';
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
  Future<void> createAnalisisPlanInversion({
    required AnalisisPlanDeInversion analisisPlanDeInversion,
  });
  Future<void> createAnalisisFiador({
    required AnalisisFiadoresHn analisisFiadoresHn,
  });
  Future<AnalisisFiadoresSearchClientByDocument?> getAnalisisFiadorByDocument({
    required String cedula,
    required String tipoDocumentoCodigo,
  });
  Future<void> createAnalisisGarantias({
    required AnalisisGarantiaCreditoHn analisisGarantiaCreditoHn,
  });
  Future<AnalisisGarantiaArticuloHn> getAnalisisGarantiasArticulos();
  Future<AnalisisGarantiaDataHn> getAnalisisGarantiasByNumero({
    required int numeroSolicitud,
  });
  Future<void> createAnalisisGarantiasArticulo({
    required String tipo,
    required String descripcion,
  });
  Future<void> createAnalisisGarantiasDetalle({
    required AnalisisGarantiaDetalle analisisGarantiaDetalle,
  });
  Future<AnalisisDpfsResponseHn> getAnalisisDpfs({
    required String tipoPersona,
    required String cedula,
  });
  Future<void> closeAnalisis({
    required int numeroSolicitud,
    required String tipoSolicitud,
  });
  Future<AnalisisChecksResponse> analisisChecks({
    required int numeroSolicitud,
    required String tipoSolicitud,
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

  @override
  Future<void> createAnalisisPlanInversion({
    required AnalisisPlanDeInversion analisisPlanDeInversion,
  }) async {
    final endpoint = PlanDeInversionEndpointHN(
      analisisPlanDeInversion: analisisPlanDeInversion,
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
  Future<void> createAnalisisFiador({
    required AnalisisFiadoresHn analisisFiadoresHn,
  }) async {
    final endpoint = CreateAnalisisFiadorEndpoinHN(
      analisisFiadoresHn: analisisFiadoresHn,
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
  Future<AnalisisFiadoresSearchClientByDocument?> getAnalisisFiadorByDocument({
    required String cedula,
    required String tipoDocumentoCodigo,
  }) async {
    final endpoint = AnalisisObtenerAutoCompletadoEndpointHN(
      cedula: cedula,
      tipoDocumentoCodigo: tipoDocumentoCodigo,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }

      final data = AnalisisFiadoresSearchClientByDocument.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> createAnalisisGarantias({
    required AnalisisGarantiaCreditoHn analisisGarantiaCreditoHn,
  }) async {
    final endpoint = CreateAnalisisGarantiasHNEndpoint(
      analisisGarantiaCreditoHn: analisisGarantiaCreditoHn,
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
  Future<void> createAnalisisGarantiasArticulo({
    required String tipo,
    required String descripcion,
  }) async {
    final endpoint = CrearArticulosGarantiasHNEndpoint(
      tipo: tipo,
      descripcion: descripcion,
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
  Future<AnalisisGarantiaArticuloHn> getAnalisisGarantiasArticulos() async {
    final endpoint = ObtenerArticulosGarantiasHNEndpoint();
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }

      final data = AnalisisGarantiaArticuloHn.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<AnalisisGarantiaDataHn> getAnalisisGarantiasByNumero({
    required int numeroSolicitud,
  }) async {
    final endpoint =
        ObtenerGarantiaByNumeroHNEndpoint(numeroSolicitud: numeroSolicitud);
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }

      final data = AnalisisGarantiaDataHn.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> createAnalisisGarantiasDetalle({
    required AnalisisGarantiaDetalle analisisGarantiaDetalle,
  }) async {
    final endpoint = CreateAnalisisGarantiasDetalleHNEndpoint(
      analisisGarantiaCreditoHn: analisisGarantiaDetalle,
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
  Future<AnalisisDpfsResponseHn> getAnalisisDpfs({
    required String tipoPersona,
    required String cedula,
  }) async {
    final endpoint = GetDpfsByCedulaHNEndpoint(
      tipoPersona: tipoPersona,
      cedula: cedula,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.e(resp);
        final (errorMsg, _) = getErrorMessage(
          resp,
          errorMsg:
              'Tienes problemas de conexión. Revisa tu conexión a internet.',
        );
        throw AppException(optionalMsg: errorMsg);
      }
      final data = AnalisisDpfsResponseHn.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> closeAnalisis({
    required int numeroSolicitud,
    required String tipoSolicitud,
  }) async {
    final endpoint = CloseAnalisisEndpointHN(
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
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<AnalisisChecksResponse> analisisChecks({
    required int numeroSolicitud,
    required String tipoSolicitud,
  }) async {
    final endpoint = GetAnalsisChecksEndpointHN(
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

      final data = AnalisisChecksResponse.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}

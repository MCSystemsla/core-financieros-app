import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/config/helpers/error_handler/http_error_handler.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/solicitud_asalariado_hn.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/nuevamenor/solicitud_nueva_menor_hn.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/catalogo/catalogo_valor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/catalogo_frecuencia_pago/catalogo_frecuencia_pago.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/nacionalidad/catalogo_nacionalidad.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/parametro/parametro_valor.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/endpoint/solicitudes_credito_hn_endpoint.dart';
import 'package:logger/logger.dart';

abstract class SolicitudesCreditoHnRepository {
  Future<(bool, String)> createSolicitudAsalariado({
    required SolicitudAsalariadoHn solicitud,
  });
  Future<(bool, String)> createSolicitudNuevaMenor({
    required SolicitudNuevaMenorHn solicitud,
  });
  Future<CatalogoValor> getCatalogoByCodigo({required String codigo});
  Future<CatalogoValor> getCatalogoProducts();
  Future<CatalogoNacionalidad> getCatalogoUbicaciones({required String codigo});
  Future<CatalogoFrecuenciaPago> getCatalogoFrecuenciaPago();
  Future<ParametroValor> getParametroValor({required String nombre});
}

class SolicitudesCreditoHnRepositoryImpl
    implements SolicitudesCreditoHnRepository {
  final _api = global<APIRepository>();
  final _logger = Logger();
  @override
  Future<(bool, String)> createSolicitudAsalariado({
    required SolicitudAsalariadoHn solicitud,
  }) async {
    final endpoint = CrearSolciitudAsalariadoHNEndpoint(
      solicitud: solicitud,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] == 409) {
        _logger.i(endpoint.body);
        return (false, resp.toString());
      }
      if (resp['statusCode'] != 201) {
        _logger.i(endpoint.body);
        final (errorMsg, _) = getErrorMessage(resp);
        return (false, errorMsg);
      }

      _logger.i(endpoint.body);
      return (true, resp['message'] as String);
    } catch (e) {
      _logger.e(e.toString());
      return (false, e.toString());
    }
  }

  @override
  Future<CatalogoValor> getCatalogoByCodigo({required String codigo}) async {
    final endpoint = GetCatalogoHNByCodigoEndpoint(
      codigo: codigo,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);

      if (resp['statusCode'] != 200) {
        final (errorMsg, _) = getErrorMessage(
          resp,
          errorMsg:
              'Tienes problemas de conexión. Revisa tu conexión a internet.',
        );
        throw AppException(optionalMsg: errorMsg);
      }
      final data = CatalogoValor.fromJson(resp);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<(bool, String)> createSolicitudNuevaMenor({
    required SolicitudNuevaMenorHn solicitud,
  }) async {
    final endpoint = CrearSolciitudNuevaMenorHNEndpoint(
      solicitud: solicitud,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] == 409) {
        _logger.i(endpoint.body);
        return (false, resp.toString());
      }
      if (resp['statusCode'] != 201) {
        _logger.i(endpoint.body);
        return (false, resp.toString());
      }
      _logger.i(endpoint.body);
      return (true, resp['message'] as String);
    } catch (e) {
      _logger.e(e.toString());
      return (false, e.toString());
    }
  }

  @override
  Future<CatalogoValor> getCatalogoProducts() async {
    final endpoint = GetProductosHNEndpoint();
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        final (errorMsg, _) = getErrorMessage(
          resp,
          errorMsg:
              'Tienes problemas de conexión. Revisa tu conexión a internet.',
        );
        throw AppException(optionalMsg: errorMsg);
      }
      final data = CatalogoValor.fromJson(resp);
      _logger.i(resp);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CatalogoNacionalidad> getCatalogoUbicaciones({
    required String codigo,
  }) async {
    final endpoint = GetCatalogosUbicacionesHNEndpoint(
      codigo: codigo,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        final (errorMsg, _) = getErrorMessage(
          resp,
          errorMsg:
              'Tienes problemas de conexión. Revisa tu conexión a internet.',
        );
        throw AppException(optionalMsg: errorMsg);
      }
      final data = CatalogoNacionalidad.fromJson(resp);
      _logger.i(resp);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CatalogoFrecuenciaPago> getCatalogoFrecuenciaPago() async {
    final endpoint = GetCatalogosFrecuenciaDePagoEndpoint();
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        final (errorMsg, _) = getErrorMessage(
          resp,
          errorMsg:
              'Tienes problemas de conexión. Revisa tu conexión a internet.',
        );
        throw AppException(optionalMsg: errorMsg);
      }
      final data = CatalogoFrecuenciaPago.fromJson(resp);
      _logger.i(resp);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ParametroValor> getParametroValor({required String nombre}) async {
    final endpoint = GetParametroByCodigoEndpoint(nombre: nombre);
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        final (errorMsg, _) = getErrorMessage(
          resp,
          errorMsg:
              'Tienes problemas de conexión. Revisa tu conexión a internet.',
        );
        throw AppException(optionalMsg: errorMsg);
      }
      final data = ParametroValor.fromJson(resp);
      return data;
    } catch (e) {
      rethrow;
    }
  }
}

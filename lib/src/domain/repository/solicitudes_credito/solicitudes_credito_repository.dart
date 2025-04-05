import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/catalogo/catalogo_valor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/nacionalidad/catalogo_nacionalidad.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/nueva_menor/solicitud_nueva_menor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/represtamo/solicitud_represtamo.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/user_cedula/user_cedula_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/endpoint/solicitudes_credito_endpoint.dart';
import 'package:logger/logger.dart';

abstract class SolicitudesCreditoRepository {
  Future<(bool, String)> createSolicitudCreditoNuevaMenor({
    required SolicitudNuevaMenor solicitudNuevaMenor,
  });
  Future<(bool, String)> createSolicitudReprestamo({
    required SolicitudReprestamo solicitudReprestamo,
  });
  Future<CatalogoValor> getCatalogoByCodigo({required String codigo});
  Future<CatalogoNacionalidad> getNacionalidadByCodigo({
    required String codigo,
  });
  Future<CatalogoValor> getCatalogoProductos();
  Future<UserCedulaResponse> getUserByCedula({required String cedula});
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
      if (resp['statusCode'] != 201) {
        _logger.i(endpoint.body);

        return (false, resp['message']['message'] as String);
      }

      _logger.i(resp);
      _logger.i(endpoint.body);

      return (true, resp.toString());
    } catch (e) {
      _logger.e(e);
      _logger.i(endpoint.body);
      return (false, e.toString());
    }
  }

  @override
  Future<CatalogoValor> getCatalogoByCodigo({required String codigo}) async {
    final endpoint = CatalogoSolicitudEndpoint(codigo: codigo);
    try {
      final resp = await _api.request(endpoint: endpoint);
      final data = CatalogoValor.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<CatalogoNacionalidad> getNacionalidadByCodigo({
    required String codigo,
  }) async {
    final endpoint = NacionalidadEndpoint(codigo: codigo);
    try {
      final resp = await _api.request(endpoint: endpoint);
      final data = CatalogoNacionalidad.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<CatalogoValor> getCatalogoProductos() async {
    final endpoint = ProductosEndpoint();
    try {
      final resp = await _api.request(endpoint: endpoint);
      final data = CatalogoValor.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<UserCedulaResponse> getUserByCedula({required String cedula}) async {
    final endpoint = UserCedulaEndpoint(cedula: cedula);

    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        throw AppException(optionalMsg: resp['message']['message']);
      }
      final data = UserCedulaResponse.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<(bool, String)> createSolicitudReprestamo({
    required SolicitudReprestamo solicitudReprestamo,
  }) async {
    final endpoint = SolicitudReprestamoEndpoint(
      solicitudReprestamo: solicitudReprestamo,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) {
        _logger.i(endpoint.body);
        AppException(optionalMsg: resp['message']['message'] as String);
        return (false, resp['message']['message'] as String);
      }

      _logger.i(resp);

      return (true, resp.toString());
    } catch (e) {
      _logger.e(e);
      _logger.i(endpoint.body);
      return (false, e.toString());
    }
  }
}

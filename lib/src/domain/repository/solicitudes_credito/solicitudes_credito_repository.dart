import 'dart:async';
import 'dart:io';

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/asalariado/solicitud_asalariado.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/catalogo/catalogo_valor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/nacionalidad/catalogo_nacionalidad.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/nueva_menor/solicitud_nueva_menor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/parametro/parametro_valor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/represtamo/solicitud_represtamo.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/user_cedula/represtamo_user_cedula.dart';
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
  Future<(bool, String)> createSolicitudAsalariado({
    required SolicitudAsalariado solicitudAsalariado,
  });
  Future<CatalogoValor> getCatalogoByCodigo({required String codigo});
  Future<CatalogoNacionalidad> getNacionalidadByCodigo({
    required String codigo,
  });
  Future<CatalogoValor> getCatalogoProductos();
  Future<UserCedulaResponse> getUserByCedula({required String cedula});
  Future<ReprestamoUserCedula> getUserReprestamoByCedula({
    required String cedula,
  });
  Future<ParametroValor> getParametroByName({required String nombre});
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
      if (resp['statusCode'] == 409) {
        _logger.i(endpoint.body);

        return (false, (resp.toString()));
      }
      if (resp['statusCode'] != 201) {
        _logger.i(endpoint.body);

        return (false, (resp.toString()));
      }

      _logger.i(resp);
      _logger.i(endpoint.body);

      return (true, resp['message'] as String);
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
      if (resp['statusCode'] != 200) {
        throw AppException(optionalMsg: 'App Exception: ${resp['message']}');
      }
      final data = CatalogoValor.fromJson(resp);
      return data;
    } on TimeoutException catch (e) {
      _logger.e('Tiempo de espera agotado: $e');
      throw AppException(optionalMsg: 'Tiemp de espera agotado');
    } on SocketException catch (e) {
      _logger.e('Sin conexión a internet: $e');
      throw AppException(optionalMsg: 'No hay conexión a internet');
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
        throw AppException(optionalMsg: resp['message']);
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
      if (resp['statusCode'] == 409) {
        _logger.i(endpoint.body);
        AppException(optionalMsg: resp['message'] as String);
        return (false, resp['message'] as String);
      }
      if (resp['statusCode'] != 201) {
        _logger.i(endpoint.body);
        AppException(optionalMsg: resp['message']['message'] as String);
        return (false, resp['message']['message'] as String);
      }

      _logger.i(resp);

      return (true, resp['message'] as String);
    } catch (e) {
      _logger.e(e);
      _logger.i(endpoint.body);
      return (false, e.toString());
    }
  }

  @override
  Future<ReprestamoUserCedula> getUserReprestamoByCedula({
    required String cedula,
  }) async {
    final endpoint = ReprestamoUserCedulaEndpoint(cedula: cedula);
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        throw AppException(optionalMsg: resp['message']);
      }
      final data = ReprestamoUserCedula.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<(bool, String)> createSolicitudAsalariado({
    required SolicitudAsalariado solicitudAsalariado,
  }) async {
    final endpoint = SolicitudAsalariadoEndpoint(
      solicitudAsalariado: solicitudAsalariado,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) {
        _logger.e(resp);
        _logger.i(endpoint.body);
        return (false, resp['message'] as String);
      }
      _logger.i(resp);
      _logger.i(endpoint.body);

      return (true, resp['message'] as String);
    } catch (e) {
      _logger.e(e);
      _logger.i(endpoint.body);
      return (false, e.toString());
    }
  }

  @override
  Future<ParametroValor> getParametroByName({required String nombre}) async {
    final endpoint = ObtenerParametrosEndpoint(nombre: nombre);
    try {
      final resp = await _api.request(endpoint: endpoint);
      final data = ParametroValor.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}

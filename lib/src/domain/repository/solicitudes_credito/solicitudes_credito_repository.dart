import 'dart:async';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/config/helpers/error_handler/http_error_handler.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/asalariado/solicitud_asalariado.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/catalogo/catalogo_valor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/catalogo_frecuencia_pago/catalogo_frecuencia_pago.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/nacionalidad/catalogo_nacionalidad.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/nueva_menor/solicitud_nueva_menor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/parametro/parametro_valor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/represtamo/solicitud_represtamo.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/user_cedula/represtamo_user_cedula.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/user_cedula/user_cedula_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/endpoint/solicitudes_credito_endpoint.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
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
  Future<(UserCedulaData?, bool, String)> getUserByCedulaNuevaMenor({
    required String cedula,
  });
  Future<ReprestamoUserCedula> getUserReprestamoByCedula({
    required String cedula,
  });
  Future<ParametroValor> getParametroByName({required String nombre});
  Future<CatalogoFrecuenciaPago> getCatalogoFrecuenciaPago();
  Future<(UserCedulaData?, bool, String)> getUserByCedulaAsalariado({
    required String cedula,
  });
  Future<(UserCedulaData?, bool, String)> determineUserCedulaByTypeForm({
    required String cedula,
    required TypeForm typeForm,
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
      if (resp['statusCode'] == 409) {
        _logger.i(endpoint.body);

        return (false, (resp['message'] as String));
      }
      if (resp['statusCode'] != 201) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);

        return (false, errorMsg);
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
      if (resp['statusCode'] != 200) {
        final (errorMsg, status) = getErrorMessage(
          resp,
          errorMsg:
              'Tienes problemas de conexión. Revisa tu conexión a internet.',
        );
        throw AppException(optionalMsg: '$errorMsg - $status');
      }

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
      if (resp['statusCode'] != 200) {
        final (errorMsg, status) = getErrorMessage(
          resp,
          errorMsg:
              'Tienes problemas de conexión. Revisa tu conexión a internet.',
        );
        throw AppException(optionalMsg: '$errorMsg - $status');
      }
      final data = CatalogoValor.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<(UserCedulaData?, bool, String)> getUserByCedulaNuevaMenor({
    required String cedula,
  }) async {
    final endpoint = UserCedulaEndpoint(cedula: cedula);

    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        final (errorMsg, _) = getErrorMessage(
          resp,
          errorMsg: 'Aun puedes seguir creando la solicitud',
        );
        throw AppException(optionalMsg: errorMsg);
      }
      if (resp['data'] == null) return (null, true, 'NO_DATA');
      final data = UserCedulaData.fromJson(resp);

      return (data, false, 'OK');
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
        AppException(optionalMsg: resp.toString());
        return (false, resp.toString());
      }
      if (resp['statusCode'] != 201) {
        _logger.i(endpoint.body);
        final (errorMsg, _) = getErrorMessage(resp);
        return (false, errorMsg);
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
        final (errorMsg, _) = getErrorMessage(resp, errorMsg: '');
        throw AppException(optionalMsg: errorMsg);
      }
      final data = ReprestamoUserCedula.fromJson(resp['data']);
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
        final (errorMsg, _) = getErrorMessage(resp);
        return (false, errorMsg);
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
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<CatalogoFrecuenciaPago> getCatalogoFrecuenciaPago() async {
    final endpoint = CatalogoFrecuenciaPagoEndpoint();
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        final (errorMsg, status) = getErrorMessage(
          resp,
          errorMsg:
              'Tienes problemas de conexión. Revisa tu conexión a internet.',
        );
        throw AppException(optionalMsg: '$errorMsg - $status');
      }
      final data = CatalogoFrecuenciaPago.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<(UserCedulaData?, bool, String)> getUserByCedulaAsalariado({
    required String cedula,
  }) async {
    final endpoint = AsalariadoUserCedulaEndpoint(cedula: cedula);

    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        final (errorMsg, _) = getErrorMessage(
          resp,
          errorMsg: 'Aun puedes seguir creando la solicitud',
        );
        throw AppException(optionalMsg: errorMsg);
      }
      if (resp['data'] == null) return (null, true, 'NO_DATA');
      final data = UserCedulaData.fromJson(resp);

      return (data, false, 'OK');
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<(UserCedulaData?, bool, String)> determineUserCedulaByTypeForm({
    required String cedula,
    required TypeForm typeForm,
  }) async {
    switch (typeForm) {
      case TypeForm.nueva:
        return getUserByCedulaNuevaMenor(cedula: cedula);
      case TypeForm.asalariado:
        return getUserByCedulaAsalariado(cedula: cedula);

      default:
        throw AppException(optionalMsg: 'Form Type not found');
    }
  }
}

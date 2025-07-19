import 'dart:async';
import 'dart:convert';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/config/helpers/error_handler/http_error_handler.dart';
import 'package:core_financiero_app/src/config/helpers/error_reporter/error_reporter.dart';
import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/asalariado/solicitud_asalariado.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/asesor/asesor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/catalogo/catalogo_valor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/catalogo_frecuencia_pago/catalogo_frecuencia_pago.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/nacionalidad/catalogo_nacionalidad.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/nueva_menor/solicitud_nueva_menor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/parametro/parametro_valor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/represtamo/solicitud_represtamo.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/user_cedula/represtamo_user_cedula.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/user_cedula/user_cedula_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/endpoint/solicitudes_credito_endpoint.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

abstract class SolicitudesCreditoRepository {
  Future<(bool, String, String?)> createSolicitudCreditoNuevaMenor({
    required SolicitudNuevaMenor solicitudNuevaMenor,
  });
  Future<(bool, String, String?)> createSolicitudReprestamo({
    required SolicitudReprestamo solicitudReprestamo,
  });
  Future<(bool, String, String?)> createSolicitudAsalariado({
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
  Future<(bool, SolicitudByEstado)> getSolicitudesNuevaMenorPorEstado({
    required EstadoCredito estadoCredito,
    required bool isAsignadaToAsesorCredito,
    required String? numeroSolicitud,
    required String? cedulaCliente,
  });
  Future<(bool, SolicitudByEstado)> getSolicitudesAsalariadoPorEstado({
    required EstadoCredito estadoCredito,
    required bool isAsignadaToAsesorCredito,
    required String? numeroSolicitud,
    required String? cedulaCliente,
  });
  Future<(bool, SolicitudByEstado)> getSolicitudesReprestamoPorEstado({
    required EstadoCredito estadoCredito,
    required bool isAsignadaToAsesorCredito,
    required String? numeroSolicitud,
    required String? cedulaCliente,
  });
  Future<(bool, Asesor)> getAsesores();
  Future<(bool, String)> asignSolicitudNuevaToAsesor({
    required int idSolicitud,
    required int idPromotor,
  });
  Future<(bool, String)> asignSolicitudReprestamoToAsesor({
    required int idSolicitud,
    required int idPromotor,
  });
  Future<(bool, String)> asignSolicitudAsalariadoToAsesor({
    required int idSolicitud,
    required int idPromotor,
  });
  Future<(bool, SolicitudByEstado)> getSolicitudesEstadoByTypeForm({
    required TypeForm typeForm,
    required EstadoCredito estadoCredito,
    required bool isAsignadaToAsesorCredito,
    required String? numeroSolicitud,
    required String? cedulaCliente,
  });
  Future<(bool, SolicitudByEstado)> getSolicitudesCreditoByEstado({
    required EstadoCredito estadoCredito,
    required bool isAsignadaToAsesorCredito,
    required String? numeroSolicitud,
    required String? cedulaCliente,
  });
  Future<(bool, String)> asginSolicitudCreditoToAsesor({
    required int idSolicitud,
    required int idPromotor,
    required TypeForm typeForm,
  });
  Future<(bool, String)> sendCedulaImageWhenSolicitudCreditoCreated({
    required int numeroSolicitud,
    required String cedulaCliente,
    required String imagenFrontal,
    required String imagenTrasera,
  });
}

class SolicitudCreditoRepositoryImpl implements SolicitudesCreditoRepository {
  final _api = global<APIRepository>();
  final _logger = Logger();
  @override
  Future<(bool, String, String?)> createSolicitudCreditoNuevaMenor({
    required SolicitudNuevaMenor solicitudNuevaMenor,
  }) async {
    final endpoint = SolicitudesCreditoNuevaMenorEndpoint(
      solicitudNuevaMenor: solicitudNuevaMenor,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] == 409) {
        _logger.i(endpoint.body);

        return (false, (resp['message'] as String), null);
      }
      if (resp['statusCode'] != 201) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);

        return (false, errorMsg, null);
      }

      _logger.i(resp);
      _logger.i(endpoint.body);

      return (
        true,
        resp['message'] as String,
        resp['NumeroSolicitud'] as String
      );
    } catch (e) {
      _logger.e(e);
      _logger.i(endpoint.body);
      return (false, e.toString(), null);
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
  Future<(bool, String, String?)> createSolicitudReprestamo({
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
        return (false, resp.toString(), null);
      }
      if (resp['statusCode'] != 201) {
        _logger.i(endpoint.body);
        final (errorMsg, _) = getErrorMessage(resp);
        return (false, errorMsg, null);
      }

      _logger.i(resp);

      return (
        true,
        resp['message'] as String,
        resp['NumeroSolicitud'] as String
      );
    } catch (e) {
      _logger.e(e);
      _logger.i(endpoint.body);
      return (
        false,
        e.toString(),
        null,
      );
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
  Future<(bool, String, String?)> createSolicitudAsalariado({
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
        return (false, errorMsg, null);
      }
      _logger.i(resp);
      _logger.i(endpoint.body);

      return (
        true,
        resp['message'] as String,
        resp['NumeroSolicitud'] as String
      );
    } catch (e) {
      _logger.e(e);
      _logger.i(endpoint.body);

      return (false, e.toString(), null);
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

  @override
  Future<(bool, SolicitudByEstado)> getSolicitudesNuevaMenorPorEstado({
    required EstadoCredito estadoCredito,
    required bool isAsignadaToAsesorCredito,
    required String? numeroSolicitud,
    required String? cedulaCliente,
  }) async {
    final endpoint = NuevaMenorObtenerSolicitudesPorEstadoEndpoint(
      estadoCredito: estadoCredito,
      isAsignadaToAsesorCredito: isAsignadaToAsesorCredito,
      numeroSolicitud: numeroSolicitud,
      cedulaCliente: cedulaCliente,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.e(resp);
        final (errorMsg, _) =
            getErrorMessage(resp, errorMsg: 'Tienes problemas de conexión.');
        throw AppException(optionalMsg: errorMsg);
      }
      final data = SolicitudByEstado.fromJson(resp);
      _logger.i(resp);
      return (true, data);
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<(bool, Asesor)> getAsesores() async {
    final endpoint = ObtenerAsesoresEndpoint();
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.e(resp);
        final (errorMsg, _) = getErrorMessage(
          resp,
          errorMsg: 'Tienes problemas de conexión.',
        );
        throw AppException(optionalMsg: errorMsg);
      }
      final data = Asesor.fromJson(resp);
      _logger.i(resp);
      return (true, data);
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<(bool, String)> asignSolicitudNuevaToAsesor({
    required int idSolicitud,
    required int idPromotor,
  }) async {
    final endpoint = AsignarSolicitudEndpoint(
      idSolicitud: idSolicitud,
      idPromotor: idPromotor,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.e(resp);
        final (errorMsg, _) = getErrorMessage(
          resp,
          errorMsg: 'Tienes problemas de conexión.',
        );
        return (false, errorMsg);
      }

      _logger.i(resp);
      return (true, resp.toString());
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }

  @override
  Future<(bool, SolicitudByEstado)> getSolicitudesAsalariadoPorEstado({
    required EstadoCredito estadoCredito,
    required bool isAsignadaToAsesorCredito,
    required String? numeroSolicitud,
    required String? cedulaCliente,
  }) async {
    final endpoint = AsalariadoObtenerSolicitudesPorEstadoEndpoint(
      estadoCredito: estadoCredito,
      isAsignadaToAsesorCredito: isAsignadaToAsesorCredito,
      numeroSolicitud: numeroSolicitud,
      cedulaCliente: cedulaCliente,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.e(resp);
        final (errorMsg, _) =
            getErrorMessage(resp, errorMsg: 'Tienes problemas de conexión.');
        throw AppException(optionalMsg: errorMsg);
      }
      final data = SolicitudByEstado.fromJson(resp);
      _logger.i(resp);
      return (true, data);
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<(bool, SolicitudByEstado)> getSolicitudesReprestamoPorEstado({
    required EstadoCredito estadoCredito,
    required bool isAsignadaToAsesorCredito,
    required String? numeroSolicitud,
    required String? cedulaCliente,
  }) async {
    final endpoint = ReprestamoObtenerSolicitudesPorEstadoEndpoint(
      estadoCredito: estadoCredito,
      isAsignadaToAsesorCredito: isAsignadaToAsesorCredito,
      numeroSolicitud: numeroSolicitud,
      cedulaCliente: cedulaCliente,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.e(resp);
        final (errorMsg, _) =
            getErrorMessage(resp, errorMsg: 'Tienes problemas de conexión.');
        throw AppException(optionalMsg: errorMsg);
      }
      final data = SolicitudByEstado.fromJson(resp);
      _logger.i(resp);
      return (true, data);
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<(bool, SolicitudByEstado)> getSolicitudesEstadoByTypeForm({
    required TypeForm typeForm,
    required EstadoCredito estadoCredito,
    required bool isAsignadaToAsesorCredito,
    required String? numeroSolicitud,
    required String? cedulaCliente,
  }) async {
    return switch (typeForm) {
      TypeForm.nueva => await getSolicitudesNuevaMenorPorEstado(
          estadoCredito: estadoCredito,
          isAsignadaToAsesorCredito: isAsignadaToAsesorCredito,
          numeroSolicitud: numeroSolicitud,
          cedulaCliente: cedulaCliente,
        ),
      TypeForm.asalariado => await getSolicitudesAsalariadoPorEstado(
          estadoCredito: estadoCredito,
          isAsignadaToAsesorCredito: isAsignadaToAsesorCredito,
          numeroSolicitud: numeroSolicitud,
          cedulaCliente: cedulaCliente,
        ),
      TypeForm.represtamo => await getSolicitudesReprestamoPorEstado(
          estadoCredito: estadoCredito,
          isAsignadaToAsesorCredito: isAsignadaToAsesorCredito,
          numeroSolicitud: numeroSolicitud,
          cedulaCliente: cedulaCliente,
        ),
    };
  }

  @override
  Future<(bool, String)> asignSolicitudAsalariadoToAsesor({
    required int idSolicitud,
    required int idPromotor,
  }) async {
    final endpoint = AsignarSolicitudAsalariadoEndpoint(
      idSolicitud: idSolicitud,
      idPromotor: idPromotor,
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
      return (true, resp.toString());
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }

  @override
  Future<(bool, String)> asignSolicitudReprestamoToAsesor({
    required int idSolicitud,
    required int idPromotor,
  }) async {
    final endpoint = AsignarSolicitudReprestamoEndpoint(
      idSolicitud: idSolicitud,
      idPromotor: idPromotor,
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
      return (true, resp['message'] as String);
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }

  @override
  Future<(bool, String)> asginSolicitudCreditoToAsesor({
    required int idSolicitud,
    required int idPromotor,
    required TypeForm typeForm,
  }) async {
    return switch (typeForm) {
      TypeForm.nueva => await asignSolicitudNuevaToAsesor(
          idSolicitud: idSolicitud,
          idPromotor: idPromotor,
        ),
      TypeForm.asalariado => await asignSolicitudAsalariadoToAsesor(
          idSolicitud: idSolicitud,
          idPromotor: idPromotor,
        ),
      TypeForm.represtamo => await asignSolicitudReprestamoToAsesor(
          idSolicitud: idSolicitud,
          idPromotor: idPromotor,
        ),
    };
  }

  @override
  Future<(bool, String)> sendCedulaImageWhenSolicitudCreditoCreated({
    required int numeroSolicitud,
    required String cedulaCliente,
    required String imagenFrontal,
    required String imagenTrasera,
  }) async {
    const apiUrl = String.fromEnvironment('apiUrl');
    const protocol = String.fromEnvironment('protocol');
    const url = '$protocol://$apiUrl/solicitudes/registrar-cedula';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['numeroSolicitud'] = numeroSolicitud.toString();
      request.fields['cedula'] = cedulaCliente;
      request.fields['database'] = LocalStorage().database;
      request.files.add(await http.MultipartFile.fromPath(
        'frontal',
        imagenFrontal,
        filename: imagenFrontal,
        contentType: MediaType('image', 'jpg'),
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'trasera',
        imagenTrasera,
        filename: imagenTrasera,
        contentType: MediaType('image', 'jpg'),
      ));
      request.headers.addAll({
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer ${LocalStorage().jwt}',
        'CF-Access-Client-Id': const String.fromEnvironment('CFAccessClientId'),
        'CF-Access-Client-Secret':
            const String.fromEnvironment('CFAccessClientSecret'),
      });
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      final Map<String, dynamic> jsonBody = json.decode(responseBody.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        _logger.i('Imagenes enviadas exitosamente: ${responseBody.body}');
      } else {
        await ErrorReporter.registerError(
          errorMessage:
              'Error enviando imagenes Solicitudes: ${jsonBody['message']}',
          statusCode: response.statusCode.toString(),
          username: LocalStorage().currentUserName,
        );
        _logger.e(
            'Error del servidor: ${response.statusCode}, ${responseBody.body}, ${responseBody.reasonPhrase}, ${responseBody.request}');
        return (
          false,
          jsonBody['message'] as String,
        );
      }
      _logger.i(response.reasonPhrase);
      return (true, 'Imagenes Enviadas exitosamente!');
    } catch (e) {
      await ErrorReporter.registerError(
        errorMessage: 'Error enviando imagenes Solicitudes: $e',
        statusCode: '400',
        username: LocalStorage().currentUserName,
      );
      _logger.e(e);
      return (false, e.toString());
    }
  }

  @override
  Future<(bool, SolicitudByEstado)> getSolicitudesCreditoByEstado({
    required EstadoCredito estadoCredito,
    required bool isAsignadaToAsesorCredito,
    required String? numeroSolicitud,
    required String? cedulaCliente,
  }) async {
    final endpoint = GetSolicitudesCreditoByEstado(
      estadoCredito: estadoCredito,
      isAsignadaToAsesorCredito: isAsignadaToAsesorCredito,
      numeroSolicitud: numeroSolicitud,
      cedulaCliente: cedulaCliente,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.e(resp);
        final (errorMsg, _) =
            getErrorMessage(resp, errorMsg: 'Tienes problemas de conexión.');
        throw AppException(optionalMsg: errorMsg);
      }
      final data = SolicitudByEstado.fromJson(resp);
      _logger.i(resp);
      return (true, data);
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}

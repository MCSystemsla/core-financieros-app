import 'dart:convert';

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/config/helpers/error_handler/http_error_handler.dart';
import 'package:core_financiero_app/src/config/helpers/error_reporter/error_reporter.dart';
import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/catalogos/actividades_economicas_alias_filtered.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/solicitud_asalariado_hn.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/nuevamenor/solicitud_nueva_menor_hn.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/represtamo/solicitud_represtamo_hn.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/user_by_document/user_by_document.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/user_by_document/user_by_document_represtamo.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/asesor/asesor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/catalogo/catalogo_valor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/catalogo_frecuencia_pago/catalogo_frecuencia_pago.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/nacionalidad/catalogo_nacionalidad.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/parametro/parametro_valor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/endpoint/solicitudes_credito_hn_endpoint.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/crear_solicitud_screen.dart';
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

abstract class SolicitudesCreditoHnRepository {
  Future<(bool, String, String?)> createSolicitudAsalariado({
    required SolicitudAsalariadoHn solicitud,
  });
  Future<(bool, String, String?)> createSolicitudNuevaMenor({
    required SolicitudNuevaMenorHn solicitud,
  });
  Future<(bool, String)> createSolicitudReprestamo({
    required SolicitudReprestamoHn solicitud,
  });
  Future<(bool, String)> sendCedulaImageWhenSolicitudCreditoCreated({
    required int numeroSolicitud,
    required String cedulaCliente,
    required String imagenFrontal,
    required String imagenTrasera,
  });
  Future<CatalogoValor> getCatalogoByCodigo({required String codigo});
  Future<CatalogoValor> getCatalogoProducts();
  Future<CatalogoNacionalidad> getCatalogoUbicaciones({required String codigo});
  Future<CatalogoFrecuenciaPago> getCatalogoFrecuenciaPago();
  Future<ParametroValor> getParametroValor({required String nombre});
  Future<(UserByDocumentHn?, bool)> getUserByDocument({
    required String nombre,
    required String cedula,
    required String tipoDocumentoCodigo,
  });
  Future<UserByDocumentReprestamoHn> getUserByDocumentReprestamo({
    required String nombre,
    required String cedula,
    required String tipoDocumentoCodigo,
  });
  Future<(UserByDocumentHn?, bool)> getUserByDocumentAsalariado({
    required String nombre,
    required String cedula,
    required String tipoDocumentoCodigo,
  });
  Future<SolicitudByEstado> getSolicitudesByEstado({
    required EstadoCredito estadoCredito,
    required bool isAsignadaToAsesorCredito,
    required String? numeroSolicitud,
    required String? cedulaCliente,
    required int pagina,
  });
  Future<(bool, String)> asignSolicitudToAsesor({
    required int idSolicitud,
    required int idPromotor,
    required TypeForm typeForm,
  });
  Future<(bool, String)> asignSolicitudToAsesorNuevaMenor({
    required int idSolicitud,
    required int idPromotor,
  });
  Future<(bool, String)> asignSolicitudToAsesorAsalariado({
    required int idSolicitud,
    required int idPromotor,
  });
  Future<(bool, String)> asignSolicitudToAsesorReprestamo({
    required int idSolicitud,
    required int idPromotor,
  });
  Future<(bool, Asesor)> getAsesores();
  Future<ActividadesEconomicasAliasFilteredResponse>
      getActividadesEconomicasAliasFiltered();
}

class SolicitudesCreditoHnRepositoryImpl
    implements SolicitudesCreditoHnRepository {
  final _api = global<APIRepository>();
  final _logger = Logger();
  @override
  Future<(bool, String, String?)> createSolicitudAsalariado({
    required SolicitudAsalariadoHn solicitud,
  }) async {
    final endpoint = CrearSolciitudAsalariadoHNEndpoint(
      solicitud: solicitud,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] == 409) {
        _logger.i(endpoint.body);
        return (false, resp.toString(), null);
      }
      if (resp['statusCode'] != 201) {
        _logger.i(endpoint.body);
        // final (errorMsg, _) = getErrorMessage(resp);
        return (false, resp.toString(), null);
      }

      _logger.i(endpoint.body);
      return (
        true,
        resp['message'] as String,
        resp['NumeroSolicitud'] as String,
      );
    } catch (e) {
      _logger.e(e.toString());
      return (false, e.toString(), null);
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
  Future<(bool, String, String?)> createSolicitudNuevaMenor({
    required SolicitudNuevaMenorHn solicitud,
  }) async {
    final endpoint = CrearSolciitudNuevaMenorHNEndpoint(
      solicitud: solicitud,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] == 409) {
        _logger.i(endpoint.body);
        return (false, resp.toString(), null);
      }
      if (resp['statusCode'] != 201) {
        _logger.i(endpoint.body);
        return (false, resp.toString(), null);
      }
      _logger.i(endpoint.body);
      return (
        true,
        resp['message'] as String,
        resp['NumeroSolicitud'] as String,
      );
    } catch (e) {
      _logger.e(e.toString());
      return (false, e.toString(), null);
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

  @override
  Future<(bool, String)> createSolicitudReprestamo({
    required SolicitudReprestamoHn solicitud,
  }) async {
    final endpoint = CreateSolicitudReprestamoHNEndpoint(
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
        // final (_, _) = getErrorMessage(resp);
        return (false, resp.toString());
      }

      _logger.i(resp);
      return (true, resp['message'] as String);
    } catch (e) {
      _logger.e(e.toString());
      return (false, e.toString());
    }
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
    const url = '$protocol://$apiUrl/solicitudes/general/subir-fotos-cedula';

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
  Future<(UserByDocumentHn?, bool)> getUserByDocument({
    required String nombre,
    required String cedula,
    required String tipoDocumentoCodigo,
  }) async {
    final endpoint = ObtenerAutoCompletadoNuevaMenorEndpoint(
      nombre: nombre,
      cedula: cedula,
      tipoDocumentoCodigo: tipoDocumentoCodigo,
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
      if (resp['data'] == null) {
        return (null, true);
      }
      final data = UserByDocumentHn.fromJson(resp);
      return (data, false);
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<UserByDocumentReprestamoHn> getUserByDocumentReprestamo({
    required String nombre,
    required String cedula,
    required String tipoDocumentoCodigo,
  }) async {
    final endpoint = ObtenerAutoCompletadoReprestamoEndpoint(
      nombre: nombre,
      cedula: cedula,
      tipoDocumentoCodigo: tipoDocumentoCodigo,
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
      final data = UserByDocumentReprestamoHn.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<(UserByDocumentHn?, bool)> getUserByDocumentAsalariado({
    required String nombre,
    required String cedula,
    required String tipoDocumentoCodigo,
  }) async {
    final endpoint = ObtenerAutoCompletadoAsalariadoEndpoint(
      nombre: nombre,
      cedula: cedula,
      tipoDocumentoCodigo: tipoDocumentoCodigo,
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
      if (resp['data'] == null) return (null, true);
      final data = UserByDocumentHn.fromJson(resp);
      return (data, false);
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<SolicitudByEstado> getSolicitudesByEstado({
    required EstadoCredito estadoCredito,
    required bool isAsignadaToAsesorCredito,
    required String? numeroSolicitud,
    required String? cedulaCliente,
    required int pagina,
  }) async {
    final endpoint = GetSolicitudesByEstadoEndpoint(
      estadoCredito: estadoCredito,
      isAsignadaToAsesorCredito: isAsignadaToAsesorCredito,
      numeroSolicitud: numeroSolicitud,
      cedulaCliente: cedulaCliente,
      pagina: pagina,
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
      final data = SolicitudByEstado.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<(bool, String)> asignSolicitudToAsesorAsalariado({
    required int idSolicitud,
    required int idPromotor,
  }) async {
    final endpoint = AsignSolicitudToAsesorAsalariadoHNEndpoint(
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
  Future<(bool, String)> asignSolicitudToAsesorNuevaMenor({
    required int idSolicitud,
    required int idPromotor,
  }) async {
    final endpoint = AsignSolicitudToAsesorNuevaMenorHNEndpoint(
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
  Future<(bool, String)> asignSolicitudToAsesorReprestamo({
    required int idSolicitud,
    required int idPromotor,
  }) async {
    final endpoint = AsignSolicitudToAsesorReprestamoHNEndpoint(
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
  Future<(bool, String)> asignSolicitudToAsesor({
    required int idSolicitud,
    required int idPromotor,
    required TypeForm typeForm,
  }) async {
    return switch (typeForm) {
      TypeForm.nueva => await asignSolicitudToAsesorNuevaMenor(
          idSolicitud: idSolicitud,
          idPromotor: idPromotor,
        ),
      TypeForm.asalariado => await asignSolicitudToAsesorAsalariado(
          idSolicitud: idSolicitud,
          idPromotor: idPromotor,
        ),
      TypeForm.represtamo => await asignSolicitudToAsesorReprestamo(
          idSolicitud: idSolicitud,
          idPromotor: idPromotor,
        ),
    };
  }

  @override
  Future<(bool, Asesor)> getAsesores() async {
    final endpoint = GetAsesoresHNEndpoint();
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.e(resp);
        final (errorMsg, _) = getErrorMessage(
          resp,
          errorMsg: 'Tienes problemas de conexión a internet.',
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
  Future<ActividadesEconomicasAliasFilteredResponse>
      getActividadesEconomicasAliasFiltered() async {
    final endpoint = ActividadesEconomicasAliasFilteredEndpoint();
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.e(resp);
        final (errorMsg, _) = getErrorMessage(
          resp,
          errorMsg: 'Tienes problemas de conexión a internet.',
        );
        throw AppException(optionalMsg: errorMsg);
      }
      final data = ActividadesEconomicasAliasFilteredResponse.fromJson(resp);
      _logger.i(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}

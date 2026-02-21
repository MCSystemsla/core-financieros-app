import 'dart:convert';

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/config/helpers/error_handler/http_error_handler.dart';
import 'package:core_financiero_app/src/config/helpers/error_reporter/error_reporter.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_asalariado_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_checks_response.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_grupal_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_menor_mil.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_represtamo_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores/analisis_fiadores_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores/analisis_fiadores_search_client_by_document.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores/fiadores_response.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores_checks_response.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_dpfs_response_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_credito_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_data_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/evaluador_cnbs_response.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/plan_inversion/analisis_plan_inversion.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/plan_inversion/plan_inversion_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/endpoint/analisis_endpoint_hn.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

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
  Future<void> createAnalisisGrupal({
    required AnalisisGrupal analisisSolicitudGrupal,
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
  Future<AnalisisGarantiaArticuloHn> getAnalisisGarantiasArticulos({
    required String tipoGarantiaCodigo,
  });
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
    required String cedulaCliente,
  });
  Future<FiadoresCheckResponse> fiadoresChecks({
    required int numeroSolicitud,
    required String tipoSolicitud,
  });
  Future<void> createAnalisisNuevaMenorMil({
    required AnalisisMenorMilHN analisis,
  });
  Future<void> createAnalisisReprestamoMenorMil({
    required AnalisisMenorMilHN analisis,
  });
  Future<void> createAnalisisMenorMilByTipoSolicitud({
    required AnalisisMenorMilHN analisis,
    required AnalisisSolicitudesInterceptorType tipoSolicitud,
  });
  Future<EvaluadorCnbsResponse> getEvaluadoresGarantia();
  Future<FiadoresResponse> getFiadoresByNumeroSolicitud({
    required String tipoFiadorCodigo,
    required int numeroSolicitud,
  });
  Future<PlanInversionResponse> getPlanInversionAnalisis({
    required int numeroSolicitud,
  });

  Future<(bool, String)> createAnalisisFotoNegocio({
    required int numeroSolicitud,
    required String cedulaCliente,
    required String imagenNegocio,
    required String imagenNegocio2,
    required String imagenNegocio3,
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
  Future<AnalisisGarantiaArticuloHn> getAnalisisGarantiasArticulos(
      {required String tipoGarantiaCodigo}) async {
    final endpoint = ObtenerArticulosGarantiasHNEndpoint(
      tipoGarantiaCodigo: tipoGarantiaCodigo,
    );
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
    required String cedulaCliente,
  }) async {
    final endpoint = GetAnalsisChecksEndpointHN(
      numeroSolicitud: numeroSolicitud,
      tipoSolicitud: tipoSolicitud,
      cedulaCliente: cedulaCliente,
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

  @override
  Future<FiadoresCheckResponse> fiadoresChecks({
    required int numeroSolicitud,
    required String tipoSolicitud,
  }) async {
    final endpoint = GetAnalisisFiadoresChecksEndpointHN(
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

      final data = FiadoresCheckResponse.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> createAnalisisNuevaMenorMil({
    required AnalisisMenorMilHN analisis,
  }) async {
    final endpoint = CrearAnalisisMenorMilNuevaHNEndpoint(
      analisisSolicitudMenorMil: analisis,
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
  Future<void> createAnalisisReprestamoMenorMil({
    required AnalisisMenorMilHN analisis,
  }) async {
    final endpoint = CrearAnalisisMenorMilNuevaHNEndpoint(
      analisisSolicitudMenorMil: analisis,
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
  Future<void> createAnalisisMenorMilByTipoSolicitud({
    required AnalisisMenorMilHN analisis,
    required AnalisisSolicitudesInterceptorType tipoSolicitud,
  }) async {
    return switch (tipoSolicitud) {
      AnalisisSolicitudesInterceptorType.nueva => createAnalisisNuevaMenorMil(
          analisis: analisis,
        ),
      AnalisisSolicitudesInterceptorType.represtamo =>
        createAnalisisReprestamoMenorMil(
          analisis: analisis,
        ),
      _ => throw Exception('Tipo Solicitud no reconocido: $tipoSolicitud'),
    };
  }

  @override
  Future<EvaluadorCnbsResponse> getEvaluadoresGarantia() async {
    final endpoint = GetEvaluadoresGarantiaHnEndpoint();
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }

      final data = EvaluadorCnbsResponse.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<FiadoresResponse> getFiadoresByNumeroSolicitud({
    required String tipoFiadorCodigo,
    required int numeroSolicitud,
  }) async {
    final endpoint = GetFiadoresByNumeroSolicitudHNEndpoint(
      tipoFiadorCodigo: tipoFiadorCodigo,
      numeroSolicitud: numeroSolicitud,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }

      final data = FiadoresResponse.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<PlanInversionResponse> getPlanInversionAnalisis({
    required int numeroSolicitud,
  }) async {
    final endpoint = GetPlanInversionAnalisisHNEndpoint(
      numeroSolicitud: numeroSolicitud,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }

      final data = PlanInversionResponse.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<(bool, String)> createAnalisisFotoNegocio({
    required int numeroSolicitud,
    required String cedulaCliente,
    required String imagenNegocio,
    required String imagenNegocio2,
    required String imagenNegocio3,
  }) async {
    const apiUrl = String.fromEnvironment('apiUrl');
    const protocol = String.fromEnvironment('protocol');
    const url =
        '$protocol://$apiUrl/cartera/solicitudes/general/analisis/fotos-negocio';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['NumeroSolicitud'] = numeroSolicitud.toString();
      request.fields['Cedula'] = cedulaCliente;
      request.fields['database'] = LocalStorage().database;
      request.files.add(await http.MultipartFile.fromPath(
        'fotoNegocio',
        imagenNegocio,
        filename: imagenNegocio,
        contentType: MediaType('image', 'jpg'),
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'fotoNegocio2',
        imagenNegocio,
        filename: imagenNegocio,
        contentType: MediaType('image', 'jpg'),
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'fotoNegocio3',
        imagenNegocio,
        filename: imagenNegocio,
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
  Future<void> createAnalisisGrupal({
    required AnalisisGrupal analisisSolicitudGrupal,
  }) async {
    final endpoint = CreateAnalisisGrupalEndpoint(
      data: analisisSolicitudGrupal,
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

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/config/helpers/error_handler/http_error_handler.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_aprobacion.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_calculo_datos_response.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_create_service_schema.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_fuentes_financiamiento_response.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_servicios_response.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_solicitud_response.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_solicitudes_on_comite_response.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_tipos_credito_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/endpoint/comite_endpoint_hn.dart';
import 'package:logger/logger.dart';

abstract class ComiteRepositoryHN {
  Future<ComiteSolicitudResponse> obtenerDataSolicitud({
    required int numeroSolicitud,
    required String tipoSolicitud,
  });
  Future<ComiteServicesResponse> obtenerServicios({
    required int comiteID,
    required int plazoCredito,
    required double montoCredito,
    required double capitalAdeudado,
    required int primaSegurosDanios,
    bool esGrupal = false,
    bool esMayorA60 = false,
    bool esDPF = false,
    bool esCreditoHipotecario = false,
  });
  Future<void> crearServicios({
    required ComiteCreateServiceSchema data,
  });
  Future<String> crearAprobacion({
    required ComiteAprobacion data,
  });
  Future<SolicitudesOnComiteResponse> obtenerSolicitudesEnComite({
    int? numeroSolicitud,
    String? documentoCliente,
    String? nombrePromotor,
    int? numeroActa,
  });
  Future<ComiteTiposCreditoResponse> obtenerTiposCredito();
  Future<ComiteFuentesFinanciamientoResponse> obtenerFuentesFinanciamientos();
  Future<ComiteCalculoDatosResponse> obtenerCalculoDatos({
    required int actaID,
    required String productoCodigo,
    required num monto,
    required int plazoMeses,
    required String monedaCodigo,
    required DateTime fechaPrimerPago,
    required bool esRestructuracion,
    required bool esMantieneTasa,
    required String creditoCancelacion,
    required String creditoCancelacion2,
    required String formaPagoCodigo,
    required double comisionSegurosFinanciado,
    required String tipoCobroSaldoDeudorCodigo,
    required String paisCodigo,
  });
}

class ComiteRepositoryHNImpl implements ComiteRepositoryHN {
  final _logger = Logger();
  final _api = global<APIRepository>();
  @override
  Future<ComiteSolicitudResponse> obtenerDataSolicitud({
    required int numeroSolicitud,
    required String tipoSolicitud,
  }) async {
    final endpoint = ComiteObtenerDataSolicitudEndpointHN(
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
      final data = ComiteSolicitudResponse.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<ComiteServicesResponse> obtenerServicios({
    required int comiteID,
    required int plazoCredito,
    required double montoCredito,
    required double capitalAdeudado,
    required int primaSegurosDanios,
    bool esGrupal = false,
    bool esMayorA60 = false,
    bool esDPF = false,
    bool esCreditoHipotecario = false,
  }) async {
    final endpoint = ComiteServiciosHNEndpoint(
      comiteID: comiteID,
      plazoCredito: plazoCredito,
      montoCredito: montoCredito,
      capitalAdeudado: capitalAdeudado,
      primaSegurosDanios: primaSegurosDanios,
      esGrupal: esGrupal,
      esMayorA60: esMayorA60,
      esDPF: esDPF,
      esCreditoHipotecario: esCreditoHipotecario,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }
      final data = ComiteServicesResponse.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> crearServicios({required ComiteCreateServiceSchema data}) async {
    final endpoint = ComiteCrearServiciosHNEndpoint(data: data);
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
  Future<String> crearAprobacion({required ComiteAprobacion data}) async {
    final endpoint = ComiteCrearAprobacionEndpoint(data: data);
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }
      final message = resp['message']?.toString();
      return message ?? 'Acta de Comite aprobada exitosamente';
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<SolicitudesOnComiteResponse> obtenerSolicitudesEnComite({
    int? numeroSolicitud,
    String? documentoCliente,
    String? nombrePromotor,
    int? numeroActa,
  }) async {
    final endpoint = GetSolicitudesOnComiteEndpoint(
      documentoCliente: documentoCliente,
      numeroSolicitud: numeroSolicitud,
      nombrePromotor: nombrePromotor,
      numeroActa: numeroActa,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }
      final data = SolicitudesOnComiteResponse.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<ComiteCalculoDatosResponse> obtenerCalculoDatos({
    required int actaID,
    required String productoCodigo,
    required num monto,
    required int plazoMeses,
    required String monedaCodigo,
    required DateTime fechaPrimerPago,
    required bool esRestructuracion,
    required bool esMantieneTasa,
    required String creditoCancelacion,
    required String creditoCancelacion2,
    required String formaPagoCodigo,
    required double comisionSegurosFinanciado,
    required String tipoCobroSaldoDeudorCodigo,
    required String paisCodigo,
  }) async {
    final endpoint = GetCalculosDatosEndpoint(
      actaID: actaID,
      productoCodigo: productoCodigo,
      monto: monto,
      plazoMeses: plazoMeses,
      monedaCodigo: monedaCodigo,
      fechaPrimerPago: fechaPrimerPago,
      esRestructuracion: esRestructuracion,
      esMantieneTasa: esMantieneTasa,
      creditoCancelacion: creditoCancelacion,
      creditoCancelacion2: creditoCancelacion2,
      formaPagoCodigo: formaPagoCodigo,
      comisionSegurosFinanciado: comisionSegurosFinanciado,
      tipoCobroSaldoDeudorCodigo: tipoCobroSaldoDeudorCodigo,
      paisCodigo: paisCodigo,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.i(endpoint.body);
        _logger.i(endpoint.queryParameters);

        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }
      _logger.i(resp);
      final data = ComiteCalculoDatosResponse.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<ComiteTiposCreditoResponse> obtenerTiposCredito() async {
    final endpoint = ObtenerTiposCreditosHNEndpoint();
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }
      final data = ComiteTiposCreditoResponse.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<ComiteFuentesFinanciamientoResponse>
      obtenerFuentesFinanciamientos() async {
    final endpoint = ObtenerFuentesFinanciamientosHNEndpoint();
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        _logger.i(endpoint.body);
        final (errorMsg, errorCode) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }
      final data = ComiteFuentesFinanciamientoResponse.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/helpers/error_handler/http_error_handler.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_asalariado_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_menor_mil.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_represtamo_hn.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/ni/endpoint/analisis_forms_endpoint_ni.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_solicitudes_interceptor_type.dart';
import 'package:logger/logger.dart';

/// Repositorio de los formularios de análisis de Nicaragua.
///
/// Espeja a `AnalisisRepositoryHn` pero vive aparte para que un cambio de
/// Nicaragua no toque Honduras.
abstract class AnalisisFormsRepositoryNi {
  Future<void> createAnalisisNuevaMayorMil({
    required AnalisisNuevaMayorMilHn analisisSolicitudNuevaMenor,
  });
  Future<void> createAnalisisAsalariado({
    required AnalisisAsalariadoHn analisisSolicitudAsalariado,
  });
  Future<void> createAnalisisReprestamo({
    required AnalisisReprestamoHn analisisSolicitudReprestamo,
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
}

class AnalisisFormsRepositoryNiImpl extends AnalisisFormsRepositoryNi {
  final _logger = Logger();
  final _api = global<APIRepository>();

  @override
  Future<void> createAnalisisNuevaMayorMil({
    required AnalisisNuevaMayorMilHn analisisSolicitudNuevaMenor,
  }) async {
    final endpoint = CreateAnalisisNuevaMayorMilNiEndpoint(
      analisisSolicitudNuevaMenor: analisisSolicitudNuevaMenor,
    );
    await _post(endpoint);
  }

  @override
  Future<void> createAnalisisAsalariado({
    required AnalisisAsalariadoHn analisisSolicitudAsalariado,
  }) async {
    final endpoint = CreateAnalisisAsalariadoNiEndpoint(
      analisisSolicitudAsalariado: analisisSolicitudAsalariado,
    );
    await _post(endpoint);
  }

  @override
  Future<void> createAnalisisReprestamo({
    required AnalisisReprestamoHn analisisSolicitudReprestamo,
  }) async {
    final endpoint = CreateAnalisisReprestamoNiEndpoint(
      analisisSolicitudReprestamo: analisisSolicitudReprestamo,
    );
    await _post(endpoint);
  }

  @override
  Future<void> createAnalisisNuevaMenorMil({
    required AnalisisMenorMilHN analisis,
  }) async {
    final endpoint = CrearAnalisisMenorMilNuevaNiEndpoint(
      analisisSolicitudMenorMil: analisis,
    );
    await _post(endpoint);
  }

  @override
  Future<void> createAnalisisReprestamoMenorMil({
    required AnalisisMenorMilHN analisis,
  }) async {
    // Se mantiene el mismo endpoint que usa Honduras hoy para no cambiar el
    // comportamiento al separar el código. Si el backend de Nicaragua espera
    // la ruta de represtamo, cambiar por CrearAnalisisMenorMilReprestamoNiEndpoint.
    final endpoint = CrearAnalisisMenorMilNuevaNiEndpoint(
      analisisSolicitudMenorMil: analisis,
    );
    await _post(endpoint);
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

  Future<void> _post(Endpoint endpoint) async {
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) {
        _logger.i(endpoint.body);
        final (errorMsg, _) = getErrorMessage(resp);
        throw AppException(optionalMsg: errorMsg.toString());
      }
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/domain/entities/responses/socilitudes_pendientes_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes-pendientes/endpoint/socilitudes_pendientes_endpoint.dart';

abstract class SolicitudesPendientesRepository {
  Future<SolicitudesPendienteResponse> getSolicitudesPendientes();
}

class SolicitudesPendientesRepositoryImpl
    extends SolicitudesPendientesRepository {
  final _api = global<APIRepository>();

  @override
  Future<SolicitudesPendienteResponse> getSolicitudesPendientes() async {
    final endpoint = SolicitudesPendientesEndpoints();
    try {
      final resp = await _api.request(endpoint: endpoint);
      final data = SolicitudesPendienteResponse.fromJson(resp);
      return data;
    } catch (e) {
      throw AppException.toAppException(e.toString());
    }
  }
}

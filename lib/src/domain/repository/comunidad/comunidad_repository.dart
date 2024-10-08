import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/domain/entities/responses/comunidad_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/comunidad/endpoint/comunidad_endpoint.dart';

abstract class ComunidadRepository {
  Future<ComunidadResponse> getComunidades();
}

class ComunidadRepositoryImpl extends ComunidadRepository {
  final _api = global<APIRepository>();

  @override
  Future<ComunidadResponse> getComunidades() async {
    final endpoint = ComunidadEndpoint();
    try {
      final resp = await _api.request(endpoint: endpoint);
      final data = ComunidadResponse.fromJson(resp);
      return data;
    } catch (e) {
      throw AppException.toAppException(e);
    }
  }
}

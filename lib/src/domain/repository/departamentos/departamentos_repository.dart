import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/domain/entities/responses/departamentos_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/endpoint/departamentos_endpoint.dart';

abstract class DepartamentoRepository {
  Future<DepartamentosResponse> getDepartamentos();
}

class DepartamentosRepositoryImpl extends DepartamentoRepository {
  final _api = global<APIRepository>();

  @override
  Future<DepartamentosResponse> getDepartamentos() async {
    try {
      final endpoint = DepartamentosEndpoint();
      final resp = await _api.request(endpoint: endpoint);

      final data = DepartamentosResponse.fromJson(resp);
      return data;
    } catch (e) {
      throw AppException.toAppException(e.toString());
    }
  }
}

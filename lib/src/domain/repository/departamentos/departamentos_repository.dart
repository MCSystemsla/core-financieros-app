import 'dart:async';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/config/helpers/error_handler/http_error_handler.dart';
import 'package:core_financiero_app/src/domain/entities/responses/departamentos_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/endpoint/departamentos_endpoint.dart';
import 'package:logger/logger.dart';

abstract class DepartamentoRepository {
  Future<DepartamentosResponse> getDepartamentos();
}

class DepartamentosRepositoryImpl extends DepartamentoRepository {
  final _api = global<APIRepository>();
  final _logger = Logger();

  @override
  Future<DepartamentosResponse> getDepartamentos() async {
    try {
      final endpoint = DepartamentosEndpoint();
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 200) {
        final (errorMsg, status) = getErrorMessage(
          resp,
          errorMsg:
              'Tienes problemas de conexión. Revisa tu conexión a internet.',
        );
        throw AppException(optionalMsg: '$errorMsg - $status');
      }
      final data = DepartamentosResponse.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}

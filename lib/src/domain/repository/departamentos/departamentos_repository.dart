import 'dart:async';
import 'dart:io';

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
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

      final data = DepartamentosResponse.fromJson(resp);
      return data;
    } on TimeoutException catch (e) {
      _logger.e('Tiempo de espera agotado: $e');
      throw AppException(optionalMsg: 'Tiempo de espera agotado');
    } on SocketException catch (e) {
      _logger.e('Sin conexión a internet: $e');
      throw AppException(optionalMsg: 'No hay conexión a internet');
    } catch (e) {
      throw AppException(optionalMsg: 'App Exception: $e');
    }
  }
}

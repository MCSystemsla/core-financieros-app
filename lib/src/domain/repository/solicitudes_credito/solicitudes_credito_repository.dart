import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/api/api_repository.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/catalogo/catalogo_valor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/nacionalidad/catalogo_nacionalidad.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/nueva_menor/solicitud_nueva_menor.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/endpoint/solicitudes_credito_endpoint.dart';
import 'package:logger/logger.dart';

abstract class SolicitudesCreditoRepository {
  Future<(bool, String)> createSolicitudCreditoNuevaMenor({
    required SolicitudNuevaMenor solicitudNuevaMenor,
  });
  Future<CatalogoValor> getCatalogoByCodigo({required String codigo});
  Future<CatalogoNacionalidad> getNacionalidadByCodigo({
    required String codigo,
  });
  Future<CatalogoValor> getCatalogoProductos();
}

class SolicitudCreditoRepositoryImpl implements SolicitudesCreditoRepository {
  final _api = global<APIRepository>();
  final _logger = Logger();
  @override
  Future<(bool, String)> createSolicitudCreditoNuevaMenor({
    required SolicitudNuevaMenor solicitudNuevaMenor,
  }) async {
    final endpoint = SolicitudesCreditoNuevaMenorEndpoint(
      solicitudNuevaMenor: solicitudNuevaMenor,
    );
    try {
      final resp = await _api.request(endpoint: endpoint);
      if (resp['statusCode'] != 201) return (false, resp['message'] as String);
      _logger.i(resp);
      return (true, resp.toString());
    } catch (e) {
      _logger.e(e);
      return (false, e.toString());
    }
  }

  @override
  Future<CatalogoValor> getCatalogoByCodigo({required String codigo}) async {
    final endpoint = CatalogoSolicitudEndpoint(codigo: codigo);
    try {
      final resp = await _api.request(endpoint: endpoint);
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
      final data = CatalogoValor.fromJson(resp);
      return data;
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }
}

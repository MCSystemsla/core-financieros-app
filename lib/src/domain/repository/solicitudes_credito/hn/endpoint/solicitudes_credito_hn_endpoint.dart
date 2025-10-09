import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/solicitud_asalariado_hn.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/nuevamenor/solicitud_nueva_menor_hn.dart';

class CrearSolciitudAsalariadoHNEndpoint extends Endpoint {
  final SolicitudAsalariadoHn solicitud;

  CrearSolciitudAsalariadoHNEndpoint({
    required this.solicitud,
  });
  @override
  Method get method => Method.post;

  @override
  String get path => '/solicitud-asalariado/crear';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => solicitud.toJson();
}

class CrearSolciitudNuevaMenorHNEndpoint extends Endpoint {
  final SolicitudNuevaMenorHn solicitud;

  CrearSolciitudNuevaMenorHNEndpoint({
    required this.solicitud,
  });
  @override
  Method get method => Method.post;

  @override
  String get path => '/solicitud-nueva-menor/crear';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => solicitud.toJson();
}

class GetCatalogoHNByCodigoEndpoint extends Endpoint {
  final String codigo;
  GetCatalogoHNByCodigoEndpoint({required this.codigo});
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/catalogo/general';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, String> get queryParameters => {
        'database': LocalStorage().database,
        'codigo': codigo,
      };
}

class GetProductosHNEndpoint extends Endpoint {
  GetProductosHNEndpoint();
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/catalogo/producto';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, String> get queryParameters => {
        'database': LocalStorage().database,
      };
}

class GetCatalogosUbicacionesHNEndpoint extends Endpoint {
  final String codigo;
  GetCatalogosUbicacionesHNEndpoint({required this.codigo});
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/catalogo/ubicacion';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, String> get queryParameters => {
        'database': LocalStorage().database,
        'codigo': codigo,
      };
}

class GetCatalogosFrecuenciaDePagoEndpoint extends Endpoint {
  GetCatalogosFrecuenciaDePagoEndpoint();
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/catalogo/frecuencia-pago';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, String> get queryParameters => {
        'database': LocalStorage().database,
      };
}

class GetParametroByCodigoEndpoint extends Endpoint {
  final String nombre;
  GetParametroByCodigoEndpoint({required this.nombre});
  @override
  Method get method => Method.get;

  @override
  String get path => 'cartera/catalogo/obtener-parametro';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, String> get queryParameters => {
        'database': LocalStorage().database,
        'nombre': nombre,
      };
}

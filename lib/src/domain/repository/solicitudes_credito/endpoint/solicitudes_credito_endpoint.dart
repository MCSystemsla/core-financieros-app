import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/nueva_menor/solicitud_nueva_menor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/represtamo/solicitud_represtamo.dart';

class SolicitudesCreditoNuevaMenorEndpoint extends Endpoint {
  final SolicitudNuevaMenor solicitudNuevaMenor;
  SolicitudesCreditoNuevaMenorEndpoint({required this.solicitudNuevaMenor});

  @override
  Method get method => Method.post;

  @override
  String get path => '/solicitudes/crear-solicitud-nuevamenor';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => solicitudNuevaMenor.toJson();
}

class CatalogoSolicitudEndpoint extends Endpoint {
  final String codigo;
  CatalogoSolicitudEndpoint({required this.codigo});

  @override
  Method get method => Method.get;

  @override
  String get path => '/catalogo/obtener-catalogo-activos';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        // if (queryParams != null) ...queryParams!,
        'database': LocalStorage().database,
        'codigo': codigo,
      };
}

class NacionalidadEndpoint extends Endpoint {
  final String codigo;
  NacionalidadEndpoint({required this.codigo});

  @override
  Method get method => Method.get;

  @override
  String get path => '/catalogo/obtener-catalogo-ubicacion';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        // if (queryParams != null) ...queryParams!,
        'database': LocalStorage().database,
        'codigo': codigo,
      };
}

class ProductosEndpoint extends Endpoint {
  ProductosEndpoint();

  @override
  Method get method => Method.get;

  @override
  String get path => '/catalogo/obtener-catalogo-productos';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        // if (queryParams != null) ...queryParams!,
        'database': LocalStorage().database,
      };
}

class UserCedulaEndpoint extends Endpoint {
  final String cedula;
  UserCedulaEndpoint({required this.cedula});

  @override
  Method get method => Method.get;

  @override
  String get path => '/solicitudes/obtener-persona';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
        'cedula': cedula,
      };
}

class SolicitudReprestamoEndpoint extends Endpoint {
  final SolicitudReprestamo solicitudReprestamo;
  SolicitudReprestamoEndpoint({required this.solicitudReprestamo});
  @override
  Method get method => Method.post;

  @override
  String get path => '/solicitudes/crear-solicitud-represtamo';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => solicitudReprestamo.toJson();
}

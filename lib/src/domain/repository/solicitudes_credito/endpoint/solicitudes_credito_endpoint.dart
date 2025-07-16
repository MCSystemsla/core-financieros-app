import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/asalariado/solicitud_asalariado.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/nueva_menor/solicitud_nueva_menor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/represtamo/solicitud_represtamo.dart';

class SolicitudesCreditoNuevaMenorEndpoint extends Endpoint {
  final SolicitudNuevaMenor solicitudNuevaMenor;
  SolicitudesCreditoNuevaMenorEndpoint({required this.solicitudNuevaMenor});

  @override
  Method get method => Method.post;

  @override
  String get path => '/solicitud-nueva-menor/crear';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => solicitudNuevaMenor.toJson();
}

class SolicitudReprestamoEndpoint extends Endpoint {
  final SolicitudReprestamo solicitudReprestamo;
  SolicitudReprestamoEndpoint({required this.solicitudReprestamo});
  @override
  Method get method => Method.post;

  @override
  String get path => '/solicitud-represtamo/crear';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => solicitudReprestamo.toJson();
}

class SolicitudAsalariadoEndpoint extends Endpoint {
  final SolicitudAsalariado solicitudAsalariado;
  SolicitudAsalariadoEndpoint({required this.solicitudAsalariado});
  @override
  Method get method => Method.post;

  @override
  String get path => '/solicitud-asalariado/crear';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => solicitudAsalariado.toJson();
}

class UserCedulaEndpoint extends Endpoint {
  final String cedula;
  UserCedulaEndpoint({required this.cedula});

  @override
  Method get method => Method.get;

  @override
  String get path =>
      '/solicitud-nueva-menor/validar-cedula-y-obtener-auto-completado';
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

class ReprestamoUserCedulaEndpoint extends Endpoint {
  final String cedula;
  ReprestamoUserCedulaEndpoint({required this.cedula});
  @override
  Method get method => Method.get;

  @override
  String get path =>
      '/solicitud-represtamo/validar-cedula-y-obtener-auto-completado';
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

class AsalariadoUserCedulaEndpoint extends Endpoint {
  final String cedula;
  AsalariadoUserCedulaEndpoint({required this.cedula});
  @override
  Method get method => Method.get;

  @override
  String get path =>
      '/solicitud-asalariado/validar-cedula-y-obtener-auto-completado';
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
        'database': LocalStorage().database,
      };
}

class ObtenerParametrosEndpoint extends Endpoint {
  final String nombre;
  ObtenerParametrosEndpoint({required this.nombre});
  @override
  Method get method => Method.get;

  @override
  String get path => '/catalogo/obtener-parametro';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
        'nombre': nombre,
      };
}

class CatalogoFrecuenciaPagoEndpoint extends Endpoint {
  CatalogoFrecuenciaPagoEndpoint();
  @override
  Method get method => Method.get;

  @override
  String get path => '/solicitudes/obtener-frecuencia-pago';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
      };
}

class AsalariadoObtenerSolicitudesPorEstadoEndpoint extends Endpoint {
  final EstadoCredito estadoCredito;
  AsalariadoObtenerSolicitudesPorEstadoEndpoint({required this.estadoCredito});
  @override
  Method get method => Method.get;

  @override
  String get path => '/solicitud-asalariado/obtener-solicitud-por-estado';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
        'estado': estadoCredito.codigo,
      };
}

class NuevaMenorObtenerSolicitudesPorEstadoEndpoint extends Endpoint {
  final EstadoCredito estadoCredito;
  NuevaMenorObtenerSolicitudesPorEstadoEndpoint({required this.estadoCredito});
  @override
  Method get method => Method.get;

  @override
  String get path => '/solicitud-nueva-menor/obtener-solicitud-por-estado';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
        'estado': estadoCredito.codigo,
      };
}

class ReprestamoObtenerSolicitudesPorEstadoEndpoint extends Endpoint {
  final EstadoCredito estadoCredito;
  ReprestamoObtenerSolicitudesPorEstadoEndpoint({required this.estadoCredito});
  @override
  Method get method => Method.get;

  @override
  String get path => '/solicitud-represtamo/obtener-solicitud-por-estado';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
        'estado': estadoCredito.codigo,
      };
}

class ObtenerAsesoresEndpoint extends Endpoint {
  ObtenerAsesoresEndpoint();
  @override
  Method get method => Method.get;

  @override
  String get path => '/solicitudes/obtener-asesores';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
      };
}

class AsignarSolicitudEndpoint extends Endpoint {
  final int idSolicitud;
  final int idPromotor;
  AsignarSolicitudEndpoint({
    required this.idSolicitud,
    required this.idPromotor,
  });
  @override
  Method get method => Method.patch;

  @override
  String get path => '/solicitud-nueva-menor/asignar-solicitud';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };

  @override
  Map<String, dynamic> get body => {
        'database': LocalStorage().database,
        'idSolicitud': idSolicitud,
        'idPromotor': idPromotor,
      };
}

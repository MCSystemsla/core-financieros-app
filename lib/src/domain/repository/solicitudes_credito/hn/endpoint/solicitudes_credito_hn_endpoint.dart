import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/solicitud_asalariado_hn.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/nuevamenor/solicitud_nueva_menor_hn.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/represtamo/solicitud_represtamo_hn.dart';

class CrearSolciitudAsalariadoHNEndpoint extends Endpoint {
  final SolicitudAsalariadoHn solicitud;

  CrearSolciitudAsalariadoHNEndpoint({
    required this.solicitud,
  });
  @override
  Method get method => Method.post;

  @override
  String get path => '/cartera/solicitud-asalariado/crear';
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
  String get path => '/cartera/solicitud-nueva-menor/crear';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => solicitud.toJson();
}

class CreateSolicitudReprestamoHNEndpoint extends Endpoint {
  final SolicitudReprestamoHn solicitud;

  CreateSolicitudReprestamoHNEndpoint({
    required this.solicitud,
  });
  @override
  Method get method => Method.post;

  @override
  String get path => '/cartera/solicitud-represtamo/crear';
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
  String get path => '/cartera/catalogo/obtener-parametro';
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

class ObtenerAutoCompletadoNuevaMenorEndpoint extends Endpoint {
  final String nombre;
  final String cedula;
  final String tipoDocumentoCodigo;
  ObtenerAutoCompletadoNuevaMenorEndpoint({
    required this.nombre,
    required this.cedula,
    required this.tipoDocumentoCodigo,
  });
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/solicitud-nueva-menor/obtener-auto-completado';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, String> get queryParameters => {
        'database': LocalStorage().database,
        'nombre': nombre,
        'cedula': cedula,
        'tipoDocumentoCodigo': tipoDocumentoCodigo,
      };
}

class ObtenerAutoCompletadoReprestamoEndpoint extends Endpoint {
  final String nombre;
  final String cedula;
  final String tipoDocumentoCodigo;
  ObtenerAutoCompletadoReprestamoEndpoint({
    required this.nombre,
    required this.cedula,
    required this.tipoDocumentoCodigo,
  });
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/solicitud-represtamo/obtener-auto-completado';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, String> get queryParameters => {
        'database': LocalStorage().database,
        'nombre': nombre,
        'cedula': cedula,
        'tipoDocumentoCodigo': tipoDocumentoCodigo,
      };
}

class ObtenerAutoCompletadoAsalariadoEndpoint extends Endpoint {
  final String nombre;
  final String cedula;
  final String tipoDocumentoCodigo;
  ObtenerAutoCompletadoAsalariadoEndpoint({
    required this.nombre,
    required this.cedula,
    required this.tipoDocumentoCodigo,
  });
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/solicitud-asalariado/obtener-auto-completado';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, String> get queryParameters => {
        'database': LocalStorage().database,
        'nombre': nombre,
        'cedula': cedula,
        'tipoDocumentoCodigo': tipoDocumentoCodigo,
      };
}

class GetSolicitudesByEstadoEndpoint extends Endpoint {
  final EstadoCredito estadoCredito;
  final bool isAsignadaToAsesorCredito;
  final String? numeroSolicitud;
  final String? cedulaCliente;
  final int? pagina;
  GetSolicitudesByEstadoEndpoint({
    required this.estadoCredito,
    required this.isAsignadaToAsesorCredito,
    this.numeroSolicitud,
    this.cedulaCliente,
    this.pagina,
  });
  @override
  Method get method => Method.get;

  @override
  String get path =>
      '/cartera/solicitudes/general/obtener-solicitud-por-estado';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
        'EstadoSolicitudCodigo': estadoCredito.codigo,
        'OficialCreditoAsignado': isAsignadaToAsesorCredito.toString(),
        if (numeroSolicitud != null && numeroSolicitud!.isNotEmpty)
          'Numero': numeroSolicitud,
        if (cedulaCliente != null && cedulaCliente!.isNotEmpty)
          'Cedula': cedulaCliente,
        if (pagina != null) 'Pagina': pagina.toString(),
      };
}

class AsignSolicitudToAsesorAsalariadoHNEndpoint extends Endpoint {
  final int idSolicitud;
  final int idPromotor;

  AsignSolicitudToAsesorAsalariadoHNEndpoint({
    required this.idSolicitud,
    required this.idPromotor,
  });
  @override
  Method get method => Method.patch;

  @override
  String get path => '/solicitud-asalariado/asignar-solicitud';
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

class AsignSolicitudToAsesorNuevaMenorHNEndpoint extends Endpoint {
  final int idSolicitud;
  final int idPromotor;

  AsignSolicitudToAsesorNuevaMenorHNEndpoint({
    required this.idSolicitud,
    required this.idPromotor,
  });
  @override
  Method get method => Method.patch;

  @override
  String get path => '/cartera/solicitud-nueva-menor/asignar-solicitud';
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

class AsignSolicitudToAsesorReprestamoHNEndpoint extends Endpoint {
  final int idSolicitud;
  final int idPromotor;

  AsignSolicitudToAsesorReprestamoHNEndpoint({
    required this.idSolicitud,
    required this.idPromotor,
  });
  @override
  Method get method => Method.patch;

  @override
  String get path => '/cartera/solicitud-represtamo/asignar-solicitud';
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

class GetAsesoresHNEndpoint extends Endpoint {
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/solicitudes/general/obtener-asesores';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
      };
}

class ActividadesEconomicasAliasFilteredEndpoint extends Endpoint {
  @override
  Method get method => Method.get;

  @override
  String get path =>
      '/ahorro/herramientas/actividades-economicas-alias/get-filtered';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
}

class AutorizarSolicitudCreditoHNEndpoint extends Endpoint {
  final int numeroSolicitud;
  final String tipoSolicitud;
  AutorizarSolicitudCreditoHNEndpoint({
    required this.numeroSolicitud,
    required this.tipoSolicitud,
  });
  @override
  Method get method => Method.patch;

  @override
  String get path => '/cartera/solicitudes/general/autorizar-solicitud';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => {
        'database': LocalStorage().database,
        'NumeroSolicitud': numeroSolicitud,
        'TipoSolicitud': tipoSolicitud,
      };
}

class SolciitudGrupalGruposActivos extends Endpoint {
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/grupales/grupos-activos';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
      };
}

class SolicitudesGrupalCreateGrupoCreditoEndpoint extends Endpoint {
  final String nombre;

  SolicitudesGrupalCreateGrupoCreditoEndpoint({required this.nombre});
  @override
  Method get method => Method.post;

  @override
  String get path => '/cartera/grupales/crear-grupo';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => {
        'database': LocalStorage().database,
        'Nombre': nombre,
      };
}

class SolicitudesGrupalesGetCargosDisponiblesEndpoint extends Endpoint {
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/grupales/cargos-disponibles';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
      };
}

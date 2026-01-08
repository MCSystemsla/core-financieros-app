import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_aprobacion.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_create_service_schema.dart';

class ComiteObtenerDataSolicitudEndpointHN extends Endpoint {
  final int numeroSolicitud;
  final String tipoSolicitud;

  ComiteObtenerDataSolicitudEndpointHN({
    required this.numeroSolicitud,
    required this.tipoSolicitud,
  });

  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/comite/obtener-data-solicitud';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'NumeroSolicitud': numeroSolicitud.toString(),
        'TipoSolicitud': tipoSolicitud,
        'database': LocalStorage().database,
      };
}

class ComiteServiciosHNEndpoint extends Endpoint {
  final int comiteID;
  final int plazoCredito;
  final double montoCredito;
  final double capitalAdeudado;
  final int primaSegurosDanios;
  final bool esGrupal;
  final bool esMayorA60;
  final bool esDPF;
  final bool esCreditoHipotecario;

  ComiteServiciosHNEndpoint({
    required this.comiteID,
    required this.plazoCredito,
    required this.montoCredito,
    required this.capitalAdeudado,
    required this.primaSegurosDanios,
    this.esGrupal = false,
    this.esMayorA60 = false,
    this.esDPF = false,
    this.esCreditoHipotecario = false,
  });

  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/comite/obtener-servicios-acta';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
        'ComiteID': comiteID.toString(),
        'PlazoCredito': plazoCredito.toString(),
        'MontoCredito': montoCredito.toString(),
        'CapitalAdeudado': capitalAdeudado.toString(),
        'EsGrupal': esGrupal.toString(),
        'EsMayorA60': esMayorA60.toString(),
        'EsDPF': esDPF.toString(),
        'EsCreditoHipotecario': esCreditoHipotecario.toString(),
        'PrimaSegurosDanios': primaSegurosDanios.toString(),
      };
}

class ComiteCrearServiciosHNEndpoint extends Endpoint {
  final ComiteCreateServiceSchema data;

  ComiteCrearServiciosHNEndpoint({required this.data});
  @override
  Method get method => Method.post;

  @override
  String get path => '/cartera/comite/upsert-servicios';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => data.toJson();
}

class ComiteCrearAprobacionEndpoint extends Endpoint {
  final ComiteAprobacion data;
  ComiteCrearAprobacionEndpoint({required this.data});

  @override
  Method get method => Method.post;

  @override
  String get path => '/cartera/comite/aprobar';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => data.toJson();
}

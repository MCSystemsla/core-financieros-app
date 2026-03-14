import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_aprobacion.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_create_service_schema.dart';
import 'package:core_financiero_app/src/utils/extensions/order_type/order_type.dart';

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
  final int numeroSolicitud;
  final int comiteID;
  final int plazoCredito;
  final double montoCredito;
  final double capitalAdeudado;
  final int primaSegurosDanios;
  final String tipoSolicitud;

  ComiteServiciosHNEndpoint({
    required this.comiteID,
    required this.plazoCredito,
    required this.montoCredito,
    required this.capitalAdeudado,
    required this.primaSegurosDanios,
    required this.numeroSolicitud,
    required this.tipoSolicitud,
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
        'PrimaSegurosDanios': primaSegurosDanios.toString(),
        'NumeroSolicitud': numeroSolicitud.toString(),
        'TipoSolicitud': tipoSolicitud,
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
  Method get method => Method.patch;

  @override
  String get path => '/cartera/comite/aprobar';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => data.toJson();
}

class GetSolicitudesOnComiteEndpoint extends Endpoint {
  final int? numeroSolicitud;
  final String? documentoCliente;
  final String? nombrePromotor;
  final int? numeroActa;
  final OrderType orderType;

  GetSolicitudesOnComiteEndpoint({
    this.numeroSolicitud,
    this.documentoCliente,
    this.nombrePromotor,
    this.numeroActa,
    required this.orderType,
  });
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/comite/actas-comite-usuario';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
        'Page': 1.toString(),
        if (numeroSolicitud != null && numeroSolicitud != 0)
          'NumeroSolicitud': numeroSolicitud.toString(),
        if (documentoCliente != null && documentoCliente!.isNotEmpty)
          'DocumentoCliente': documentoCliente,
        if (nombrePromotor != null && nombrePromotor!.isNotEmpty)
          'NombrePromotor': nombrePromotor,
        if (numeroActa != null && numeroActa != 0)
          'NumeroActa': numeroActa.toString(),
        'Order': orderType.value,
      };
}

class GetCalculosDatosEndpoint extends Endpoint {
  final int actaID;
  final String productoCodigo;
  final num monto;
  final int plazoMeses;
  final String monedaCodigo;
  final DateTime fechaPrimerPago;
  final bool esRestructuracion;
  final bool esMantieneTasa;
  final String creditoCancelacion;
  final String creditoCancelacion2;
  final String formaPagoCodigo;
  final double comisionSegurosFinanciado;
  final String tipoCobroSaldoDeudorCodigo;
  final String paisCodigo;

  GetCalculosDatosEndpoint({
    required this.actaID,
    required this.productoCodigo,
    required this.monto,
    required this.plazoMeses,
    required this.monedaCodigo,
    required this.fechaPrimerPago,
    required this.esRestructuracion,
    required this.esMantieneTasa,
    required this.creditoCancelacion,
    required this.creditoCancelacion2,
    required this.formaPagoCodigo,
    required this.comisionSegurosFinanciado,
    required this.tipoCobroSaldoDeudorCodigo,
    required this.paisCodigo,
  });
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/comite/obtener-calculo-datos';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
        'ActaID': actaID.toString(),
        'ProductoCodigo': productoCodigo,
        'Monto': monto.toString(),
        'Plazo': plazoMeses.toString(),
        'MonedaCodigo': monedaCodigo,
        'FechaPrimerPago': fechaPrimerPago.toUtc().toIso8601String(),
        'EsReestructurado': esRestructuracion.toString(),
        'EsMantieneTasa': esMantieneTasa.toString(),
        'CreditoCancelacion1': creditoCancelacion.toString(),
        'CreditoCancelacion2': creditoCancelacion2.toString(),
        'FormaPagoCodigo': formaPagoCodigo,
        'ComisionSegurosFinanciado': comisionSegurosFinanciado.toString(),
        'TipoCobroSaldoDeudorCodigo': tipoCobroSaldoDeudorCodigo.toString(),
      };
}

class ObtenerFuentesFinanciamientosHNEndpoint extends Endpoint {
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/comite/obtener-fuentes-financiamiento';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
      };
}

class ObtenerTiposCreditosHNEndpoint extends Endpoint {
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/comite/obtener-tipos-credito';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
      };
}

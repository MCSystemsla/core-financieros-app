import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_asalariado_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_menor_mil.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_represtamo_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores/analisis_fiadores_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_credito_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/plan_inversion/analisis_plan_inversion.dart';

class CreateAnalisisNuevaMayorMilHNEndpoint extends Endpoint {
  final AnalisisNuevaMayorMilHn analisisSolicitudNuevaMenor;
  CreateAnalisisNuevaMayorMilHNEndpoint({
    required this.analisisSolicitudNuevaMenor,
  });
  @override
  Method get method => Method.post;

  @override
  String get path =>
      '/cartera/analisis-nueva-menor/crear-analisis-nueva-menor-mayor-mil';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => analisisSolicitudNuevaMenor.toJson();
}

class CreateAnalisisAsalariadoEndpoint extends Endpoint {
  final AnalisisAsalariadoHn analisisSolicitudAsalariado;
  CreateAnalisisAsalariadoEndpoint({
    required this.analisisSolicitudAsalariado,
  });
  @override
  Method get method => Method.post;

  @override
  String get path => '/cartera/analisis-asalariado/crear-analisis-asalariado';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => analisisSolicitudAsalariado.toJson();
}

class CreateAnalisisReprestamoEndpoint extends Endpoint {
  final AnalisisReprestamoHn analisisSolicitudReprestamo;
  CreateAnalisisReprestamoEndpoint({
    required this.analisisSolicitudReprestamo,
  });
  @override
  Method get method => Method.post;

  @override
  String get path =>
      '/cartera/analisis-represtamo/crear-analisis-represtamo-mayor-mil';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => analisisSolicitudReprestamo.toJson();
}

class CatalogoEmpleadosActivos extends Endpoint {
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/catalogo/empleados-activos';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
      };
}

class PlanDeInversionEndpointHN extends Endpoint {
  final AnalisisPlanDeInversion analisisPlanDeInversion;

  PlanDeInversionEndpointHN({
    required this.analisisPlanDeInversion,
  });
  @override
  Method get method => Method.post;

  @override
  String get path => '/cartera/analisis-plan-inversion/crear';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => analisisPlanDeInversion.toJson();
}

class AnalisisObtenerAutoCompletadoEndpointHN extends Endpoint {
  final String cedula;
  final String tipoDocumentoCodigo;

  AnalisisObtenerAutoCompletadoEndpointHN({
    required this.cedula,
    required this.tipoDocumentoCodigo,
  });

  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/analisis-fiador/obtener-auto-completado';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
        'tipoDocumentoCodigo': tipoDocumentoCodigo,
        'cedula': cedula,
      };
}

class CreateAnalisisFiadorEndpoinHN extends Endpoint {
  final AnalisisFiadoresHn analisisFiadoresHn;

  CreateAnalisisFiadorEndpoinHN({
    required this.analisisFiadoresHn,
  });

  @override
  Method get method => Method.post;

  @override
  String get path => '/cartera/analisis-fiador/create';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => analisisFiadoresHn.toJson();
}

class CreateAnalisisGarantiasHNEndpoint extends Endpoint {
  final AnalisisGarantiaCreditoHn analisisGarantiaCreditoHn;

  CreateAnalisisGarantiasHNEndpoint({
    required this.analisisGarantiaCreditoHn,
  });

  @override
  Method get method => Method.post;

  @override
  String get path => '/cartera/analisis-garantias/create-garantia';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => analisisGarantiaCreditoHn.toJson();
}

class CreateAnalisisGarantiasDetalleHNEndpoint extends Endpoint {
  final AnalisisGarantiaDetalle analisisGarantiaCreditoHn;

  CreateAnalisisGarantiasDetalleHNEndpoint({
    required this.analisisGarantiaCreditoHn,
  });

  @override
  Method get method => Method.post;

  @override
  String get path => '/cartera/analisis-garantias/create-garantia-detalle';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => analisisGarantiaCreditoHn.toJson();
}

class ObtenerArticulosGarantiasHNEndpoint extends Endpoint {
  final String tipoGarantiaCodigo;

  ObtenerArticulosGarantiasHNEndpoint({
    required this.tipoGarantiaCodigo,
  });
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/analisis-garantias/obtener-articulos-garantia';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
        'tipoGarantiaCodigo': tipoGarantiaCodigo,
      };
}

class ObtenerGarantiaByNumeroHNEndpoint extends Endpoint {
  final int numeroSolicitud;

  ObtenerGarantiaByNumeroHNEndpoint({required this.numeroSolicitud});
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/analisis-garantias/obtener-garantia-by-numero';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
        'NumeroSolicitud': numeroSolicitud.toString(),
      };
}

class CrearArticulosGarantiasHNEndpoint extends Endpoint {
  final String tipo;
  final String descripcion;

  CrearArticulosGarantiasHNEndpoint({
    required this.tipo,
    required this.descripcion,
  });
  @override
  Method get method => Method.post;

  @override
  String get path => '/cartera/analisis-garantias/create-articulo-garantia';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => {
        'database': LocalStorage().database,
        'Tipo': tipo,
        'Descripcion': descripcion,
      };
}

class GetDpfsByCedulaHNEndpoint extends Endpoint {
  final String tipoPersona;
  final String cedula;

  GetDpfsByCedulaHNEndpoint({
    required this.tipoPersona,
    required this.cedula,
  });
  @override
  Method get method => Method.get;

  @override
  String get path =>
      '/ahorro/cuenta/dpf-garantia/get-dpfs-by-cedula-tipo-persona';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'cedula': cedula,
        'tipoPersona': tipoPersona,
      };
}

class CloseAnalisisEndpointHN extends Endpoint {
  final int numeroSolicitud;
  final String tipoSolicitud;

  CloseAnalisisEndpointHN({
    required this.numeroSolicitud,
    required this.tipoSolicitud,
  });

  @override
  Method get method => Method.patch;

  @override
  String get path => '/cartera/solicitudes/general/analisis/cerrar';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => {
        'NumeroSolicitud': numeroSolicitud,
        'TipoSolicitud': tipoSolicitud,
        'database': LocalStorage().database,
      };
}

class GetAnalsisChecksEndpointHN extends Endpoint {
  final int numeroSolicitud;
  final String tipoSolicitud;

  GetAnalsisChecksEndpointHN({
    required this.numeroSolicitud,
    required this.tipoSolicitud,
  });

  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/solicitudes/general/analisis/checks';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'NumeroSolicitud': numeroSolicitud.toString(),
        'database': LocalStorage().database,
        'TipoSolicitud': tipoSolicitud,
      };
}

class GetAnalisisFiadoresChecksEndpointHN extends Endpoint {
  final int numeroSolicitud;
  final String tipoSolicitud;

  GetAnalisisFiadoresChecksEndpointHN({
    required this.numeroSolicitud,
    required this.tipoSolicitud,
  });

  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/solicitudes/general/analisis/fiadores/checks';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'NumeroSolicitud': numeroSolicitud.toString(),
        'database': LocalStorage().database,
        'TipoSolicitud': tipoSolicitud,
      };
}

class CrearAnalisisMenorMilNuevaHNEndpoint extends Endpoint {
  final AnalisisMenorMilHN analisisSolicitudMenorMil;

  CrearAnalisisMenorMilNuevaHNEndpoint({
    required this.analisisSolicitudMenorMil,
  });
  @override
  Method get method => Method.post;

  @override
  String get path =>
      '/cartera/analisis-nueva-menor/crear-analisis-nueva-menor-mil';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => analisisSolicitudMenorMil.toJson();
}

class CrearAnalisisMenorMilReprestamoHNEndpoint extends Endpoint {
  final AnalisisMenorMilHN analisisSolicitudMenorMil;

  CrearAnalisisMenorMilReprestamoHNEndpoint({
    required this.analisisSolicitudMenorMil,
  });
  @override
  Method get method => Method.post;

  @override
  String get path =>
      '/cartera/analisis-represtamo/crear-analisis-represtamo-menor-mil';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => analisisSolicitudMenorMil.toJson();
}

class GetEvaluadoresGarantiaHnEndpoint extends Endpoint {
  @override
  Method get method => Method.get;

  @override
  String get path => '/cartera/analisis-garantias/obtener-evaluadores';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
      };
}

class GetFiadoresByNumeroSolicitudHNEndpoint extends Endpoint {
  final String tipoFiadorCodigo;

  GetFiadoresByNumeroSolicitudHNEndpoint({required this.tipoFiadorCodigo});
  @override
  Method get method => Method.get;

  @override
  String get path =>
      '/cartera/analisis-garantias/obtener-fiadores-relacionados';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        'database': LocalStorage().database,
        'TipoFiadorCodigo': tipoFiadorCodigo,
      };
}

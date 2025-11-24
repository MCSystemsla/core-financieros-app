import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_asalariado_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_represtamo_hn.dart';
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

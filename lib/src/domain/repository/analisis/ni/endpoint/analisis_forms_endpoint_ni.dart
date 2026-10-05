import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_asalariado_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_menor_mil.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_represtamo_hn.dart';

class CreateAnalisisNuevaMayorMilNiEndpoint extends Endpoint {
  final AnalisisNuevaMayorMilHn analisisSolicitudNuevaMenor;
  CreateAnalisisNuevaMayorMilNiEndpoint({
    required this.analisisSolicitudNuevaMenor,
  });
  @override
  Method get method => Method.post;

  @override
  String get path => '/cartera/analisis/nueva-menor/mayor-mil';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => analisisSolicitudNuevaMenor.toJson();
}

class CreateAnalisisAsalariadoNiEndpoint extends Endpoint {
  final AnalisisAsalariadoHn analisisSolicitudAsalariado;
  CreateAnalisisAsalariadoNiEndpoint({
    required this.analisisSolicitudAsalariado,
  });
  @override
  Method get method => Method.post;

  @override
  String get path => '/cartera/analisis/asalariado';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => analisisSolicitudAsalariado.toJson();
}

class CreateAnalisisReprestamoNiEndpoint extends Endpoint {
  final AnalisisReprestamoHn analisisSolicitudReprestamo;
  CreateAnalisisReprestamoNiEndpoint({
    required this.analisisSolicitudReprestamo,
  });
  @override
  Method get method => Method.post;

  @override
  String get path => '/cartera/analisis/represtamo/mayor-mil';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => analisisSolicitudReprestamo.toJson();
}

class CrearAnalisisMenorMilNuevaNiEndpoint extends Endpoint {
  final AnalisisMenorMilHN analisisSolicitudMenorMil;

  CrearAnalisisMenorMilNuevaNiEndpoint({
    required this.analisisSolicitudMenorMil,
  });
  @override
  Method get method => Method.post;

  @override
  String get path => '/cartera/analisis/nueva-menor/menor-mil';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => {
        ...analisisSolicitudMenorMil.toJson(),
        'database': LocalStorage().database,
      };
}

class CrearAnalisisMenorMilReprestamoNiEndpoint extends Endpoint {
  final AnalisisMenorMilHN analisisSolicitudMenorMil;

  CrearAnalisisMenorMilReprestamoNiEndpoint({
    required this.analisisSolicitudMenorMil,
  });
  @override
  Method get method => Method.post;

  @override
  String get path => '/cartera/analisis/represtamo/menor-mil';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => analisisSolicitudMenorMil.toJson();
}

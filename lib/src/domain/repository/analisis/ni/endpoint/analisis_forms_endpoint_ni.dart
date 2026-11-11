import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_asalariado_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_menor_mil.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_represtamo_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/ni/fiadores/analisis_fiador_ni.dart';

/// Campos que el backend de Nicaragua ya no acepta en los análisis.
///
/// Los modelos son los de Honduras (compartidos), así que se quitan aquí, al
/// armar el body, para no tocar lo que envía Honduras.
const _camposEliminadosNi = <String>{
  'Salud',
  'PermisoOperacionNumero',
  'PermisoOperacionNombreInstitucion',
  'PermisoOperacionFechaEmision',
  'PermisoOperacionFechaVencimiento',
  'NombreReferencia3',
  'CedulaReferencia3',
  'DireccionReferencia3',
  'TelefonoReferencia3',
  'LugarTrabajoReferencia3',
  'AniosConocerReferido3',
  'ParentescoReferenciaCodigo3',
  'FechaVerificacion3',
  'ResultadoVerificacion3',
  'objEmpleadoVerificaReferenciaID3',
};

Map<String, dynamic> _sinCamposEliminados(Map<String, dynamic> body) =>
    Map.of(body)..removeWhere((key, _) => _camposEliminadosNi.contains(key));

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
  Map<String, dynamic> get body =>
      _sinCamposEliminados(analisisSolicitudNuevaMenor.toJson());
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
  Map<String, dynamic> get body =>
      _sinCamposEliminados(analisisSolicitudAsalariado.toJson());
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
  Map<String, dynamic> get body =>
      _sinCamposEliminados(analisisSolicitudReprestamo.toJson());
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
        ..._sinCamposEliminados(analisisSolicitudMenorMil.toJson()),
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
  Map<String, dynamic> get body =>
      _sinCamposEliminados(analisisSolicitudMenorMil.toJson());
}

class CreateAnalisisFiadorEndpointNi extends Endpoint {
  final AnalisisFiadorNi analisisFiadorNi;

  CreateAnalisisFiadorEndpointNi({
    required this.analisisFiadorNi,
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
  Map<String, dynamic> get body => analisisFiadorNi.toJson();
}

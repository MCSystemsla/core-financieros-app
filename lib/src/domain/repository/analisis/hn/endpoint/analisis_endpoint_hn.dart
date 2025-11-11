import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/analisis_nueva_mayor_a_mil_hn.dart';

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

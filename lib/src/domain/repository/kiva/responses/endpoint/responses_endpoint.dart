import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_answer.dart';

class MejoraViviendaKivaResponsesEndpoind extends Endpoint {
  final MejoraViviendaAnswer mejoraViviendaAnswer;
  MejoraViviendaKivaResponsesEndpoind({required this.mejoraViviendaAnswer});

  @override
  Method get method => Method.post;

  @override
  String get path => '/kiva/crear-mejora-vivienda';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };

  @override
  Map<String, dynamic> get body => mejoraViviendaAnswer.toJson();
}

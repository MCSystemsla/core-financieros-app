import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/forms/energia_limpia/energia_limpia_model.dart';
import 'package:core_financiero_app/src/datasource/forms/energia_limpia/recurrente_energia_limpia.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_answer.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_recurrente.dart';

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

class RecurrenteMejoraViviendaEndpoint extends Endpoint {
  final MejoraViviendaRecurrente mejoraViviendaAnswer;
  RecurrenteMejoraViviendaEndpoint({required this.mejoraViviendaAnswer});

  @override
  Method get method => Method.post;

  @override
  String get path => '/kiva/crear-mejora-vivienda-recurrente';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };

  @override
  Map<String, dynamic> get body => mejoraViviendaAnswer.toJson();
}

class EnergiaLimpiaEndpoint extends Endpoint {
  final EnergiaLimpiaModel energiaLimpiaModel;
  EnergiaLimpiaEndpoint({required this.energiaLimpiaModel});

  @override
  Method get method => Method.post;

  @override
  String get path => '/kiva/crear-energia-limpia';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };

  @override
  Map<String, dynamic> get body => energiaLimpiaModel.toJson();
}

class RecurrenteEnergiaLimpiaEndpoint extends Endpoint {
  final RecurrenteEnergiaLimpiaModel recurrenteEnergiaLimpiaModel;
  RecurrenteEnergiaLimpiaEndpoint({required this.recurrenteEnergiaLimpiaModel});

  @override
  Method get method => Method.post;

  @override
  String get path => '/kiva/crear-energia-limpia-recurrente';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };

  @override
  Map<String, dynamic> get body => recurrenteEnergiaLimpiaModel.toJson();
}

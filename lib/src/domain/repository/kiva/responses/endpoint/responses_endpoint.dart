import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/forms/agua_y_saneamiento/agua_y_saneamiento_model.dart';
import 'package:core_financiero_app/src/datasource/forms/agua_y_saneamiento/recurrente_agua_y_saneamiento.dart';
import 'package:core_financiero_app/src/datasource/forms/energia_limpia/energia_limpia_model.dart';
import 'package:core_financiero_app/src/datasource/forms/energia_limpia/recurrente_energia_limpia.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_answer.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_recurrente.dart';
import 'package:core_financiero_app/src/datasource/forms/mujer_emprende/mujer_emprende_model.dart';
import 'package:core_financiero_app/src/datasource/forms/mujer_emprende/recurrente_mujer_emprende.dart';

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

class AguaSaneamientoEndpoint extends Endpoint {
  final AguaSaneamientoModel aguaSaneamientoModel;
  AguaSaneamientoEndpoint({required this.aguaSaneamientoModel});

  @override
  Method get method => Method.post;

  @override
  String get path => '/kiva/crear-agua-saneamiento';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };

  @override
  Map<String, dynamic> get body => aguaSaneamientoModel.toJson();
}

class RecurrenteAguaSaneamientoEndpoint extends Endpoint {
  final RecurrenteAguaSaneamientoModel recurrenteAguaSaneamientoModel;
  RecurrenteAguaSaneamientoEndpoint({
    required this.recurrenteAguaSaneamientoModel,
  });

  @override
  Method get method => Method.post;

  @override
  String get path => '/kiva/crear-agua-saneamiento-recurrente';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };

  @override
  Map<String, dynamic> get body => recurrenteAguaSaneamientoModel.toJson();
}

class MujerEmprendeEndpoint extends Endpoint {
  final MujerEmprendeModel mujerEmprendeModel;
  MujerEmprendeEndpoint({
    required this.mujerEmprendeModel,
  });

  @override
  Method get method => Method.post;

  @override
  String get path => '/kiva/crear-mujer-emprende';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };

  @override
  Map<String, dynamic> get body => mujerEmprendeModel.toJson();
}

class RecurrenteMujerEmprendeEndpoint extends Endpoint {
  final RecurrenteMujerEmprendeModel recurrenteMujerEmprendeModel;
  RecurrenteMujerEmprendeEndpoint({
    required this.recurrenteMujerEmprendeModel,
  });

  @override
  Method get method => Method.post;

  @override
  String get path => '/kiva/crear-mujer-emprende-recurrente';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };

  @override
  Map<String, dynamic> get body => recurrenteMujerEmprendeModel.toJson();
}

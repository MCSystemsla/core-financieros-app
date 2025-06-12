import 'package:core_financiero_app/src/api/endpoint.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/forms/agua_y_saneamiento/agua_y_saneamiento_model.dart';
import 'package:core_financiero_app/src/datasource/forms/agua_y_saneamiento/recurrente_agua_y_saneamiento.dart';
import 'package:core_financiero_app/src/datasource/forms/energia_limpia/energia_limpia_model.dart';
import 'package:core_financiero_app/src/datasource/forms/energia_limpia/recurrente_energia_limpia.dart';
import 'package:core_financiero_app/src/datasource/forms/estandar/estandar_model.dart';
import 'package:core_financiero_app/src/datasource/forms/estandar/recurrente_estandar_model.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_answer.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_recurrente.dart';
import 'package:core_financiero_app/src/datasource/forms/micredi_estudio/micredi_estudio_model.dart';
import 'package:core_financiero_app/src/datasource/forms/micredi_estudio/recurrente_micredi_estudio_model.dart';
import 'package:core_financiero_app/src/datasource/forms/migrantes-economicos/migrantes_ecomicos.dart';
import 'package:core_financiero_app/src/datasource/forms/migrantes-economicos/recurrente_migrante_economico.dart';
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

class MiCrediEstudioEndpoint extends Endpoint {
  final MiCrediEstudioModel miCrediEstudioModel;
  MiCrediEstudioEndpoint({
    required this.miCrediEstudioModel,
  });

  @override
  Method get method => Method.post;

  @override
  String get path => '/kiva/crear-micredi-estudio';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };

  @override
  Map<String, dynamic> get body => miCrediEstudioModel.toJson();
}

class RecurrenteMiCrediEstudioEndpoint extends Endpoint {
  final RecurrenteMiCrediEstudioModel recurrenteMiCrediEstudioModel;
  RecurrenteMiCrediEstudioEndpoint({
    required this.recurrenteMiCrediEstudioModel,
  });

  @override
  Method get method => Method.post;

  @override
  String get path => '/kiva/crear-micredi-estudio-recurrente';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };

  @override
  Map<String, dynamic> get body => recurrenteMiCrediEstudioModel.toJson();
}

class EstandarEndpoint extends Endpoint {
  final EstandarModel estandarModel;
  EstandarEndpoint({
    required this.estandarModel,
  });

  @override
  Method get method => Method.post;

  @override
  String get path => '/kiva/crear-credito-estandar';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };

  @override
  Map<String, dynamic> get body => estandarModel.toJson();
}

class RecurrenteEstandarEndpoint extends Endpoint {
  final RecurrenteEstandarModel recurrenteEstandarModel;
  RecurrenteEstandarEndpoint({
    required this.recurrenteEstandarModel,
  });

  @override
  Method get method => Method.post;

  @override
  String get path => '/kiva/crear-credito-estandar-recurrente';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };

  @override
  Map<String, dynamic> get body => recurrenteEstandarModel.toJson();
}

class KivaMotivoAnteriorEndpoint extends Endpoint {
  final int numero;
  KivaMotivoAnteriorEndpoint({required this.numero});

  @override
  Method get method => Method.post;

  @override
  String get path => '/kiva/motivo-anterior';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };

  @override
  Map<String, dynamic> get body => {
        'database': LocalStorage().database,
        'solicitudId': numero,
      };
}

class MigrantesEconomicosEndpoint extends Endpoint {
  final MigrantesEconomicos migrantesEconomicos;
  MigrantesEconomicosEndpoint({required this.migrantesEconomicos});

  @override
  Method get method => Method.post;

  @override
  String get path => '/kiva/crear-migrantes-economicos';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };

  @override
  Map<String, dynamic> get body => migrantesEconomicos.toJson();
}

class MigrantesEconomicosEndpointRecurrente extends Endpoint {
  final MigrantesEconomicosRecurrente migrantesEconomicosRecurrente;
  MigrantesEconomicosEndpointRecurrente(
      {required this.migrantesEconomicosRecurrente});

  @override
  Method get method => Method.post;

  @override
  String get path => '/kiva/crear-migrantes-economicos-recurrente';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };

  @override
  Map<String, dynamic> get body => migrantesEconomicosRecurrente.toJson();
}

class CodigoVerificationEndpoint extends Endpoint {
  final String codigo;
  CodigoVerificationEndpoint({required this.codigo});

  @override
  Method get method => Method.post;

  @override
  String get path => '/kiva/validar-codigo';
  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };
  @override
  Map<String, dynamic> get body => {
        'codigo': codigo,
      };
}

class FileEndpoint extends Endpoint {
  final int numSolicitud;
  final String formularioKiva;
  FileEndpoint({
    required this.imgPath,
    required this.numSolicitud,
    required this.formularioKiva,
  });
  final ImagesModelEndpoint imgPath;

  @override
  Method get method => Method.post;

  @override
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${LocalStorage().jwt}',
      };

  @override
  String get path => 'kiva/subir-imagenes';

  @override
  TypeBody get typeBody => TypeBody.formData;

  @override
  Map<String, dynamic> get body => {
        'database': LocalStorage().database,
      };

  @override
  List<ImagesModelEndpoint> get files => [imgPath];
}

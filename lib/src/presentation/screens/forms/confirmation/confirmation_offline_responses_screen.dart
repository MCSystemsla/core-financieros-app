import 'dart:developer';

import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/agua_y_saneamiento/agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/energia_limpia/energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/estandar/estandar_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/mejora_vivienda/mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/micredi_estudio/micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/migrantes_economicos/migrantes_economicos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/mujer_emprende/mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_,mejora_vivienda.dart/recurrente_mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_agua_y_saniamiento/recurrente_agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_estandar/recurrente_estandart_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_estandar_confirmation/recurrente_estandar_confirmation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_micredi_estudio/recurrente_micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_mujer_emprende/recurrente_mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/energia_limpia_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/estandar_offline_responses.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/mejora_vivienda_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/micredi_estudio_responses.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/migrantes_economicos_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/mujer_emprende_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/recurrente_migrante_economico_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/saneamiento_offline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/kiva/recurrente_migrante_economico/recurrente_migrantes_economicos_cubit.dart';

class ConfirmationOfflineResponsesScreen extends StatelessWidget {
  final String typeProduct;
  final String? widgetsolicitudId;
  const ConfirmationOfflineResponsesScreen(
      {super.key, required this.typeProduct, this.widgetsolicitudId});

  @override
  Widget build(BuildContext context) {
    log('Solicitud widget: $widgetsolicitudId');
    final solicitudId = context.read<KivaRouteCubit>().state.solicitudId;
    final name = context.read<KivaRouteCubit>().state.nombre;
    final isar = context.read<SolicitudesPendientesLocalDbCubit>().state.isar;
    final respository = ResponsesRepositoryImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => RecurrenteEstandartCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => EstandarCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => MicrediEstudioCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteEstandarConfirmationCubit()
            ..getRecurrentResponses(
                isar: isar, solicitudId: int.tryParse(solicitudId) ?? 0),
        ),
        BlocProvider(
          create: (ctx) => MejoraViviendaCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteMejoraViviendaCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteMejoraViviendaCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => AguaYSaneamientoCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteAguaYSaneamientoCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => EnergiaLimpiaCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteEnergiaLimpiaCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => MujerEmprendeCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteMujerEmprendeCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => UploadUserFileCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteMicrediEstudioCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => MigrantesEconomicosCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteMigrantesEconomicosCubit(respository),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: _CurrentForm(
          typeProduct: typeProduct,
          solicitudId:
              solicitudId != '0' ? solicitudId : (widgetsolicitudId ?? '0'),
        ),
      ),
    );
  }
}

class _CurrentForm extends StatelessWidget {
  const _CurrentForm({
    required this.typeProduct,
    required this.solicitudId,
  });

  final String typeProduct;
  final String solicitudId;

  @override
  Widget build(BuildContext context) {
    return switch (typeProduct) {
      'ESTANDAR RECURRENTE' => EstandarOfflineForm(
          typeProduct: typeProduct,
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'ESTANDAR NUEVO' => EstandarForm(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'MICREDIESTUDIO NUEVO' => MicrediEstudioForm(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'MICREDIESTUDIO RECURRENTE' => MiCrediEstudioRecurrenteForm(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'VIVIENDA NUEVA' => ViviendaNuevaOfflineResponse(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'VIVIENDA REPRESTAMO' => RecurrenteViviendaOfflineResponse(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'AGUA Y SANEAMIENTO NUEVO' => AguaSaneamientoOffline(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'AGUA Y SANEAMIENTO RECURRENTE' => RecurrenteSaneamientoOffline(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'ASER NUEVO' => EnergiaLImpiaOffline(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'ASER RECURRENTE' => RecurrenteEnergiaLimpiaOffline(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'MUJER EMPRENDE NUEVO' => MujerEmprendeOffline(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'MUJER EMPRENDE RECURRENTE' => RecurrenteMujerEmprendeOffline(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'ESTANDAR COLONES NUEVO MAYOR A MIL' => MigranteEconomicoOffline(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'ESTANDAR COLONES NUEVO MENOR A MIL' => MigranteEconomicoOffline(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'ESTANDAR COLONES RECURRENTE MAYOR A MIL' =>
        RecurrenteMigranteEconomicoOffline(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'ESTANDAR COLONES RECURRENTE MENOR A MIL' =>
        RecurrenteMigranteEconomicoOffline(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      _ => const SizedBox(),
    };
  }
}

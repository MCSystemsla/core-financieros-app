import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/forms/migrantes-economicos/recurrente_migrante_economico.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/agua_y_saneamiento/agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/energia_limpia/energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/estandar/estandar_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/mejora_vivienda/mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/micredi_estudio/micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/migrantes_economicos/migrantes_economicos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/mujer_emprende/mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_,mejora_vivienda.dart/recurrente_mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_agua_y_saniamiento/recurrente_agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_estandar/recurrente_estandart_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_estandar_confirmation/recurrente_estandar_confirmation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_micredi_estudio/recurrente_micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_mujer_emprende/recurrente_mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/energia_limpia_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/estandar_offline_responses.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/mejora_vivienda_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/micredi_estudio_responses.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/migrantes_economicos_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/mujer_emprende_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/saneamiento_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/custom_pop_up.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../bloc/recurrente_migrante_economico/recurrente_migrantes_economicos_cubit.dart';

class ConfirmationOfflineResponsesScreen extends StatelessWidget {
  final String typeProduct;
  const ConfirmationOfflineResponsesScreen(
      {super.key, required this.typeProduct});

  @override
  Widget build(BuildContext context) {
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
          solicitudId: solicitudId,
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

class RecurrenteMigranteEconomicoOffline extends StatefulWidget {
  final int solicitudId;
  const RecurrenteMigranteEconomicoOffline({
    super.key,
    required this.solicitudId,
  });

  @override
  State<RecurrenteMigranteEconomicoOffline> createState() =>
      _RecurrenteMigranteEconomicoOfflineState();
}

class _RecurrenteMigranteEconomicoOfflineState
    extends State<RecurrenteMigranteEconomicoOffline> {
  @override
  void initState() {
    initFunctions();
    super.initState();
  }

  initFunctions() async {
    final solicitudesProvider =
        context.read<SolicitudesPendientesLocalDbCubit>();
    await solicitudesProvider.getRecurrentMigranteEconomico(widget.solicitudId);
    await solicitudesProvider.getImagesModel(widget.solicitudId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, state) {
        return BlocConsumer<RecurrenteMigrantesEconomicosCubit,
            RecurrenteMigrantesEconomicosState>(
          listener: (context, status) async {
            if (status.status == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  showCloseIcon: true,
                  content: Text(status.errorMsg),
                ),
              );
            }
            if (status.status == Status.done) {
              context.read<UploadUserFileCubit>().uploadUserFilesOffline(
                    imagen1: state.imageModel?.imagen1 ?? 'NO PATH',
                    imagen2: state.imageModel?.imagen2 ?? 'NO PATH',
                    imagen3: state.imageModel?.imagen3 ?? 'NO PATH',
                    fotoCedula: state.imageModel?.imagen4 ?? 'NO PATH',
                    fotoFirma: state.imageModel?.imagenFirma ?? 'NO PATH',
                    solicitudId: widget.solicitudId,
                    formularioKiva:
                        context.read<KivaRouteCubit>().state.currentRoute,
                  );
              context
                  .read<SolicitudesPendientesLocalDbCubit>()
                  .removeWhenFormIsUpload(
                    widget.solicitudId,
                    context.read<KivaRouteCubit>().state.currentRoute,
                  );

              await customPopUp(
                context: context,
                dismissOnTouchOutside: false,
                size: MediaQuery.sizeOf(context),
                title: 'Formulario Kiva Enviado exitosamente!!',
                subtitle: 'Las respuestas se han enviado Exitosamente',
                dialogType: DialogType.success,
                buttonAcept: true,
                textButtonAcept: 'Ok',
                colorButtonAcept: AppColors.getPrimaryColor(),
                onPressedAccept: () {
                  context.pushReplacement('/');
                },
              );
            }
          },
          builder: (context, response) {
            return switch (state.status) {
              Status.inProgress => const LoadingWidget(),
              Status.done => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(20),
                      CommentaryWidget(
                        initialValue: state.recurrenteMigranteEconomicoDbLocal
                                    ?.tieneTrabajo ??
                                false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                        title: '¿Tiene algún trabajo o negocio? ¿Cuál?',
                        readOnly: true,
                      ),
                      if (state.recurrenteMigranteEconomicoDbLocal
                              ?.tieneTrabajo ??
                          false)
                        CommentaryWidget(
                          title: 'Cual',
                          initialValue: state.recurrenteMigranteEconomicoDbLocal
                                  ?.trabajoNegocioDescripcion ??
                              '',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'input.input_validator'.tr();
                            }
                            return null;
                          },
                          readOnly: true,
                        ),
                      const Gap(10),
                      CommentaryWidget(
                        title: 'Tiempo de la actividad:* (MESES)',
                        initialValue: state.recurrenteMigranteEconomicoDbLocal
                                ?.tiempoActividad
                                ?.toString() ??
                            '',
                        textInputType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'input.input_validator'.tr();
                          }
                          final numero = int.tryParse(value);
                          if (numero == null || numero < 0 || numero >= 255) {
                            return 'Valor no valido'.tr();
                          }
                          return null;
                        },
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        initialValue: state.recurrenteMigranteEconomicoDbLocal
                                    ?.otrosIngresos ??
                                false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                        title: '¿Tiene otros ingresos?',
                        readOnly: true,
                      ),
                      if (state.recurrenteMigranteEconomicoDbLocal
                              ?.otrosIngresos ??
                          false)
                        CommentaryWidget(
                          title: 'Cuales Otros Ingresos?',
                          initialValue: state.recurrenteMigranteEconomicoDbLocal
                                  ?.otrosIngresosDescripcion ??
                              'N/A',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'input.input_validator'.tr();
                            }
                            return null;
                          },
                          readOnly: true,
                        ),
                      const Gap(20),
                      CommentaryWidget(
                        title: 'Número de personas a cargo:*',
                        initialValue: state.recurrenteMigranteEconomicoDbLocal
                                ?.personasCargo
                                ?.toString() ??
                            '0',
                        textInputType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'input.input_validator'.tr();
                          }
                          final numero = int.tryParse(value);
                          if (numero == null || numero < 0 || numero >= 255) {
                            return 'Valor no valido'.tr();
                          }
                          return null;
                        },
                        readOnly: true,
                      ),
                      CommentaryWidget(
                        textInputType: TextInputType.number,
                        title: 'Número de hijos:*',
                        initialValue: state
                                .recurrenteMigranteEconomicoDbLocal?.numeroHijos
                                ?.toString() ??
                            '0',
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        initialValue: state.recurrenteMigranteEconomicoDbLocal
                                ?.edadHijos ??
                            '0',
                        title: '¿Qué edades tienen sus hijos?',
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        initialValue: state.recurrenteMigranteEconomicoDbLocal
                                ?.tipoEstudioHijos ??
                            'N/A',
                        title: '¿Qué tipo de estudios reciben sus hijos?',
                        readOnly: true,
                      ),
                      CommentaryWidget(
                        initialValue: state.recurrenteMigranteEconomicoDbLocal
                                    ?.coincideRespuesta ??
                                false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                        title:
                            '¿Coincide la respuesta del cliente con el formato anterior?'
                                .tr(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'input.input_validator'.tr();
                          }
                          return null;
                        },
                        readOnly: true,
                      ),
                      if (state.recurrenteMigranteEconomicoDbLocal
                              ?.coincideRespuesta ??
                          false == false)
                        CommentaryWidget(
                          initialValue: state.recurrenteMigranteEconomicoDbLocal
                                  ?.explicacionInversion ??
                              'N/A',
                          title:
                              'Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'input.input_validator'.tr();
                            }
                            return null;
                          },
                          readOnly: true,
                        ),
                      const Gap(20),
                      CommentaryWidget(
                        initialValue: state.recurrenteMigranteEconomicoDbLocal
                                    ?.apoyanNegocio ??
                                false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                        title: '¿Hay alguien que le apoye en su negocio?'.tr(),
                        readOnly: true,
                      ),
                      const Gap(20),
                      if (state.recurrenteMigranteEconomicoDbLocal
                              ?.apoyanNegocio ??
                          false)
                        CommentaryWidget(
                          initialValue: state.recurrenteMigranteEconomicoDbLocal
                                  ?.cuantosApoyan ??
                              '0',
                          title:
                              'De ser positivo, favor responder cuántas personas.',
                          readOnly: true,
                        ),
                      CommentaryWidget(
                        initialValue: state.recurrenteMigranteEconomicoDbLocal
                                ?.motivoPrestamo ??
                            'N/A',
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'input.input_validator'.tr();
                          }
                          return null;
                        },
                        title: '¿Para qué solicitó este nuevo crédito?',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        initialValue: state.recurrenteMigranteEconomicoDbLocal
                                ?.quienApoya ??
                            'N/A',
                        readOnly: true,
                        title:
                            '¿Hay alguien que le esté apoyando en este nuevo préstamo?',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        initialValue: state.recurrenteMigranteEconomicoDbLocal
                                    ?.mejoraCondiciones ??
                                false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                        title:
                            '¿Usted considera que esta nueva inversión le ayudará a mejorar sus condiciones de vida?',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'input.input_validator'.tr();
                          }
                          return null;
                        },
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        hintText: '',
                        initialValue: state.recurrenteMigranteEconomicoDbLocal
                                ?.explicacionMejoraCondiciones ??
                            'N/A',
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'input.input_validator'.tr();
                          }
                          return null;
                        },
                        title: '¿Por qué?',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        initialValue: state.recurrenteMigranteEconomicoDbLocal
                                ?.siguienteMeta ??
                            'N/A',
                        readOnly: true,
                        title:
                            'Una vez finalizado este préstamo ¿Cuál sería su siguiente meta?',
                      ),
                      const Gap(20),
                      ButtonActionsWidget(
                        disabled: state.status == Status.inProgress ||
                            response.status == Status.inProgress,
                        onPreviousPressed: () {
                          context.pop();
                        },
                        onNextPressed: () {
                          context
                              .read<RecurrenteMigrantesEconomicosCubit>()
                              .sendOfflineAnswers(
                                recurrenteMigranteEcomico:
                                    MigrantesEconomicosRecurrente(
                                  tipoSolicitud: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.tipoSolicitud ??
                                      '',
                                  database: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.database ??
                                      '',
                                  tieneTrabajo: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.tieneTrabajo ??
                                      false,
                                  trabajoNegocioDescripcion: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.trabajoNegocioDescripcion ??
                                      '',
                                  tiempoActividad: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.tiempoActividad ??
                                      0,
                                  numeroHijos: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.numeroHijos ??
                                      0,
                                  edadHijos: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.edadHijos ??
                                      '',
                                  tipoEstudioHijos: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.tipoEstudioHijos ??
                                      '',
                                  otrosIngresos: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.otrosIngresos ??
                                      false,
                                  otrosIngresosDescripcion: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.otrosIngresosDescripcion ??
                                      '',
                                  personasCargo: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.personasCargo ??
                                      0,
                                  motivoPrestamo: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.motivoPrestamo ??
                                      '',
                                  objSolicitudRecurrenteId: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.objSolicitudRecurrenteId ??
                                      0,
                                  coincideRespuesta: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.coincideRespuesta ??
                                      false,
                                  explicacionInversion: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.explicacionInversion ??
                                      '',
                                  apoyanNegocio: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.apoyanNegocio ??
                                      false,
                                  quienApoya: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.quienApoya ??
                                      '',
                                  cuantosApoyan: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.cuantosApoyan ??
                                      '',
                                  mejoraCondiciones: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.mejoraCondiciones ??
                                      false,
                                  explicacionMejoraCondiciones: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.explicacionMejoraCondiciones ??
                                      '',
                                  siguienteMeta: state
                                          .recurrenteMigranteEconomicoDbLocal
                                          ?.siguienteMeta ??
                                      '',
                                ),
                              );
                        },
                        previousTitle: 'Salir'.tr(),
                        nextTitle: 'Enviar'.tr(),
                      ),
                    ],
                  ),
                ),
              _ => const SizedBox(),
            };
          },
        );
      },
    );
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_answer.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/estandar/estandar_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/mejora_vivienda/mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/micredi_estudio/micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_,mejora_vivienda.dart/recurrente_mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_estandar/recurrente_estandart_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_estandar_confirmation/recurrente_estandar_confirmation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/estandar_offline_responses.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/micredi_estudio_responses.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/custom_pop_up.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ConfirmationOfflineResponsesScreen extends StatelessWidget {
  final String typeProduct;
  const ConfirmationOfflineResponsesScreen(
      {super.key, required this.typeProduct});

  @override
  Widget build(BuildContext context) {
    final solicitudId = context.read<KivaRouteCubit>().state.solicitudId;
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
        BlocProvider(create: (ctx) => MejoraViviendaCubit(respository)),
        BlocProvider(
            create: (ctx) => RecurrenteMejoraViviendaCubit(respository)),
      ],
      child: Scaffold(
        appBar: AppBar(),
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
      'VIVIENDA REPRESTAMO' => const Text('vivienda represtamo'),
      'AGUA Y SANEAMIENTO NUEVO' => const Text(' agua saneamiento'),
      'AGUA Y SANEAMIENTO RECURRENTE' =>
        const Text('agua saneamiento recurrente'),
      'ASER NUEVO' => const Text(' Energia Limpia'),
      'ASER RECURRENTE' => const Text(' Energia Recurrente'),
      'MUJER EMPRENDE NUEVO' => const Text(' Mujer Emprende'),
      'MUJER EMPRENDE RECURRENTE' => const Text(' Mujer Emprende recurrente'),
      _ => const SizedBox(),
    };
  }
}

class ViviendaNuevaOfflineResponse extends StatefulWidget {
  final int solicitudId;
  const ViviendaNuevaOfflineResponse({
    super.key,
    required this.solicitudId,
  });

  @override
  State<ViviendaNuevaOfflineResponse> createState() =>
      _ViviendaNuevaOfflineResponseState();
}

class _ViviendaNuevaOfflineResponseState
    extends State<ViviendaNuevaOfflineResponse> {
  @override
  void initState() {
    context
        .read<SolicitudesPendientesLocalDbCubit>()
        .getViviendaNueva(widget.solicitudId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, state) {
        return BlocConsumer<MejoraViviendaCubit, MejoraViviendaState>(
          listener: (context, state) async {
            if (state.status == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  showCloseIcon: true,
                  content: Text(state.errorMsg),
                ),
              );
            }
            if (state.status == Status.done) {
              await customPopUp(
                context: context,
                dismissOnTouchOutside: false,
                size: size,
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
            return SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(20),
                  CommentaryWidget(
                    initialValue:
                        state.mejoraViviendaDbLocal?.tieneTrabajo ?? false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                    title: '¿Tiene algún trabajo o negocio? ¿Cuál?',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    initialValue: state
                            .mejoraViviendaDbLocal?.trabajoNegocioDescripcion ??
                        'N/A',
                    title: 'Cual?',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    initialValue: state.mejoraViviendaDbLocal?.tiempoActividad
                            .toString() ??
                        '0',
                    title: 'Tiempo de la actividad:*',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: '¿Tiene otros ingresos?¿Cuales?*',
                    initialValue:
                        state.mejoraViviendaDbLocal?.otrosIngresos ?? false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                  ),
                  CommentaryWidget(
                    initialValue:
                        state.mejoraViviendaDbLocal?.otrosIngresosDescripcion ??
                            'N/A',
                    title: 'Describe tus otros Ingresos',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'forms.entorno_familiar.person_origin'.tr(),
                    initialValue:
                        state.mejoraViviendaDbLocal?.objOrigenCatalogoValorId ??
                            'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Su comunidad es:',
                    initialValue:
                        state.mejoraViviendaDbLocal?.objTipoComunidadId ??
                            'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    initialValue:
                        state.mejoraViviendaDbLocal?.necesidadesComunidad ??
                            'N/A',
                    title: '¿Cuáles son las necesidades en su comunidad?',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    initialValue:
                        state.mejoraViviendaDbLocal?.personasCargo ?? 'N/A',
                    title: 'Número de personas a cargo:*',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    initialValue:
                        state.mejoraViviendaDbLocal?.numeroHijos.toString() ??
                            'N/A',
                    title: 'Número de hijos:*',
                    textInputType: TextInputType.number,
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    initialValue:
                        state.mejoraViviendaDbLocal?.edadHijos ?? 'N/A',
                    title: '¿Que edades tienen sus hijos?',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    initialValue:
                        state.mejoraViviendaDbLocal?.tipoEstudioHijos ?? 'N/A',
                    title: '¿Qué tipo de estudios reciben sus hijos?',
                  ),
                  CommentaryWidget(
                    title: 'forms.mejora_de_vivienda.question1'.tr(),
                    initialValue:
                        state.mejoraViviendaDbLocal?.motivoPrestamo ?? 'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: 'forms.mejora_de_vivienda.question2'.tr(),
                    initialValue:
                        state.mejoraViviendaDbLocal?.comoAyudara ?? 'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: '¿Cuáles son sus planes para los próximos años?',
                    initialValue:
                        state.mejoraViviendaDbLocal?.planesFuturo ?? 'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    initialValue:
                        state.mejoraViviendaDbLocal?.otrosDatosCliente ?? 'N/A',
                    title: 'Otros datos relevantes e interesantes del cliente',
                  ),
                  ButtonActionsWidget(
                    disabled: state.status == Status.inProgress ||
                        response.status == Status.inProgress,
                    onPreviousPressed: () {
                      context.pop();
                    },
                    onNextPressed: () {
                      context.read<MejoraViviendaCubit>().sendOfflineAnswers(
                            mejoravivienda: MejoraViviendaAnswer(
                                otrosDatosCliente: state.mejoraViviendaDbLocal
                                        ?.otrosDatosCliente ??
                                    '',
                                planesFuturo:
                                    state.mejoraViviendaDbLocal?.planesFuturo ??
                                        '',
                                comoAyudara:
                                    state.mejoraViviendaDbLocal?.comoAyudara ??
                                        '',
                                motivoPrestamo:
                                    state.mejoraViviendaDbLocal?.motivoPrestamo ??
                                        '',
                                tipoEstudioHijos: state.mejoraViviendaDbLocal
                                        ?.tipoEstudioHijos ??
                                    '',
                                edadHijos:
                                    state.mejoraViviendaDbLocal?.edadHijos ??
                                        '',
                                numeroHijos:
                                    state.mejoraViviendaDbLocal?.numeroHijos ??
                                        0,
                                personasCargo:
                                    state.mejoraViviendaDbLocal?.personasCargo ??
                                        '',
                                necesidadesComunidad:
                                    state.mejoraViviendaDbLocal?.necesidadesComunidad ?? '',
                                objTipoComunidadId: state.mejoraViviendaDbLocal?.objTipoComunidadId ?? '',
                                objOrigenCatalogoValorId: state.mejoraViviendaDbLocal?.objOrigenCatalogoValorId ?? '',
                                otrosIngresosDescripcion: state.mejoraViviendaDbLocal?.otrosIngresosDescripcion ?? '',
                                otrosIngresos: state.mejoraViviendaDbLocal?.otrosIngresos ?? false,
                                tiempoActividad: state.mejoraViviendaDbLocal?.tiempoActividad ?? 0,
                                solicitudNuevamenorId: state.mejoraViviendaDbLocal?.solicitudNuevamenorId ?? 0,
                                username: state.mejoraViviendaDbLocal?.username ?? '',
                                tieneTrabajo: state.mejoraViviendaDbLocal?.tieneTrabajo ?? false,
                                database: state.mejoraViviendaDbLocal?.database ?? '',
                                trabajoNegocioDescripcion: state.mejoraViviendaDbLocal?.trabajoNegocioDescripcion ?? ''),
                          );
                    },
                    previousTitle: 'Salir',
                    nextTitle: 'Enviar',
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

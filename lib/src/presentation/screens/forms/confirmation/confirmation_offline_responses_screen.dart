import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/forms/agua_y_saneamiento/agua_y_saneamiento_model.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/agua_y_saneamiento/agua_y_saneamiento_cubit.dart';
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
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/mejora_vivienda_offline.dart';
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
        BlocProvider(create: (ctx) => MejoraViviendaCubit(respository)),
        BlocProvider(
            create: (ctx) => RecurrenteMejoraViviendaCubit(respository)),
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
      'AGUA Y SANEAMIENTO RECURRENTE' =>
        const Text('agua saneamiento recurrente'),
      'ASER NUEVO' => const Text(' Energia Limpia'),
      'ASER RECURRENTE' => const Text('Energia Recurrente'),
      'MUJER EMPRENDE NUEVO' => const Text(' Mujer Emprende'),
      'MUJER EMPRENDE RECURRENTE' => const Text(' Mujer Emprende recurrente'),
      _ => const SizedBox(),
    };
  }
}

class AguaSaneamientoOffline extends StatefulWidget {
  final int solicitudId;
  const AguaSaneamientoOffline({
    super.key,
    required this.solicitudId,
  });

  @override
  State<AguaSaneamientoOffline> createState() => _AguaSaneamientoOfflineState();
}

class _AguaSaneamientoOfflineState extends State<AguaSaneamientoOffline> {
  @override
  void initState() {
    context
        .read<SolicitudesPendientesLocalDbCubit>()
        .getSaneamientoNueva(widget.solicitudId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, state) {
        return BlocConsumer<AguaYSaneamientoCubit, AguaYSaneamientoState>(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommentaryWidget(
                    title: '¿Tiene algún trabajo o negocio? ¿Cuál?',
                    initialValue:
                        state.saneamientoDbLocal?.tieneTrabajo ?? false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                  ),
                  CommentaryWidget(
                    title: 'Cual?',
                    initialValue:
                        state.saneamientoDbLocal?.trabajoNegocioDescripcion ??
                            'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: 'Tiempo de la actividad (meses o años)',
                    initialValue:
                        state.saneamientoDbLocal?.tiempoActividad.toString() ??
                            '0',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: '¿Tiene otros ingresos?¿Cuales?*',
                    initialValue:
                        state.saneamientoDbLocal?.otrosIngresos ?? false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                  ),
                  CommentaryWidget(
                    title: 'Cuales?',
                    initialValue:
                        state.saneamientoDbLocal?.otrosIngresosDescripcion ??
                            'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                      title: 'forms.entorno_familiar.person_origin'.tr()),
                  const Gap(10),
                  CommentaryWidget(
                      title: 'Número de personas a cargo:*',
                      initialValue:
                          state.saneamientoDbLocal?.personasCargo ?? ''),
                  const Gap(10),
                  CommentaryWidget(
                    title: 'Numero de Hijos',
                    initialValue:
                        state.saneamientoDbLocal?.numeroHijos.toString() ?? '0',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                      title: 'forms.entorno_familiar.childs_age'.tr(),
                      initialValue:
                          state.saneamientoDbLocal?.edadHijos ?? 'N/A'),
                  const Gap(10),
                  CommentaryWidget(
                    initialValue:
                        state.saneamientoDbLocal?.tipoEstudioHijos ?? 'N/A',
                    title: '¿Qué tipo de estudios reciben sus hijos?',
                  ),
                  const Gap(15),
                  CommentaryWidget(
                    title: 'forms.develpment_and_description.aboutCredit'.tr(),
                    initialValue:
                        state.saneamientoDbLocal?.motivoPrestamo ?? 'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title:
                        '¿Porqué considera importante mejorar las condiciones higiénicas en su familia?*'
                            .tr(),
                    initialValue: state.saneamientoDbLocal
                            ?.importanciaMejorarCondiciones ??
                        'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    initialValue:
                        state.saneamientoDbLocal?.cumpliriaPropuesta ?? false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                    title:
                        '¿Cree usted que con este crédito va poder cumplir el proyecto que se ha propuesto? ¿Por qué?',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: 'Porque?',
                    initialValue: state.saneamientoDbLocal
                            ?.explicacionCumpliriaPropuesta ??
                        'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: '¿Para que solicitó este préstamo? Explique'.tr(),
                    initialValue:
                        state.saneamientoDbLocal?.motivoPrestamo ?? 'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: 'forms.impacto_social_kiva.how_perform'.tr(),
                    initialValue:
                        state.saneamientoDbLocal?.mejoraCalidadVida ?? 'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title:
                        '¿Cuál sería el siguiente proyecto para enriquecer su calidad de vida ?*'
                            .tr(),
                    initialValue: state
                            .saneamientoDbLocal?.siguienteProyectoCalidadVida ??
                        'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title:
                        '¿Cuáles son sus metas para los próximos años?*'.tr(),
                    initialValue:
                        state.saneamientoDbLocal?.metasProximas ?? 'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: '¿Otros datos relevantes e interesantes del cliente:'
                        .tr(),
                    initialValue:
                        state.saneamientoDbLocal?.otrosDatosCliente ?? 'N/A',
                  ),
                  const Gap(20),
                  ButtonActionsWidget(
                    disabled: state.status == Status.inProgress ||
                        response.status == Status.inProgress,
                    onPreviousPressed: () {
                      context.pop();
                    },
                    onNextPressed: () {
                      context.read<AguaYSaneamientoCubit>().sendOfflineAnswers(
                            aguaSaneamientoModel: AguaSaneamientoModel(
                              database:
                                  state.saneamientoDbLocal?.database ?? '',
                              objSolicitudNuevamenorId: state.saneamientoDbLocal
                                      ?.objSolicitudNuevamenorId ??
                                  0,
                              tieneTrabajo:
                                  state.saneamientoDbLocal?.tieneTrabajo ??
                                      false,
                              trabajoNegocioDescripcion: state
                                      .saneamientoDbLocal
                                      ?.trabajoNegocioDescripcion ??
                                  '',
                              tiempoActividad:
                                  state.saneamientoDbLocal?.tiempoActividad ??
                                      0,
                              otrosIngresos:
                                  state.saneamientoDbLocal?.otrosIngresos ??
                                      false,
                              otrosIngresosDescripcion: state.saneamientoDbLocal
                                      ?.otrosIngresosDescripcion ??
                                  '',
                              objOrigenCatalogoValorId: state.saneamientoDbLocal
                                      ?.objOrigenCatalogoValorId ??
                                  '',
                              personasCargo:
                                  state.saneamientoDbLocal?.personasCargo ?? '',
                              numeroHijos:
                                  state.saneamientoDbLocal?.numeroHijos ?? 0,
                              edadHijos:
                                  state.saneamientoDbLocal?.edadHijos ?? '',
                              tipoEstudioHijos:
                                  state.saneamientoDbLocal?.tipoEstudioHijos ??
                                      '',
                              motivacionCredito:
                                  state.saneamientoDbLocal?.motivacionCredito ??
                                      '',
                              importanciaMejorarCondiciones: state
                                      .saneamientoDbLocal
                                      ?.importanciaMejorarCondiciones ??
                                  '',
                              cumpliriaPropuesta: state
                                      .saneamientoDbLocal?.cumpliriaPropuesta ??
                                  false,
                              explicacionCumpliriaPropuesta: state
                                      .saneamientoDbLocal
                                      ?.explicacionCumpliriaPropuesta ??
                                  '',
                              motivoPrestamo:
                                  state.saneamientoDbLocal?.motivoPrestamo ??
                                      '',
                              mejoraCalidadVida:
                                  state.saneamientoDbLocal?.mejoraCalidadVida ??
                                      '',
                              siguienteProyectoCalidadVida: state
                                      .saneamientoDbLocal
                                      ?.siguienteProyectoCalidadVida ??
                                  '',
                              metasProximas:
                                  state.saneamientoDbLocal?.metasProximas ?? '',
                              otrosDatosCliente:
                                  state.saneamientoDbLocal?.otrosDatosCliente ??
                                      '',
                            ),
                          );
                    },
                    previousTitle: 'button.previous'.tr(),
                    nextTitle: 'button.next'.tr(),
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

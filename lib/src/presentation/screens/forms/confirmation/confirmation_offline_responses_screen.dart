import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/forms/estandar/recurrente_estandar_model.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_estandar/recurrente_estandart_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/custom_pop_up.dart';
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
    final solicitudId = context.watch<KivaRouteCubit>().state.solicitudId;
    return BlocProvider(
      create: (ctx) => RecurrenteEstandartCubit(ResponsesRepositoryImpl()),
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
      'ESTANDAR NUEVO' => EstandarOfflineForm(
          typeProduct: typeProduct,
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'ESTANDAR RECURRENTE' => EstandarOfflineForm(
          typeProduct: typeProduct,
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      _ => const SizedBox(),
    };
  }
}

class EstandarOfflineForm extends StatefulWidget {
  final String typeProduct;
  final int solicitudId;

  const EstandarOfflineForm({
    super.key,
    required this.typeProduct,
    required this.solicitudId,
  });

  @override
  State<EstandarOfflineForm> createState() => _EstandarOfflineFormState();
}

class _EstandarOfflineFormState extends State<EstandarOfflineForm> {
  @override
  void initState() {
    context
        .read<SolicitudesPendientesLocalDbCubit>()
        .getRecurrentEstandar(widget.solicitudId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<RecurrenteEstandartCubit, RecurrenteEstandartState>(
          listener: (context, state) async {
            if (state.status == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  showCloseIcon: true,
                  content: Text(state.erroMsg),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommentaryWidget(
                    title: '¿Tiene otros ingresos?¿Cuales?*',
                    initialValue: state.recurrenteEstandarDbLocal?.otrosIngresos
                        .toString(),
                    readOnly: true,
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: '¿Cuales?*',
                    initialValue: state.recurrenteEstandarDbLocal!
                            .otrosIngresosDescripcion!.isEmpty
                        ? 'N/A'
                        : state.recurrenteEstandarDbLocal!
                            .otrosIngresosDescripcion!,
                    readOnly: true,
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Número de personas a cargo:*',
                    readOnly: true,
                    textInputType: TextInputType.number,
                    initialValue: state.recurrenteEstandarDbLocal?.personasCargo
                            .toString() ??
                        '0',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Número de hijos:*',
                    readOnly: true,
                    initialValue: state.recurrenteEstandarDbLocal?.numeroHijos
                            .toString() ??
                        '0',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: '¿Que edades tienen sus hijos?',
                    readOnly: true,
                    initialValue:
                        state.recurrenteEstandarDbLocal?.edadHijos.toString() ??
                            'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: '¿Qué tipo de estudios reciben sus hijos?',
                    readOnly: true,
                    initialValue: state
                            .recurrenteEstandarDbLocal?.tipoEstudioHijos
                            .toString() ??
                        'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title:
                        '¿Coincide la respuesta del cliente con el formato anterior?',
                    readOnly: true,
                    initialValue: state
                            .recurrenteEstandarDbLocal?.coincideRespuesta
                            .toString() ??
                        'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title:
                        'Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                    readOnly: true,
                    initialValue: state
                            .recurrenteEstandarDbLocal?.explicacionInversion
                            .toString() ??
                        'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: '¿Hay alguien que le apoye en su negocio?',
                    readOnly: true,
                    initialValue: state.recurrenteEstandarDbLocal?.apoyanNegocio
                            .toString() ??
                        'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'De ser positivo, favor responder cuántas personas',
                    readOnly: true,
                    initialValue: state.recurrenteEstandarDbLocal?.cuantosApoyan
                            .toString() ??
                        'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title:
                        '¿Cómo este crédito ha constribuido a mejorar su calidad de vida y empoderarse de su negocio? Explique.',
                    readOnly: true,
                    initialValue: state
                            .recurrenteEstandarDbLocal?.comoMejoraEntorno
                            .toString() ??
                        'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title:
                        '¿En qué piensa invertir este nuevo préstamo? Explique',
                    readOnly: true,
                    initialValue: state
                            .recurrenteEstandarDbLocal?.motivoPrestamo
                            .toString() ??
                        'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title:
                        '¿Considera usted que este nuevo préstamo continúe fortaleciendo su negocio y generando mayores ganancias que beneficien a su familia? Explique ',
                    readOnly: true,
                    initialValue: state.recurrenteEstandarDbLocal?.comoFortalece
                            .toString() ??
                        'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'A futuro ¿Cuál seria su siguiente paso?*',
                    readOnly: true,
                    initialValue: state.recurrenteEstandarDbLocal?.siguientePaso
                            .toString() ??
                        'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title:
                        'Una vez finalizado el pago de este préstamo ¿ Podría ser una persona auto suficiente?',
                    readOnly: true,
                    initialValue: state
                            .recurrenteEstandarDbLocal?.personaAutoSuficiente
                            .toString() ??
                        'N/A',
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
                          .read<RecurrenteEstandartCubit>()
                          .sendOfflineAnswers(
                              recurrentEstandarModel: RecurrenteEstandarModel(
                            database:
                                state.recurrenteEstandarDbLocal?.database ?? '',
                            otrosIngresos: state
                                    .recurrenteEstandarDbLocal?.otrosIngresos ??
                                false,
                            otrosIngresosDescripcion: state
                                    .recurrenteEstandarDbLocal
                                    ?.otrosIngresosDescripcion ??
                                '',
                            personasCargo: state
                                    .recurrenteEstandarDbLocal?.personasCargo ??
                                0,
                            numeroHijos:
                                state.recurrenteEstandarDbLocal?.numeroHijos ??
                                    0,
                            edadHijos:
                                state.recurrenteEstandarDbLocal?.edadHijos ??
                                    '',
                            tipoEstudioHijos: state.recurrenteEstandarDbLocal
                                    ?.tipoEstudioHijos ??
                                '',
                            apoyanNegocio: state
                                    .recurrenteEstandarDbLocal?.apoyanNegocio ??
                                false,
                            cuantosApoyan: state
                                    .recurrenteEstandarDbLocal?.cuantosApoyan ??
                                '',
                            objSolicitudRecurrenteId: state
                                    .recurrenteEstandarDbLocal
                                    ?.objSolicitudRecurrenteId ??
                                0,
                            coincideRespuesta: state.recurrenteEstandarDbLocal
                                    ?.coincideRespuesta ??
                                false,
                            explicacionInversion: state
                                    .recurrenteEstandarDbLocal
                                    ?.explicacionInversion ??
                                '',
                            comoMejoraEntorno: state.recurrenteEstandarDbLocal
                                    ?.comoMejoraEntorno ??
                                '',
                            motivoPrestamo: state.recurrenteEstandarDbLocal
                                    ?.motivoPrestamo ??
                                '',
                            comoFortalece: state
                                    .recurrenteEstandarDbLocal?.comoFortalece ??
                                '',
                            siguientePaso: state
                                    .recurrenteEstandarDbLocal?.siguientePaso ??
                                '',
                            personaAutoSuficiente: state
                                    .recurrenteEstandarDbLocal
                                    ?.personaAutoSuficiente ??
                                '',
                          ));
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

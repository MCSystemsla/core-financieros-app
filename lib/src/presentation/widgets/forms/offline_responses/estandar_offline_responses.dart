import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/forms/estandar/estandar_model.dart';
import 'package:core_financiero_app/src/datasource/forms/estandar/recurrente_estandar_model.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/estandar/estandar_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_estandar/recurrente_estandart_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/custom_pop_up.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

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

class EstandarForm extends StatefulWidget {
  final int solicitudId;
  const EstandarForm({
    super.key,
    required this.solicitudId,
  });

  @override
  State<EstandarForm> createState() => _EstandarFormState();
}

class _EstandarFormState extends State<EstandarForm> {
  @override
  void initState() {
    context
        .read<SolicitudesPendientesLocalDbCubit>()
        .getEstandar(widget.solicitudId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(20),
              CommentaryWidget(
                title: '¿Tiene otros ingresos?¿Cuales?*',
                initialValue: state.estandarDbLocal?.otrosIngresos ?? false
                    ? 'input.yes'.tr()
                    : 'input.no'.tr(),
                readOnly: true,
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'Cuales?',
                initialValue:
                    state.estandarDbLocal?.otrosIngresosDescripcion ?? 'N/A',
                readOnly: true,
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'forms.entorno_familiar.person_origin'.tr(),
                initialValue:
                    state.estandarDbLocal?.objOrigenCatalogoValorId ?? 'N/A',
                readOnly: true,
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'Número de personas a cargo:*',
                initialValue:
                    state.estandarDbLocal?.personasCargo.toString() ?? 'N/A',
                readOnly: true,
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'Número de hijos:*',
                initialValue:
                    state.estandarDbLocal?.numeroHijos.toString() ?? 'N/A',
                readOnly: true,
              ),
              const Gap(20),
              CommentaryWidget(
                title: '¿Que edades tienen sus hijos?',
                initialValue:
                    state.estandarDbLocal?.edadHijos.toString() ?? 'N/A',
                readOnly: true,
              ),
              const Gap(20),
              CommentaryWidget(
                title: '¿Qué tipo de estudios reciben sus hijos?',
                initialValue:
                    state.estandarDbLocal?.tipoEstudioHijos.toString() ?? 'N/A',
                readOnly: true,
              ),
              const Gap(20),
              CommentaryWidget(
                title: '¿Qué tipo de estudios reciben sus hijos?',
                initialValue:
                    state.estandarDbLocal?.tipoEstudioHijos.toString() ?? 'N/A',
                readOnly: true,
              ),
              const Gap(20),
              CommentaryWidget(
                title: '¿Cuenténos cómo inició su negocio?*',
                initialValue:
                    state.estandarDbLocal?.inicioNegocio.toString() ?? 'N/A',
                readOnly: true,
              ),
              const Gap(20),
              CommentaryWidget(
                title:
                    '¿Hay alguien que le apoye en su negocio? de ser positivo,?',
                initialValue:
                    state.estandarDbLocal?.inicioNegocio.toString() ?? 'N/A',
                readOnly: true,
              ),
              const Gap(20),
              CommentaryWidget(
                title:
                    '¿Hay alguien que le apoye en su negocio? de ser positivo,?',
                initialValue:
                    state.estandarDbLocal?.apoyanNegocio.toString() ?? 'N/A',
                readOnly: true,
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'Favor responder cuántas personas',
                initialValue:
                    state.estandarDbLocal?.cuantosApoyan.toString() ?? 'N/A',
                readOnly: true,
              ),
              const Gap(20),
              CommentaryWidget(
                title:
                    '¿En qué tipo de lugares le gustaría dar a conocer su producto? ¿Por qué?*',
                initialValue:
                    state.estandarDbLocal?.publicitarNegocio.toString() ??
                        'N/A',
                readOnly: true,
              ),
              const Gap(20),
              CommentaryWidget(
                title: '¿Cómo mira su negocio en los proximos años?*',
                initialValue:
                    state.estandarDbLocal?.negocioProximosAnios.toString() ??
                        'N/A',
                readOnly: true,
              ),
              const Gap(20),
              CommentaryWidget(
                title: '¿Para qué solicitó el préstamo? Explique',
                initialValue:
                    state.estandarDbLocal?.motivoPrestamo.toString() ?? 'N/A',
                readOnly: true,
              ),
              const Gap(20),
              CommentaryWidget(
                title:
                    '¿Cuáles son sus planes personales para los proximos 5 años?*',
                initialValue:
                    state.estandarDbLocal?.planesFuturo.toString() ?? 'N/A',
                readOnly: true,
              ),
              const Gap(20),
              CommentaryWidget(
                title:
                    '¿Cómo este crédito fortalecerá su negocio y mejorará sus condiciones de vida?*',
                initialValue:
                    state.estandarDbLocal?.comoMejoraVida.toString() ?? 'N/A',
                readOnly: true,
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'Otros datos relevantes e interesantes del cliente',
                initialValue:
                    state.estandarDbLocal?.otrosDatosCliente.toString() ??
                        'N/A',
                readOnly: true,
              ),
              const Gap(20),
              ButtonActionsWidget(
                // disabled: state.status == Status.inProgress ||
                // response.status == Status.inProgress,
                onPreviousPressed: () {
                  context.pop();
                },
                onNextPressed: () {
                  context.read<EstandarCubit>().sendOffilneAnswers(
                        estandarModel: EstandarModel(
                          objSolicitudNuevamenorId:
                              state.estandarDbLocal?.objSolicitudNuevamenorId ??
                                  0,
                          database: state.estandarDbLocal?.database ?? '',
                          otrosIngresos:
                              state.estandarDbLocal?.otrosIngresos ?? false,
                          otrosIngresosDescripcion:
                              state.estandarDbLocal?.otrosIngresosDescripcion ??
                                  '',
                          objOrigenCatalogoValorId:
                              state.estandarDbLocal?.objOrigenCatalogoValorId ??
                                  '',
                          personasCargo:
                              state.estandarDbLocal?.personasCargo ?? 0,
                          numeroHijos: state.estandarDbLocal?.numeroHijos ?? 0,
                          edadHijos: state.estandarDbLocal?.edadHijos ?? '',
                          tipoEstudioHijos:
                              state.estandarDbLocal?.tipoEstudioHijos ?? '',
                          inicioNegocio: state.estandarDbLocal?.inicioNegocio ??
                              DateTime.now(),
                          apoyanNegocio:
                              state.estandarDbLocal?.apoyanNegocio ?? false,
                          cuantosApoyan:
                              state.estandarDbLocal?.cuantosApoyan ?? '',
                          publicitarNegocio:
                              state.estandarDbLocal?.publicitarNegocio ?? '',
                          negocioProximosAnios:
                              state.estandarDbLocal?.negocioProximosAnios ?? '',
                          motivoPrestamo:
                              state.estandarDbLocal?.motivoPrestamo ?? '',
                          comoMejoraVida:
                              state.estandarDbLocal?.comoMejoraVida ?? '',
                          planesFuturo:
                              state.estandarDbLocal?.planesFuturo ?? '',
                          otrosDatosCliente:
                              state.estandarDbLocal?.otrosDatosCliente ?? '',
                        ),
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
  }
}
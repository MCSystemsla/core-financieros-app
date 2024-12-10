import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/agua_y_saneamiento/agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_agua_y_saniamiento/recurrente_agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ImpactoSocialKivaWidget extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController controller;
  const ImpactoSocialKivaWidget(
      {super.key, required this.controller, required this.isRecurrentForm});

  @override
  State<ImpactoSocialKivaWidget> createState() =>
      _ImpactoSocialKivaWidgetState();
}

class _ImpactoSocialKivaWidgetState extends State<ImpactoSocialKivaWidget>
    with AutomaticKeepAliveClientMixin {
  final motivoPrestamo = TextEditingController();
  final mejoraCalidadVida = TextEditingController();
  final siguienteProyectoCalidadVida = TextEditingController();
  final metasProximas = TextEditingController();
  final otrosDatosCliente = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return switch (widget.isRecurrentForm) {
      true => _RecurrentForm(
          controller: widget.controller,
        ),
      false => SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MiCreditoProgress(
                      steps: 5,
                      currentStep: 4,
                    ),
                    const Gap(20),
                    Text(
                      'Impacto Social de Kiva ( Uso específico, objetivos, metas del préstamo)'
                          .tr(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const Gap(10),
                    CommentaryWidget(
                      title: '¿Para que solicitó este préstamo? Explique'.tr(),
                      textEditingController: motivoPrestamo,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                    ),
                    const Gap(10),
                    CommentaryWidget(
                      title: 'forms.impacto_social_kiva.how_perform'.tr(),
                      textEditingController: mejoraCalidadVida,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                    ),
                    const Gap(10),
                    CommentaryWidget(
                      title:
                          '¿Cuál sería el siguiente proyecto para enriquecer su calidad de vida ?*'
                              .tr(),
                      textEditingController: siguienteProyectoCalidadVida,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                    ),
                    const Gap(10),
                    CommentaryWidget(
                      title:
                          '¿Cuáles son sus metas para los próximos años?*'.tr(),
                      textEditingController: metasProximas,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                    ),
                    const Gap(10),
                    CommentaryWidget(
                      title:
                          '¿Otros datos relevantes e interesantes del cliente:'
                              .tr(),
                      textEditingController: otrosDatosCliente,
                    ),
                    const Gap(20),
                    ButtonActionsWidget(
                      onPreviousPressed: () {
                        widget.controller.previousPage(
                          duration: const Duration(
                            milliseconds: 350,
                          ),
                          curve: Curves.easeIn,
                        );
                      },
                      onNextPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          context.read<AguaYSaneamientoCubit>().saveAnswers(
                                motivoPrestamo: motivoPrestamo.text.trim(),
                                mejoraCalidadVida:
                                    mejoraCalidadVida.text.trim(),
                                siguienteProyectoCalidadVida:
                                    siguienteProyectoCalidadVida.text.trim(),
                                metasProximas: metasProximas.text.trim(),
                                otrosDatosCliente:
                                    otrosDatosCliente.text.trim(),
                                solicitudNuevamenorId: int.parse(
                                  context
                                      .read<KivaRouteCubit>()
                                      .state
                                      .solicitudId,
                                ),
                              );
                          context.read<ResponseCubit>().addResponses(
                            responses: [
                              Response(
                                index: widget.controller.page?.toInt() ?? 0,
                                question:
                                    '¿Para que solicitó este préstamo? Explique',
                                response: motivoPrestamo.text.trim(),
                              ),
                              Response(
                                index: widget.controller.page?.toInt() ?? 0,
                                question:
                                    'forms.impacto_social_kiva.how_perform'
                                        .tr(),
                                response: mejoraCalidadVida.text.trim(),
                              ),
                              Response(
                                index: widget.controller.page?.toInt() ?? 0,
                                question:
                                    '¿Cuál sería el siguiente proyecto para enriquecer su calidad de vida ?*'
                                        .tr(),
                                response:
                                    siguienteProyectoCalidadVida.text.trim(),
                              ),
                              Response(
                                index: widget.controller.page?.toInt() ?? 0,
                                question:
                                    '¿Cuáles son sus metas para los próximos años?*'
                                        .tr(),
                                response: metasProximas.text.trim(),
                              ),
                              Response(
                                index: widget.controller.page?.toInt() ?? 0,
                                question:
                                    '¿Otros datos relevantes e interesantes del cliente:'
                                        .tr(),
                                response: otrosDatosCliente.text.trim(),
                              ),
                            ],
                          );
                          widget.controller.nextPage(
                            duration: const Duration(
                              milliseconds: 350,
                            ),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      previousTitle: 'button.previous'.tr(),
                      nextTitle: 'button.next'.tr(),
                    ),
                    const Gap(10),
                  ],
                ),
              ),
            ),
          ),
        ),
    };
  }

  @override
  bool get wantKeepAlive => true;
}

class _RecurrentForm extends StatefulWidget {
  final PageController controller;
  const _RecurrentForm({required this.controller});

  @override
  State<_RecurrentForm> createState() => _RecurrentFormState();
}

class _RecurrentFormState extends State<_RecurrentForm>
    with AutomaticKeepAliveClientMixin {
  final motivoPrestamo = TextEditingController();
  final comoMejoraCondicionesEntorno = TextEditingController();
  final quienApoya = TextEditingController();
  final siguientePaso = TextEditingController();
  final explicacionAlcanzaraMeta = TextEditingController();
  String? alcanzaraMeta;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MiCreditoProgress(
                steps: 5,
                currentStep: 4,
              ),
              const Gap(20),
              Text(
                'Impacto Social de Kiva ( Uso específico, objetivos, metas del préstamo)'
                    .tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(10),
              CommentaryWidget(
                title:
                    '¿En qué piensa invertir este nuevo préstamo de agua y saneamiento?*'
                        .tr(),
                textEditingController: motivoPrestamo,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(10),
              CommentaryWidget(
                title:
                    '¿Cómo cree usted que este nuevo préstamo mejore sus condiciones de vida y entorno familiar?*'
                        .tr(),
                textEditingController: comoMejoraCondicionesEntorno,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(10),
              CommentaryWidget(
                title:
                    '¿Quién o quienes le estarían apoyando en esta inversión?*'
                        .tr(),
                textEditingController: quienApoya,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(10),
              CommentaryWidget(
                title:
                    'Una vez finalizado el pago de este préstamo: ¿Cuál sería su siguiente paso?*'
                        .tr(),
                textEditingController: siguientePaso,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(10),
              CommentaryWidget(
                title: 'Explique Como Alcanzara la meta?',
                textEditingController: explicacionAlcanzaraMeta,
              ),
              const Gap(20),
              ButtonActionsWidget(
                onPreviousPressed: () {
                  widget.controller.previousPage(
                    duration: const Duration(
                      milliseconds: 350,
                    ),
                    curve: Curves.easeIn,
                  );
                },
                onNextPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    context.read<RecurrenteAguaYSaneamientoCubit>().saveAnswers(
                          motivoPrestamo: motivoPrestamo.text.trim(),
                          comoMejoraCondicionesEntorno:
                              comoMejoraCondicionesEntorno.text.trim(),
                          quienApoya: quienApoya.text.trim(),
                          siguientePaso: siguientePaso.text.trim(),
                          explicacionAlcanzaraMeta:
                              explicacionAlcanzaraMeta.text.trim(),
                          objSolicitudRecurrenteId: int.parse(
                            context.read<KivaRouteCubit>().state.solicitudId,
                          ),
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          index: widget.controller.page?.toInt() ?? 0,
                          question:
                              '¿En qué piensa invertir este nuevo préstamo de agua y saneamiento?*',
                          response: motivoPrestamo.text.trim(),
                        ),
                        Response(
                          index: widget.controller.page?.toInt() ?? 0,
                          question:
                              '¿Cómo cree usted que este nuevo préstamo mejore sus condiciones de vida y entorno familiar?*',
                          response: comoMejoraCondicionesEntorno.text.trim(),
                        ),
                        Response(
                          index: widget.controller.page?.toInt() ?? 0,
                          question:
                              '¿Quién o quienes le estarían apoyando en esta inversión?*',
                          response: quienApoya.text.trim(),
                        ),
                        Response(
                          index: widget.controller.page?.toInt() ?? 0,
                          question:
                              'Una vez finalizado el pago de este préstamo: ¿Cuál sería su siguiente paso?*',
                          response: siguientePaso.text.trim(),
                        ),
                        Response(
                          index: widget.controller.page?.toInt() ?? 0,
                          question: 'Explique Como Alcanzara la meta?',
                          response: explicacionAlcanzaraMeta.text.trim(),
                        ),
                      ],
                    );
                    widget.controller.nextPage(
                      duration: const Duration(
                        milliseconds: 350,
                      ),
                      curve: Curves.easeIn,
                    );
                  }
                },
                previousTitle: 'button.previous'.tr(),
                nextTitle: 'button.next'.tr(),
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

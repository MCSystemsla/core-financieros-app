import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/micredi_estudio/micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_micredi_estudio/recurrente_micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/button_actions_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MiCrediEstudioImpactoSocialWidget extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController controller;
  const MiCrediEstudioImpactoSocialWidget({
    super.key,
    required this.controller,
    required this.isRecurrentForm,
  });

  @override
  State<MiCrediEstudioImpactoSocialWidget> createState() =>
      _ImpactoSocialCrediEstudioWidgetState();
}

class _ImpactoSocialCrediEstudioWidgetState
    extends State<MiCrediEstudioImpactoSocialWidget>
    with AutomaticKeepAliveClientMixin {
  final question1Controller = TextEditingController();
  final question2Controller = TextEditingController();
  final question3Controller = TextEditingController();
  final question4Controller = TextEditingController();
  final question5Controller = TextEditingController();
  final question6Controller = TextEditingController();
  final cualEstudio = TextEditingController();
  String? optarOtroEstudio;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return switch (widget.isRecurrentForm) {
      true => _RecurrentFormImpactoSocial(
          pageController: widget.controller,
        ),
      false => SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MiCreditoProgress(
                    steps: 5,
                    currentStep: 5,
                  ),
                  const Gap(20),
                  Text(
                    'forms.mejora_de_vivienda.impacto_social.title'.tr(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: 'forms.miCredi_estudio.question1'.tr(),
                    textEditingController: question1Controller,
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
                        '¿De qué manera este financiamiento le ayudará a crecer profesionalemente? Explique'
                            .tr(),
                    textEditingController: question2Controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  WhiteCard(
                    marginTop: 15,
                    padding: const EdgeInsets.all(10),
                    child: JLuxDropdown(
                      isContainIcon: true,
                      title: '¿Piensa optar a otro estudio superior?*'.tr(),
                      items: ['input.yes'.tr(), 'input.no'.tr()],
                      onChanged: (item) {
                        if (item == null) return;
                        optarOtroEstudio = item;
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                      toStringItem: (item) => item,
                      hintText: 'input.select_option'.tr(),
                    ),
                  ),
                  if (optarOtroEstudio == 'input.yes'.tr())
                    CommentaryWidget(
                      title: 'Porque?',
                      textEditingController: cualEstudio,
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
                        '¿Cuáles son sus planes en los próximos 10 años?*'.tr(),
                    textEditingController: question4Controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: '¿Qué aspira laboralmente?*'.tr(),
                    textEditingController: question5Controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: 'Otros datos relevantes e interesantes del cliente'
                        .tr(),
                    textEditingController: question6Controller,
                  ),
                  const Gap(10),
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
                        context.read<MicrediEstudioCubit>().saveAnswers(
                              motivoPrestamo: question1Controller.text.trim(),
                              comoAyudaCrecer: question2Controller.text.trim(),
                              optarOtroEstudio:
                                  optarOtroEstudio == 'input.yes'.tr(),
                              cualEstudio: cualEstudio.text.trim(),
                              planFuturo: question4Controller.text.trim(),
                              aspiraLaboralmente:
                                  question5Controller.text.trim(),
                              otrosDatosCliente:
                                  question6Controller.text.trim(),
                              objSolicitudNuevamenorId: int.parse(
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
                              question: 'forms.miCredi_estudio.question1'.tr(),
                              response: question1Controller.text.trim(),
                            ),
                            Response(
                              index: widget.controller.page?.toInt() ?? 0,
                              question:
                                  '¿De qué manera este financiamiento le ayudará a crecer profesionalemente? Explique'
                                      .tr(),
                              response: question2Controller.text.trim(),
                            ),
                            Response(
                              index: widget.controller.page?.toInt() ?? 0,
                              question:
                                  '¿Piensa optar a otro estudio superior?*'
                                      .tr(),
                              response: optarOtroEstudio ?? 'N/A',
                            ),
                            if (optarOtroEstudio == 'input.yes'.tr())
                              Response(
                                index: widget.controller.page?.toInt() ?? 0,
                                question: 'Porque?'.tr(),
                                response: cualEstudio.text.trim(),
                              ),
                            Response(
                              index: widget.controller.page?.toInt() ?? 0,
                              question:
                                  '¿Cuáles son sus planes en los próximos 10 años?*'
                                      .tr(),
                              response: question4Controller.text.trim(),
                            ),
                            Response(
                              index: widget.controller.page?.toInt() ?? 0,
                              question: '¿Qué aspira laboralmente?*'.tr(),
                              response: question5Controller.text.trim(),
                            ),
                            Response(
                              index: widget.controller.page?.toInt() ?? 0,
                              question:
                                  'Otros datos relevantes e interesantes del cliente'
                                      .tr(),
                              response: question6Controller.text.trim(),
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
    };
  }

  @override
  bool get wantKeepAlive => true;
}

class _RecurrentFormImpactoSocial extends StatefulWidget {
  final PageController pageController;
  const _RecurrentFormImpactoSocial({
    required this.pageController,
  });

  @override
  State<_RecurrentFormImpactoSocial> createState() =>
      _RecurrentFormImpactoSocialState();
}

class _RecurrentFormImpactoSocialState
    extends State<_RecurrentFormImpactoSocial>
    with AutomaticKeepAliveClientMixin {
  final motivoPrestamo = TextEditingController();
  final comoAyudaCrecer = TextEditingController();
  String? alcanzaraMeta;
  final explicacionAlcanzaraMeta = TextEditingController();
  final siguentePaso = TextEditingController();
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
                currentStep: 5,
              ),
              const Gap(20),
              Text(
                'Impacto Social de Kiva ( Uso específico, objetivos, metas del préstamo)'
                    .tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: motivoPrestamo,
                title:
                    '¿En qué piensa invertir este nuevo préstamo de MiCrediestudio?* Explique',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(20),
              CommentaryWidget(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
                textEditingController: comoAyudaCrecer,
                title:
                    '¿Cómo cree usted que este nuevo préstamo le ayude en su crecimiento profesional?*',
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: explicacionAlcanzaraMeta,
                title: 'Explica la meta?',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: siguentePaso,
                title: '¿Cuál sería su siguiente paso?',
              ),
              ButtonActionsWidget(
                onPreviousPressed: () {
                  widget.pageController.previousPage(
                    duration: const Duration(
                      milliseconds: 350,
                    ),
                    curve: Curves.easeIn,
                  );
                },
                onNextPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    context.read<RecurrenteMicrediEstudioCubit>().saveAnswers(
                          motivoPrestamo: motivoPrestamo.text.trim(),
                          comoAyudaCrecer: comoAyudaCrecer.text.trim(),
                          explicacionAlcanzaraMeta:
                              explicacionAlcanzaraMeta.text.trim(),
                          siguientePaso: siguentePaso.text.trim(),
                          objSolicitudRecurrenteId: int.parse(
                            context.read<KivaRouteCubit>().state.solicitudId,
                          ),
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          index: 1,
                          question:
                              '¿En qué piensa invertir este nuevo préstamo de MiCrediestudio?* Explique',
                          response: motivoPrestamo.text.trim(),
                        ),
                        Response(
                          index: 1,
                          question:
                              '¿Cómo cree usted que este nuevo préstamo le ayude en su crecimiento profesional?*',
                          response: comoAyudaCrecer.text.trim(),
                        ),
                        Response(
                          index: 1,
                          question:
                              '¿Cree usted que una vez finalizado el pago de este préstamo de MiCréditoEstudio alcanzó su meta académica? ¿Por qué?',
                          response: alcanzaraMeta ?? 'N/A',
                        ),
                        if (alcanzaraMeta == 'input.yes'.tr())
                          Response(
                            index: 1,
                            question: 'Explica la meta?',
                            response: explicacionAlcanzaraMeta.text.trim(),
                          ),
                        Response(
                          index: 1,
                          question: '¿Cuál sería su siguiente paso?',
                          response: siguentePaso.text.trim(),
                        ),
                      ],
                    );
                    widget.pageController.nextPage(
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

import 'package:core_financiero_app/src/presentation/bloc/mejora_vivienda/mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_,mejora_vivienda.dart/recurrente_mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../domain/entities/responses.dart';

class ImpactoSocialKivaObjetiveWidget extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController controller;
  const ImpactoSocialKivaObjetiveWidget(
      {super.key, required this.controller, required this.isRecurrentForm});

  @override
  State<ImpactoSocialKivaObjetiveWidget> createState() =>
      _ImpactoSocialKivaObjetiveWidgetState();
}

class _ImpactoSocialKivaObjetiveWidgetState
    extends State<ImpactoSocialKivaObjetiveWidget>
    with AutomaticKeepAliveClientMixin {
  final question1Controller = TextEditingController();
  final question2Controller = TextEditingController();
  final question3Controller = TextEditingController();
  final question4Controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return switch (widget.isRecurrentForm) {
      true => _RecurrentForm(
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
                    currentStep: 3,
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
                    title: 'forms.mejora_de_vivienda.question1'.tr(),
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
                    title: 'forms.mejora_de_vivienda.question2'.tr(),
                    textEditingController: question2Controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: '¿Cuáles son sus planes para los próximos años?',
                    textEditingController: question3Controller,
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    textEditingController: question4Controller,
                    title: 'Otros datos relevantes e interesantes del cliente',
                  ),
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
                        context.read<MejoraViviendaCubit>().saveAnswer2(
                              motivoPrestamo: question2Controller.text.trim(),
                              comoAyudara: question2Controller.text.trim(),
                              planesFuturo: question3Controller.text.trim(),
                              otrosDatosCliente:
                                  question4Controller.text.trim(),
                            );
                        context.read<ResponseCubit>().addResponses(
                          responses: [
                            Response(
                              question:
                                  'forms.mejora_de_vivienda.question1'.tr(),
                              response: question1Controller.text.trim(),
                            ),
                            Response(
                              question:
                                  'forms.mejora_de_vivienda.question2'.tr(),
                              response: question2Controller.text.trim(),
                            ),
                            Response(
                              question:
                                  '¿Cuáles son sus planes para los próximos años?'
                                      .tr(),
                              response: question3Controller.text.trim(),
                            ),
                            Response(
                              question:
                                  'Otros datos relevantes e interesantes del cliente'
                                      .tr(),
                              response: question4Controller.text.trim(),
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
        )
    };
  }

  @override
  bool get wantKeepAlive => true;
}

class _RecurrentForm extends StatefulWidget {
  final PageController pageController;
  const _RecurrentForm({required this.pageController});

  @override
  State<_RecurrentForm> createState() => _RecurrentFormState();
}

class _RecurrentFormState extends State<_RecurrentForm>
    with AutomaticKeepAliveClientMixin {
  final question1 = TextEditingController();
  final question2 = TextEditingController();
  final question3 = TextEditingController();
  final question4 = TextEditingController();
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
                currentStep: 3,
              ),
              const Gap(20),
              const Text('recurrente'),
              Text(
                'forms.mejora_de_vivienda.impacto_social.title'.tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: question1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
                title:
                    '¿En qué piensa invertir este nuevo préstamo de Mejora de Vivienda?* Explique',
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: question2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
                title:
                    '¿Cómo cree usted que este nuevo préstamo vaya a mejorar la seguridad de su familia?*',
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: question3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
                title:
                    '¿Quién o quiénes le estarían apoyando en esta nueva inversión?*',
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: question4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
                title:
                    'Una vez finalizado este préstamo ¿Cuál sería su siguiente meta?',
              ),
              const Gap(20),
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
                    context.read<RecurrenteMejoraViviendaCubit>().saveAnswers3(
                          motivoPrestamo: question1.text.trim(),
                          explicacionInversion: question1.text.trim(),
                          mejoraSeguridadFamilia: question2.text.trim(),
                          quienApoya: question3.text.trim(),
                          siguienteMeta: question4.text.trim(),
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

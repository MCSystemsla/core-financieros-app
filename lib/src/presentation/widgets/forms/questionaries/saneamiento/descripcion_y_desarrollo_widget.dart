import 'package:core_financiero_app/src/presentation/bloc/agua_y_saneamiento/agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_agua_y_saniamiento/recurrente_agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/motivo_prestamo_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DescripcionYDesarrolloWidget extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController controller;
  const DescripcionYDesarrolloWidget({
    super.key,
    required this.controller,
    required this.isRecurrentForm,
  });

  @override
  State<DescripcionYDesarrolloWidget> createState() =>
      _DescripcionYDesarrolloWidgetState();
}

class _DescripcionYDesarrolloWidgetState
    extends State<DescripcionYDesarrolloWidget>
    with AutomaticKeepAliveClientMixin {
  final question1Controller = TextEditingController();
  final question2Controller = TextEditingController();
  final question3Controller = TextEditingController();
  final question4Controller = TextEditingController();
  final explicacionCumpliriaPropuesta = TextEditingController();
  String? cumpliriaPropuesta;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return switch (widget.isRecurrentForm) {
      true => _RecurrentForm(
          pageController: widget.controller,
        ),
      false => SingleChildScrollView(
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
                      currentStep: 3,
                    ),
                    const Gap(20),
                    Text(
                      'forms.develpment_and_description.title'.tr(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const Gap(10),
                    CommentaryWidget(
                      title:
                          'forms.develpment_and_description.aboutCredit'.tr(),
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
                          '¿Porqué considera importante mejorar las condiciones higiénicas en su familia?*'
                              .tr(),
                      textEditingController: question2Controller,
                    ),
                    const Gap(10),
                    WhiteCard(
                      padding: const EdgeInsets.all(5),
                      child: JLuxDropdown(
                        isContainIcon: true,
                        validator: (value) {
                          if (value == null) {
                            return 'input.input_validator'.tr();
                          }

                          return null;
                        },
                        title:
                            '¿Cree usted que con este crédito va poder cumplir el proyecto que se ha propuesto? ¿Por qué?'
                                .tr(),
                        items: ['input.yes'.tr(), 'input.no'.tr()],
                        onChanged: (item) {
                          if (item == null) return;
                          cumpliriaPropuesta = item;
                          setState(() {});
                        },
                        toStringItem: (item) {
                          return item;
                        },
                        hintText: 'input.select_option'.tr(),
                      ),
                    ),
                    const Gap(10),
                    if (cumpliriaPropuesta == 'input.yes'.tr())
                      CommentaryWidget(
                        title: 'Porque?',
                        textEditingController: explicacionCumpliriaPropuesta,
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
                                motivacionCredito:
                                    question1Controller.text.trim(),
                                importanciaMejorarCondiciones:
                                    question2Controller.text.trim(),
                                cumpliriaPropuesta:
                                    cumpliriaPropuesta == 'input.yes'.tr(),
                                explicacionCumpliriaPropuesta:
                                    explicacionCumpliriaPropuesta.text.trim(),
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
  final PageController pageController;
  const _RecurrentForm({required this.pageController});

  @override
  State<_RecurrentForm> createState() => _RecurrentFormState();
}

class _RecurrentFormState extends State<_RecurrentForm>
    with AutomaticKeepAliveClientMixin {
  String? item1;
  String? coincideRespuesta;
  final explicacionInversion = TextEditingController();
  final comoAyudoCondiciones = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const MiCreditoProgress(
                steps: 5,
                currentStep: 3,
              ),
              const Gap(20),
              Text(
                'forms.develpment_and_description.title'.tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(10),
              // const CommentaryWidget(
              //   title:
              //       '¿Para que utilizó el crédito anterior ?* (autorellenará con la respuesta del crédito anterior)',
              // ),

              const Gap(10),
              const MotivoPrestamoWidget(),
              const Gap(10),
              WhiteCard(
                padding: const EdgeInsets.all(5),
                child: JLuxDropdown(
                  isContainIcon: true,
                  validator: (value) {
                    if (value == null) return 'input.input_validator'.tr();

                    return null;
                  },
                  title:
                      '¿Coincide la respuesta del cliente con el formato anterior?'
                          .tr(),
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    coincideRespuesta = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              const Gap(10),
              if (coincideRespuesta == 'input.no'.tr())
                CommentaryWidget(
                  textEditingController: explicacionInversion,
                  title:
                      '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                ),
              const Gap(10),
              CommentaryWidget(
                title:
                    '¿De qué manera le ayudó este préstamo Kiva a mejorar sus condiciones en la familia?*',
                textEditingController: comoAyudoCondiciones,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
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
                    context.read<RecurrenteAguaYSaneamientoCubit>().saveAnswers(
                          coincideRespuesta:
                              coincideRespuesta == 'input.yes'.tr(),
                          explicacionInversion:
                              explicacionInversion.text.trim(),
                          comoAyudoCondiciones:
                              comoAyudoCondiciones.text.trim(),
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

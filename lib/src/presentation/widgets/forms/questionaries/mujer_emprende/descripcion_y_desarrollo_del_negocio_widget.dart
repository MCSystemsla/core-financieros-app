import 'package:core_financiero_app/src/presentation/bloc/mujer_emprende/mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DescripcionYDesarrolloDelNegocioWidget extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController pageController;
  const DescripcionYDesarrolloDelNegocioWidget({
    super.key,
    required this.pageController,
    required this.isRecurrentForm,
  });

  @override
  State<DescripcionYDesarrolloDelNegocioWidget> createState() =>
      _DescripcionYDesarrolloDelNegocioWidgetState();
}

class _DescripcionYDesarrolloDelNegocioWidgetState
    extends State<DescripcionYDesarrolloDelNegocioWidget>
    with AutomaticKeepAliveClientMixin {
  final question1 = TextEditingController();
  final question2 = TextEditingController();
  final question3 = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return switch (widget.isRecurrentForm) {
      true => _RecurrentForm(
          pageController: widget.pageController,
        ),
      false => Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MiCreditoProgress(
                    steps: 4,
                    currentStep: 2,
                  ),
                  const Gap(20),
                  Text(
                    'Descripción y desarrollo del negocio'.tr(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Cuéntenos, ¿Qué la motivó a emprender su negocio?*',
                    textEditingController: question1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  CommentaryWidget(
                    title:
                        'Coméntenos, ¿ Cómo conoció el proyecto de Mujer Emprende en MiCrédito?',
                    textEditingController: question2,
                  ),
                  CommentaryWidget(
                    title: '¿Qué la impulsó a optar a este tipo de crédito?*',
                    textEditingController: question3,
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
                        context.read<MujerEmprendeCubit>().saveAnswers(
                              motivoEmprender: question1.text.trim(),
                              conocioMujerEmprende: question2.text.trim(),
                              impulsoOptar: question3.text.trim(),
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
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 4,
              currentStep: 2,
            ),
            const Gap(20),
            Text(
              'Descripción del crédito anterior Mujer Emprende'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(20),
            const CommentaryWidget(
              title:
                  '¿Para que utilizó el crédito anterior ?* (autorellenará con la respuesta del crédito anterior)',
            ),
            const Gap(20),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title:
                    '¿Coincide la respuesta del cliente con el formato anterior?'
                        .tr(),
                items: const ['Si', 'No'],
                onChanged: (item) {
                  if (item == null) return;
                },
                toStringItem: (item) => item,
                hintText: 'input.select_department'.tr(),
              ),
            ),
            const Gap(20),
            const CommentaryWidget(
              title:
                  '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
            ),
            const Gap(20),
            const CommentaryWidget(
              title: '¿De qué manera le ayudó este préstamo Kiva?*',
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
                widget.pageController.nextPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              previousTitle: 'button.previous'.tr(),
              nextTitle: 'button.next'.tr(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

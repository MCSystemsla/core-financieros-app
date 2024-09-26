import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EstandarDescripciondelNegocio extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController pageController;
  const EstandarDescripciondelNegocio({
    super.key,
    required this.pageController,
    required this.isRecurrentForm,
  });

  @override
  State<EstandarDescripciondelNegocio> createState() =>
      _EstandarDescripciondelNegocioState();
}

class _EstandarDescripciondelNegocioState
    extends State<EstandarDescripciondelNegocio> {
  @override
  Widget build(BuildContext context) {
    return switch (widget.isRecurrentForm) {
      true => _RecurrentForm(
          pageController: widget.pageController,
        ),
      false => Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MiCreditoProgress(
                  steps: 4,
                  currentStep: 3,
                ),
                const Gap(20),
                Text(
                  'Descripción y desarrollo del negocio.'.tr(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const Gap(20),
                const CommentaryWidget(
                    title: '¿Cuenténos cómo inició su negocio?*'),
                const Gap(20),
                WhiteCard(
                  padding: const EdgeInsets.all(5),
                  child: JLuxDropdown(
                    isContainIcon: true,
                    validator: (value) {
                      if (value == null) return 'input.input_validator'.tr();
                      return null;
                    },
                    title:
                        '¿Hay alguien que le apoye en su negocio? de ser positivo, favor responder cuántas personas'
                            .tr(),
                    items: const [
                      '1 a 3',
                      '4 a 6',
                      '7 o mas',
                    ],
                    onChanged: (item) {
                      if (item == null) return;
                    },
                    toStringItem: (item) {
                      return item;
                    },
                    hintText: 'input.select_option'.tr(),
                  ),
                ),
                const Gap(20),
                const CommentaryWidget(
                  title:
                      '¿En qué tipo de lugares le gustaría dar a conocer su producto? ¿Por qué?*',
                ),
                const Gap(20),
                const CommentaryWidget(
                  title: '¿Cómo mira su negocio en los proximos años?*',
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
                const Gap(10),
              ],
            ),
          ),
        ),
    };
  }
}

class _RecurrentForm extends StatefulWidget {
  final PageController pageController;
  const _RecurrentForm({required this.pageController});

  @override
  State<_RecurrentForm> createState() => _RecurrentFormState();
}

class _RecurrentFormState extends State<_RecurrentForm>
    with AutomaticKeepAliveClientMixin {
  String? decisionItem;
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
              currentStep: 3,
            ),
            const Gap(20),
            Text(
              'Descripcíon del crédito anterior'.tr(),
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
                  decisionItem = item;
                  setState(() {});
                },
                toStringItem: (item) {
                  return item;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
            if (decisionItem == 'input.no'.tr())
              const CommentaryWidget(
                title:
                    'Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
              ),
            const Gap(20),
            WhiteCard(
              padding: const EdgeInsets.all(5),
              child: JLuxDropdown(
                isContainIcon: true,
                validator: (value) {
                  if (value == null) return 'input.input_validator'.tr();
                  return null;
                },
                title:
                    '¿Hay alguien que le apoye en su negocio? de ser positivo, favor responder cuántas personas'
                        .tr(),
                items: const [
                  '1 a 3',
                  '4 a 6',
                  '7 o mas',
                ],
                onChanged: (item) {
                  if (item == null) return;
                },
                toStringItem: (item) {
                  return item;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
            const CommentaryWidget(
              title:
                  '¿Cómo este crédito ha constribuido a mejorar su calidad de vida y empoderarse de su negocio? Explique. ',
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
            const Gap(10),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

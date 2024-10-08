import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EstandarImpactoSocial extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController pageController;
  const EstandarImpactoSocial({
    super.key,
    required this.pageController,
    required this.isRecurrentForm,
  });

  @override
  State<EstandarImpactoSocial> createState() => _EstandarImpactoSocialState();
}

class _EstandarImpactoSocialState extends State<EstandarImpactoSocial> {
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
                  'Impacto Social de Kiva ( Uso específico, objetivos, metas del préstamo)'
                      .tr(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const Gap(20),
                const CommentaryWidget(
                  title: '¿Para qué solicitó el préstamo? Explique',
                ),
                const Gap(20),
                const CommentaryWidget(
                  title:
                      '¿Cómo este crédito fortalecerá su negocio y mejorará sus condiciones de vida?*',
                ),
                const Gap(20),
                const CommentaryWidget(
                  title:
                      '¿Cuáles son sus planes personales para los proximos 5 años?*',
                ),
                const Gap(20),
                const CommentaryWidget(
                  title: 'Otros datos relevantes e interesantes del cliente',
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

class _RecurrentFormState extends State<_RecurrentForm> {
  @override
  Widget build(BuildContext context) {
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
              'Impacto Social de Kiva ( Uso específico, objetivos, metas del préstamo)'
                  .tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(20),
            const CommentaryWidget(
              title: '¿En qué piensa invertir este nuevo préstamo? Explique',
            ),
            const Gap(20),
            const CommentaryWidget(
              title:
                  '¿Considera usted que este nuevo préstamo continúe fortaleciendo su negocio y generando mayores ganancias que beneficien a su familia? Explique ',
            ),
            const Gap(20),
            const CommentaryWidget(
              title: 'A futuro ¿Cuál seria su siguiente paso?*',
            ),
            const Gap(20),
            const CommentaryWidget(
              title:
                  'Una vez finalizado el pago de este préstamo ¿ Podría ser una persona auto suficiente?',
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
}

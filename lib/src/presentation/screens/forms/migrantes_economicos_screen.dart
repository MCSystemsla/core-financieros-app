import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MigrantesEconomicosScreen extends StatelessWidget {
  const MigrantesEconomicosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return Scaffold(
      appBar: AppBar(
        title: Text('forms.migrantes_economicos.title'.tr()),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          SaneamientoContent(
            controller: pageController,
          ),
          PrimerPrestamoWidget(
            controller: pageController,
          ),
          _ImpactoSocialMigranteEconomico(
            controller: pageController,
          ),
          const SignQuestionaryWidget(),
        ],
      ),
    );
  }
}

class PrimerPrestamoWidget extends StatefulWidget {
  final PageController controller;
  const PrimerPrestamoWidget({super.key, required this.controller});

  @override
  State<PrimerPrestamoWidget> createState() => _PrimerPrestamoWidgetState();
}

class _PrimerPrestamoWidgetState extends State<PrimerPrestamoWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 3,
              currentStep: 2,
            ),
            const Gap(20),
            Text(
              'forms.migrantes_economicos.primer_prestamo.title'.tr(),
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(20),
            CommentaryWidget(
              title:
                  'forms.migrantes_economicos.primer_prestamo.question1'.tr(),
            ),
            const Gap(20),
            CommentaryWidget(
              title:
                  'forms.migrantes_economicos.primer_prestamo.question2'.tr(),
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
                widget.controller.nextPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              previousTitle: 'button.previous'.tr(),
              nextTitle: 'button.next'.tr(),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

class _ImpactoSocialMigranteEconomico extends StatefulWidget {
  final PageController controller;
  const _ImpactoSocialMigranteEconomico({required this.controller});

  @override
  State<_ImpactoSocialMigranteEconomico> createState() =>
      _ImpactoSocialMigranteEconomicoState();
}

class _ImpactoSocialMigranteEconomicoState
    extends State<_ImpactoSocialMigranteEconomico> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 3,
              currentStep: 2,
            ),
            const Gap(20),
            Text(
              'forms.mejora_de_vivienda.impacto_social.title'.tr(),
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'forms.migrantes_economicos.impacto_social.question1'.tr(),
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'forms.migrantes_economicos.impacto_social.question2'.tr(),
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'forms.migrantes_economicos.impacto_social.question3'.tr(),
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'forms.migrantes_economicos.impacto_social.question4'.tr(),
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
                widget.controller.nextPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              previousTitle: 'button.previous'.tr(),
              nextTitle: 'button.signed'.tr(),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

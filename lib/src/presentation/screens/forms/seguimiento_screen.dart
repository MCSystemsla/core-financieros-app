import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SeguimientoScreen extends StatelessWidget {
  const SeguimientoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        title: Text('forms.seguimiento.title'.tr()),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          SaneamientoContent(
            controller: pageController,
          ),
          GrupoEncuestaWidget(
            controller: pageController,
          ),
          const SignQuestionaryWidget(),
        ],
      ),
    );
  }
}

class GrupoEncuestaWidget extends StatefulWidget {
  final PageController controller;
  const GrupoEncuestaWidget({super.key, required this.controller});

  @override
  State<GrupoEncuestaWidget> createState() => _GrupoEncuestaWidgetState();
}

class _GrupoEncuestaWidgetState extends State<GrupoEncuestaWidget> {
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
              'forms.seguimiento.description'.tr(),
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'forms.seguimiento.question1'.tr(),
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'forms.seguimiento.question2'.tr(),
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'forms.seguimiento.question3'.tr(),
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'forms.seguimiento.question4'.tr(),
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'forms.seguimiento.question5'.tr(),
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
              nextTitle: 'button.signed'.tr(),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
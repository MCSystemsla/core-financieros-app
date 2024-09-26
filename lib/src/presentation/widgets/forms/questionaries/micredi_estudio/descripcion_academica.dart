import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DescripcionAcademica extends StatefulWidget {
  final PageController pageController;
  final bool isRecurrentForm;
  const DescripcionAcademica(
      {super.key, required this.pageController, required this.isRecurrentForm});

  @override
  State<DescripcionAcademica> createState() => _DescripcionAcademicaState();
}

class _DescripcionAcademicaState extends State<DescripcionAcademica> {
  @override
  Widget build(BuildContext context) {
    return switch (widget.isRecurrentForm) {
      true => _RecurrentForm(
          pageController: widget.pageController,
        ),
      false => const Text('no recurrente')
    };
  }
}

class _RecurrentForm extends StatefulWidget {
  final PageController pageController;
  const _RecurrentForm({
    required this.pageController,
  });

  @override
  State<_RecurrentForm> createState() => _RecurrentFormState();
}

class _RecurrentFormState extends State<_RecurrentForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MiCreditoProgress(
            steps: 5,
            currentStep: 2,
          ),
          const Gap(20),
          Text(
            'Descripcion Academica'.tr(),
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          const Gap(20),
          const CommentaryWidget(title: 'Carrera: '),
          const Gap(20),
          const CommentaryWidget(title: 'Años de la carrera:'),
          const Gap(20),
          const CommentaryWidget(
            title:
                '¿Quién o quiénes le estarían apoyando en esta nueva etapa?*',
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
    );
  }
}

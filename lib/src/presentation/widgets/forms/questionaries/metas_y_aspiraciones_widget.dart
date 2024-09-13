import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MetasYAspiracionesWidget extends StatelessWidget {
  final PageController controller;
  const MetasYAspiracionesWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 5,
              currentStep: 5,
            ),
            const Gap(20),
            Text(
              'forms.metas_y_aspiraciones.title'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.metas_y_aspiraciones.question1'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.metas_y_aspiraciones.question2'.tr(),
            ),
            const Gap(10),
            ButtonActionsWidget(
              onPreviousPressed: () {
                controller.previousPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              onNextPressed: () {
                controller.nextPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              previousTitle: 'button.previous'.tr(),
              nextTitle: 'button.signed'.tr(),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}

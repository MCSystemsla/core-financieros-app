import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EnergiaLimpiaImpactoSocial extends StatefulWidget {
  final PageController pageController;
  const EnergiaLimpiaImpactoSocial({
    super.key,
    required this.pageController,
  });

  @override
  State<EnergiaLimpiaImpactoSocial> createState() =>
      _EnergiaLimpiaImpactoSocialState();
}

class _EnergiaLimpiaImpactoSocialState extends State<EnergiaLimpiaImpactoSocial>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MiCreditoProgress(
            steps: 4,
            currentStep: 4,
          ),
          const Gap(20),
          Text(
            'Impacto Social de Kiva (uso específico, objetivos, metas del préstamo).'
                .tr(),
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          const CommentaryWidget(
            title: '¿Por qué y para qué solicitó el préstamo? Explique.*',
          ),
          const Gap(20),
          const CommentaryWidget(
            title: '¿Cuáles son sus planes para los próximos años?',
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}

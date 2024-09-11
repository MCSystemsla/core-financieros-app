import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MiCreditoEstudioScreen extends StatelessWidget {
  const MiCreditoEstudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        title: Text('MiCredi Estudio'.tr()),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          SaneamientoContent(
            controller: pageController,
          ),
          _EntornoSocialEstudioWidget(
            controller: pageController,
          ),
          _ImpactoSocialCrediEstudioWidget(
            controller: pageController,
          ),
          const SignQuestionaryWidget(),
        ],
      ),
    );
  }
}

class _EntornoSocialEstudioWidget extends StatefulWidget {
  final PageController controller;
  const _EntornoSocialEstudioWidget({
    required this.controller,
  });

  @override
  State<_EntornoSocialEstudioWidget> createState() =>
      _EntornoSocialEstudioWidgetState();
}

class _EntornoSocialEstudioWidgetState
    extends State<_EntornoSocialEstudioWidget> {
  String? itemSelected;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
              'forms.entorno_familiar.title'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(10),
            CommentaryWidget(
                title: 'forms.entorno_familiar.person_origin'.tr()),
            const Gap(10),
            CommentaryWidget(title: 'forms.entorno_familiar.childs_age'.tr()),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.entorno_familiar.childs_education'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.entorno_familiar.question1'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.entorno_familiar.question2'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.entorno_familiar.question3'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.entorno_familiar.question4'.tr(),
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
                title: 'forms.entorno_familiar.question5'.tr(),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  itemSelected = item;
                  setState(() {});
                },
                toStringItem: (item) {
                  return item;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
            const Gap(20),
            if (itemSelected == 'Si')
              CommentaryWidget(
                title: 'forms.entorno_familiar.question6'.tr(),
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
            const Gap(10),
          ],
        ),
      ),
    );
  }
}

class _ImpactoSocialCrediEstudioWidget extends StatelessWidget {
  final PageController controller;
  const _ImpactoSocialCrediEstudioWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
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
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.miCredi_estudio.question1'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.miCredi_estudio.question2'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.miCredi_estudio.question3'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.miCredi_estudio.question4'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.miCredi_estudio.question5'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.miCredi_estudio.question6'.tr(),
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

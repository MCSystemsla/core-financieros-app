import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class EstandarAditionalData extends StatefulWidget {
  final bool isRecurrenteForm;
  final PageController pageController;
  const EstandarAditionalData({
    super.key,
    required this.pageController,
    required this.isRecurrenteForm,
  });

  @override
  State<EstandarAditionalData> createState() => _EstandarAditionalDataState();
}

class _EstandarAditionalDataState extends State<EstandarAditionalData> {
  @override
  Widget build(BuildContext context) {
    return switch (widget.isRecurrenteForm) {
      true => const SizedBox(),
      false => Column(
          children: [
            const MiCreditoProgress(
              steps: 4,
              currentStep: 2,
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
                title: '¿Tiene otros ingresos?¿Cuales?*'.tr(),
                items: ['input.yes'.tr(), 'input.no'.tr()],
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
    };
  }
}

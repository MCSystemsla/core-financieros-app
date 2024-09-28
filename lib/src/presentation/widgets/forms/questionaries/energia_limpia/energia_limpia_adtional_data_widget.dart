import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EnergiaLimpiaAditionalDataWidget extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController pageController;
  const EnergiaLimpiaAditionalDataWidget({
    super.key,
    required this.pageController,
    required this.isRecurrentForm,
  });

  @override
  State<EnergiaLimpiaAditionalDataWidget> createState() =>
      _EnergiaLimpiaAditionalDataWidgetState();
}

class _EnergiaLimpiaAditionalDataWidgetState
    extends State<EnergiaLimpiaAditionalDataWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return switch (widget.isRecurrentForm) {
      true => _RecurrentForm(
          pageController: widget.pageController,
        ),
      false => Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
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
                  title: '¿Tiene algún trabajo o negocio? ¿Cuál?'.tr(),
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
              const Gap(10),
              const CommentaryWidget(
                title: 'Tiempo de la actividad:*',
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

class _RecurrentFormState extends State<_RecurrentForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              title: '¿Tiene algún trabajo o negocio? ¿Cuál?'.tr(),
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
          const Gap(10),
          const CommentaryWidget(
            title: 'Tiempo de la actividad:*',
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
          const Gap(10),
        ],
      ),
    );
  }
}

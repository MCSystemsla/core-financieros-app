import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CreditoDatosDeConyugeYSeguroWidget extends StatefulWidget {
  final PageController pageController;
  const CreditoDatosDeConyugeYSeguroWidget({
    super.key,
    required this.pageController,
  });

  @override
  State<CreditoDatosDeConyugeYSeguroWidget> createState() =>
      _CreditoDatosDeConyugeYSeguroWidgetState();
}

class _CreditoDatosDeConyugeYSeguroWidgetState
    extends State<CreditoDatosDeConyugeYSeguroWidget> {
  String? isPersonWork;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 6,
              currentStep: 3,
            ),
            const Gap(20),
            Text(
              'Datos del Conyuge y seguro'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(10),
            Text(
              'Datos del Conyuge'.tr(),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Nombre del conyuge'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Nacionalidad del Conyuge'.tr(),
            ),
            const Gap(10),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title: 'Trabaja?'.tr(),
                items: const ['Si', 'No'],
                onChanged: (item) {
                  if (item == null) return;
                  isPersonWork = item;
                  setState(() {});
                },
                toStringItem: (item) => item,
                hintText: 'Selecciona una opcion'.tr(),
              ),
            ),
            if (isPersonWork == 'Si') const IsPersonWorkWidget(),
            const Gap(20),
            Text(
              'Beneficiarios del Seguro'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Nombres y Apellidos'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Cedula'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Cedula'.tr(),
            ),
            const Gap(10),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title: 'Parentesco'.tr(),
                items: const ['Madre', 'Padre'],
                onChanged: (item) {
                  if (item == null) return;
                  isPersonWork = item;
                  setState(() {});
                },
                toStringItem: (item) => item,
                hintText: 'Selecciona una opcion'.tr(),
              ),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Telefono'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Nombres y Apellidos'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Cedula'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Cedula'.tr(),
            ),
            const Gap(10),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title: 'Parentesco'.tr(),
                items: const ['Madre', 'Padre'],
                onChanged: (item) {
                  if (item == null) return;
                  isPersonWork = item;
                  setState(() {});
                },
                toStringItem: (item) => item,
                hintText: 'Selecciona una opcion'.tr(),
              ),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Telefono'.tr(),
            ),
            const Gap(10),
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

class IsPersonWorkWidget extends StatelessWidget {
  const IsPersonWorkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(10),
        CommentaryWidget(
          title: 'Nombre de lugar de trabajo'.tr(),
        ),
        const Gap(10),
        CommentaryWidget(
          title: 'Direccion de trabajo'.tr(),
        ),
        const Gap(10),
        CommentaryWidget(
          title: 'Telefono'.tr(),
        ),
      ],
    );
  }
}

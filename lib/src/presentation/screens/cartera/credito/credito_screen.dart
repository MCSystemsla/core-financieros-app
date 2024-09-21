import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/creditos/credito_datos_de_conyuge_y_seguro_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/creditos/credito_datos_personales_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/creditos/credito_general_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CreditoScreen extends StatelessWidget {
  const CreditoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitud de Credito'),
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          CreditoGeneralesWidget(
            pageController: pageController,
          ),
          CreditoDatosPersonalesWidget(
            controller: pageController,
          ),
          CreditoDatosDeConyugeYSeguroWidget(
            pageController: pageController,
          ),
          CreditoDatosDeNegocioWidget(
            pageController: pageController,
          ),
        ],
      ),
    );
  }
}

class CreditoDatosDeNegocioWidget extends StatelessWidget {
  final PageController pageController;
  const CreditoDatosDeNegocioWidget({
    super.key,
    required this.pageController,
  });

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
              currentStep: 4,
            ),
            const Gap(20),
            Text(
              'Datos del Negocio'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Nombre del Negocio'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Direccion'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Barrio'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'Municipio'.tr(),
            ),
            const Gap(10),
            ButtonActionsWidget(
              onPreviousPressed: () {
                pageController.previousPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              onNextPressed: () {
                pageController.nextPage(
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

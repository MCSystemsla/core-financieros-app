import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/impacto_social_kiva_objetivo.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/metas_y_aspiraciones_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';

class MejoraDeViviendaScreen extends StatelessWidget {
  const MejoraDeViviendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Mejora de vivienda nueva'.tr()),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          SaneamientoContent(
            controller: pageController,
          ),
          EntornoSocialWidget(
            controller: pageController,
          ),
          ImpactoSocialKivaObjetiveWidget(
            controller: pageController,
          ),
          MetasYAspiracionesWidget(
            controller: pageController,
          ),
          const SignQuestionaryWidget(),
        ],
      ),
    );
  }
}

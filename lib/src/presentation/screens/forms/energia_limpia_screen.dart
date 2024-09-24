import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/mejora_de_vivienda_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/energia_limpia_adtional_data_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/energia_limpia_entorno_familiar.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/energia_limpia_impacto_social.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnergiaLimpiaScreen extends StatelessWidget {
  const EnergiaLimpiaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return BlocProvider(
      create: (ctx) => ResponseCubit(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Energia Limpia'),
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            SaneamientoContent(
              controller: pageController,
            ),
            EnergiaLimpiaAditionalDataWidget(
              pageController: pageController,
            ),
            EnergiaLimpiaEntornoFamiliar(
              pageController: pageController,
            ),
            EnergiaLimpiaImpactoSocial(
              pageController: pageController,
            ),
            FormResponses(
              controller: pageController,
            ),
            const SignQuestionaryWidget(),
          ],
        ),
      ),
    );
  }
}

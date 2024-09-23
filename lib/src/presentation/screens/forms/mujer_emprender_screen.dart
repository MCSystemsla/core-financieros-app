import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mujer_emprende/descripcion_y_desarrollo_del_negocio_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mujer_emprende/mujer_emprende_entorno_social_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mujer_emprende/mujer_emprende_impacto_social_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MujerEmprenderScreen extends StatelessWidget {
  const MujerEmprenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ResponseCubit(),
        ),
        BlocProvider(
          create: (ctx) => DepartamentosCubit(DepartamentosRepositoryImpl())
            ..getDepartamentos(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Mujer Emprende'),
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            SaneamientoContent(
              controller: pageController,
            ),
            MujerEmprendeEntornoSocialWidget(
              pageController: pageController,
            ),
            DescripcionYDesarrolloDelNegocioWidget(
              pageController: pageController,
            ),
            MujerEmprendeImpactoSocial(
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

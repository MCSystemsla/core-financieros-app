import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/mejora_de_vivienda_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/estandar/estandar_aditional_data.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/estandar/estandar_descripcion_del_negocio.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/estandar/estandar_entorno_familiar.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/estandar/estandar_impacto_social.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EstandarScreen extends StatelessWidget {
  const EstandarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const isRecurrentForm = true;
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
          title: const Text('Estandar'),
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            SaneamientoContent(
              controller: pageController,
            ),
            EstandarAditionalData(
              isRecurrenteForm: false,
              pageController: pageController,
            ),
            EstandarEntornoFamiliar(
              isRecurrenteForm: isRecurrentForm,
              pageController: pageController,
            ),
            EstandarDescripciondelNegocio(
              isRecurrentForm: isRecurrentForm,
              pageController: pageController,
            ),
            EstandarImpactoSocial(
              isRecurrentForm: isRecurrentForm,
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

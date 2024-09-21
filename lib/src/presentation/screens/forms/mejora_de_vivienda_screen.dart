import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/impacto_social_kiva_objetivo.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/metas_y_aspiraciones_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MejoraDeViviendaScreen extends StatelessWidget {
  const MejoraDeViviendaScreen({super.key});

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
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('forms.mejora_de_vivienda.title'.tr()),
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
              FormResponses(
                controller: pageController,
              ),
              const SignQuestionaryWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class FormResponses extends StatelessWidget {
  final PageController controller;
  const FormResponses({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              'input.form_response'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(15),
            BlocBuilder<ResponseCubit, ResponseState>(
              builder: (context, state) {
                return ListView.separated(
                  itemCount: state.responses.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return const Gap(20);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return WhiteCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.responses[index].question,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                          const Gap(20),
                          Text(
                            state.responses[index].response,
                            style: Theme.of(context).textTheme.bodyMedium!,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            const Gap(20),
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
          ],
        ),
      ),
    );
  }
}

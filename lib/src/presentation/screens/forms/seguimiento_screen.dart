import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/mejora_de_vivienda_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SeguimientoScreen extends StatelessWidget {
  const SeguimientoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return BlocProvider(
      create: (ctx) => ResponseCubit(),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('forms.seguimiento.title'.tr()),
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              SaneamientoContent(
                controller: pageController,
              ),
              GrupoEncuestaWidget(
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

class GrupoEncuestaWidget extends StatefulWidget {
  final PageController controller;
  const GrupoEncuestaWidget({super.key, required this.controller});

  @override
  State<GrupoEncuestaWidget> createState() => _GrupoEncuestaWidgetState();
}

class _GrupoEncuestaWidgetState extends State<GrupoEncuestaWidget>
    with AutomaticKeepAliveClientMixin {
  final question1Controller = TextEditingController();
  final question2Controller = TextEditingController();
  final question3Controller = TextEditingController();
  final question4Controller = TextEditingController();
  final question5Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 3,
              currentStep: 2,
            ),
            const Gap(20),
            Text(
              'forms.seguimiento.description'.tr(),
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'forms.seguimiento.question1'.tr(),
              textEditingController: question1Controller,
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'forms.seguimiento.question2'.tr(),
              textEditingController: question2Controller,
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'forms.seguimiento.question3'.tr(),
              textEditingController: question3Controller,
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'forms.seguimiento.question4'.tr(),
              textEditingController: question4Controller,
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'forms.seguimiento.question5'.tr(),
              textEditingController: question5Controller,
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
                context.read<ResponseCubit>().addResponses(
                  responses: [
                    Response(
                      question: 'forms.seguimiento.question1'.tr(),
                      response: question1Controller.text.trim(),
                      index: 1,
                    ),
                    Response(
                      question: 'forms.seguimiento.question2'.tr(),
                      response: question2Controller.text.trim(),
                      index: 1,
                    ),
                    Response(
                      question: 'forms.seguimiento.question3'.tr(),
                      response: question3Controller.text.trim(),
                      index: 1,
                    ),
                    Response(
                      question: 'forms.seguimiento.question4'.tr(),
                      response: question4Controller.text.trim(),
                      index: 1,
                    ),
                    Response(
                      question: 'forms.seguimiento.question5'.tr(),
                      response: question5Controller.text.trim(),
                      index: 1,
                    ),
                  ],
                );
                widget.controller.nextPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              previousTitle: 'button.previous'.tr(),
              nextTitle: 'button.signed'.tr(),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MigrantesEconomicosScreen extends StatelessWidget {
  const MigrantesEconomicosScreen({super.key});

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
            title: Text('forms.migrantes_economicos.title'.tr()),
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              SaneamientoContent(
                controller: pageController,
              ),
              PrimerPrestamoWidget(
                controller: pageController,
              ),
              _ImpactoSocialMigranteEconomico(
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

class PrimerPrestamoWidget extends StatefulWidget {
  final PageController controller;
  const PrimerPrestamoWidget({super.key, required this.controller});

  @override
  State<PrimerPrestamoWidget> createState() => _PrimerPrestamoWidgetState();
}

class _PrimerPrestamoWidgetState extends State<PrimerPrestamoWidget>
    with AutomaticKeepAliveClientMixin {
  final question1Controller = TextEditingController();
  final question2Controller = TextEditingController();
  final question3Controller = TextEditingController();
  final question4Controller = TextEditingController();
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
              currentStep: 1,
            ),
            const Gap(20),
            Text(
              'forms.migrantes_economicos.primer_prestamo.title'.tr(),
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(20),
            CommentaryWidget(
              title:
                  'forms.migrantes_economicos.primer_prestamo.question1'.tr(),
              textEditingController: question1Controller,
            ),
            const Gap(20),
            CommentaryWidget(
              title:
                  'forms.migrantes_economicos.primer_prestamo.question2'.tr(),
              textEditingController: question2Controller,
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
                      question:
                          'forms.migrantes_economicos.primer_prestamo.question1'
                              .tr(),
                      response: question1Controller.text.trim(),
                    ),
                    Response(
                      question:
                          'forms.migrantes_economicos.primer_prestamo.question2'
                              .tr(),
                      response: question2Controller.text.trim(),
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
              nextTitle: 'button.next'.tr(),
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

class _ImpactoSocialMigranteEconomico extends StatefulWidget {
  final PageController controller;
  const _ImpactoSocialMigranteEconomico({required this.controller});

  @override
  State<_ImpactoSocialMigranteEconomico> createState() =>
      _ImpactoSocialMigranteEconomicoState();
}

class _ImpactoSocialMigranteEconomicoState
    extends State<_ImpactoSocialMigranteEconomico>
    with AutomaticKeepAliveClientMixin {
  final question1Controller = TextEditingController();
  final question2Controller = TextEditingController();
  final question3Controller = TextEditingController();
  final question4Controller = TextEditingController();
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
              'forms.mejora_de_vivienda.impacto_social.title'.tr(),
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'forms.migrantes_economicos.impacto_social.question1'.tr(),
              textEditingController: question1Controller,
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'forms.migrantes_economicos.impacto_social.question2'.tr(),
              textEditingController: question2Controller,
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'forms.migrantes_economicos.impacto_social.question3'.tr(),
              textEditingController: question3Controller,
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'forms.migrantes_economicos.impacto_social.question4'.tr(),
              textEditingController: question4Controller,
            ),
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
                      question:
                          'forms.migrantes_economicos.impacto_social.question1'
                              .tr(),
                      response: question1Controller.text.trim(),
                    ),
                    Response(
                      question:
                          'forms.migrantes_economicos.impacto_social.question2'
                              .tr(),
                      response: question2Controller.text.trim(),
                    ),
                    Response(
                      question:
                          'forms.migrantes_economicos.impacto_social.question3'
                              .tr(),
                      response: question3Controller.text.trim(),
                    ),
                    Response(
                      question:
                          'forms.migrantes_economicos.impacto_social.question4'
                              .tr(),
                      response: question4Controller.text.trim(),
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

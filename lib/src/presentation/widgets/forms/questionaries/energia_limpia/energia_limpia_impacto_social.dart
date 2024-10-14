import 'package:core_financiero_app/src/presentation/bloc/energia_limpia/energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EnergiaLimpiaImpactoSocial extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController pageController;
  const EnergiaLimpiaImpactoSocial({
    super.key,
    required this.pageController,
    required this.isRecurrentForm,
  });

  @override
  State<EnergiaLimpiaImpactoSocial> createState() =>
      _EnergiaLimpiaImpactoSocialState();
}

class _EnergiaLimpiaImpactoSocialState extends State<EnergiaLimpiaImpactoSocial>
    with AutomaticKeepAliveClientMixin {
  final motivoPrestamo = TextEditingController();
  final planesFuturo = TextEditingController();
  final otrosDatosCliente = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return switch (widget.isRecurrentForm) {
      true => _RecurrentForm(
          pageController: widget.pageController,
        ),
      false => Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MiCreditoProgress(
                    steps: 4,
                    currentStep: 4,
                  ),
                  const Gap(20),
                  Text(
                    'Impacto Social de Kiva (uso específico, objetivos, metas del préstamo).'
                        .tr(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  CommentaryWidget(
                    title:
                        '¿Por qué y para qué solicitó el préstamo? Explique.*',
                    textEditingController: motivoPrestamo,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: '¿Cuáles son sus planes para los próximos años?',
                    textEditingController: planesFuturo,
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Otros datos relevantes e interesantes del cliente',
                    textEditingController: otrosDatosCliente,
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
                      if (formKey.currentState?.validate() ?? false) {
                        context.read<EnergiaLimpiaCubit>().saveAnswer3(
                              motivoPrestamo: motivoPrestamo.text.trim(),
                              otrosDatosCliente: otrosDatosCliente.text.trim(),
                              planesFuturo: planesFuturo.text.trim(),
                            );
                        widget.pageController.nextPage(
                          duration: const Duration(
                            milliseconds: 350,
                          ),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    previousTitle: 'button.previous'.tr(),
                    nextTitle: 'button.next'.tr(),
                  ),
                  const Gap(10),
                ],
              ),
            ),
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

class _RecurrentFormState extends State<_RecurrentForm>
    with AutomaticKeepAliveClientMixin {
  final motivoPrestamo = TextEditingController();
  final comoMejoraSituacion = TextEditingController();
  final quienApoya = TextEditingController();
  final siguienteMeta = TextEditingController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 4,
              currentStep: 4,
            ),
            const Gap(20),
            Text(
              'Impacto Social de Kiva (uso específico, objetivos, metas del préstamo).'
                  .tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(20),
            CommentaryWidget(
              title:
                  '¿En qué piensa invertir este nuevo crédito de energía limpia?* Explique',
              textEditingController: motivoPrestamo,
            ),
            const Gap(20),
            CommentaryWidget(
              title:
                  '¿Cómo cree usted que este nuevo préstamo vaya a mejorar su situación y la de su familia?*',
              textEditingController: comoMejoraSituacion,
            ),
            const Gap(20),
            CommentaryWidget(
              title:
                  '¿Quién o quiénes le estarían apoyando en esta nueva inversión?*',
              textEditingController: quienApoya,
            ),
            const Gap(20),
            CommentaryWidget(
              title:
                  'Una vez finalizado este préstamo ¿Cuál sería su siguiente meta?',
              textEditingController: siguienteMeta,
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
                context.read<RecurrenteEnergiaLimpiaCubit>().saveAnswer3(
                      motivoPrestamo: motivoPrestamo.text.trim(),
                      comoMejoraSituacion: comoMejoraSituacion.text.trim(),
                      quienApoya: quienApoya.text.trim(),
                      siguienteMeta: siguienteMeta.text.trim(),
                    );
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

  @override
  bool get wantKeepAlive => true;
}

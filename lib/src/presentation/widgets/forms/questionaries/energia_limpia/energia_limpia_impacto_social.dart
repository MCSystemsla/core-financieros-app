import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/energia_limpia/energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
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
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                              solicitudNuevamenorId: int.parse(
                                context
                                    .read<KivaRouteCubit>()
                                    .state
                                    .solicitudId,
                              ),
                            );
                        context.read<ResponseCubit>().addResponses(
                          responses: [
                            Response(
                              index: widget.isRecurrentForm ? 4 : 3,
                              question:
                                  '¿Por qué y para qué solicitó el préstamo? Explique.*',
                              response: motivoPrestamo.text.trim(),
                            ),
                            Response(
                              index: widget.isRecurrentForm ? 4 : 3,
                              question:
                                  '¿Cuáles son sus planes para los próximos años?',
                              response: planesFuturo.text.trim(),
                            ),
                            Response(
                              index: widget.isRecurrentForm ? 4 : 3,
                              question:
                                  'Otros datos relevantes e interesantes del cliente',
                              response: otrosDatosCliente.text.trim(),
                            ),
                          ],
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
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
              const Gap(20),
              CommentaryWidget(
                title:
                    '¿En qué piensa invertir este nuevo crédito de energía limpia?* Explique',
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
                title:
                    '¿Cómo cree usted que este nuevo préstamo vaya a mejorar su situación y la de su familia?*',
                textEditingController: comoMejoraSituacion,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }

                  return null;
                },
              ),
              const Gap(20),
              CommentaryWidget(
                title:
                    '¿Quién o quiénes le estarían apoyando en esta nueva inversión?*',
                textEditingController: quienApoya,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }

                  return null;
                },
              ),
              const Gap(20),
              CommentaryWidget(
                title:
                    'Una vez finalizado este préstamo ¿Cuál sería su siguiente meta?',
                textEditingController: siguienteMeta,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }

                  return null;
                },
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
                    context.read<RecurrenteEnergiaLimpiaCubit>().saveAnswer3(
                          motivoPrestamo: motivoPrestamo.text.trim(),
                          comoMejoraSituacion: comoMejoraSituacion.text.trim(),
                          quienApoya: quienApoya.text.trim(),
                          siguienteMeta: siguienteMeta.text.trim(),
                          objSolicitudRecurrenteId: int.parse(
                            context.read<KivaRouteCubit>().state.solicitudId,
                          ),
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          index: 4,
                          question:
                              '¿En qué piensa invertir este nuevo crédito de energía limpia?* Explique',
                          response: motivoPrestamo.text.trim(),
                        ),
                        Response(
                          index: 4,
                          question:
                              '¿Cómo cree usted que este nuevo préstamo vaya a mejorar su situación y la de su familia?*',
                          response: comoMejoraSituacion.text.trim(),
                        ),
                        Response(
                          index: 4,
                          question:
                              '¿Quién o quiénes le estarían apoyando en esta nueva inversión?*',
                          response: quienApoya.text.trim(),
                        ),
                        Response(
                          index: 4,
                          question:
                              'Una vez finalizado este préstamo ¿Cuál sería su siguiente meta?',
                          response: siguienteMeta.text.trim(),
                        ),
                      ],
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}

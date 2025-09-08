import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/estandar/estandar_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_estandar/recurrente_estandart_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/button_actions_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EstandarImpactoSocial extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController pageController;
  const EstandarImpactoSocial({
    super.key,
    required this.pageController,
    required this.isRecurrentForm,
  });

  @override
  State<EstandarImpactoSocial> createState() => _EstandarImpactoSocialState();
}

class _EstandarImpactoSocialState extends State<EstandarImpactoSocial>
    with AutomaticKeepAliveClientMixin {
  final motivoPrestamo = TextEditingController();
  final planesFuturo = TextEditingController();
  final otrosDatosCliente = TextEditingController();
  final comoMejoraVida = TextEditingController();
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
                    steps: 5,
                    currentStep: 5,
                  ),
                  const Gap(20),
                  Text(
                    'Impacto Social de Kiva ( Uso específico, objetivos, metas del préstamo)'
                        .tr(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: '¿Para qué solicitó el préstamo? Explique',
                    textEditingController: motivoPrestamo,
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    textEditingController: planesFuturo,
                    title:
                        '¿Cuáles son sus planes personales para los proximos 5 años?*',
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    textEditingController: comoMejoraVida,
                    title:
                        '¿Cómo este crédito fortalecerá su negocio y mejorará sus condiciones de vida?*',
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    textEditingController: otrosDatosCliente,
                    title: 'Otros datos relevantes e interesantes del cliente',
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
                        context.read<EstandarCubit>().saveAnswers(
                              motivoPrestamo: motivoPrestamo.text.trim(),
                              comoMejoraVida: comoMejoraVida.text.trim(),
                              planesFuturo: planesFuturo.text.trim(),
                              otrosDatosCliente: otrosDatosCliente.text.trim(),
                              objSolicitudNuevamenorId: int.tryParse(
                                context
                                    .read<KivaRouteCubit>()
                                    .state
                                    .solicitudId,
                              ),
                            );
                        context.read<ResponseCubit>().addResponses(
                          responses: [
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question:
                                  '¿Para qué solicitó el préstamo? Explique',
                              response: motivoPrestamo.text.trim(),
                            ),
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question:
                                  '¿Cuáles son sus planes personales para los proximos 5 años?*',
                              response: planesFuturo.text.trim(),
                            ),
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question:
                                  '¿Cómo este crédito fortalecerá su negocio y mejorará sus condiciones de vida?*',
                              response: comoMejoraVida.text.trim(),
                            ),
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
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
  final comoFortalece = TextEditingController();
  final siguientePaso = TextEditingController();
  final personaAutoSuficiente = TextEditingController();
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
                steps: 5,
                currentStep: 5,
              ),
              const Gap(20),
              Text(
                'Impacto Social de Kiva ( Uso específico, objetivos, metas del préstamo)'
                    .tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: motivoPrestamo,
                title: '¿En qué piensa invertir este nuevo préstamo? Explique',
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: comoFortalece,
                title:
                    '¿Considera usted que este nuevo préstamo continúe fortaleciendo su negocio y generando mayores ganancias que beneficien a su familia? Explique ',
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: siguientePaso,
                title: 'A futuro ¿Cuál seria su siguiente paso?*',
                validator: (value) {
                  final trimmedValue = value?.trim();
                  if (trimmedValue == null ||
                      trimmedValue.isEmpty ||
                      trimmedValue == 'input.select_option'.tr()) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: personaAutoSuficiente,
                title:
                    'Una vez finalizado el pago de este préstamo ¿ Podría ser una persona auto suficiente?',
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
                    context.read<RecurrenteEstandartCubit>().saveAnswers(
                          motivoPrestamo: motivoPrestamo.text.trim(),
                          comoFortalece: comoFortalece.text.trim(),
                          siguientePaso: siguientePaso.text.trim(),
                          personaAutoSuficiente:
                              personaAutoSuficiente.text.trim(),
                          objSolicitudRecurrenteId: int.tryParse(
                              context.read<KivaRouteCubit>().state.solicitudId),
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question:
                              '¿En qué piensa invertir este nuevo préstamo? Explique',
                          response: motivoPrestamo.text.trim(),
                        ),
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question:
                              '¿Considera usted que este nuevo préstamo continúe fortaleciendo su negocio y generando mayores ganancias que beneficien a su familia? Explique ',
                          response: comoFortalece.text.trim(),
                        ),
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question: 'A futuro ¿Cuál seria su siguiente paso?*',
                          response: siguientePaso.text.trim(),
                        ),
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question:
                              'Una vez finalizado el pago de este préstamo ¿ Podría ser una persona auto suficiente?',
                          response: personaAutoSuficiente.text.trim(),
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

import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/mujer_emprende/mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_mujer_emprende/recurrente_mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/motivo_prestamo_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DescripcionYDesarrolloDelNegocioWidget extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController pageController;
  const DescripcionYDesarrolloDelNegocioWidget({
    super.key,
    required this.pageController,
    required this.isRecurrentForm,
  });

  @override
  State<DescripcionYDesarrolloDelNegocioWidget> createState() =>
      _DescripcionYDesarrolloDelNegocioWidgetState();
}

class _DescripcionYDesarrolloDelNegocioWidgetState
    extends State<DescripcionYDesarrolloDelNegocioWidget>
    with AutomaticKeepAliveClientMixin {
  final question1 = TextEditingController();
  final question2 = TextEditingController();
  final question3 = TextEditingController();
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
                    currentStep: 2,
                  ),
                  const Gap(20),
                  Text(
                    'Descripción y desarrollo del negocio'.tr(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Cuéntenos, ¿Qué la motivó a emprender su negocio?*',
                    textEditingController: question1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  CommentaryWidget(
                    title:
                        'Coméntenos, ¿ Cómo conoció el proyecto de Mujer Emprende en MiCrédito?',
                    textEditingController: question2,
                  ),
                  CommentaryWidget(
                    title: '¿Qué la impulsó a optar a este tipo de crédito?*',
                    textEditingController: question3,
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
                        context.read<MujerEmprendeCubit>().saveAnswers(
                              motivoEmprender: question1.text.trim(),
                              conocioMujerEmprende: question2.text.trim(),
                              impulsoOptar: question3.text.trim(),
                            );
                        context.read<ResponseCubit>().addResponses(
                          responses: [
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question:
                                  'Cuéntenos, ¿Qué la motivó a emprender su negocio?*',
                              response: question1.text.trim(),
                            ),
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question:
                                  'Coméntenos, ¿ Cómo conoció el proyecto de Mujer Emprende en MiCrédito?',
                              response: question2.text.trim(),
                            ),
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question:
                                  '¿Qué la impulsó a optar a este tipo de crédito?*',
                              response: question3.text.trim(),
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
  String? coincideRespuesta;
  final explicacionInversion = TextEditingController();
  final comoAyudo = TextEditingController();
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
                currentStep: 2,
              ),
              const Gap(20),
              Text(
                'Descripción del crédito anterior Mujer Emprende'.tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(20),
              const MotivoPrestamoWidget(),
              const Gap(20),
              WhiteCard(
                marginTop: 15,
                padding: const EdgeInsets.all(10),
                child: JLuxDropdown(
                  validator: (value) {
                    if (value == null) return 'input.input_validator'.tr();
                    return null;
                  },
                  isContainIcon: true,
                  title:
                      '¿Coincide la respuesta del cliente con el formato anterior?'
                          .tr(),
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    coincideRespuesta = item;
                    setState(() {});
                  },
                  toStringItem: (item) => item,
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              const Gap(20),
              if (coincideRespuesta == 'input.no'.tr())
                CommentaryWidget(
                  textEditingController: explicacionInversion,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'input.input_validator'.tr();
                    }
                    return null;
                  },
                  title:
                      '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                ),
              const Gap(20),
              CommentaryWidget(
                title: '¿De qué manera le ayudó este préstamo Kiva?*',
                textEditingController: comoAyudo,
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
                    context.read<RecurrenteMujerEmprendeCubit>().saveAnswers(
                          coincideRespuesta:
                              coincideRespuesta == 'input.yes'.tr(),
                          explicacionInversion:
                              explicacionInversion.text.trim(),
                          comoAyudo: comoAyudo.text.trim(),
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question:
                              '¿Coincide la respuesta del cliente con el formato anterior?',
                          response: coincideRespuesta ?? 'N/A',
                        ),
                        if (coincideRespuesta == 'input.no'.tr())
                          Response(
                            index: widget.pageController.page?.toInt() ?? 0,
                            question:
                                '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                            response: explicacionInversion.text.trim(),
                          ),
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question:
                              '¿De qué manera le ayudó este préstamo Kiva?*',
                          response: comoAyudo.text.trim(),
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
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

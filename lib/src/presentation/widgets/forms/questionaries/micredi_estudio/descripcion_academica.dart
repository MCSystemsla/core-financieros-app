import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/micredi_estudio/micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_micredi_estudio/recurrente_micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/button_actions_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DescripcionAcademica extends StatefulWidget {
  final PageController pageController;
  final bool isRecurrentForm;
  const DescripcionAcademica(
      {super.key, required this.pageController, required this.isRecurrentForm});

  @override
  State<DescripcionAcademica> createState() => _DescripcionAcademicaState();
}

class _DescripcionAcademicaState extends State<DescripcionAcademica>
    with AutomaticKeepAliveClientMixin {
  final carrera = TextEditingController();
  final universidad = TextEditingController();
  final tiempoCarreras = TextEditingController();
  final motivoCarrera = TextEditingController();
  final explicacionRelizandoProfesionalmente = TextEditingController();
  final quienApoya = TextEditingController();
  final ocupacionPadres = TextEditingController();
  String? relizandoProfesionalmente;
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
                    steps: 5,
                    currentStep: 3,
                  ),
                  const Gap(20),
                  Text(
                    'Descripcion Academica'.tr(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Carrera:',
                    textEditingController: carrera,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Universidad a la que pertenece:',
                    textEditingController: universidad,
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Años de la carrera:',
                    textEditingController: tiempoCarreras,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: '¿Qué te motivó a elegir esa carrera?',
                    textEditingController: motivoCarrera,
                  ),
                  const Gap(20),
                  WhiteCard(
                    marginTop: 15,
                    padding: const EdgeInsets.all(10),
                    child: JLuxDropdown(
                      isContainIcon: true,
                      title:
                          '¿Sentís que te estás realizando profesionalmente?*'
                              .tr(),
                      items: ['input.yes'.tr(), 'input.no'.tr()],
                      onChanged: (item) {
                        if (item == null) return;
                        relizandoProfesionalmente = item;
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null) return 'input.input_validator'.tr();
                        return null;
                      },
                      toStringItem: (item) => item,
                      hintText: 'input.select_option'.tr(),
                    ),
                  ),
                  if (relizandoProfesionalmente == 'input.yes'.tr() ||
                      relizandoProfesionalmente == 'input.no'.tr())
                    CommentaryWidget(
                      title: 'Por que?',
                      textEditingController:
                          explicacionRelizandoProfesionalmente,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                    ),
                  const Gap(20),
                  CommentaryWidget(
                    title: '¿Quién o quiénes te apoyan en tus estudios?*',
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
                        '¿En qué trabaja o qué negocio tienen tus padres o tutores?*',
                    textEditingController: ocupacionPadres,
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
                        context.read<MicrediEstudioCubit>().saveAnswers(
                              carrera: carrera.text.trim(),
                              tiempoCarrera:
                                  int.tryParse(tiempoCarreras.text.trim()),
                              universidad: universidad.text.trim(),
                              motivoCarrera: motivoCarrera.text.trim(),
                              relizandoProfesionalmente:
                                  relizandoProfesionalmente == 'input.yes'.tr(),
                              explicacionRelizandoProfesionalmente:
                                  explicacionRelizandoProfesionalmente.text
                                      .trim(),
                              quienApoya: quienApoya.text.trim(),
                              ocupacionPadres: ocupacionPadres.text.trim(),
                            );
                        context.read<ResponseCubit>().addResponses(
                          responses: [
                            Response(
                              index: widget.pageController.page?.round() ?? 3,
                              question: 'Carrera:',
                              response: carrera.text.trim(),
                            ),
                            Response(
                              index: 3,
                              question: 'Universidad a la que pertenece:',
                              response: universidad.text.trim(),
                            ),
                            Response(
                              index: 3,
                              question: 'Años de la carrera:',
                              response: tiempoCarreras.text.trim(),
                            ),
                            Response(
                              index: 3,
                              question: '¿Qué te motivó a elegir esa carrera?',
                              response: motivoCarrera.text.trim(),
                            ),
                            Response(
                              index: 3,
                              question:
                                  '¿Sentís que te estás realizando profesionalmente?*',
                              response: relizandoProfesionalmente ?? 'N/A',
                            ),
                            if (relizandoProfesionalmente == 'input.yes'.tr())
                              Response(
                                index: 3,
                                question: 'Por que?',
                                response: explicacionRelizandoProfesionalmente
                                    .text
                                    .trim(),
                              ),
                            Response(
                              index: 3,
                              question:
                                  '¿Quién o quiénes te apoyan en tus estudios?*',
                              response: quienApoya.text.trim(),
                            ),
                            Response(
                              index: 3,
                              question:
                                  '¿En qué trabaja o qué negocio tienen tus padres o tutores?*',
                              response: ocupacionPadres.text.trim(),
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
  const _RecurrentForm({
    required this.pageController,
  });

  @override
  State<_RecurrentForm> createState() => _RecurrentFormState();
}

class _RecurrentFormState extends State<_RecurrentForm>
    with AutomaticKeepAliveClientMixin {
  final carrera = TextEditingController();
  final tiempoCarrera = TextEditingController();
  final universidad = TextEditingController();
  final quienApoya = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MiCreditoProgress(
                steps: 5,
                currentStep: 3,
              ),
              const Gap(20),
              Text(
                'Descripcion Academica'.tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'Carrera:',
                textEditingController: carrera,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'Años de la carrera:',
                textEditingController: tiempoCarrera,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: universidad,
                title: 'Universidad a la que pertenece',
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: quienApoya,
                title:
                    '¿Quién o quiénes le estarían apoyando en esta nueva etapa?*',
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
                    context.read<RecurrenteMicrediEstudioCubit>().saveAnswers(
                          carrera: carrera.text.trim(),
                          tiempoCarrera:
                              int.tryParse(tiempoCarrera.text.trim()),
                          universidad: universidad.text.trim(),
                          quienApoya: quienApoya.text.trim(),
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question: 'Carrera:',
                          response: carrera.text.trim(),
                        ),
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question: 'Años de la carrera:',
                          response: tiempoCarrera.text.trim(),
                        ),
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question: 'Universidad a la que pertenece',
                          response: universidad.text.trim(),
                        ),
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question:
                              '¿Quién o quiénes le estarían apoyando en esta nueva etapa?*',
                          response: quienApoya.text.trim(),
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

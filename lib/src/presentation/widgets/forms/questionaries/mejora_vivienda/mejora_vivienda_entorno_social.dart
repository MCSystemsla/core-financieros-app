import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/comunidades/comunidades_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/mejora_vivienda/mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_,mejora_vivienda.dart/recurrente_mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MejoraViviendaEntornoSocial extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController pageController;
  const MejoraViviendaEntornoSocial({
    super.key,
    required this.pageController,
    required this.isRecurrentForm,
  });

  @override
  State<MejoraViviendaEntornoSocial> createState() =>
      _MejoraViviendaEntornoSocialState();
}

String? question1;
final question2 = TextEditingController();
String? question3;
String? question4;
String? question5;
final question6 = TextEditingController();
final question7 = TextEditingController();
final question8 = TextEditingController();
final storeDescription = TextEditingController();
final necesidadesController = TextEditingController();
final otrosIngresosController = TextEditingController();
String? question9;
String? otrosIngresos;

final formKey = GlobalKey<FormState>();

class _MejoraViviendaEntornoSocialState
    extends State<MejoraViviendaEntornoSocial>
    with AutomaticKeepAliveClientMixin {
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
                    'Entorno Social'.tr(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Gap(20),
                  WhiteCard(
                    padding: const EdgeInsets.all(5),
                    child: JLuxDropdown(
                      isContainIcon: true,
                      title: '¿Tiene algún trabajo o negocio? ¿Cuál?'.tr(),
                      items: ['input.yes'.tr(), 'input.no'.tr()],
                      onChanged: (item) {
                        if (item == null) return;
                        question1 = item;
                        setState(() {});
                      },
                      toStringItem: (item) {
                        return item;
                      },
                      hintText: 'input.select_option'.tr(),
                    ),
                  ),
                  const Gap(20),
                  if (question1 == 'input.yes'.tr())
                    CommentaryWidget(
                      textEditingController: storeDescription,
                      title: 'Cual?',
                    ),
                  const Gap(20),
                  CommentaryWidget(
                    textEditingController: question2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }

                      return null;
                    },
                    title: 'Tiempo de la actividad:*',
                  ),
                  const Gap(20),
                  WhiteCard(
                    padding: const EdgeInsets.all(5),
                    child: JLuxDropdown(
                      isContainIcon: true,
                      validator: (value) {
                        if (value == null) return 'input.input_validator'.tr();

                        return null;
                      },
                      title: '¿Tiene otros ingresos?¿Cuales?*'.tr(),
                      items: ['input.yes'.tr(), 'input.no'.tr()],
                      onChanged: (item) {
                        if (item == null) return;
                        question3 = item;

                        setState(() {});
                      },
                      toStringItem: (item) {
                        return item;
                      },
                      hintText: 'input.select_option'.tr(),
                    ),
                  ),
                  if (question3 == 'input.yes'.tr())
                    CommentaryWidget(
                      textEditingController: otrosIngresosController,
                      title: 'Describe tus otros Ingresos',
                    ),
                  const Gap(20),
                  BlocBuilder<DepartamentosCubit, DepartamentosState>(
                    builder: (context, state) {
                      return WhiteCard(
                        marginTop: 15,
                        padding: const EdgeInsets.all(10),
                        child: JLuxDropdown(
                          isContainIcon: true,
                          validator: (value) {
                            if (value == null) {
                              return 'input.input_validator'.tr();
                            }

                            return null;
                          },
                          isLoading: state.status == Status.inProgress,
                          title: 'forms.entorno_familiar.person_origin'.tr(),
                          items: state.departamentos,
                          onChanged: (item) {
                            if (item == null) return;
                            question4 = item.valor;
                            setState(() {});
                          },
                          toStringItem: (item) => item.nombre,
                          hintText: 'input.select_department'.tr(),
                        ),
                      );
                    },
                  ),
                  const Gap(20),
                  BlocBuilder<ComunidadesCubit, ComunidadesState>(
                    builder: (context, state) {
                      return WhiteCard(
                        padding: const EdgeInsets.all(5),
                        child: JLuxDropdown(
                          isContainIcon: true,
                          isLoading: state.status == Status.inProgress,
                          title: 'Su comunidad es:'.tr(),
                          items: state.comunidades,
                          onChanged: (item) {
                            if (item == null) return;
                            question5 = item.valor;
                            setState(() {});
                          },
                          toStringItem: (item) {
                            return item.nombre;
                          },
                          hintText: 'input.select_option'.tr(),
                        ),
                      );
                    },
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    textEditingController: necesidadesController,
                    title: '¿Cuáles son las necesidades en su comunidad?',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    textEditingController: question6,
                    title: 'Número de personas a cargo:*',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    textEditingController: question7,
                    title: 'Número de hijos:*',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }

                      return null;
                    },
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    textEditingController: question8,
                    title: '¿Que edades tienen sus hijos?',
                  ),
                  const Gap(20),
                  WhiteCard(
                    padding: const EdgeInsets.all(5),
                    child: JLuxDropdown(
                      isContainIcon: true,
                      title: '¿Qué tipo de estudios reciben sus hijos?'.tr(),
                      items: const [
                        'Ninguno',
                        'Preescolar',
                        'Primaria',
                        'Secundaria',
                        'Técnico',
                        'Universitario'
                      ],
                      onChanged: (item) {
                        if (item == null) return;
                        question9 = item;
                        setState(() {});
                      },
                      toStringItem: (item) {
                        return item;
                      },
                      hintText: 'input.select_option'.tr(),
                    ),
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
                        context.read<MejoraViviendaCubit>().saveAnswer1(
                              tieneTrabajo: question1 == 'input.yes'.tr(),
                              tiempoActividad:
                                  int.tryParse(question2.text.trim()),
                              otrosIngresos: question3 == 'input.yes'.tr(),
                              objOrigenCatalogoValorId: question4,
                              objTipoComunidadId: question5,
                              personasCargo: question6.text.trim(),
                              numeroHijos: int.tryParse(question7.text.trim()),
                              edadHijos: question8.text.trim(),
                              tipoEstudioHijos: question9,
                              trabajoNegocioDescripcion:
                                  storeDescription.text.trim(),
                              necesidadesComunidad:
                                  necesidadesController.text.trim(),
                              otrosIngresosDescription:
                                  otrosIngresosController.text.trim(),
                            );
                        context.read<ResponseCubit>().addResponses(
                          responses: [
                            Response(
                              question:
                                  '¿Tiene algún trabajo o negocio? ¿Cuál?',
                              response: question1 ?? 'N/A',
                              index: 1,
                            ),
                            Response(
                              question: '¿Cuál?',
                              response: storeDescription.text.trim(),
                              index: 1,
                            ),
                            Response(
                              question: 'Tiempo de la actividad:*',
                              response: question2.text.trim(),
                              index: 1,
                            ),
                            Response(
                              question: '¿Tiene otros ingresos?¿Cuales?*',
                              response: question3 ?? 'N/A',
                              index: 1,
                            ),
                            Response(
                              question: 'Describe tus otros Ingresos',
                              response: otrosIngresosController.text.trim(),
                              index: 1,
                            ),
                            Response(
                              question:
                                  'forms.entorno_familiar.person_origin'.tr(),
                              response: question4 ?? 'N/A',
                              index: 1,
                            ),
                            Response(
                              question: 'Su comunidad es:'.tr(),
                              response: question5 ?? 'N/A',
                              index: 1,
                            ),
                            Response(
                              question:
                                  '¿Cuáles son las necesidades en su comunidad?'
                                      .tr(),
                              response: necesidadesController.text.trim(),
                              index: 1,
                            ),
                            Response(
                              question: 'Número de personas a cargo:*'.tr(),
                              response: question6.text.trim(),
                              index: 1,
                            ),
                            Response(
                              question: 'Número de hijos:*'.tr(),
                              response: question7.text.trim(),
                              index: 1,
                            ),
                            Response(
                              question: '¿Que edades tienen sus hijos?'.tr(),
                              response: question7.text.trim(),
                              index: 1,
                            ),
                            Response(
                              question:
                                  '¿Qué tipo de estudios reciben sus hijos?'
                                      .tr(),
                              response: question9 ?? 'N/A',
                              index: 1,
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
        )
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
  String? question1;
  final question2 = TextEditingController();
  String? question3;
  String? question4;
  String? question5;
  final question6 = TextEditingController();
  final question7 = TextEditingController();
  final question8 = TextEditingController();
  final storeDescription = TextEditingController();
  final necesidadesController = TextEditingController();
  final otrosIngresosController = TextEditingController();
  String? question9;
  String? otrosIngresos;
  final cualesOtrosIngresosController = TextEditingController();
  final cualesOtroTrabajoController = TextEditingController();

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
                'Entorno Social Recurrente'.tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(20),
              WhiteCard(
                padding: const EdgeInsets.all(5),
                child: JLuxDropdown(
                  isContainIcon: true,
                  title: '¿Tiene algún trabajo o negocio? ¿Cuál?'.tr(),
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    question1 = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              const Gap(20),
              if (question1 == 'input.yes'.tr())
                CommentaryWidget(
                  title: 'Cual?',
                  textEditingController: cualesOtroTrabajoController,
                ),
              // if (question1 == 'input.yes'.tr())
              //   CommentaryWidget(
              //     textEditingController: storeDescription,
              //     title: 'Cual?',
              //   ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: question2,
                title: 'Tiempo de la actividad:*',
              ),
              const Gap(20),
              WhiteCard(
                padding: const EdgeInsets.all(5),
                child: JLuxDropdown(
                  isContainIcon: true,
                  validator: (value) {
                    if (value == null) return 'input.input_validator'.tr();

                    return null;
                  },
                  title: '¿Tiene otros ingresos?¿Cuales?*'.tr(),
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    question3 = item;

                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              const Gap(20),
              if (question3 == 'input.yes'.tr())
                CommentaryWidget(
                  title: 'Cuales Ingresos son?',
                  textEditingController: cualesOtrosIngresosController,
                ),
              const Gap(20),
              BlocBuilder<ComunidadesCubit, ComunidadesState>(
                builder: (context, state) {
                  return WhiteCard(
                    padding: const EdgeInsets.all(5),
                    child: JLuxDropdown(
                      isContainIcon: true,
                      isLoading: state.status == Status.inProgress,
                      // validator: (value) {
                      //   if (value == null) {
                      //     return 'input.input_validator'.tr();
                      //   }

                      //   return null;
                      // },
                      title: 'Su comunidad es:'.tr(),
                      items: state.comunidades,
                      onChanged: (item) {
                        if (item == null) return;
                        question5 = item.valor;
                        setState(() {});
                      },
                      toStringItem: (item) {
                        return item.nombre;
                      },
                      hintText: 'input.select_option'.tr(),
                    ),
                  );
                },
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: necesidadesController,
                title: '¿Cuáles son las necesidades en su comunidad?',
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: question6,
                title: 'Número de personas a cargo:*',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: question7,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
                title: 'Número de hijos:*',
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: question8,
                title: '¿Que edades tienen sus hijos?',
              ),
              const Gap(20),
              WhiteCard(
                padding: const EdgeInsets.all(5),
                child: JLuxDropdown(
                  isContainIcon: true,
                  title: '¿Qué tipo de estudios reciben sus hijos?'.tr(),
                  items: const [
                    'Ninguno',
                    'Preescolar',
                    'Primaria',
                    'Secundaria',
                    'Técnico',
                    'Universitario'
                  ],
                  onChanged: (item) {
                    if (item == null) return;
                    question9 = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
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
                    context.read<RecurrenteMejoraViviendaCubit>().saveAnswers1(
                          tieneTrabajo: question1 == 'input.yes'.tr(),
                          tiempoActividad: int.tryParse(question2.text),
                          otrosIngresos: question3 == 'input.yes'.tr(),
                          objTipoComunidadId: question5,
                          necesidadesComunidad:
                              necesidadesController.text.trim(),
                          personasCargo: question6.text.trim(),
                          numeroHijos: int.parse(
                            question7.text.trim(),
                          ),
                          edadHijos: question8.text.trim(),
                          tipoEstudioHijos: question9,
                          otrosIngresosDescripcion:
                              cualesOtrosIngresosController.text.trim(),
                          trabajoNegocioDescripcion:
                              cualesOtroTrabajoController.text.trim(),
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          index: 1,
                          question: '¿Tiene algún trabajo o negocio? ¿Cuál?',
                          response: question1 ?? 'N/A',
                        ),
                        if (question1 == 'input.yes'.tr())
                          Response(
                            index: 1,
                            question: 'Cual?',
                            response: cualesOtroTrabajoController.text.trim(),
                          ),
                        Response(
                          index: 1,
                          question: 'Tiempo de la actividad:*',
                          response: question2.text.trim(),
                        ),
                        Response(
                          index: 1,
                          question: '¿Tiene otros ingresos?¿Cuales?*',
                          response: question3 ?? 'N/A',
                        ),
                        if (question3 == 'input.yes'.tr())
                          Response(
                            index: 1,
                            question: 'Cuales Ingresos son?',
                            response: cualesOtrosIngresosController.text.trim(),
                          ),
                        Response(
                          index: 1,
                          question: 'Su comunidad es:',
                          response: question5 ?? 'N/A',
                        ),
                        Response(
                          index: 1,
                          question:
                              '¿Cuáles son las necesidades en su comunidad?',
                          response: necesidadesController.text.trim(),
                        ),
                        Response(
                          index: 1,
                          question: 'Número de personas a cargo:*',
                          response: question6.text.trim(),
                        ),
                        Response(
                          index: 1,
                          question: 'Número de hijos:*',
                          response: question7.text.trim(),
                        ),
                        Response(
                          index: 1,
                          question: '¿Qué tipo de estudios reciben sus hijos?',
                          response: question9 ?? 'N/A',
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

import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/mujer_emprende/mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_mujer_emprende/recurrente_mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MujerEmprendeEntornoSocialWidget extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController pageController;
  const MujerEmprendeEntornoSocialWidget({
    super.key,
    required this.pageController,
    required this.isRecurrentForm,
  });

  @override
  State<MujerEmprendeEntornoSocialWidget> createState() =>
      _MujerEmprendeEntornoSocialWidgetState();
}

class _MujerEmprendeEntornoSocialWidgetState
    extends State<MujerEmprendeEntornoSocialWidget>
    with AutomaticKeepAliveClientMixin {
  final question1 = TextEditingController();
  final question2 = TextEditingController();
  final question3 = TextEditingController();
  final otrosIngresosDescripcion = TextEditingController();
  String? otrosIngresosItem;
  String? originItem;
  String? academicLevelItem;
  String? tieneTrabajo;
  final trabajoNegocioDescripcion = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return switch (widget.isRecurrentForm) {
      true => _RecurrentForm(
          pageController: widget.pageController,
        ),
      false => SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(15),
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
                    'forms.entorno_familiar.title'.tr(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Gap(10),
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
                        otrosIngresosItem = item;
                        setState(() {});
                      },
                      toStringItem: (item) {
                        return item;
                      },
                      hintText: 'input.select_option'.tr(),
                    ),
                  ),
                  if (otrosIngresosItem == 'input.yes'.tr())
                    CommentaryWidget(
                      title: 'Cuales',
                      textEditingController: otrosIngresosDescripcion,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                    ),
                  WhiteCard(
                    padding: const EdgeInsets.all(5),
                    child: JLuxDropdown(
                      isContainIcon: true,
                      validator: (value) {
                        if (value == null) return 'input.input_validator'.tr();

                        return null;
                      },
                      title: '¿Tiene Trabajo? Cual?'.tr(),
                      items: ['input.yes'.tr(), 'input.no'.tr()],
                      onChanged: (item) {
                        if (item == null) return;
                        tieneTrabajo = item;
                        setState(() {});
                      },
                      toStringItem: (item) {
                        return item;
                      },
                      hintText: 'input.select_option'.tr(),
                    ),
                  ),
                  if (tieneTrabajo == 'input.yes'.tr())
                    CommentaryWidget(
                      title: 'Cuales?',
                      textEditingController: trabajoNegocioDescripcion,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                    ),
                  const Gap(20),
                  BlocBuilder<SolicitudesPendientesLocalDbCubit,
                      SolicitudesPendientesLocalDbState>(
                    builder: (context, state) {
                      return WhiteCard(
                        marginTop: 15,
                        padding: const EdgeInsets.all(10),
                        child: JLuxDropdown(
                          validator: (value) {
                            if (value == null) {
                              return 'input.input_validator'.tr();
                            }
                            return null;
                          },
                          isContainIcon: true,
                          isLoading: state.status == Status.inProgress,
                          title: 'forms.entorno_familiar.person_origin'.tr(),
                          items: state.departamentos,
                          onChanged: (item) {
                            if (item == null) return;
                            originItem = item.valor;
                            setState(() {});
                          },
                          toStringItem: (item) => item.nombre ?? '',
                          hintText: 'input.select_department'.tr(),
                        ),
                      );
                    },
                  ),
                  CommentaryWidget(
                    title: 'Número de personas a cargo:*',
                    textInputType: TextInputType.number,
                    textEditingController: question1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      final numero = int.tryParse(value);
                      if (numero == null || numero < 0) {
                        return 'Valor no valido'.tr();
                      }
                      return null;
                    },
                  ),
                  CommentaryWidget(
                    title: '¿Que edades tienen sus hijos?',
                    textEditingController: question2,
                  ),
                  CommentaryWidget(
                    title: 'Número de hijos:*',
                    textEditingController: question3,
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      final numero = int.tryParse(value);
                      if (numero == null || numero < 0) {
                        return 'Valor no valido'.tr();
                      }
                      return null;
                    },
                  ),
                  WhiteCard(
                    padding: const EdgeInsets.all(5),
                    child: JLuxDropdown(
                      isContainIcon: true,
                      validator: (value) {
                        if (value == null) return 'input.input_validator'.tr();
                        return null;
                      },
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
                        academicLevelItem = item;
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
                        context.read<MujerEmprendeCubit>().saveAnswers(
                              otrosIngresos:
                                  otrosIngresosItem == 'input.yes'.tr(),
                              otrosIngresosDescripcion:
                                  otrosIngresosDescripcion.text.trim(),
                              objOrigenCatalogoValorId: originItem,
                              personasCargo:
                                  int.tryParse(question1.text.trim()),
                              edadHijos: question2.text.trim(),
                              numeroHijos: int.tryParse(question3.text.trim()),
                              tipoEstudioHijos: academicLevelItem,
                              tieneTrabajo: tieneTrabajo == 'input.yes'.tr(),
                              trabajoNegocioDescripcion:
                                  trabajoNegocioDescripcion.text.trim(),
                            );
                        context.read<ResponseCubit>().addResponses(
                          responses: [
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question: '¿Tiene otros ingresos?¿Cuales?*',
                              response: otrosIngresosItem ?? 'N/A',
                            ),
                            if (otrosIngresosItem == 'input.yes'.tr())
                              Response(
                                index: widget.pageController.page?.toInt() ?? 0,
                                question: 'Cuales',
                                response: otrosIngresosDescripcion.text.trim(),
                              ),
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question:
                                  'forms.entorno_familiar.person_origin'.tr(),
                              response: originItem ?? 'N/A',
                            ),
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question: '¿Tiene Trabajo? Cual?'.tr(),
                              response: tieneTrabajo!,
                            ),
                            if (tieneTrabajo == 'input.yes'.tr())
                              Response(
                                index: widget.pageController.page?.toInt() ?? 0,
                                question: 'Cuales?'.tr(),
                                response: trabajoNegocioDescripcion.text.trim(),
                              ),
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question: 'Número de personas a cargo:*'.tr(),
                              response: question1.text.trim(),
                            ),
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question: '¿Que edades tienen sus hijos?'.tr(),
                              response: question2.text.trim(),
                            ),
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question: 'Número de hijos:*'.tr(),
                              response: question3.text.trim(),
                            ),
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question:
                                  '¿Qué tipo de estudios reciben sus hijos?'
                                      .tr(),
                              response: academicLevelItem ?? 'N/A',
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
  String? otrosIngresos;
  String? tipoEstudioHijos;
  final otrosIngresosDescripcion = TextEditingController();
  final personasCargo = TextEditingController();
  final numeroHijos = TextEditingController();
  final edadHijos = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? tieneTrabajo;
  final trabajoNegocioDescripcion = TextEditingController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.all(15),
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
                'forms.entorno_familiar.title'.tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(10),
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
                    otrosIngresos = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              if (otrosIngresos == 'input.yes'.tr())
                CommentaryWidget(
                  title: 'Cuales?',
                  textEditingController: otrosIngresosDescripcion,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'input.input_validator'.tr();
                    }
                    return null;
                  },
                ),
              WhiteCard(
                padding: const EdgeInsets.all(5),
                child: JLuxDropdown(
                  isContainIcon: true,
                  validator: (value) {
                    if (value == null) return 'input.input_validator'.tr();

                    return null;
                  },
                  title: '¿Tiene Trabajo? Cual?'.tr(),
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    tieneTrabajo = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              if (tieneTrabajo == 'input.yes'.tr())
                CommentaryWidget(
                  title: 'Cuales?',
                  textEditingController: trabajoNegocioDescripcion,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'input.input_validator'.tr();
                    }
                    return null;
                  },
                ),
              const Gap(20),
              CommentaryWidget(
                title: 'Número de personas a cargo:*',
                textEditingController: personasCargo,
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  final numero = int.tryParse(value);
                  if (numero == null || numero < 0) {
                    return 'Valor no valido'.tr();
                  }
                  return null;
                },
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'Número de hijos:*',
                textEditingController: numeroHijos,
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  final numero = int.tryParse(value);
                  if (numero == null || numero < 0) {
                    return 'Valor no valido'.tr();
                  }
                  return null;
                },
              ),
              const Gap(20),
              CommentaryWidget(
                title: '¿Que edades tienen sus hijos?',
                textEditingController: edadHijos,
              ),
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
                    tipoEstudioHijos = item;
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
                    context.read<RecurrenteMujerEmprendeCubit>().saveAnswers(
                          tieneTrabajo: tieneTrabajo == 'input.yes'.tr(),
                          tieneTrabajoDescripcion:
                              trabajoNegocioDescripcion.text.trim(),
                          otrosIngresos: otrosIngresos == 'input.yes'.tr(),
                          otrosIngresosDescripcion:
                              otrosIngresosDescripcion.text.trim(),
                          personasCargo:
                              int.tryParse(personasCargo.text.trim()),
                          numeroHijos: int.tryParse(numeroHijos.text.trim()),
                          edadHijos: edadHijos.text.trim(),
                          tipoEstudioHijos: tipoEstudioHijos,
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question: '¿Tiene otros ingresos?¿Cuales?*',
                          response: otrosIngresos ?? 'N/A',
                        ),
                        if (otrosIngresos == 'input.yes'.tr())
                          Response(
                            index: widget.pageController.page?.toInt() ?? 0,
                            question: 'Cuales?',
                            response: otrosIngresosDescripcion.text.trim(),
                          ),
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question: 'Número de personas a cargo:*',
                          response: personasCargo.text.trim(),
                        ),
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question: 'Número de hijos:*',
                          response: numeroHijos.text.trim(),
                        ),
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question: '¿Que edades tienen sus hijos?',
                          response: edadHijos.text.trim(),
                        ),
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question: '¿Qué tipo de estudios reciben sus hijos?',
                          response: tipoEstudioHijos ?? 'N/A',
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

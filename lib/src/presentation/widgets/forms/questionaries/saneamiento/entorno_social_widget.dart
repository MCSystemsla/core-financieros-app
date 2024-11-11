import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/agua_y_saneamiento/agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_agua_y_saniamiento/recurrente_agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mejora_vivienda/mejora_vivienda_entorno_social.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EntornoSocialWidget extends StatefulWidget {
  final PageController controller;
  final bool isRecurrentForm;
  const EntornoSocialWidget(
      {super.key, required this.controller, required this.isRecurrentForm});

  @override
  State<EntornoSocialWidget> createState() => _EntornoSocialWidgetState();
}

class _EntornoSocialWidgetState extends State<EntornoSocialWidget>
    with AutomaticKeepAliveClientMixin {
  String? tieneTrabajo;
  String? personOrigin;
  String? otrosIngresos;
  String? tipoEstudioHijos;
  final question2Controller = TextEditingController();
  final question3Controller = TextEditingController();
  final trabajoNegocioDescripcion = TextEditingController();
  final tiempoActividad = TextEditingController();
  final personasCargo = TextEditingController();
  final numeroHijos = TextEditingController();
  final otrosIngresosDescripcion = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return switch (widget.isRecurrentForm) {
      true => _RecurrentForm(
          controller: widget.controller,
        ),
      false => SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MiCreditoProgress(
                      steps: 5,
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
                      marginTop: 15,
                      padding: const EdgeInsets.all(10),
                      child: JLuxDropdown(
                        isContainIcon: true,
                        title: '¿Tiene algún trabajo o negocio? ¿Cuál?'.tr(),
                        items: ['input.yes'.tr(), 'input.no'.tr()],
                        onChanged: (item) {
                          if (item == null) return;
                          tieneTrabajo = item;
                          setState(() {});
                        },
                        toStringItem: (item) => item,
                        hintText: 'input.select_option'.tr(),
                      ),
                    ),
                    if (tieneTrabajo == 'input.yes'.tr())
                      CommentaryWidget(
                          title: 'Cual?',
                          textEditingController: trabajoNegocioDescripcion),
                    const Gap(10),
                    CommentaryWidget(
                      title: 'Tiempo de la actividad (meses o años)',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                      textEditingController: tiempoActividad,
                    ),
                    const Gap(10),
                    WhiteCard(
                      marginTop: 15,
                      padding: const EdgeInsets.all(10),
                      child: JLuxDropdown(
                        isContainIcon: true,
                        title: '¿Tiene otros ingresos?¿Cuales?*'.tr(),
                        items: ['input.yes'.tr(), 'input.no'.tr()],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'input.input_validator'.tr();
                          }
                          return null;
                        },
                        onChanged: (item) {
                          if (item == null) return;
                          otrosIngresos = item;
                          setState(() {});
                        },
                        toStringItem: (item) => item,
                        hintText: 'input.select_option'.tr(),
                      ),
                    ),
                    if (otrosIngresos == 'input.yes'.tr())
                      CommentaryWidget(
                        title: 'Cuales?',
                        textEditingController: otrosIngresosDescripcion,
                      ),
                    const Gap(10),
                    BlocBuilder<DepartamentosCubit, DepartamentosState>(
                      builder: (context, state) {
                        return WhiteCard(
                          marginTop: 15,
                          padding: const EdgeInsets.all(10),
                          child: JLuxDropdown(
                            isContainIcon: true,
                            isLoading: state.status == Status.inProgress,
                            title: 'forms.entorno_familiar.person_origin'.tr(),
                            validator: (value) {
                              if (value == null) {
                                return 'input.input_validator'.tr();
                              }
                              return null;
                            },
                            items: state.departamentos,
                            onChanged: (item) {
                              if (item == null) return;
                              personOrigin = item.valor;
                            },
                            toStringItem: (item) => item.nombre,
                            hintText: 'input.select_department'.tr(),
                          ),
                        );
                      },
                    ),
                    const Gap(10),
                    CommentaryWidget(
                      title: 'Número de personas a cargo:*',
                      textEditingController: personasCargo,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                    ),
                    const Gap(10),
                    CommentaryWidget(
                      title: 'Numero de Hijos',
                      textEditingController: numeroHijos,
                    ),
                    const Gap(10),
                    CommentaryWidget(
                      title: 'forms.entorno_familiar.childs_age'.tr(),
                      textEditingController: question2Controller,
                    ),
                    const Gap(10),
                    WhiteCard(
                      padding: const EdgeInsets.all(5),
                      child: JLuxDropdown(
                        isContainIcon: true,
                        validator: (value) {
                          if (value == null) {
                            return 'input.input_validator'.tr();
                          }
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
                          tipoEstudioHijos = item;
                          setState(() {});
                        },
                        toStringItem: (item) {
                          return item;
                        },
                        hintText: 'input.select_option'.tr(),
                      ),
                    ),
                    const Gap(15),
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
                        if (formKey.currentState?.validate() ?? false) {
                          context.read<AguaYSaneamientoCubit>().saveAnswers(
                                tieneTrabajo: tieneTrabajo == 'input.yes'.tr(),
                                trabajoNegocioDescripcion:
                                    trabajoNegocioDescripcion.text.trim(),
                                otrosIngresos:
                                    otrosIngresos == 'input.yes'.tr(),
                                otrosIngresosDescripcion:
                                    otrosIngresosController.text.trim(),
                                objOrigenCatalogoValorId: personOrigin,
                                personasCargo: personasCargo.text.trim(),
                                edadHijos: question2Controller.text.trim(),
                                tipoEstudioHijos: tipoEstudioHijos,
                                tiempoActividad:
                                    int.tryParse(tiempoActividad.text.trim()),
                              );
                          context.read<ResponseCubit>().addResponses(
                            responses: [
                              Response(
                                index: widget.controller.page?.toInt() ?? 0,
                                question:
                                    '¿Tiene algún trabajo o negocio? ¿Cuál?',
                                response: tieneTrabajo ?? 'N/A',
                              ),
                            ],
                          );

                          widget.controller.nextPage(
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
        ),
    };
  }

  @override
  bool get wantKeepAlive => true;
}

class _RecurrentForm extends StatefulWidget {
  final PageController controller;
  const _RecurrentForm({required this.controller});

  @override
  State<_RecurrentForm> createState() => _RecurrentFormState();
}

class _RecurrentFormState extends State<_RecurrentForm>
    with AutomaticKeepAliveClientMixin {
  final personasCargo = TextEditingController();
  final trabajoNegocioDescripcion = TextEditingController();
  final tiempoActividad = TextEditingController();
  final otrosIngresosDescripcion = TextEditingController();
  final numeroHijos = TextEditingController();
  final edadHijos = TextEditingController();
  String? tieneTrabajo;
  String? otrosIngresos;
  String? otrosIngresostipoEstudioHijos;
  String? tipoEstudioHijos;
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
              CommentaryWidget(
                title: 'Número de personas a cargo:*',
                textEditingController: personasCargo,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(10),
              WhiteCard(
                marginTop: 15,
                padding: const EdgeInsets.all(10),
                child: JLuxDropdown(
                  isContainIcon: true,
                  title: '¿Tiene algún trabajo o negocio? ¿Cuál?'.tr(),
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    tieneTrabajo = item;
                    setState(() {});
                  },
                  toStringItem: (item) => item,
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              if (tieneTrabajo == 'input.yes'.tr())
                CommentaryWidget(
                  title: 'Cual?',
                  textEditingController: trabajoNegocioDescripcion,
                ),
              CommentaryWidget(
                textEditingController: tiempoActividad,
                title: 'Tiempo de la actividad (meses o años):*',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(10),
              WhiteCard(
                marginTop: 15,
                padding: const EdgeInsets.all(10),
                child: JLuxDropdown(
                  isContainIcon: true,
                  title: '¿Tiene otros ingresos?¿Cuales?*'.tr(),
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  validator: (value) {
                    if (value == null) {
                      return 'input.input_validator'.tr();
                    }
                    return null;
                  },
                  onChanged: (item) {
                    if (item == null) return;
                    otrosIngresos = item;
                    setState(() {});
                  },
                  toStringItem: (item) => item,
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
              const Gap(10),
              CommentaryWidget(
                title: 'Número de hijos:*',
                textEditingController: numeroHijos,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(10),
              CommentaryWidget(
                title: '¿Que edades tienen sus hijos?',
                textEditingController: edadHijos,
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
              const Gap(15),
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
                  if (formKey.currentState?.validate() ?? false) {
                    context.read<RecurrenteAguaYSaneamientoCubit>().saveAnswers(
                          personasCargo: personasCargo.text.trim(),
                          tieneTrabajo: tieneTrabajo == 'input.yes'.tr(),
                          trabajoNegocioDescripcion:
                              trabajoNegocioDescripcion.text.trim(),
                          tiempoActividad:
                              int.tryParse(tiempoActividad.text.trim()),
                          otrosIngresos: otrosIngresos == 'input.yes'.tr(),
                          otrosIngresosDescripcion:
                              otrosIngresosDescripcion.text.trim(),
                        );
                    widget.controller.nextPage(
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

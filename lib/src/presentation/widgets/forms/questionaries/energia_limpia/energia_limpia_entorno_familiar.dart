import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/energia_limpia/energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EnergiaLimpiaEntornoFamiliar extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController pageController;
  const EnergiaLimpiaEntornoFamiliar({
    super.key,
    required this.pageController,
    required this.isRecurrentForm,
  });

  @override
  State<EnergiaLimpiaEntornoFamiliar> createState() =>
      _EnergiaLimpiaEntornoFamiliarState();
}

class _EnergiaLimpiaEntornoFamiliarState
    extends State<EnergiaLimpiaEntornoFamiliar>
    with AutomaticKeepAliveClientMixin {
  String? objOrigenCatalogoValorId;
  String? objTipoComunidadId;
  String? tieneProblemasEnergia;
  String? tipoEstudioHijos;
  final numeroHijos = TextEditingController();
  final edadHijos = TextEditingController();
  final personasCargo = TextEditingController();
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
                    currentStep: 3,
                  ),
                  const Gap(20),
                  Text(
                    'Descripción del entorno familiar.'.tr(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Gap(10),
                  BlocBuilder<SolicitudesPendientesLocalDbCubit,
                      SolicitudesPendientesLocalDbState>(
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
                            objOrigenCatalogoValorId = item.valor;
                            setState(() {});
                          },
                          toStringItem: (item) => item.nombre ?? '',
                          hintText: 'input.select_department'.tr(),
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  BlocBuilder<SolicitudesPendientesLocalDbCubit,
                      SolicitudesPendientesLocalDbState>(
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
                            objTipoComunidadId = item.valor;
                            setState(() {});
                          },
                          toStringItem: (item) {
                            return item.nombre ?? '';
                          },
                          hintText: 'input.select_option'.tr(),
                        ),
                      );
                    },
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
                      title:
                          '¿Usted tiene problemas de energía eléctrica en su comunidad?'
                              .tr(),
                      items: ['input.yes'.tr(), 'input.no'.tr()],
                      onChanged: (item) {
                        if (item == null) return;
                        tieneProblemasEnergia = item;
                        setState(() {});
                      },
                      toStringItem: (item) {
                        return item;
                      },
                      hintText: 'input.select_option'.tr(),
                    ),
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
                      return null;
                    },
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: '¿Qué edades tienen sus hijos?',
                    textEditingController: edadHijos,
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
                      title: '¿Qué tipo de estudios reciben sus hijos?'.tr(),
                      items: [
                        'Ninguno'.tr(),
                        'Preescolar'.tr(),
                        'Primaria'.tr(),
                        'Secundaria'.tr(),
                        'Técnico'.tr(),
                        'Universitario'.tr(),
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
                        context.read<EnergiaLimpiaCubit>().saveAnswers2(
                              edadHijos: edadHijos.text.trim(),
                              numeroHijos: int.parse(numeroHijos.text.trim()),
                              objOrigenCatalogoValorId:
                                  objOrigenCatalogoValorId,
                              objTipoComunidadId: objTipoComunidadId,
                              personasCargo: personasCargo.text.trim(),
                              tieneProblemasEnergia:
                                  tieneProblemasEnergia == 'input.yes'.tr(),
                              tipoEstudioHijos: tipoEstudioHijos,
                            );
                        context.read<ResponseCubit>().addResponses(
                          responses: [
                            Response(
                              index: 2,
                              question:
                                  'forms.entorno_familiar.person_origin'.tr(),
                              response: objOrigenCatalogoValorId ?? 'N/A',
                            ),
                            Response(
                              index: 2,
                              question: 'Su comunidad es:',
                              response: objTipoComunidadId ?? 'N/A',
                            ),
                            Response(
                              index: 2,
                              question:
                                  '¿Usted tiene problemas de energía eléctrica en su comunidad?',
                              response: tieneProblemasEnergia ?? 'N/A',
                            ),
                            Response(
                              index: 2,
                              question:
                                  '¿Usted tiene problemas de energía eléctrica en su comunidad?',
                              response: tieneProblemasEnergia ?? 'N/A',
                            ),
                            Response(
                              index: 2,
                              question: 'Número de personas a cargo:*',
                              response: personasCargo.text.trim(),
                            ),
                            Response(
                              index: 2,
                              question: 'Número de hijos:*',
                              response: numeroHijos.text.trim(),
                            ),
                            Response(
                              index: 2,
                              question: '¿Qué edades tienen sus hijos?',
                              response: edadHijos.text.trim(),
                            ),
                            Response(
                              index: 2,
                              question:
                                  '¿Qué tipo de estudios reciben sus hijos?',
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
  String? objTipoComunidadId;
  String? tieneProblemasEnergia;
  String? tipoEstudioHijos;
  final personasCargo = TextEditingController();
  final numeroHijos = TextEditingController();
  final edadHijos = TextEditingController();
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
                currentStep: 3,
              ),
              const Gap(20),
              Text(
                'Descripción del entorno familiar.'.tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(10),
              BlocBuilder<SolicitudesPendientesLocalDbCubit,
                  SolicitudesPendientesLocalDbState>(
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
                        objTipoComunidadId = item.valor;
                        setState(() {});
                      },
                      toStringItem: (item) {
                        return item.nombre ?? '';
                      },
                      hintText: 'input.select_option'.tr(),
                    ),
                  );
                },
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
                  title:
                      '¿Usted tiene problemas de energía eléctrica en su comunidad?'
                          .tr(),
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    tieneProblemasEnergia = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'Numero de persona a cargo',
                textEditingController: personasCargo,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(20),
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
              const Gap(20),
              CommentaryWidget(
                title: '¿Qué edades tienen sus hijos?',
                textEditingController: edadHijos,
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
                    context.read<RecurrenteEnergiaLimpiaCubit>().saveAnswer2(
                          edadHijos: edadHijos.text.trim(),
                          numeroHijos: int.tryParse(numeroHijos.text.trim()),
                          objTipoComunidadId: objTipoComunidadId,
                          personasCargo: personasCargo.text.trim(),
                          tieneProblemasEnergia:
                              tieneProblemasEnergia == 'input.yes'.tr(),
                          tipoEstudioHijos: tipoEstudioHijos,
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          index: 2,
                          question: 'Su comunidad es:',
                          response: objTipoComunidadId ?? 'N/A',
                        ),
                        Response(
                          index: 2,
                          question:
                              '¿Usted tiene problemas de energía eléctrica en su comunidad?',
                          response: tieneProblemasEnergia ?? 'N/A',
                        ),
                        Response(
                          index: 2,
                          question: 'Numero de persona a cargo',
                          response: tieneProblemasEnergia ?? 'N/A',
                        ),
                        Response(
                          index: 2,
                          question: '¿Qué edades tienen sus hijos?',
                          response: edadHijos.text.trim(),
                        ),
                        Response(
                          index: 2,
                          question: 'Número de hijos:*',
                          response: numeroHijos.text.trim(),
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

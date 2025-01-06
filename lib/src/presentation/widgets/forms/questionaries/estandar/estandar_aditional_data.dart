import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/estandar/estandar_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_estandar/recurrente_estandart_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EstandarAditionalData extends StatefulWidget {
  final bool isRecurrenteForm;
  final PageController pageController;
  const EstandarAditionalData({
    super.key,
    required this.pageController,
    required this.isRecurrenteForm,
  });

  @override
  State<EstandarAditionalData> createState() => _EstandarAditionalDataState();
}

class _EstandarAditionalDataState extends State<EstandarAditionalData>
    with AutomaticKeepAliveClientMixin {
  String? otrosIngresos;
  final cualesOtrosIngrsos = TextEditingController();
  String? tieneTrabajo;
  final tieneTrabajoDescripcion = TextEditingController();
  final tiempoActividad = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return switch (widget.isRecurrenteForm) {
      true => _RecurrentForm(
          pageController: widget.pageController,
        ),
      false => Form(
          key: formKey,
          child: Column(
            children: [
              const MiCreditoProgress(
                steps: 4,
                currentStep: 2,
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
                  textEditingController: cualesOtrosIngrsos,
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
                  textEditingController: tieneTrabajoDescripcion,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'input.input_validator'.tr();
                    }
                    return null;
                  },
                ),
              CommentaryWidget(
                textEditingController: tiempoActividad,
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
                title: 'Tiempo de la actividad:* (MESES)',
                textInputType: TextInputType.number,
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
                          tipoSolicitud: context
                              .read<KivaRouteCubit>()
                              .state
                              .tipoSolicitud,
                          tiempoActividad:
                              int.tryParse(tiempoActividad.text.trim()),
                          otrosIngresos: otrosIngresos == 'input.yes'.tr(),
                          otrosIngresosDescripcion:
                              cualesOtrosIngrsos.text.trim(),
                          tieneTrabajo: tieneTrabajo == 'input.yes'.tr(),
                          trabajoNegocioDescripcion:
                              tieneTrabajoDescripcion.text.trim(),
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
                            response: otrosIngresos ?? 'N/A',
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
  final formKey = GlobalKey<FormState>();
  String? otrosIngresos;
  final cualesOtrosIngrsos = TextEditingController();
  String? tieneTrabajo;
  final tieneTrabajoDescripcion = TextEditingController();
  final tiempoActividad = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const MiCreditoProgress(
              steps: 4,
              currentStep: 2,
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
                textEditingController: cualesOtrosIngrsos,
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
                textEditingController: tieneTrabajoDescripcion,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
            CommentaryWidget(
              textEditingController: tiempoActividad,
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
              title: 'Tiempo de la actividad:* (MESES)',
              textInputType: TextInputType.number,
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
                        tipoSolitud:
                            context.read<KivaRouteCubit>().state.tipoSolicitud,
                        tiempoActividad:
                            int.tryParse(tiempoActividad.text.trim()),
                        tieneTrabajo: tieneTrabajo == 'input.yes'.tr(),
                        trabajoDescripcion: tieneTrabajoDescripcion.text.trim(),
                        otrosIngresos: otrosIngresos == 'input.yes'.tr(),
                        otrosIngresosDescripcion:
                            cualesOtrosIngrsos.text.trim(),
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
                          response: otrosIngresos ?? 'N/A',
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}

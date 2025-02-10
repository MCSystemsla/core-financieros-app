import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/energia_limpia/energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EnergiaLimpiaAditionalDataWidget extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController pageController;
  const EnergiaLimpiaAditionalDataWidget({
    super.key,
    required this.pageController,
    required this.isRecurrentForm,
  });

  @override
  State<EnergiaLimpiaAditionalDataWidget> createState() =>
      _EnergiaLimpiaAditionalDataWidgetState();
}

class _EnergiaLimpiaAditionalDataWidgetState
    extends State<EnergiaLimpiaAditionalDataWidget>
    with AutomaticKeepAliveClientMixin {
  String? tieneTrabajo;
  String? otrosIngresos;
  final trabajoNegocioDescripcion = TextEditingController();
  final tiempoActividad = TextEditingController();
  final otrosIngresosDescripcion = TextEditingController();
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
                      title: '¿Tiene algún trabajo o negocio? ¿Cuál?'.tr(),
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
                      title: 'Cual',
                      textEditingController: trabajoNegocioDescripcion,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                    ),
                  const Gap(10),
                  CommentaryWidget(
                    title: 'Tiempo de la actividad (MESES) *',
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      final numero = int.tryParse(value);
                      if (numero == null || numero < 0 || numero >= 255) {
                        return 'Valor no valido'.tr();
                      }
                      return null;
                    },
                    textEditingController: tiempoActividad,
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
                      title: 'Cuales Otros Ingresos?',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                      textEditingController: otrosIngresosDescripcion,
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
                        context.read<EnergiaLimpiaCubit>().saveAnswer1(
                              tipoSolicitud: context
                                  .read<KivaRouteCubit>()
                                  .state
                                  .tipoSolicitud,
                              otrosIngresos: otrosIngresos == 'input.yes'.tr(),
                              otrosIngresosDescripcion:
                                  otrosIngresosDescripcion.text.trim(),
                              tiempoActividad:
                                  int.tryParse(tiempoActividad.text.trim()),
                              tieneTrabajo: tieneTrabajo == 'input.yes'.tr(),
                              trabajoNegocioDescripcion:
                                  trabajoNegocioDescripcion.text.trim(),
                            );
                        context.read<ResponseCubit>().addResponses(
                          responses: [
                            Response(
                              index: 1,
                              question:
                                  '¿Tiene algún trabajo o negocio? ¿Cuál?',
                              response: tieneTrabajo ?? 'N/A',
                            ),
                            if (tieneTrabajo == 'input.yes'.tr())
                              Response(
                                index: 1,
                                question: 'Cual',
                                response: trabajoNegocioDescripcion.text.trim(),
                              ),
                            Response(
                              index: 1,
                              question: 'Tiempo de la actividad:*',
                              response: tiempoActividad.text.trim(),
                            ),
                            Response(
                              index: 1,
                              question: '¿Tiene otros ingresos?¿Cuales?*',
                              response: otrosIngresos ?? 'N/A',
                            ),
                            if (otrosIngresos == 'input.yes'.tr())
                              Response(
                                index: 1,
                                question: 'Cuales Otros Ingresos?',
                                response: otrosIngresosDescripcion.text.trim(),
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
  final formKey = GlobalKey<FormState>();
  String? tieneTrabajo;
  String? otrosIngresos;
  final trabajoNegocioDescripcion = TextEditingController();
  final tiempoActividad = TextEditingController();
  final otrosIngresosDescripcion = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  title: '¿Tiene algún trabajo o negocio? ¿Cuál?',
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
                  title: 'Cual?',
                  textEditingController: trabajoNegocioDescripcion,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'input.input_validator'.tr();
                    }
                    return null;
                  },
                ),
              const Gap(10),
              CommentaryWidget(
                title: 'Tiempo de la actividad:',
                textInputType: TextInputType.number,
                textEditingController: tiempoActividad,
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
                  title: 'Ingrese los otros ingresos',
                  textEditingController: otrosIngresosDescripcion,
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
                    context.read<RecurrenteEnergiaLimpiaCubit>().saveAnswer1(
                          tipoSolicitud: context
                              .read<KivaRouteCubit>()
                              .state
                              .tipoSolicitud,
                          otrosIngresos: otrosIngresos == 'input.yes'.tr(),
                          otrosIngresosDescripcion:
                              otrosIngresosDescripcion.text.trim(),
                          tiempoActividad:
                              int.tryParse(tiempoActividad.text.trim()),
                          tieneTrabajo: tieneTrabajo == 'input.yes'.tr(),
                          trabajoNegocioDescripcion:
                              trabajoNegocioDescripcion.text.trim(),
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          question: '¿Tiene algún trabajo o negocio? ¿Cuál?',
                          response: tieneTrabajo ?? 'N/A',
                          index: 1,
                        ),
                        if (tieneTrabajo == 'input.yes'.tr())
                          Response(
                            question: 'Cual?',
                            response: trabajoNegocioDescripcion.text.trim(),
                            index: 1,
                          ),
                        Response(
                          question: 'Tiempo de la actividad:',
                          response: tiempoActividad.text.trim(),
                          index: 1,
                        ),
                        Response(
                          question: '¿Tiene otros ingresos?¿Cuales?*',
                          response: otrosIngresos ?? 'N/A',
                          index: 1,
                        ),
                        if (otrosIngresos == 'input.yes'.tr())
                          Response(
                            question: 'Ingrese los otros ingresos',
                            response: otrosIngresosDescripcion.text.trim(),
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}

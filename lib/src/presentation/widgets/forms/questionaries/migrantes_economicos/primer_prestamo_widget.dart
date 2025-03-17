import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/migrantes_economicos/migrantes_economicos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../bloc/kiva/recurrente_migrante_economico/recurrente_migrantes_economicos_cubit.dart';

class PrimerPrestamoWidget extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController controller;
  const PrimerPrestamoWidget(
      {super.key, required this.controller, required this.isRecurrentForm});

  @override
  State<PrimerPrestamoWidget> createState() => _PrimerPrestamoWidgetState();
}

class _PrimerPrestamoWidgetState extends State<PrimerPrestamoWidget>
    with AutomaticKeepAliveClientMixin {
  final otrosIngresosDescripcion = TextEditingController();
  final personasCargo = TextEditingController();
  final tiempoActividad = TextEditingController();
  final trabajoNegocioDescripcion = TextEditingController();
  String? tieneTrabajo;
  String? otrosIngresos;
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
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MiCreditoProgress(
                    steps: 3,
                    currentStep: 1,
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
                      widget.controller.previousPage(
                        duration: const Duration(
                          milliseconds: 350,
                        ),
                        curve: Curves.easeIn,
                      );
                    },
                    onNextPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        context.read<MigrantesEconomicosCubit>().saveAnswers(
                              tipoSolicitud: context
                                  .read<KivaRouteCubit>()
                                  .state
                                  .tipoSolicitud,
                              otrosIngresos: otrosIngresos == 'input.yes'.tr(),
                              otrosIngresosDescripcion:
                                  otrosIngresosDescripcion.text.trim(),
                            );
                        context.read<ResponseCubit>().addResponses(
                          responses: [
                            Response(
                              question:
                                  '¿Tiene algún trabajo o negocio? ¿Cuál?'.tr(),
                              response: tieneTrabajo ?? 'N/A',
                              index: widget.controller.page?.toInt() ?? 0,
                            ),
                            if (tieneTrabajo == 'input.yes'.tr())
                              Response(
                                question: 'Cual',
                                response: trabajoNegocioDescripcion.text.trim(),
                                index: widget.controller.page?.toInt() ?? 0,
                              ),
                            Response(
                              question: 'Tiempo de la actividad:* (MESES)',
                              response: tiempoActividad.text.trim(),
                              index: widget.controller.page?.toInt() ?? 0,
                            ),
                            Response(
                              question: '¿Tiene otros ingresos?¿Cuales?*'.tr(),
                              response: otrosIngresos ?? 'N/A',
                              index: widget.controller.page?.toInt() ?? 0,
                            ),
                            if (otrosIngresos == 'input.yes'.tr())
                              Response(
                                question: 'Cuales Otros Ingresos?',
                                response: otrosIngresosDescripcion.text.trim(),
                                index: widget.controller.page?.toInt() ?? 0,
                              ),
                            Response(
                              question: 'Número de personas a cargo:*',
                              response: personasCargo.text.trim(),
                              index: widget.controller.page?.toInt() ?? 0,
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
                  const Gap(20),
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
  final PageController controller;
  const _RecurrentForm({
    required this.controller,
  });

  @override
  State<_RecurrentForm> createState() => _RecurrentFormState();
}

class _RecurrentFormState extends State<_RecurrentForm> {
  final formKey = GlobalKey<FormState>();
  String? tieneTrabajo;
  final trabajoNegocioDescripcion = TextEditingController();
  final tiempoActividad = TextEditingController();
  String? otrosIngresos;
  final otrosIngresosDescripcion = TextEditingController();
  final personasCargo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MiCreditoProgress(
                steps: 3,
                currentStep: 1,
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
                  widget.controller.previousPage(
                    duration: const Duration(
                      milliseconds: 350,
                    ),
                    curve: Curves.easeIn,
                  );
                },
                onNextPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    context
                        .read<RecurrenteMigrantesEconomicosCubit>()
                        .saveAnswers(
                          tipoSolicitud: context
                              .read<KivaRouteCubit>()
                              .state
                              .tipoSolicitud,
                          otrosIngresos: otrosIngresos == 'input.yes'.tr(),
                          otrosIngresosDescripcion:
                              otrosIngresosDescripcion.text.trim(),
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          question: '¿Tiene otros ingresos?¿Cuales?*'.tr(),
                          response: otrosIngresos ?? 'N/A',
                          index: widget.controller.page?.toInt() ?? 0,
                        ),
                        if (otrosIngresos == 'input.yes'.tr())
                          Response(
                            question: 'Cuales Otros Ingresos?',
                            response: otrosIngresosDescripcion.text.trim(),
                            index: widget.controller.page?.toInt() ?? 0,
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
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}

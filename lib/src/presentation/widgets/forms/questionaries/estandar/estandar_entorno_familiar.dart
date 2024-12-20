import 'package:core_financiero_app/src/datasource/origin/origin.dart';
import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/estandar/estandar_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_estandar/recurrente_estandart_cubit.dart';
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

class EstandarEntornoFamiliar extends StatefulWidget {
  final bool isRecurrenteForm;
  final PageController pageController;
  const EstandarEntornoFamiliar({
    super.key,
    required this.pageController,
    required this.isRecurrenteForm,
  });

  @override
  State<EstandarEntornoFamiliar> createState() =>
      _EstandarEntornoFamiliarState();
}

class _EstandarEntornoFamiliarState extends State<EstandarEntornoFamiliar>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  String? objOrigenCatalogoValorId;
  final personasCargo = TextEditingController();
  final numeroHijos = TextEditingController();
  final edadHijos = TextEditingController();
  String? tipoEstudioHijos;
  @override
  void initState() {
    initFunctions();
    super.initState();
  }

  initFunctions() async {
    final solicitudesProvider =
        context.read<SolicitudesPendientesLocalDbCubit>();
    await solicitudesProvider.getComunidades();
    await solicitudesProvider.getDepartamentos();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return switch (widget.isRecurrenteForm) {
      true => _RecurrenteFormWidget(
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
                  WhiteCard(
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
                      // isLoading: state.status == Status.inProgress,
                      title: 'forms.entorno_familiar.person_origin'.tr(),
                      items: Origin.originCatalogosValores,
                      onChanged: (item) {
                        if (item == null) return;
                        objOrigenCatalogoValorId = item.valor;
                        setState(() {});
                      },
                      toStringItem: (item) => item.nombre,
                      hintText: 'input.select_department'.tr(),
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
                      final numero = int.tryParse(value);
                      if (numero == null || numero < 0 || numero >= 255) {
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
                      if (numero == null || numero < 0 || numero >= 255) {
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
                        context.read<EstandarCubit>().saveAnswers(
                              objOrigenCatalogoValorId:
                                  objOrigenCatalogoValorId!,
                              personasCargo:
                                  int.tryParse(personasCargo.text.trim()),
                              numeroHijos:
                                  int.tryParse(numeroHijos.text.trim()),
                              edadHijos: edadHijos.text.trim(),
                              tipoEstudioHijos: tipoEstudioHijos!,
                            );
                        context.read<ResponseCubit>().addResponses(
                          responses: [
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question:
                                  'forms.entorno_familiar.person_origin'.tr(),
                              response: objOrigenCatalogoValorId ?? 'N/A',
                            ),
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question: 'Número de personas a cargo:*'.tr(),
                              response: personasCargo.text.trim(),
                            ),
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question: 'Número de hijos:*'.tr(),
                              response: numeroHijos.text.trim(),
                            ),
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question: '¿Que edades tienen sus hijos?'.tr(),
                              response: edadHijos.text.trim(),
                            ),
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question:
                                  '¿Qué tipo de estudios reciben sus hijos?'
                                      .tr(),
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
        ),
    };
  }

  @override
  bool get wantKeepAlive => true;
}

class _RecurrenteFormWidget extends StatefulWidget {
  final PageController pageController;
  const _RecurrenteFormWidget({required this.pageController});

  @override
  State<_RecurrenteFormWidget> createState() => _RecurrenteFormWidgetState();
}

class _RecurrenteFormWidgetState extends State<_RecurrenteFormWidget>
    with AutomaticKeepAliveClientMixin {
  final personasCargo = TextEditingController();
  final numeroHijos = TextEditingController();
  final edadHijos = TextEditingController();
  String? tipoEstudioHijos;
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
                'Descripción del entorno familiar.'.tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'Número de personas a cargo:*',
                textInputType: TextInputType.number,
                textEditingController: personasCargo,
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
                    context.read<RecurrenteEstandartCubit>().saveAnswers(
                          personasCargo:
                              int.tryParse(personasCargo.text.trim()),
                          numeroHijos: int.tryParse(numeroHijos.text.trim()),
                          edadHijos: numeroHijos.text.trim(),
                          tipoEstudioHijos: tipoEstudioHijos,
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
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

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/estandar/estandar_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_estandar/recurrente_estandart_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/button_actions_widget.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final solicitudesProvider =
          context.read<SolicitudesPendientesLocalDbCubit>();
      await solicitudesProvider.getDepartamentos();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cantidadHijos = context.read<KivaRouteCubit>().state.cantidadHijos;
    final localDbProvider = global<ObjectBoxService>();
    final items = localDbProvider.departmentsBox.getAll();
    final departmentos =
        items.map((e) => Item(name: e.nombre, value: e.valor)).toList();
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
                    steps: 5,
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
                      items: departmentos,
                      onChanged: (item) {
                        if (item == null) return;
                        objOrigenCatalogoValorId = item.value;
                        setState(() {});
                      },
                      toStringItem: (item) => item.name,
                      hintText: 'input.select_department'.tr(),
                    ),
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Cantidad de hijos:',
                    readOnly: true,
                    initialValue: cantidadHijos.toString(),
                  ),
                  if (cantidadHijos > 0) ...[
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
                  ],
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
                              edadHijos: edadHijos.text.trim(),
                              tipoEstudioHijos: tipoEstudioHijos ?? '',
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
    final cantidadHijos = context.read<KivaRouteCubit>().state.cantidadHijos;
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
                steps: 5,
                currentStep: 3,
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
                title: 'Cantidad de hijos:*',
                readOnly: true,
                initialValue: cantidadHijos.toString(),
              ),
              if (cantidadHijos > 0) ...[
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
              ],
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
                          edadHijos: numeroHijos.text.trim(),
                          tipoEstudioHijos: tipoEstudioHijos,
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
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

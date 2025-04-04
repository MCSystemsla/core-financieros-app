import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/mujer_emprende/mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_mujer_emprende/recurrente_mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
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
  final tiempoActividad = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
                  const Gap(20),
                  WhiteCard(
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
                      // isLoading: state.status == Status.inProgress,
                      title: 'forms.entorno_familiar.person_origin'.tr(),
                      items: departmentos,
                      onChanged: (item) {
                        if (item == null) return;
                        originItem = item.value;
                        setState(() {});
                      },
                      toStringItem: (item) => item.name,
                      hintText: 'input.select_department'.tr(),
                    ),
                  ),
                  CommentaryWidget(
                    title: 'Cantdad de hijos:',
                    readOnly: true,
                    initialValue: cantidadHijos.toString(),
                  ),
                  if (cantidadHijos > 0) ...[
                    CommentaryWidget(
                      title: '¿Que edades tienen sus hijos?',
                      textEditingController: question2,
                    ),
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
                          academicLevelItem = item;
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
                        context.read<MujerEmprendeCubit>().saveAnswers(
                              tipoSolicitud: context
                                  .read<KivaRouteCubit>()
                                  .state
                                  .tipoSolicitud,
                              otrosIngresos:
                                  otrosIngresosItem == 'input.yes'.tr(),
                              otrosIngresosDescripcion:
                                  otrosIngresosDescripcion.text.trim(),
                              objOrigenCatalogoValorId: originItem,
                              edadHijos: question2.text.trim(),
                              tipoEstudioHijos: academicLevelItem,
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
                              question: '¿Que edades tienen sus hijos?'.tr(),
                              response: question2.text.trim(),
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
  final tiempoActividad = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cantidadHijos = context.read<KivaRouteCubit>().state.cantidadHijos;
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
                    context.read<RecurrenteMujerEmprendeCubit>().saveAnswers(
                          tipoSolicitud: context
                              .read<KivaRouteCubit>()
                              .state
                              .tipoSolicitud,
                          otrosIngresos: otrosIngresos == 'input.yes'.tr(),
                          otrosIngresosDescripcion:
                              otrosIngresosDescripcion.text.trim(),
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

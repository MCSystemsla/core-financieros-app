import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/estandar/estandar_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_estandar/recurrente_estandart_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/dates_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/motivo_prestamo_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EstandarDescripciondelNegocio extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController pageController;
  const EstandarDescripciondelNegocio({
    super.key,
    required this.pageController,
    required this.isRecurrentForm,
  });

  @override
  State<EstandarDescripciondelNegocio> createState() =>
      _EstandarDescripciondelNegocioState();
}

class _EstandarDescripciondelNegocioState
    extends State<EstandarDescripciondelNegocio>
    with AutomaticKeepAliveClientMixin {
  late DateTime _selectedDate;
  String? apoyanNegocio;
  final publicitarNegocio = TextEditingController();
  final negocioProximosAnios = TextEditingController();
  String? coincideRespuesta;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _selectedDate = DateTime.now();
    super.initState();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      setState(() {});
    }
  }

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
                    'Descripción y desarrollo del negocio.'.tr(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Gap(20),
                  DatesWidget(
                    title: '¿Cuenténos cómo inició su negocio?*',
                    onSelectedDate: () => selectDate(context),
                    selectedDate: _selectedDate,
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
                          '¿Hay alguien que le apoye en su negocio? de ser positivo,?'
                              .tr(),
                      items: ['input.yes'.tr(), 'input.no'.tr()],
                      onChanged: (item) {
                        if (item == null) return;
                        coincideRespuesta = item;
                        setState(() {});
                      },
                      toStringItem: (item) {
                        return item;
                      },
                      hintText: 'input.select_option'.tr(),
                    ),
                  ),
                  const Gap(20),
                  if (coincideRespuesta == 'input.yes'.tr())
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
                        title: 'Favor responder cuántas personas'.tr(),
                        items: const [
                          '1 a 3',
                          '4 a 6',
                          '7 o mas',
                        ],
                        onChanged: (item) {
                          if (item == null) return;
                          apoyanNegocio = item;
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
                    title:
                        '¿En qué tipo de lugares le gustaría dar a conocer su producto? ¿Por qué?*',
                    textEditingController: publicitarNegocio,
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: '¿Cómo mira su negocio en los proximos años?*',
                    textEditingController: negocioProximosAnios,
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
                        context.read<EstandarCubit>().saveAnswers(
                              inicioNegocio: _selectedDate.toString(),
                              cuantosApoyan: apoyanNegocio,
                              publicitarNegocio: publicitarNegocio.text.trim(),
                              negocioProximosAnios:
                                  negocioProximosAnios.text.trim(),
                            );
                        context.read<ResponseCubit>().addResponses(
                          responses: [
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question: '¿Cuenténos cómo inició su negocio?*',
                              response: _selectedDate.formatDate(),
                            ),
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question:
                                  '¿Hay alguien que le apoye en su negocio? de ser positivo,?',
                              response: coincideRespuesta ?? 'N/A',
                            ),
                            if (coincideRespuesta == 'input.yes'.tr())
                              Response(
                                index: widget.pageController.page?.toInt() ?? 0,
                                question: 'Favor responder cuántas personas',
                                response: apoyanNegocio ?? 'N/A',
                              ),
                            Response(
                              index: widget.pageController.page?.toInt() ?? 0,
                              question:
                                  '¿Cómo mira su negocio en los proximos años?*',
                              response: negocioProximosAnios.text.trim(),
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
  const _RecurrentForm({required this.pageController});

  @override
  State<_RecurrentForm> createState() => _RecurrentFormState();
}

class _RecurrentFormState extends State<_RecurrentForm>
    with AutomaticKeepAliveClientMixin {
  String? decisionItem;
  final explicacionInversion = TextEditingController();
  String? apoyanNegocio;
  String? cuantosApoyan;
  final comoMejoroEntorno = TextEditingController();
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
                'Descripcíon del crédito anterior'.tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(20),
              const MotivoPrestamoWidget(),
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
                      '¿Coincide la respuesta del cliente con el formato anterior?'
                          .tr(),
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    decisionItem = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              if (decisionItem == 'input.no'.tr())
                CommentaryWidget(
                  textEditingController: explicacionInversion,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'input.input_validator'.tr();
                    }
                    return null;
                  },
                  title:
                      'Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                ),
              WhiteCard(
                padding: const EdgeInsets.all(5),
                child: JLuxDropdown(
                  isContainIcon: true,
                  validator: (value) {
                    if (value == null) return 'input.input_validator'.tr();
                    return null;
                  },
                  title: '¿Hay alguien que le apoye en su negocio?'.tr(),
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    apoyanNegocio = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              const Gap(20),
              if (apoyanNegocio == 'input.yes'.tr())
                WhiteCard(
                  padding: const EdgeInsets.all(5),
                  child: JLuxDropdown(
                    isContainIcon: true,
                    validator: (value) {
                      if (value == null) return 'input.input_validator'.tr();
                      return null;
                    },
                    title: 'De ser positivo, favor responder cuántas personas'
                        .tr(),
                    items: const [
                      '1 a 3',
                      '4 a 6',
                      '7 o mas',
                    ],
                    onChanged: (item) {
                      if (item == null) return;
                      cuantosApoyan = item;
                      setState(() {});
                    },
                    toStringItem: (item) {
                      return item;
                    },
                    hintText: 'input.select_option'.tr(),
                  ),
                ),
              CommentaryWidget(
                textEditingController: comoMejoroEntorno,
                title:
                    '¿Cómo este crédito ha constribuido a mejorar su calidad de vida y empoderarse de su negocio? Explique.',
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
                          coincideRespuesta: decisionItem == 'input.yes'.tr(),
                          explicacionInversion:
                              explicacionInversion.text.trim(),
                          apoyanNegocio: apoyanNegocio == 'input.yes'.tr(),
                          cuantosApoyan: cuantosApoyan,
                          comoMejoraEntorno: comoMejoroEntorno.text.trim(),
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question:
                              '¿Coincide la respuesta del cliente con el formato anterior?',
                          response: decisionItem ?? 'N/A',
                        ),
                        if (decisionItem == 'input.yes'.tr())
                          Response(
                            index: widget.pageController.page?.toInt() ?? 0,
                            question:
                                'Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                            response: explicacionInversion.text.trim(),
                          ),
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question: '¿Hay alguien que le apoye en su negocio?',
                          response: apoyanNegocio ?? 'N/A',
                        ),
                        if (apoyanNegocio == 'input.yes'.tr())
                          Response(
                            index: widget.pageController.page?.toInt() ?? 0,
                            question:
                                'De ser positivo, favor responder cuántas personas',
                            response: cuantosApoyan ?? 'N/A',
                          ),
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question:
                              '¿Cómo este crédito ha constribuido a mejorar su calidad de vida y empoderarse de su negocio? Explique.',
                          response: cuantosApoyan ?? 'N/A',
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

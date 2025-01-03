import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/migrantes_economicos/migrantes_economicos_cubit.dart';
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

import '../../../../bloc/recurrente_migrante_economico/recurrente_migrantes_economicos_cubit.dart';

class ImpactoSocialMigranteEconomico extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController controller;
  const ImpactoSocialMigranteEconomico({
    super.key,
    required this.controller,
    required this.isRecurrentForm,
  });

  @override
  State<ImpactoSocialMigranteEconomico> createState() =>
      _ImpactoSocialMigranteEconomicoState();
}

class _ImpactoSocialMigranteEconomicoState
    extends State<ImpactoSocialMigranteEconomico>
    with AutomaticKeepAliveClientMixin {
  final motivoPrestamo = TextEditingController();
  final piensaRegresar = TextEditingController();
  final propositosProximos = TextEditingController();
  final ayudaMejorarCondicionesExplicacion = TextEditingController();
  final otrosDatosCliente = TextEditingController();
  String? ayudaMejorarCondiciones;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return switch (widget.isRecurrentForm) {
      true => _RecurrentForm(controller: widget.controller),
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
                    currentStep: 2,
                  ),
                  const Gap(20),
                  Text(
                    'Impacto Social de Kiva (uso específico, objetivos, metas del préstamo).'
                        .tr(),
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                    title: '¿Para qué solicitó el crédito?'.tr(),
                    textEditingController: motivoPrestamo,
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
                          '¿Usted considera que esta nueva inversión le ayudará a mejorar sus condiciones de vida?'
                              .tr(),
                      items: ['input.yes'.tr(), 'input.no'.tr()],
                      onChanged: (item) {
                        if (item == null) return;
                        ayudaMejorarCondiciones = item;
                        setState(() {});
                      },
                      toStringItem: (item) {
                        return item;
                      },
                      hintText: 'input.select_option'.tr(),
                    ),
                  ),
                  if (ayudaMejorarCondiciones == 'input.yes'.tr())
                    CommentaryWidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                      title: 'Porque?'.tr(),
                      textEditingController: ayudaMejorarCondicionesExplicacion,
                    ),
                  CommentaryWidget(
                    textEditingController: propositosProximos,
                    title: '¿Cuáles son sus propósitos para los próximos años?',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    textEditingController: piensaRegresar,
                    title: '¿Piensa regresar a su país natal algún día?',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Otros datos relevantes e interesantes del cliente',
                    textEditingController: otrosDatosCliente,
                  ),
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
                              motivoPrestamo: motivoPrestamo.text.trim(),
                              ayudaMejorarCondiciones:
                                  ayudaMejorarCondiciones == 'input.yes'.tr(),
                              ayudaMejorarCondicionesExplicacion:
                                  ayudaMejorarCondicionesExplicacion.text
                                      .trim(),
                              propositosProximos:
                                  propositosProximos.text.trim(),
                              piensaRegresar: piensaRegresar.text.trim(),
                              otrosDatosCliente: otrosDatosCliente.text.trim(),
                            );
                        context.read<ResponseCubit>().addResponses(
                          responses: [
                            Response(
                              question: '¿Para qué solicitó el crédito?'.tr(),
                              response: motivoPrestamo.text.trim(),
                              index: widget.controller.page?.toInt() ?? 0,
                            ),
                            Response(
                              question:
                                  '¿Usted considera que esta nueva inversión le ayudará a mejorar sus condiciones de vida?'
                                      .tr(),
                              response: ayudaMejorarCondiciones ?? '',
                              index: widget.controller.page?.toInt() ?? 0,
                            ),
                            if (ayudaMejorarCondiciones == 'input.yes'.tr())
                              Response(
                                question: 'Porque?'.tr(),
                                response: ayudaMejorarCondicionesExplicacion
                                    .text
                                    .trim(),
                                index: widget.controller.page?.toInt() ?? 0,
                              ),
                            Response(
                              question:
                                  '¿Cuáles son sus propósitos para los próximos años?'
                                      .tr(),
                              response: propositosProximos.text.trim(),
                              index: widget.controller.page?.toInt() ?? 0,
                            ),
                            Response(
                              question:
                                  '¿Piensa regresar a su país natal algún día?'
                                      .tr(),
                              response: piensaRegresar.text.trim(),
                              index: widget.controller.page?.toInt() ?? 0,
                            ),
                            Response(
                              question:
                                  'Otros datos relevantes e interesantes del cliente'
                                      .tr(),
                              response: otrosDatosCliente.text.trim(),
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
  final motivoPrestamo = TextEditingController();
  final quienApoya = TextEditingController();
  final explicacionMejoraCondiciones = TextEditingController();
  final siguienteMeta = TextEditingController();
  String? mejoraCondiciones;
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
                currentStep: 2,
              ),
              const Gap(20),
              Text(
                'Impacto Social de Kiva (uso específico, objetivos, metas del préstamo).'
                    .tr(),
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              CommentaryWidget(
                textEditingController: motivoPrestamo,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
                title: '¿Para qué solicitó este nuevo crédito?',
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: quienApoya,
                title:
                    '¿Hay alguien que le esté apoyando en este nuevo préstamo? ',
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
                      '¿Usted considera que esta nueva inversión le ayudará a mejorar sus condiciones de vida?'
                          .tr(),
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    mejoraCondiciones = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              const Gap(20),
              if (mejoraCondiciones == 'input.yes'.tr())
                CommentaryWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'input.input_validator'.tr();
                    }
                    return null;
                  },
                  textEditingController: explicacionMejoraCondiciones,
                  title: '¿Por qué?',
                ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: siguienteMeta,
                title:
                    'Una vez finalizado este préstamo ¿Cuál sería su siguiente meta?',
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
                          motivoPrestamo: motivoPrestamo.text.trim(),
                          quienApoya: quienApoya.text.trim(),
                          mejoraCondiciones:
                              mejoraCondiciones == 'input.yes'.tr(),
                          explicacionMejoraCondiciones:
                              explicacionMejoraCondiciones.text.trim(),
                          siguienteMeta: siguienteMeta.text.trim(),
                          objSolicitudRecurrenteId: int.tryParse(
                            context.read<KivaRouteCubit>().state.solicitudId,
                          ),
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          question: '¿Para qué solicitó este nuevo crédito?',
                          response: motivoPrestamo.text.trim(),
                          index: widget.controller.page?.toInt() ?? 0,
                        ),
                        Response(
                          question:
                              '¿Hay alguien que le esté apoyando en este nuevo préstamo? '
                                  .tr(),
                          response: quienApoya.text.trim(),
                          index: widget.controller.page?.toInt() ?? 0,
                        ),
                        Response(
                          question:
                              '¿Usted considera que esta nueva inversión le ayudará a mejorar sus condiciones de vida?'
                                  .tr(),
                          response: mejoraCondiciones ?? 'N/A',
                          index: widget.controller.page?.toInt() ?? 0,
                        ),
                        if (mejoraCondiciones == 'input.yes'.tr())
                          Response(
                            question: '¿Por qué?',
                            response: explicacionMejoraCondiciones.text.trim(),
                            index: widget.controller.page?.toInt() ?? 0,
                          ),
                        Response(
                          question:
                              'Una vez finalizado este préstamo ¿Cuál sería su siguiente meta?'
                                  .tr(),
                          response: siguienteMeta.text.trim(),
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

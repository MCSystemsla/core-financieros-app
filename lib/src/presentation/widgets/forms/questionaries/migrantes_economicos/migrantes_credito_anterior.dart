import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/motivo_prestamo_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../bloc/kiva/recurrente_migrante_economico/recurrente_migrantes_economicos_cubit.dart';

class MigrantesCreditoAnterior extends StatefulWidget {
  final PageController controller;
  const MigrantesCreditoAnterior({
    super.key,
    required this.controller,
  });

  @override
  State<MigrantesCreditoAnterior> createState() =>
      _MigrantesCreditoAnteriorState();
}

class _MigrantesCreditoAnteriorState extends State<MigrantesCreditoAnterior> {
  final formKey = GlobalKey<FormState>();
  String? coincideRespuesta;
  String? apoyanNegocio;
  String? cuantosApoyan;
  final explicacionInversion = TextEditingController();
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
                'Descripcíon del crédito anterior'.tr(),
                textAlign: TextAlign.justify,
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
                    coincideRespuesta = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              if (coincideRespuesta == 'input.no'.tr())
                CommentaryWidget(
                  validator: (value) {
                    if (value.isEmpty || value == null) {
                      return 'input.input_validator'.tr();
                    }

                    return null;
                  },
                  textEditingController: explicacionInversion,
                  title:
                      'Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
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
                    title:
                        'De ser positivo, favor responder cuántas personas.       '
                            .tr(),
                    items: [
                      '1 a 3'.tr(),
                      '4 a 6'.tr(),
                      '7 o más'.tr(),
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
                          coincideRespuesta:
                              coincideRespuesta == 'input.yes'.tr(),
                          apoyanNegocio: apoyanNegocio == 'input.yes'.tr(),
                          cuantosApoyan: cuantosApoyan,
                          explicacionInversion:
                              explicacionInversion.text.trim(),
                        );

                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                            question:
                                '¿Coincide la respuesta del cliente con el formato anterior?',
                            response: coincideRespuesta ?? 'N/A',
                            index: widget.controller.page?.toInt() ?? 0),
                        Response(
                            question:
                                'Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                            response: explicacionInversion.text.trim(),
                            index: widget.controller.page?.toInt() ?? 0),
                        Response(
                            question:
                                '¿Hay alguien que le apoye en su negocio?',
                            response: apoyanNegocio ?? 'N/A',
                            index: widget.controller.page?.toInt() ?? 0),
                        Response(
                            question:
                                'De ser positivo, favor responder cuántas personas.',
                            response: cuantosApoyan ?? 'N/A',
                            index: widget.controller.page?.toInt() ?? 0),
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

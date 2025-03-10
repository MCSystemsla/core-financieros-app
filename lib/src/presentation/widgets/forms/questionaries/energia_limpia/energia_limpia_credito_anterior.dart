import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
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

class EnergiaLimpiaCreditoAnterior extends StatefulWidget {
  final PageController pageController;
  const EnergiaLimpiaCreditoAnterior({
    super.key,
    required this.pageController,
  });

  @override
  State<EnergiaLimpiaCreditoAnterior> createState() =>
      _EnergiaLimpiaCreditoAnteriorState();
}

class _EnergiaLimpiaCreditoAnteriorState
    extends State<EnergiaLimpiaCreditoAnterior>
    with AutomaticKeepAliveClientMixin {
  String? coincideRespuesta;
  final explicacionInversion = TextEditingController();
  final situacionAntesAhora = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final motivoAnterior = context.read<KivaRouteCubit>().state.motivoAnterior;
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
              Text(motivoAnterior),
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
                    if (value == null || value.isEmpty) {
                      return 'input.input_validator'.tr();
                    }
                    return null;
                  },
                  title:
                      '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                  textEditingController: explicacionInversion,
                ),
              const Gap(20),
              CommentaryWidget(
                title:
                    '¿Cómo era su situación antes de adquirir esta solución energética y cómo es ahora ?',
                textEditingController: situacionAntesAhora,
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
                    context.read<RecurrenteEnergiaLimpiaCubit>().saveAnswer3(
                          coincideRespuesta:
                              coincideRespuesta == 'input.yes'.tr(),
                          explicacionInversion:
                              explicacionInversion.text.trim(),
                          situacionAntesAhora: situacionAntesAhora.text.trim(),
                        );

                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          index: 3,
                          question:
                              '¿Coincide la respuesta del cliente con el formato anterior?',
                          response: coincideRespuesta ?? 'N/A',
                        ),
                        if (coincideRespuesta == 'input.no'.tr())
                          Response(
                            index: 3,
                            question:
                                '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                            response: explicacionInversion.text.trim(),
                          ),
                        Response(
                          index: 3,
                          question:
                              '¿Cómo era su situación antes de adquirir esta solución energética y cómo es ahora ?',
                          response: situacionAntesAhora.text.trim(),
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

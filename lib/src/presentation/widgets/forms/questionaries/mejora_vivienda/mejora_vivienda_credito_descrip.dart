import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_,mejora_vivienda.dart/recurrente_mejora_vivienda_cubit.dart';
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

class MejoraViviendaCreditoDescrip extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController pageController;
  const MejoraViviendaCreditoDescrip({
    super.key,
    required this.pageController,
    required this.isRecurrentForm,
  });

  @override
  State<MejoraViviendaCreditoDescrip> createState() =>
      _MejoraViviendaCreditoDescripState();
}

class _MejoraViviendaCreditoDescripState
    extends State<MejoraViviendaCreditoDescrip>
    with AutomaticKeepAliveClientMixin {
  final question1 = TextEditingController();
  String? question2;
  final isNotCoincideResponse = TextEditingController();
  final viviendaAntesyDespuesController = TextEditingController();
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
                steps: 5,
                currentStep: 3,
              ),
              const Gap(20),
              Text(
                'Descripción del crédito anterior Mejora de Vivienda'.tr(),
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
                    question2 = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              const Gap(20),
              if (question2 == 'input.no'.tr())
                CommentaryWidget(
                  textEditingController: isNotCoincideResponse,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'input.input_validator'.tr();
                    }
                    return null;
                  },
                  title:
                      '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                ),
              const Gap(20),
              CommentaryWidget(
                title:
                    '¿Cómo era su vivienda anteriormente y describa como está ahora?',
                textEditingController: viviendaAntesyDespuesController,
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
                    context.read<RecurrenteMejoraViviendaCubit>().saveAnswers2(
                          coincideRespuesta: question2 == 'input.yes'.tr(),
                          explicacionInversion:
                              isNotCoincideResponse.text.trim(),
                          viviendaAntesDespues:
                              viviendaAntesyDespuesController.text.trim(),
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          index: widget.isRecurrentForm ? 3 : 0,
                          question:
                              '¿Coincide la respuesta del cliente con el formato anterior?',
                          response: question2 ?? 'N/A',
                        ),
                        if (question2 == 'input.no'.tr())
                          Response(
                            index: widget.isRecurrentForm ? 3 : 0,
                            question:
                                '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                            response: isNotCoincideResponse.text.trim(),
                          ),
                        Response(
                          index: widget.isRecurrentForm ? 3 : 0,
                          question:
                              '¿Cómo era su vivienda anteriormente y describa como está ahora?',
                          response: isNotCoincideResponse.text.trim(),
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

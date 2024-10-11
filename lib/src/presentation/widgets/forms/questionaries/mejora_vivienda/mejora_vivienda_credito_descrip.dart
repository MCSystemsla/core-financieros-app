import 'package:core_financiero_app/src/presentation/bloc/recurrente_,mejora_vivienda.dart/recurrente_mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MejoraViviendaCreditoDescrip extends StatefulWidget {
  final PageController pageController;
  const MejoraViviendaCreditoDescrip({
    super.key,
    required this.pageController,
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
              CommentaryWidget(
                textEditingController: question1,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'input.input_validator'.tr();
                  // }

                  return null;
                },
                title:
                    '¿Para que utilizó el crédito anterior ?* (autorellenará con la respuesta del crédito anterior)',
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
                  title:
                      '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                ),
              const Gap(20),
              const CommentaryWidget(
                title:
                    '¿Cómo era su vivienda anteriormente y describa como está ahora?',
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

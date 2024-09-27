import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MujerEmprendeImpactoSocial extends StatefulWidget {
  final PageController pageController;
  final bool isRecurrentForm;
  const MujerEmprendeImpactoSocial({
    super.key,
    required this.pageController,
    required this.isRecurrentForm,
  });

  @override
  State<MujerEmprendeImpactoSocial> createState() =>
      _MujerEmprendeImpactoSocialState();
}

class _MujerEmprendeImpactoSocialState
    extends State<MujerEmprendeImpactoSocial> {
  final question1 = TextEditingController();
  final question2 = TextEditingController();
  final question3 = TextEditingController();
  final question4 = TextEditingController();
  final question5 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return switch (widget.isRecurrentForm) {
      true => _RecurrentForm(
          pageController: widget.pageController,
        ),
      false => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const MiCreditoProgress(
                  steps: 5,
                  currentStep: 3,
                ),
                const Gap(20),
                Text(
                  'Impacto Social de Kiva ( Uso específico, objetivos, metas del préstamo)'
                      .tr(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const Gap(20),
                CommentaryWidget(
                  title: '¿Para qué solicitó este préstamo?* Explique',
                  textEditingController: question1,
                ),
                const Gap(20),
                CommentaryWidget(
                  title:
                      '¿Quién o quiénes le estarían apoyando en su emprendimiento?*',
                  textEditingController: question2,
                ),
                const Gap(20),
                CommentaryWidget(
                  title:
                      '¿De qué manera este financiamiento va impactar en su negocio ?*',
                  textEditingController: question3,
                ),
                const Gap(20),
                CommentaryWidget(
                  title:
                      '¿Cómo cree usted que este crédito va a mejorar su calidad de vida?*',
                  textEditingController: question4,
                ),
                const Gap(20),
                CommentaryWidget(
                  title: 'Otros datos relevantes e interesantes del cliente',
                  textEditingController: question5,
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
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          question:
                              '¿Para qué solicitó este préstamo?* Explique',
                          response: question1.text.trim(),
                        ),
                        Response(
                          question:
                              '¿Quién o quiénes le estarían apoyando en su emprendimiento?*',
                          response: question2.text.trim(),
                        ),
                        Response(
                          question:
                              '¿De qué manera este financiamiento va impactar en su negocio ?*',
                          response: question3.text.trim(),
                        ),
                        Response(
                          question:
                              '¿Cómo cree usted que este crédito va a mejorar su calidad de vida?*',
                          response: question4.text.trim(),
                        ),
                        Response(
                          question:
                              'Otros datos relevantes e interesantes del cliente',
                          response: question5.text.trim(),
                        ),
                      ],
                    );
                    widget.pageController.nextPage(
                      duration: const Duration(
                        milliseconds: 350,
                      ),
                      curve: Curves.easeIn,
                    );
                  },
                  previousTitle: 'button.previous'.tr(),
                  nextTitle: 'button.next'.tr(),
                ),
                const Gap(10),
              ],
            ),
          ),
        )
    };
  }
}

class _RecurrentForm extends StatefulWidget {
  final PageController pageController;
  const _RecurrentForm({required this.pageController});

  @override
  State<_RecurrentForm> createState() => _RecurrentFormState();
}

class _RecurrentFormState extends State<_RecurrentForm>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 5,
              currentStep: 3,
            ),
            const Gap(20),
            Text(
              'Impacto Social de Kiva ( Uso específico, objetivos, metas del préstamo)'
                  .tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(20),
            const CommentaryWidget(
              title:
                  '¿En qué piensa invertir este nuevo préstamo de Mujer Emprende?* Explique',
            ),
            const Gap(20),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title:
                    '¿Hay alguien que le apoye en su negocio? de ser positivo, favor responder cuántas personas'
                        .tr(),
                items: const ['1 a 3', '4 a 6', '7 o mas'],
                onChanged: (item) {
                  if (item == null) return;
                },
                toStringItem: (item) => item,
                hintText: 'input.select_option'.tr(),
              ),
            ),
            const Gap(20),
            const CommentaryWidget(
              title:
                  '¿Considera usted que este nuevo préstamo fortalezca su negocio, mejore sus condiciones de vida y entorno familiar? ¿Porqué?* ',
            ),
            const Gap(20),
            const CommentaryWidget(
              title: 'A futuro ¿Cuál sería su siguiente paso?',
            ),
            const Gap(20),
            const CommentaryWidget(
              title:
                  '¿Cree usted que una vez finalizado el pago de este préstamo de Mujer Emprende alcanzó su meta? ¿Por qué?*',
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
                widget.pageController.nextPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              previousTitle: 'button.previous'.tr(),
              nextTitle: 'button.next'.tr(),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

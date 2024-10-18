import 'package:core_financiero_app/src/presentation/bloc/mujer_emprende/mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_mujer_emprende/recurrente_mujer_emprende_cubit.dart';
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
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return switch (widget.isRecurrentForm) {
      true => _RecurrentForm(
          pageController: widget.pageController,
        ),
      false => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title:
                        '¿Quién o quiénes le estarían apoyando en su emprendimiento?*',
                    textEditingController: question2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title:
                        '¿De qué manera este financiamiento va impactar en su negocio ?*',
                    textEditingController: question3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title:
                        '¿Cómo cree usted que este crédito va a mejorar su calidad de vida?*',
                    textEditingController: question4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
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
                      if (formKey.currentState?.validate() ?? false) {
                        context.read<MujerEmprendeCubit>().saveAnswers(
                              motivoPrestamo: question1.text.trim(),
                              quienApoya: question2.text.trim(),
                              comoImpactariaNegocio: question3.text.trim(),
                              comoMejoraCalidadVida: question4.text.trim(),
                              otrosDatosCliente: question5.text.trim(),
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
  final motivoPrestamo = TextEditingController();
  final mejoraEntornoExplicacion = TextEditingController();
  final siguientePaso = TextEditingController();
  final alcanzaraMetaExplicacion = TextEditingController();
  String? apoyanNegocio;
  String? cuantosApoyan;
  String? mejoraraEntorno;
  String? alcanzaraMeta;
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
            CommentaryWidget(
              textEditingController: motivoPrestamo,
              title:
                  '¿En qué piensa invertir este nuevo préstamo de Mujer Emprende?* Explique',
            ),
            const Gap(20),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title: '¿Hay alguien que le apoye en su negocio?'.tr(),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  apoyanNegocio = item;
                  setState(() {});
                },
                toStringItem: (item) => item,
                hintText: 'input.select_option'.tr(),
              ),
            ),
            if (apoyanNegocio == 'input.yes'.tr())
              WhiteCard(
                marginTop: 15,
                padding: const EdgeInsets.all(10),
                child: JLuxDropdown(
                  isContainIcon: true,
                  title:
                      'De ser positivo, favor responder cuántas personas'.tr(),
                  items: const ['1 a 3', '4 a 6', '7 o mas'],
                  onChanged: (item) {
                    if (item == null) return;
                    cuantosApoyan = item;
                    setState(() {});
                  },
                  toStringItem: (item) => item,
                  hintText: 'input.select_option'.tr(),
                ),
              ),
            const Gap(20),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title:
                    '¿Considera usted que este nuevo préstamo fortalezca su negocio, mejore sus condiciones de vida y entorno familiar?'
                        .tr(),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  mejoraraEntorno = item;
                  setState(() {});
                },
                toStringItem: (item) => item,
                hintText: 'input.select_option'.tr(),
              ),
            ),
            const Gap(20),
            CommentaryWidget(
              title: '¿Porqué?*',
              textEditingController: mejoraEntornoExplicacion,
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'A futuro ¿Cuál sería su siguiente paso?',
              textEditingController: siguientePaso,
            ),
            const Gap(20),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title:
                    '¿Cree usted que una vez finalizado el pago de este préstamo de Mujer Emprende alcanzó su meta?'
                        .tr(),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  alcanzaraMeta = item;
                  setState(() {});
                },
                toStringItem: (item) => item,
                hintText: 'input.select_option'.tr(),
              ),
            ),
            CommentaryWidget(
              title: '¿Por qué?*',
              textEditingController: alcanzaraMetaExplicacion,
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
                context.read<RecurrenteMujerEmprendeCubit>().saveAnswers(
                      apoyanNegocio: apoyanNegocio == 'input.yes'.tr(),
                      cuantosApoyan: int.tryParse(cuantosApoyan!),
                      motivoPrestamo: motivoPrestamo.text.trim(),
                      mejoraraEntorno: mejoraraEntorno == 'input.yes'.tr(),
                      mejoraraEntornoExplicacion:
                          mejoraEntornoExplicacion.text.trim(),
                      siguientePaso: siguientePaso.text.trim(),
                      alcanzaraMeta: alcanzaraMeta == 'input.yes'.tr(),
                      explicacionAlcanzaraMeta:
                          alcanzaraMetaExplicacion.text.trim(),
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}

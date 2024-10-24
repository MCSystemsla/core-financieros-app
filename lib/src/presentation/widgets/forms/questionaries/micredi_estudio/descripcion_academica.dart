import 'package:core_financiero_app/src/presentation/bloc/micredi_estudio/micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_micredi_estudio/recurrente_micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DescripcionAcademica extends StatefulWidget {
  final PageController pageController;
  final bool isRecurrentForm;
  const DescripcionAcademica(
      {super.key, required this.pageController, required this.isRecurrentForm});

  @override
  State<DescripcionAcademica> createState() => _DescripcionAcademicaState();
}

class _DescripcionAcademicaState extends State<DescripcionAcademica> {
  final carrera = TextEditingController();
  final universidad = TextEditingController();
  final tiempoCarreras = TextEditingController();
  final motivoCarrera = TextEditingController();
  final explicacionRelizandoProfesionalmente = TextEditingController();
  final quienApoya = TextEditingController();
  final ocupacionPadres = TextEditingController();
  String? relizandoProfesionalmente;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return switch (widget.isRecurrentForm) {
      true => _RecurrentForm(
          pageController: widget.pageController,
        ),
      false => Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MiCreditoProgress(
                    steps: 5,
                    currentStep: 2,
                  ),
                  const Gap(20),
                  Text(
                    'Descripcion Academica'.tr(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Carrera: ',
                    textEditingController: carrera,
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Universidad a la que pertenece:',
                    textEditingController: universidad,
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Años de la carrera:',
                    textEditingController: tiempoCarreras,
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: '¿Qué te motivó a elegir esa carrera?',
                    textEditingController: motivoCarrera,
                  ),
                  const Gap(20),
                  WhiteCard(
                    marginTop: 15,
                    padding: const EdgeInsets.all(10),
                    child: JLuxDropdown(
                      isContainIcon: true,
                      title:
                          '¿Sentís que te estás realizando profesionalmente?*'
                              .tr(),
                      items: ['input.yes'.tr(), 'input.no'.tr()],
                      onChanged: (item) {
                        if (item == null) return;
                        relizandoProfesionalmente = item;
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null) return 'input.input_validator'.tr();
                        return null;
                      },
                      toStringItem: (item) => item,
                      hintText: 'input.select_option'.tr(),
                    ),
                  ),
                  if (relizandoProfesionalmente == 'input.yes'.tr())
                    CommentaryWidget(
                      title: 'Por que?',
                      textEditingController:
                          explicacionRelizandoProfesionalmente,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                    ),
                  const Gap(20),
                  CommentaryWidget(
                    title: '¿Quién o quiénes te apoyan en tus estudios?*',
                    textEditingController: quienApoya,
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
                        '¿En qué trabaja o qué negocio tienen tus padres o tutores?*',
                    textEditingController: ocupacionPadres,
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
                        context.read<MicrediEstudioCubit>().saveAnswers(
                              carrera: carrera.text.trim(),
                              tiempoCarrera:
                                  int.tryParse(tiempoCarreras.text.trim()),
                              universidad: universidad.text.trim(),
                              motivoCarrera: motivoCarrera.text.trim(),
                              relizandoProfesionalmente:
                                  relizandoProfesionalmente == 'input.yes'.tr(),
                              explicacionRelizandoProfesionalmente:
                                  explicacionRelizandoProfesionalmente.text
                                      .trim(),
                              quienApoya: quienApoya.text.trim(),
                              ocupacionPadres: ocupacionPadres.text.trim(),
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
}

class _RecurrentForm extends StatefulWidget {
  final PageController pageController;
  const _RecurrentForm({
    required this.pageController,
  });

  @override
  State<_RecurrentForm> createState() => _RecurrentFormState();
}

class _RecurrentFormState extends State<_RecurrentForm> {
  final carrera = TextEditingController();
  final tiempoCarrera = TextEditingController();
  final universidad = TextEditingController();
  final quienApoya = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 5,
              currentStep: 2,
            ),
            const Gap(20),
            Text(
              'Descripcion Academica'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'Carrera: ',
              textEditingController: carrera,
            ),
            const Gap(20),
            CommentaryWidget(
              title: 'Años de la carrera:',
              textEditingController: tiempoCarrera,
            ),
            const Gap(20),
            CommentaryWidget(
              textEditingController: universidad,
              title: 'Universidad a la que pertenece',
            ),
            const Gap(20),
            CommentaryWidget(
              textEditingController: quienApoya,
              title:
                  '¿Quién o quiénes le estarían apoyando en esta nueva etapa?*',
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
                context.read<RecurrenteMicrediEstudioCubit>().saveAnswers(
                      carrera: carrera.text.trim(),
                      tiempoCarrera: int.tryParse(tiempoCarrera.text.trim()),
                      universidad: universidad.text.trim(),
                      quienApoya: quienApoya.text.trim(),
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
}

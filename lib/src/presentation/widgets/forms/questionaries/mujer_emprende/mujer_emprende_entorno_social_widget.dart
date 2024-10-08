import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
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
  String? otrosIngresosItem;
  String? originItem;
  String? academicLevelItem;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return switch (widget.isRecurrentForm) {
      true => _RecurrentForm(
          pageController: widget.pageController,
        ),
      false => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
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
                const Gap(20),
                BlocBuilder<DepartamentosCubit, DepartamentosState>(
                  builder: (context, state) {
                    return WhiteCard(
                      marginTop: 15,
                      padding: const EdgeInsets.all(10),
                      child: JLuxDropdown(
                        isContainIcon: true,
                        isLoading: state.status == Status.inProgress,
                        title: 'forms.entorno_familiar.person_origin'.tr(),
                        items: state.departamentos,
                        onChanged: (item) {
                          if (item == null) return;
                          originItem = item.nombre;
                          setState(() {});
                        },
                        toStringItem: (item) => item.nombre,
                        hintText: 'input.select_department'.tr(),
                      ),
                    );
                  },
                ),
                CommentaryWidget(
                  title: 'Número de personas a cargo:*',
                  textEditingController: question1,
                ),
                CommentaryWidget(
                  title: '¿Que edades tienen sus hijos?',
                  textEditingController: question2,
                ),
                CommentaryWidget(
                  title: 'Número de hijos:*',
                  textEditingController: question3,
                ),
                WhiteCard(
                  padding: const EdgeInsets.all(5),
                  child: JLuxDropdown(
                    isContainIcon: true,
                    validator: (value) {
                      if (value == null) return 'input.input_validator'.tr();
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
                          question: '¿Tiene otros ingresos?¿Cuales?*'.tr(),
                          response: otrosIngresosItem!,
                        ),
                        Response(
                          question: 'forms.entorno_familiar.person_origin'.tr(),
                          response: originItem!,
                        ),
                        Response(
                          question: 'Número de personas a cargo:*'.tr(),
                          response: question1.text.trim(),
                        ),
                        Response(
                          question: '¿Que edades tienen sus hijos?'.tr(),
                          response: question2.text.trim(),
                        ),
                        Response(
                          question: 'Número de hijos:*'.tr(),
                          response: question3.text.trim(),
                        ),
                        Response(
                          question:
                              '¿Qué tipo de estudios reciben sus hijos?'.tr(),
                          response: academicLevelItem!,
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

class _RecurrentFormState extends State<_RecurrentForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
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
                  setState(() {});
                },
                toStringItem: (item) {
                  return item;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
            const Gap(20),
            const CommentaryWidget(title: 'Número de personas a cargo:*'),
            const Gap(20),
            const CommentaryWidget(title: 'Número de hijos:*'),
            const Gap(20),
            const CommentaryWidget(title: '¿Que edades tienen sus hijos? '),
            WhiteCard(
              padding: const EdgeInsets.all(5),
              child: JLuxDropdown(
                isContainIcon: true,
                validator: (value) {
                  if (value == null) return 'input.input_validator'.tr();
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
}

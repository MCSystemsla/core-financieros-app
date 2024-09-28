import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
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

class EntornoSocialWidget extends StatefulWidget {
  final PageController controller;
  final bool isRecurrentForm;
  const EntornoSocialWidget(
      {super.key, required this.controller, required this.isRecurrentForm});

  @override
  State<EntornoSocialWidget> createState() => _EntornoSocialWidgetState();
}

class _EntornoSocialWidgetState extends State<EntornoSocialWidget>
    with AutomaticKeepAliveClientMixin {
  String? personOrigin;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final question2Controller = TextEditingController();
    final question3Controller = TextEditingController();
    return switch (widget.isRecurrentForm) {
      true => _RecurrentForm(
          controller: widget.controller,
        ),
      false => SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MiCreditoProgress(
                  steps: 5,
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
                  marginTop: 15,
                  padding: const EdgeInsets.all(10),
                  child: JLuxDropdown(
                    isContainIcon: true,
                    title: '¿Tiene algún trabajo o negocio? ¿Cuál?'.tr(),
                    items: const ['Si', 'No'],
                    onChanged: (item) {
                      if (item == null) return;
                    },
                    toStringItem: (item) => item,
                    hintText: 'input.select_option'.tr(),
                  ),
                ),
                const Gap(10),
                const CommentaryWidget(
                    title: 'Tiempo de la actividad (meses o años)'),
                const Gap(10),
                WhiteCard(
                  marginTop: 15,
                  padding: const EdgeInsets.all(10),
                  child: JLuxDropdown(
                    isContainIcon: true,
                    title: '¿Tiene otros ingresos?¿Cuales?*'.tr(),
                    items: const ['Si', 'No'],
                    onChanged: (item) {
                      if (item == null) return;
                    },
                    toStringItem: (item) => item,
                    hintText: 'input.select_option'.tr(),
                  ),
                ),
                const Gap(10),
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
                          personOrigin = item.nombre;
                        },
                        toStringItem: (item) => item.nombre,
                        hintText: 'input.select_department'.tr(),
                      ),
                    );
                  },
                ),
                const Gap(10),
                const CommentaryWidget(title: 'Número de personas a cargo:*'),
                const Gap(10),
                const CommentaryWidget(title: 'Numero de Hijos'),
                const Gap(10),
                CommentaryWidget(
                  title: 'forms.entorno_familiar.childs_age'.tr(),
                  textEditingController: question2Controller,
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
                    },
                    toStringItem: (item) {
                      return item;
                    },
                    hintText: 'input.select_option'.tr(),
                  ),
                ),
                const Gap(15),
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
                    widget.controller.nextPage(
                      duration: const Duration(
                        milliseconds: 350,
                      ),
                      curve: Curves.easeIn,
                    );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          question: 'forms.entorno_familiar.person_origin'.tr(),
                          response: personOrigin!,
                        ),
                        Response(
                          question: 'forms.entorno_familiar.childs_age'.tr(),
                          response: question2Controller.text.trim(),
                        ),
                        Response(
                          question:
                              'forms.entorno_familiar.childs_education'.tr(),
                          response: question3Controller.text.trim(),
                        ),
                      ],
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
  final PageController controller;
  const _RecurrentForm({required this.controller});

  @override
  State<_RecurrentForm> createState() => _RecurrentFormState();
}

class _RecurrentFormState extends State<_RecurrentForm> {
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
              'forms.entorno_familiar.title'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(10),
            const CommentaryWidget(
              title: 'Número de personas a cargo:*',
            ),
            const Gap(10),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title: '¿Tiene algún trabajo o negocio? ¿Cuál?'.tr(),
                items: const ['Si', 'No'],
                onChanged: (item) {
                  if (item == null) return;
                },
                toStringItem: (item) => item,
                hintText: 'input.select_option'.tr(),
              ),
            ),
            const CommentaryWidget(
              title: 'Tiempo de la actividad (meses o años):*',
            ),
            const Gap(10),
            WhiteCard(
              marginTop: 15,
              padding: const EdgeInsets.all(10),
              child: JLuxDropdown(
                isContainIcon: true,
                title: '¿Tiene otros ingresos?¿Cuales?*'.tr(),
                items: const ['Si', 'No'],
                onChanged: (item) {
                  if (item == null) return;
                },
                toStringItem: (item) => item,
                hintText: 'input.select_option'.tr(),
              ),
            ),
            const Gap(10),
            const CommentaryWidget(title: 'Número de hijos:*'),
            const Gap(10),
            const CommentaryWidget(title: '¿Que edades tienen sus hijos?'),
            const Gap(10),
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
                },
                toStringItem: (item) {
                  return item;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
            const Gap(15),
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
                widget.controller.nextPage(
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

import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/button_actions_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../domain/entities/responses.dart';

class MetasYAspiracionesWidget extends StatefulWidget {
  final PageController controller;
  const MetasYAspiracionesWidget({super.key, required this.controller});

  @override
  State<MetasYAspiracionesWidget> createState() =>
      _MetasYAspiracionesWidgetState();
}

class _MetasYAspiracionesWidgetState extends State<MetasYAspiracionesWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final question1Controller = TextEditingController();
    final question2Controller = TextEditingController();

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 5,
              currentStep: 5,
            ),
            const Gap(20),
            Text(
              'forms.metas_y_aspiraciones.title'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(10),
            CommentaryWidget(
              textEditingController: question1Controller,
              title: 'forms.metas_y_aspiraciones.question1'.tr(),
            ),
            const Gap(10),
            CommentaryWidget(
              textEditingController: question2Controller,
              title: 'forms.metas_y_aspiraciones.question2'.tr(),
            ),
            const Gap(10),
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
                context.read<ResponseCubit>().addResponses(
                  responses: [
                    Response(
                      question: 'forms.metas_y_aspiraciones.question1'.tr(),
                      response: question1Controller.text.trim(),
                      index: 1,
                    ),
                    Response(
                        question: 'forms.metas_y_aspiraciones.question2'.tr(),
                        response: question2Controller.text.trim(),
                        index: 1),
                  ],
                );
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

  @override
  bool get wantKeepAlive => true;
}

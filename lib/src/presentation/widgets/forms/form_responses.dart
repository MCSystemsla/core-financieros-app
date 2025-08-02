import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/button_actions_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class FormResponses extends StatefulWidget {
  final PageController controller;
  const FormResponses({
    super.key,
    required this.controller,
  });

  @override
  State<FormResponses> createState() => _FormResponsesState();
}

class _FormResponsesState extends State<FormResponses> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              'input.form_response'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(15),
            BlocBuilder<ResponseCubit, ResponseState>(
              builder: (context, state) {
                return ListView.separated(
                  itemCount: state.responses.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return const Gap(20);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return _ResponseWidget(
                      response: state.responses[index],
                      controller: widget.controller,
                    );
                  },
                );
              },
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
                widget.controller.nextPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              previousTitle: 'button.previous'.tr(),
              nextTitle: 'button.signed'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResponseWidget extends StatefulWidget {
  final PageController controller;
  final Response response;
  const _ResponseWidget({required this.response, required this.controller});

  @override
  State<_ResponseWidget> createState() => _ResponseWidgetState();
}

class _ResponseWidgetState extends State<_ResponseWidget> {
  bool onEditAnswer = false;
  final answerController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? responseEditedAnswer;

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 250,
                  ),
                  child: Text(
                    widget.response.question,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    // onEditAnswer = !onEditAnswer;
                    widget.controller.animateToPage(
                      widget.response.index,
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeIn,
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: AppColors.getPrimaryColor(),
                  ),
                ),
              ],
            ),
            const Gap(20),
            Text(
              widget.response.response,
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
            if (onEditAnswer)
              CommentaryWidget(
                marginTop: 2,
                initialValue: widget.response.response,
                title: '',
                // textEditingController: answerController,
                onChange: (value) {
                  responseEditedAnswer = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
            if (onEditAnswer)
              CustomElevatedButton(
                text: 'Guardar',
                color: AppColors.getPrimaryColor(),
                onPressed: () {
                  context.read<ResponseCubit>().addResponses(
                    responses: [
                      Response(
                        question: widget.response.question,
                        response: responseEditedAnswer!,
                        index: 1,
                      ),
                    ],
                  );
                  onEditAnswer = !onEditAnswer;
                  setState(() {});
                },
              ),
          ],
        ),
      ),
    );
  }
}

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

class MiCreditoEstudioScreen extends StatelessWidget {
  const MiCreditoEstudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return BlocProvider(
      create: (ctx) => ResponseCubit(),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('MiCredi Estudio'.tr()),
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              SaneamientoContent(
                controller: pageController,
              ),
              _EntornoSocialEstudioWidget(
                controller: pageController,
              ),
              _ImpactoSocialCrediEstudioWidget(
                controller: pageController,
              ),
              FormResponses(controller: pageController),
              const SignQuestionaryWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EntornoSocialEstudioWidget extends StatefulWidget {
  final PageController controller;
  const _EntornoSocialEstudioWidget({
    required this.controller,
  });

  @override
  State<_EntornoSocialEstudioWidget> createState() =>
      _EntornoSocialEstudioWidgetState();
}

class _EntornoSocialEstudioWidgetState
    extends State<_EntornoSocialEstudioWidget>
    with AutomaticKeepAliveClientMixin {
  String? itemSelected;
  final question1Controller = TextEditingController();
  final question2Controller = TextEditingController();
  final question3Controller = TextEditingController();
  final question4Controller = TextEditingController();
  final question5Controller = TextEditingController();
  final question6Controller = TextEditingController();
  final question7Controller = TextEditingController();
  final questio8Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
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
            CommentaryWidget(
              title: 'forms.entorno_familiar.person_origin'.tr(),
              textEditingController: question1Controller,
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.entorno_familiar.childs_age'.tr(),
              textEditingController: question2Controller,
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.entorno_familiar.childs_education'.tr(),
              textEditingController: question3Controller,
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.entorno_familiar.question1'.tr(),
              textEditingController: question4Controller,
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.entorno_familiar.question2'.tr(),
              textEditingController: question5Controller,
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.entorno_familiar.question3'.tr(),
              textEditingController: question6Controller,
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.entorno_familiar.question4'.tr(),
              textEditingController: question7Controller,
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
                title: 'forms.entorno_familiar.question5'.tr(),
                items: ['input.yes'.tr(), 'input.no'.tr()],
                onChanged: (item) {
                  if (item == null) return;
                  setState(() {
                    itemSelected = item;
                  });
                },
                toStringItem: (item) {
                  return item;
                },
                hintText: 'input.select_option'.tr(),
              ),
            ),
            const Gap(20),
            if (itemSelected == 'Si')
              CommentaryWidget(
                title: 'forms.entorno_familiar.question6'.tr(),
                textEditingController: questio8Controller,
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
                context.read<ResponseCubit>().addResponses(
                  responses: [
                    Response(
                      question: 'forms.entorno_familiar.person_origin'.tr(),
                      response: question1Controller.text.trim(),
                    ),
                    Response(
                      question: 'forms.entorno_familiar.childs_age'.tr(),
                      response: question2Controller.text.trim(),
                    ),
                    Response(
                      question: 'forms.entorno_familiar.childs_education'.tr(),
                      response: question3Controller.text.trim(),
                    ),
                    Response(
                      question: 'forms.entorno_familiar.question1'.tr(),
                      response: question4Controller.text.trim(),
                    ),
                    Response(
                      question: 'forms.entorno_familiar.question2'.tr(),
                      response: question5Controller.text.trim(),
                    ),
                    Response(
                      question: 'forms.entorno_familiar.question3'.tr(),
                      response: question6Controller.text.trim(),
                    ),
                    Response(
                      question: 'forms.entorno_familiar.question4'.tr(),
                      response: question7Controller.text.trim(),
                    ),
                    Response(
                      question: 'forms.entorno_familiar.question6'.tr(),
                      response: questio8Controller.text.trim(),
                    ),
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

class _ImpactoSocialCrediEstudioWidget extends StatefulWidget {
  final PageController controller;
  const _ImpactoSocialCrediEstudioWidget({required this.controller});

  @override
  State<_ImpactoSocialCrediEstudioWidget> createState() =>
      _ImpactoSocialCrediEstudioWidgetState();
}

class _ImpactoSocialCrediEstudioWidgetState
    extends State<_ImpactoSocialCrediEstudioWidget>
    with AutomaticKeepAliveClientMixin {
  final question1Controller = TextEditingController();
  final question2Controller = TextEditingController();
  final question3Controller = TextEditingController();
  final question4Controller = TextEditingController();
  final question5Controller = TextEditingController();
  final question6Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 3,
              currentStep: 2,
            ),
            const Gap(20),
            Text(
              'forms.mejora_de_vivienda.impacto_social.title'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.miCredi_estudio.question1'.tr(),
              textEditingController: question1Controller,
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.miCredi_estudio.question2'.tr(),
              textEditingController: question2Controller,
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.miCredi_estudio.question3'.tr(),
              textEditingController: question3Controller,
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.miCredi_estudio.question4'.tr(),
              textEditingController: question4Controller,
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.miCredi_estudio.question5'.tr(),
              textEditingController: question5Controller,
            ),
            const Gap(10),
            CommentaryWidget(
              title: 'forms.miCredi_estudio.question6'.tr(),
              textEditingController: question6Controller,
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
                      question: 'forms.miCredi_estudio.question1'.tr(),
                      response: question1Controller.text.trim(),
                    ),
                    Response(
                      question: 'forms.miCredi_estudio.question2'.tr(),
                      response: question2Controller.text.trim(),
                    ),
                    Response(
                      question: 'forms.miCredi_estudio.question3'.tr(),
                      response: question3Controller.text.trim(),
                    ),
                    Response(
                      question: 'forms.miCredi_estudio.question4'.tr(),
                      response: question4Controller.text.trim(),
                    ),
                    Response(
                      question: 'forms.miCredi_estudio.question5'.tr(),
                      response: question5Controller.text.trim(),
                    ),
                    Response(
                      question: 'forms.miCredi_estudio.question6'.tr(),
                      response: question6Controller.text.trim(),
                    ),
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

import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DescripcionYDesarrolloDelNegocioWidget extends StatefulWidget {
  final PageController pageController;
  const DescripcionYDesarrolloDelNegocioWidget({
    super.key,
    required this.pageController,
  });

  @override
  State<DescripcionYDesarrolloDelNegocioWidget> createState() =>
      _DescripcionYDesarrolloDelNegocioWidgetState();
}

class _DescripcionYDesarrolloDelNegocioWidgetState
    extends State<DescripcionYDesarrolloDelNegocioWidget>
    with AutomaticKeepAliveClientMixin {
  final question1 = TextEditingController();
  final question2 = TextEditingController();
  final question3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
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
            'Descripción y desarrollo del negocio'.tr(),
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          const Gap(20),
          CommentaryWidget(
            title: 'Cuéntenos, ¿Qué la motivó a emprender su negocio?*',
            textEditingController: question1,
          ),
          CommentaryWidget(
            title:
                'Coméntenos, ¿ Cómo conoció el proyecto de Mujer Emprende en MiCrédito?',
            textEditingController: question2,
          ),
          CommentaryWidget(
            title: '¿Qué la impulsó a optar a este tipo de crédito?*',
            textEditingController: question3,
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
                        'Cuéntenos, ¿Qué la motivó a emprender su negocio?*',
                    response: question1.text.trim(),
                  ),
                  Response(
                    question:
                        'Coméntenos, ¿ Cómo conoció el proyecto de Mujer Emprende en MiCrédito?',
                    response: question2.text.trim(),
                  ),
                  Response(
                    question:
                        '¿Qué la impulsó a optar a este tipo de crédito?*',
                    response: question3.text.trim(),
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}

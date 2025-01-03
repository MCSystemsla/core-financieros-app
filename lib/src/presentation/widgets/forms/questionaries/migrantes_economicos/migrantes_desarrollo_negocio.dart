import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/migrantes_economicos/migrantes_economicos_cubit.dart';
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

class MigrantesEconomicosDesarrolloDeNegocio extends StatefulWidget {
  final PageController controller;
  const MigrantesEconomicosDesarrolloDeNegocio({
    super.key,
    required this.controller,
  });

  @override
  State<MigrantesEconomicosDesarrolloDeNegocio> createState() =>
      _MigrantesEconomicosDesarrolloDeNegocioState();
}

class _MigrantesEconomicosDesarrolloDeNegocioState
    extends State<MigrantesEconomicosDesarrolloDeNegocio>
    with AutomaticKeepAliveClientMixin {
  final quienApoya = TextEditingController();
  final fortalecerIngresosExplicacion = TextEditingController();
  final metasFuturo = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? fortalecerIngresos;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MiCreditoProgress(
                steps: 3,
                currentStep: 2,
              ),
              const Gap(20),
              Text(
                'Desarrollo del negocio'.tr(),
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              CommentaryWidget(
                textEditingController: quienApoya,
                title: '¿Quién o quiénes le apoyan para salir adelante?',
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
                      '¿Le gustaría fortalecer su negocio o ingresos económicos?'
                          .tr(),
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    fortalecerIngresos = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              CommentaryWidget(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
                textEditingController: fortalecerIngresosExplicacion,
                title: '¿Porqué?',
              ),
              CommentaryWidget(
                textEditingController: metasFuturo,
                title: '¿Cuáles son las metas a futuro que tiene?',
              ),
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
                  if (formKey.currentState?.validate() ?? false) {
                    context.read<MigrantesEconomicosCubit>().saveAnswers(
                          quienApoya: quienApoya.text.trim(),
                          fortalecerIngresos:
                              fortalecerIngresos == 'input.yes'.tr(),
                          fortalecerIngresosExplicacion:
                              fortalecerIngresosExplicacion.text.trim(),
                          metasFuturo: metasFuturo.text.trim(),
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          question:
                              '¿Quién o quiénes le apoyan para salir adelante?',
                          response: quienApoya.text.trim(),
                          index: widget.controller.page?.toInt() ?? 0,
                        ),
                        Response(
                          question:
                              '¿Le gustaría fortalecer su negocio o ingresos económicos?'
                                  .tr(),
                          response: fortalecerIngresos ?? '',
                          index: widget.controller.page?.toInt() ?? 0,
                        ),
                        if (fortalecerIngresos == 'input.yes'.tr())
                          Response(
                            question: '¿Porqué?',
                            response: fortalecerIngresosExplicacion.text.trim(),
                            index: widget.controller.page?.toInt() ?? 0,
                          ),
                        Response(
                          question: '¿Cuáles son las metas a futuro que tiene?',
                          response: metasFuturo.text.trim(),
                          index: widget.controller.page?.toInt() ?? 0,
                        ),
                      ],
                    );
                    widget.controller.nextPage(
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
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

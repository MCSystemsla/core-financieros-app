import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
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

class MigrantesEconomicosAboutFamily extends StatefulWidget {
  final PageController controller;
  const MigrantesEconomicosAboutFamily({
    super.key,
    required this.controller,
  });

  @override
  State<MigrantesEconomicosAboutFamily> createState() =>
      _MigrantesEconomicosAboutFamilyState();
}

class _MigrantesEconomicosAboutFamilyState
    extends State<MigrantesEconomicosAboutFamily>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  final numeroHijos = TextEditingController();
  final edadHijos = TextEditingController();
  final enviaRemesasExplicacion = TextEditingController();
  String? tipoEstudioHijos;
  String? enviaRemesas;
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
                'Háblenos sobre su familia en su país de origen'.tr(),
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'Número de hijos:*'.tr(),
                textEditingController: numeroHijos,
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  final numero = int.tryParse(value);
                  if (numero == null || numero < 0 || numero >= 255) {
                    return 'Valor no valido'.tr();
                  }
                  return null;
                },
              ),
              const Gap(20),
              CommentaryWidget(
                title: '¿Qué edades tienen sus hijos? ',
                textEditingController: edadHijos,
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
                    tipoEstudioHijos = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
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
                  title: '¿Envía remesas a su país de origen?'.tr(),
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    setState(() {
                      enviaRemesas = item;
                    });
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              if (enviaRemesas == 'input.yes'.tr())
                CommentaryWidget(
                  title: '¿Por qué lo hace?',
                  textEditingController: enviaRemesasExplicacion,
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
                          numeroHijos: int.tryParse(numeroHijos.text.trim()),
                          edadHijos: edadHijos.text.trim(),
                          tipoEstudioHijos: tipoEstudioHijos,
                          enviaRemesas: enviaRemesas == 'input.yes'.tr(),
                          enviaRemesasExplicacion:
                              enviaRemesasExplicacion.text.trim(),
                          objSolicitudNuevamenorId: int.tryParse(
                            context.read<KivaRouteCubit>().state.solicitudId,
                          ),
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          question: 'Número de hijos'.tr(),
                          response: numeroHijos.text.trim(),
                          index: widget.controller.page?.toInt() ?? 0,
                        ),
                        Response(
                          question: '¿Qué edades tienen sus hijos?'.tr(),
                          response: edadHijos.text.trim(),
                          index: widget.controller.page?.toInt() ?? 0,
                        ),
                        Response(
                          question:
                              '¿Qué tipo de estudios reciben sus hijos?'.tr(),
                          response: tipoEstudioHijos ?? 'N/A',
                          index: widget.controller.page?.toInt() ?? 0,
                        ),
                        Response(
                          question: '¿Envía remesas a su país de origen?'.tr(),
                          response: enviaRemesas ?? 'N/A',
                          index: widget.controller.page?.toInt() ?? 0,
                        ),
                        if (enviaRemesas == 'input.yes'.tr())
                          Response(
                            question: '¿Por qué lo hace?'.tr(),
                            response: enviaRemesasExplicacion.text.trim(),
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

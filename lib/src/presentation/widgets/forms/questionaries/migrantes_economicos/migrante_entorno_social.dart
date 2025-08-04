import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/migrantes_economicos/migrantes_economicos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/button_actions_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../bloc/kiva/recurrente_migrante_economico/recurrente_migrantes_economicos_cubit.dart';

class MigrantesEconomicosEntornoSocial extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController controller;
  const MigrantesEconomicosEntornoSocial(
      {super.key, required this.controller, required this.isRecurrentForm});

  @override
  State<MigrantesEconomicosEntornoSocial> createState() =>
      _MigrantesEconomicosEntornoSocialState();
}

class _MigrantesEconomicosEntornoSocialState
    extends State<MigrantesEconomicosEntornoSocial>
    with AutomaticKeepAliveClientMixin {
  String? objOrigenCatalogoValorId;
  final motivoDejarPais = TextEditingController();
  final situacionMigratoria = TextEditingController();
  final dedicabaPaisOrigen = TextEditingController();
  final vivePaisActual = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    context.read<SolicitudesPendientesLocalDbCubit>().getDepartamentos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();
    final items = localDbProvider.departmentsBox.getAll();
    final departmentos =
        items.map((e) => Item(name: e.nombre, value: e.valor)).toList();

    super.build(context);
    return switch (widget.isRecurrentForm) {
      true => _RecurrentForm(
          controller: widget.controller,
        ),
      false => SingleChildScrollView(
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
                    'Descripción del entorno familiar.'.tr(),
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  WhiteCard(
                    marginTop: 15,
                    padding: const EdgeInsets.all(10),
                    child: JLuxDropdown(
                      isContainIcon: true,
                      // isLoading: state.status == Status.inProgress,
                      title: 'forms.entorno_familiar.person_origin'.tr(),
                      validator: (value) {
                        if (value == null) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                      items: departmentos,
                      onChanged: (item) {
                        if (item == null) return;
                        objOrigenCatalogoValorId = item.value;
                        setState(() {});
                      },
                      toStringItem: (item) => item.name,
                      hintText: 'input.select_department'.tr(),
                    ),
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    textEditingController: motivoDejarPais,
                    title: '¿Qué le motivó a dejar su país natal?',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    textEditingController: situacionMigratoria,
                    title: '¿Cuál es su situación migratoria en éste país?',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    textEditingController: dedicabaPaisOrigen,
                    title: '¿En su país de origen a qué se dedicaba?',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    textEditingController: vivePaisActual,
                    title: '¿Con quién vive en este país?',
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
                              objOrigenUbicacionGeograficaId:
                                  objOrigenCatalogoValorId,
                              motivoDejarPais: motivoDejarPais.text.trim(),
                              situacionMigratoria:
                                  situacionMigratoria.text.trim(),
                              dedicabaPaisOrigen:
                                  dedicabaPaisOrigen.text.trim(),
                              vivePaisActual: vivePaisActual.text.trim(),
                            );
                        context.read<ResponseCubit>().addResponses(
                          responses: [
                            Response(
                              question:
                                  'forms.entorno_familiar.person_origin'.tr(),
                              response: objOrigenCatalogoValorId ?? '',
                              index: widget.controller.page?.toInt() ?? 0,
                            ),
                            Response(
                              question: '¿Qué le motivó a dejar su país natal?',
                              response: motivoDejarPais.text.trim(),
                              index: widget.controller.page?.toInt() ?? 0,
                            ),
                            Response(
                              question:
                                  '¿Cuál es su situación migratoria en éste país?',
                              response: situacionMigratoria.text.trim(),
                              index: widget.controller.page?.toInt() ?? 0,
                            ),
                            Response(
                              question:
                                  '¿En su país de origen a qué se dedicaba?',
                              response: dedicabaPaisOrigen.text.trim(),
                              index: widget.controller.page?.toInt() ?? 0,
                            ),
                            Response(
                              question: '¿Con quién vive en este país?',
                              response: vivePaisActual.text.trim(),
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
  final formKey = GlobalKey<FormState>();
  final numeroHijos = TextEditingController();
  final edadHijos = TextEditingController();
  String? tipoEstudioHijos;
  @override
  Widget build(BuildContext context) {
    final cantidadHijos = context.read<KivaRouteCubit>().state.cantidadHijos;
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
                'Descripción del entorno familiar.'.tr(),
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(20),
              CommentaryWidget(
                readOnly: true,
                initialValue: cantidadHijos.toString(),
                title: 'Cantidad de hijos:',
              ),
              if (cantidadHijos > 0) ...[
                const Gap(20),
                CommentaryWidget(
                  textEditingController: edadHijos,
                  title: '¿Que edades tienen sus hijos?',
                ),
                const Gap(20),
                WhiteCard(
                  padding: const EdgeInsets.all(5),
                  child: JLuxDropdown(
                    isContainIcon: true,
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
              ],
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
                    context
                        .read<RecurrenteMigrantesEconomicosCubit>()
                        .saveAnswers(
                          numeroHijos: int.tryParse(numeroHijos.text.trim()),
                          edadHijos: edadHijos.text.trim(),
                          tipoEstudioHijos: tipoEstudioHijos,
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          question: '¿Que edades tienen sus hijos?',
                          response: edadHijos.text.trim(),
                          index: widget.controller.page?.toInt() ?? 0,
                        ),
                        Response(
                          question: '¿Qué tipo de estudios reciben sus hijos?',
                          response: tipoEstudioHijos ?? 'N/A',
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
}

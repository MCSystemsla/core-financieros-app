import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/migrantes_economicos/migrantes_economicos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MigrantesEconomicosEntornoSocial extends StatefulWidget {
  final PageController controller;
  const MigrantesEconomicosEntornoSocial({super.key, required this.controller});

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
                'Descripción del entorno familiar.'.tr(),
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              BlocBuilder<SolicitudesPendientesLocalDbCubit,
                  SolicitudesPendientesLocalDbState>(
                builder: (context, state) {
                  return WhiteCard(
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
                      items: state.departamentos,
                      onChanged: (item) {
                        if (item == null) return;
                        objOrigenCatalogoValorId = item.valor;
                        setState(() {});
                      },
                      toStringItem: (item) => item.nombre ?? '',
                      hintText: 'input.select_department'.tr(),
                    ),
                  );
                },
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
                          situacionMigratoria: situacionMigratoria.text.trim(),
                          dedicabaPaisOrigen: dedicabaPaisOrigen.text.trim(),
                          vivePaisActual: vivePaisActual.text.trim(),
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          question: 'forms.entorno_familiar.person_origin'.tr(),
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
                          question: '¿En su país de origen a qué se dedicaba?',
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}

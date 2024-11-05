import 'package:core_financiero_app/src/presentation/bloc/agua_y_saneamiento/agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_agua_y_saniamiento/recurrente_agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ImpactoSocialKivaWidget extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController controller;
  const ImpactoSocialKivaWidget(
      {super.key, required this.controller, required this.isRecurrentForm});

  @override
  State<ImpactoSocialKivaWidget> createState() =>
      _ImpactoSocialKivaWidgetState();
}

class _ImpactoSocialKivaWidgetState extends State<ImpactoSocialKivaWidget>
    with AutomaticKeepAliveClientMixin {
  final motivoPrestamo = TextEditingController();
  final mejoraCalidadVida = TextEditingController();
  final siguienteProyectoCalidadVida = TextEditingController();
  final metasProximas = TextEditingController();
  final otrosDatosCliente = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return switch (widget.isRecurrentForm) {
      true => _RecurrentForm(
          controller: widget.controller,
        ),
      false => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MiCreditoProgress(
                      steps: 5,
                      currentStep: 4,
                    ),
                    const Gap(20),
                    Text(
                      'Impacto Social de Kiva ( Uso específico, objetivos, metas del préstamo)'
                          .tr(),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const Gap(10),
                    CommentaryWidget(
                      title: '¿Para que solicitó este préstamo? Explique'.tr(),
                      textEditingController: motivoPrestamo,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                    ),
                    const Gap(10),
                    CommentaryWidget(
                      title: 'forms.impacto_social_kiva.how_perform'.tr(),
                      textEditingController: mejoraCalidadVida,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                    ),
                    const Gap(10),
                    CommentaryWidget(
                      title:
                          '¿Cuál sería el siguiente proyecto para enriquecer su calidad de vida ?*'
                              .tr(),
                      textEditingController: siguienteProyectoCalidadVida,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                    ),
                    const Gap(10),
                    CommentaryWidget(
                      title:
                          '¿Cuáles son sus metas para los próximos años?*'.tr(),
                      textEditingController: metasProximas,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                    ),
                    const Gap(10),
                    CommentaryWidget(
                      title:
                          '¿Otros datos relevantes e interesantes del cliente:'
                              .tr(),
                      textEditingController: otrosDatosCliente,
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
                          context.read<AguaYSaneamientoCubit>().saveAnswers(
                                motivoPrestamo: motivoPrestamo.text.trim(),
                                mejoraCalidadVida:
                                    mejoraCalidadVida.text.trim(),
                                siguienteProyectoCalidadVida:
                                    siguienteProyectoCalidadVida.text.trim(),
                                metasProximas: metasProximas.text.trim(),
                                otrosDatosCliente:
                                    otrosDatosCliente.text.trim(),
                                solicitudNuevamenorId: int.parse(
                                  context
                                      .read<KivaRouteCubit>()
                                      .state
                                      .solicitudId,
                                ),
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
                    const Gap(10),
                  ],
                ),
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

class _RecurrentFormState extends State<_RecurrentForm>
    with AutomaticKeepAliveClientMixin {
  final motivoPrestamo = TextEditingController();
  final comoMejoraCondicionesEntorno = TextEditingController();
  final quienApoya = TextEditingController();
  final siguientePaso = TextEditingController();
  final explicacionAlcanzaraMeta = TextEditingController();
  String? alcanzaraMeta;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MiCreditoProgress(
                steps: 5,
                currentStep: 4,
              ),
              const Gap(20),
              Text(
                'Impacto Social de Kiva ( Uso específico, objetivos, metas del préstamo)'
                    .tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(10),
              CommentaryWidget(
                title:
                    '¿En qué piensa invertir este nuevo préstamo de agua y saneamiento?*'
                        .tr(),
                textEditingController: motivoPrestamo,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(10),
              CommentaryWidget(
                title:
                    '¿Cómo cree usted que este nuevo préstamo mejore sus condiciones de vida y entorno familiar?*'
                        .tr(),
                textEditingController: comoMejoraCondicionesEntorno,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(10),
              CommentaryWidget(
                title:
                    '¿Quién o quienes le estarían apoyando en esta inversión?*'
                        .tr(),
                textEditingController: quienApoya,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(10),
              CommentaryWidget(
                title:
                    'Una vez finalizado el pago de este préstamo: ¿Cuál sería su siguiente paso?*'
                        .tr(),
                textEditingController: siguientePaso,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(10),
              WhiteCard(
                marginTop: 15,
                padding: const EdgeInsets.all(10),
                child: JLuxDropdown(
                  isContainIcon: true,
                  title: '¿Tiene algún trabajo o negocio? ¿Cuál?'.tr(),
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    alcanzaraMeta = item;
                    setState(() {});
                  },
                  toStringItem: (item) => item,
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              if (alcanzaraMeta == 'input.yes'.tr())
                CommentaryWidget(
                  title: 'Por que?',
                  textEditingController: explicacionAlcanzaraMeta,
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
                    context.read<RecurrenteAguaYSaneamientoCubit>().saveAnswers(
                          motivoPrestamo: motivoPrestamo.text.trim(),
                          comoMejoraCondicionesEntorno:
                              comoMejoraCondicionesEntorno.text.trim(),
                          quienApoya: quienApoya.text.trim(),
                          siguientePaso: siguientePaso.text.trim(),
                          alcanzaraMeta: alcanzaraMeta == 'input.yes'.tr(),
                          explicacionAlcanzaraMeta:
                              explicacionAlcanzaraMeta.text.trim(),
                          objSolicitudRecurrenteId: int.parse(
                            context.read<KivaRouteCubit>().state.solicitudId,
                          ),
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
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

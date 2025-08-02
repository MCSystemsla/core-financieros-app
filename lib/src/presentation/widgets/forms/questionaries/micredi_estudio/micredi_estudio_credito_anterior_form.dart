import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_micredi_estudio/recurrente_micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/motivo_prestamo_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/button_actions_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MicreditoCreditoAnterior extends StatefulWidget {
  final PageController pageController;
  const MicreditoCreditoAnterior({
    super.key,
    required this.pageController,
  });

  @override
  State<MicreditoCreditoAnterior> createState() =>
      _MicreditoCreditoAnteriorState();
}

class _MicreditoCreditoAnteriorState extends State<MicreditoCreditoAnterior>
    with AutomaticKeepAliveClientMixin {
  String? coincideRespuesta;
  final explicacionInversion = TextEditingController();
  final comoAyudoProfesionalmente = TextEditingController();
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
                'Descripción del crédito anterior MiCrédiEstudio'.tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const MotivoPrestamoWidget(),
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
                      '¿Coincide la respuesta del cliente con el formato anterior?'
                          .tr(),
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    coincideRespuesta = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              const Gap(20),
              if (coincideRespuesta == 'input.no'.tr())
                CommentaryWidget(
                  title:
                      '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                  textEditingController: explicacionInversion,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'input.input_validator'.tr();
                    }
                    return null;
                  },
                ),
              const Gap(20),
              CommentaryWidget(
                title:
                    '¿De qué manera ayudó este préstamo Kiva en su vida profesional?*',
                textEditingController: comoAyudoProfesionalmente,
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
                  widget.pageController.previousPage(
                    duration: const Duration(
                      milliseconds: 350,
                    ),
                    curve: Curves.easeIn,
                  );
                },
                onNextPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    context.read<RecurrenteMicrediEstudioCubit>().saveAnswers(
                          coincideRespuesta:
                              coincideRespuesta == 'input.yes'.tr(),
                          explicacionInversion:
                              explicacionInversion.text.trim(),
                          comoAyudoProfesionalmente:
                              comoAyudoProfesionalmente.text.trim(),
                          objSolicitudRecurrenteId: int.parse(
                            context.read<KivaRouteCubit>().state.solicitudId,
                          ),
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question:
                              '¿Coincide la respuesta del cliente con el formato anterior?',
                          response: coincideRespuesta ?? 'N/A',
                        ),
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question:
                              '¿Coincide la respuesta del cliente con el formato anterior?',
                          response: coincideRespuesta ?? 'N/A',
                        ),
                        if (coincideRespuesta == 'input.no'.tr())
                          Response(
                            index: widget.pageController.page?.toInt() ?? 0,
                            question:
                                '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                            response: explicacionInversion.text.trim(),
                          ),
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question:
                              '¿De qué manera ayudó este préstamo Kiva en su vida profesional?*',
                          response: comoAyudoProfesionalmente.text.trim(),
                        ),
                      ],
                    );
                    widget.pageController.nextPage(
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

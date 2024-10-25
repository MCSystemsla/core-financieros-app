import 'package:core_financiero_app/src/presentation/bloc/motivo_prestamo/motivo_prestamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EnergiaLimpiaCreditoAnterior extends StatefulWidget {
  final PageController pageController;
  const EnergiaLimpiaCreditoAnterior({
    super.key,
    required this.pageController,
  });

  @override
  State<EnergiaLimpiaCreditoAnterior> createState() =>
      _EnergiaLimpiaCreditoAnteriorState();
}

class _EnergiaLimpiaCreditoAnteriorState
    extends State<EnergiaLimpiaCreditoAnterior> {
  String? coincideRespuesta;
  final explicacionInversion = TextEditingController();
  final situacionAntesAhora = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MiCreditoProgress(
              steps: 4,
              currentStep: 3,
            ),
            const Gap(20),
            Text(
              'Descripción del entorno familiar.'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(10),
            BlocBuilder<MotivoPrestamoCubit, MotivoPrestamoState>(
              builder: (context, state) {
                if (state is OnMotivoPrestamoLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is OnMotivoPrestamoSuccess) {
                  return Text(state.motivoPrestamo);
                }
                return const SizedBox();
              },
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
            if (coincideRespuesta == 'input.no'.tr())
              CommentaryWidget(
                title:
                    '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                textEditingController: explicacionInversion,
              ),
            const Gap(20),
            CommentaryWidget(
              title:
                  '¿Cómo era su situación antes de adquirir esta solución energética y cómo es ahora ?',
              textEditingController: situacionAntesAhora,
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
                  context.read<RecurrenteEnergiaLimpiaCubit>().saveAnswer3(
                        coincideRespuesta:
                            coincideRespuesta == 'input.yes'.tr(),
                        explicacionInversion: explicacionInversion.text.trim(),
                        situacionAntesAhora: situacionAntesAhora.text.trim(),
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
          ],
        ),
      ),
    );
  }
}

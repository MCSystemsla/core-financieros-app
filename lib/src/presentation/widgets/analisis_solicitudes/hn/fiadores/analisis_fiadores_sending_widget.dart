import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_fiadores/analisis_fiadores_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/exit_confirmation_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/sending_status_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalisisFiadoresSendingWidget extends StatefulWidget {
  const AnalisisFiadoresSendingWidget({super.key});

  @override
  State<AnalisisFiadoresSendingWidget> createState() =>
      _AnalisisFiadoresSendingWidgetState();
}

class _AnalisisFiadoresSendingWidgetState
    extends State<AnalisisFiadoresSendingWidget> {
  @override
  void initState() {
    super.initState();
    context.read<AnalisisFiadoresCubit>().createAnalisisFiador();
  }

  void _goToAnalisis() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const AnalisisInterceptorByFlavor(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnalisisFiadoresCubit, AnalisisFiadoresState>(
      listener: (context, state) {
        if (state.status == Status.done) {
          context.read<AnalisisFiadoresCubit>().fiadoresEnviarFirmaDigital();
        }
      },
      builder: (context, state) {
        final numeroSolicitud =
            state.numeroSolicitud == 0 ? '' : state.numeroSolicitud.toString();

        return Scaffold(
          backgroundColor: RedesignColors.background,
          appBar: AppBar(
            backgroundColor: RedesignColors.background,
            surfaceTintColor: RedesignColors.background,
            elevation: 0,
            titleSpacing: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16, top: 6, bottom: 6),
              child: SendingCloseButton(
                onPressed: () {
                  ExitConfirmationDialog(
                    context: context,
                    title: '¿Estás seguro de que quieres salir?',
                    onYes: _goToAnalisis,
                  ).showDialog(context);
                },
              ),
            ),
            title: const Text(
              'FIADOR',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: RedesignColors.inkMuted,
              ),
            ),
          ),
          body: switch (state.status) {
            Status.inProgress => SendingStatusView(
                artTint: RedesignColors.tealTint,
                art: const SendingStatusLottie(
                  asset: ImageAsset.nuevaMenorUploading,
                ),
                title: 'Enviando fiador…',
                message:
                    'No cierres la app. Esto suele tardar menos de un minuto.',
                steps: const [
                  SendingStep(
                    label: 'Creando fiador en el servidor',
                    state: SendingStepState.active,
                  ),
                  SendingStep(label: 'Registrando firma del fiador'),
                ],
                value: numeroSolicitud,
              ),
            Status.done => SendingStatusView(
                artTint: RedesignColors.greenTint,
                art: const SendingStatusLottie(
                  asset: ImageAsset.nuevaMenorSuccess,
                  repeat: false,
                ),
                title: 'Fiador creado',
                message:
                    'Los datos y la firma del fiador quedaron registrados correctamente.',
                steps: const [
                  SendingStep(
                    label: 'Fiador creado en el servidor',
                    state: SendingStepState.done,
                  ),
                  SendingStep(
                    label: 'Firma del fiador registrada',
                    state: SendingStepState.done,
                  ),
                ],
                value: numeroSolicitud,
                actions: [
                  CustomElevatedButton(
                    text: 'Volver a análisis',
                    color: RedesignColors.green,
                    onPressed: _goToAnalisis,
                  ),
                ],
              ),
            Status.error => SendingStatusView(
                artTint: RedesignColors.indigoTint,
                art: const Icon(
                  Icons.warning_amber_rounded,
                  size: 58,
                  color: RedesignColors.indigo,
                ),
                title: 'Fiador no se pudo enviar',
                message:
                    'Guardamos los datos en el dispositivo, puedes reintentar sin perder la información.',
                errorDetail: state.errorMsg,
                value: numeroSolicitud,
                actions: [
                  CustomElevatedButton(
                    text: 'Reintentar envío',
                    color: RedesignColors.green,
                    onPressed: () {
                      context
                          .read<AnalisisFiadoresCubit>()
                          .createAnalisisFiador();
                    },
                  ),
                  CustomOutLineButton(
                    text: 'Volver',
                    color: RedesignColors.border,
                    textColor: RedesignColors.ink,
                    borderRadius: 12,
                    onPressed: _goToAnalisis,
                  ),
                ],
              ),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }
}

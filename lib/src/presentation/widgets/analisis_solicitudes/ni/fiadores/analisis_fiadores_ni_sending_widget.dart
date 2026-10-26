import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/ni/analisis_fiadores/analisis_fiadores_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/exit_confirmation_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/sending_status_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalisisFiadoresNiSendingWidget extends StatefulWidget {
  final int numeroSolicitud;
  const AnalisisFiadoresNiSendingWidget({
    super.key,
    required this.numeroSolicitud,
  });

  @override
  State<AnalisisFiadoresNiSendingWidget> createState() =>
      _AnalisisFiadoresNiSendingWidgetState();
}

class _AnalisisFiadoresNiSendingWidgetState
    extends State<AnalisisFiadoresNiSendingWidget> {
  @override
  void initState() {
    super.initState();
    _send();
  }

  void _send() {
    context.read<AnalisisFiadoresNiCubit>().createAnalisisFiador(
          numeroSolicitud: widget.numeroSolicitud,
        );
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
    final numeroSolicitud = widget.numeroSolicitud.toString();
    return BlocBuilder<AnalisisFiadoresNiCubit, AnalisisFiadoresNiState>(
      builder: (context, state) {
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
                message: 'Los datos del fiador quedaron registrados.',
                steps: const [
                  SendingStep(
                    label: 'Fiador creado en el servidor',
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
                // No hay guardado offline: los datos viven en el cubit
                // mientras el formulario siga abierto.
                message:
                    'Los datos siguen en el formulario. Puedes reintentar o volver para corregirlos.',
                errorDetail: state.errorMsg,
                value: numeroSolicitud,
                actions: [
                  CustomElevatedButton(
                    text: 'Reintentar envío',
                    color: RedesignColors.green,
                    onPressed: _send,
                  ),
                  CustomOutLineButton(
                    text: 'Volver al formulario',
                    color: RedesignColors.border,
                    textColor: RedesignColors.ink,
                    borderRadius: 12,
                    onPressed: () => Navigator.pop(context),
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

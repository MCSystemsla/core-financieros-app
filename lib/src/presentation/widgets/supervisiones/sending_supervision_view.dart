import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/sending_status_view.dart';
import 'package:flutter/material.dart';

/// Vista de envío de una supervisión. Se monta en un `Stack` sobre el
/// formulario (no en otra ruta) para que, si el envío falla, el asesor vuelva
/// al formulario con los datos intactos.
///
/// Es agnóstica del cubit: cada pantalla la alimenta con un `BlocBuilder`
/// sobre el `status`/`errorMsg` de su propio cubit.
class SendingSupervisionView extends StatelessWidget {
  final Status status;
  final String errorMsg;
  final String numeroSolicitud;

  /// Tipo de supervisión en minúscula, p. ej. `'de crédito'` o `'regional'`.
  final String tipo;

  /// Vuelve a llamar al envío del cubit con los datos actuales.
  final VoidCallback onRetry;

  /// Debe volver el `status` del cubit a [Status.notStarted] para que el
  /// asesor regrese al formulario y corrija los datos.
  final VoidCallback onReview;

  /// Cierra el formulario de supervisión.
  final VoidCallback onClose;

  const SendingSupervisionView({
    super.key,
    required this.status,
    required this.errorMsg,
    required this.numeroSolicitud,
    required this.tipo,
    required this.onRetry,
    required this.onReview,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    if (status != Status.inProgress &&
        status != Status.done &&
        status != Status.error) {
      return const SizedBox.shrink();
    }

    return Positioned.fill(
      child: PopScope(
        canPop: status != Status.inProgress,
        child: FadeIn(
          duration: const Duration(milliseconds: 200),
          child: ColoredBox(
            color: RedesignColors.background,
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'SUPERVISIÓN',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                        color: RedesignColors.inkMuted,
                      ),
                    ),
                  ),
                  Expanded(child: _buildStatus()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatus() {
    return switch (status) {
      Status.inProgress => SendingStatusView(
          artTint: RedesignColors.tealTint,
          art: const SendingStatusLottie(
            asset: ImageAsset.nuevaMenorUploading,
          ),
          title: 'Enviando supervisión…',
          message: 'No cierres la app. Esto suele tardar unos segundos.',
          steps: [
            SendingStep(
              label: 'Enviando supervisión $tipo al servidor',
              state: SendingStepState.active,
            ),
            const SendingStep(label: 'Supervisión registrada'),
          ],
          value: numeroSolicitud,
        ),
      Status.done => SendingStatusView(
          artTint: RedesignColors.greenTint,
          art: const SendingStatusLottie(
            asset: ImageAsset.nuevaMenorSuccess,
            repeat: false,
          ),
          title: 'Supervisión enviada',
          message: 'La supervisión $tipo fue registrada exitosamente.',
          steps: [
            SendingStep(
              label: 'Supervisión $tipo enviada al servidor',
              state: SendingStepState.done,
            ),
            const SendingStep(
              label: 'Supervisión registrada',
              state: SendingStepState.done,
            ),
          ],
          value: numeroSolicitud,
          actions: [
            CustomElevatedButton(
              text: 'Volver a supervisiones',
              color: RedesignColors.green,
              onPressed: onClose,
            ),
          ],
        ),
      _ => SendingStatusView(
          artTint: RedesignColors.indigoTint,
          art: const Icon(
            Icons.warning_amber_rounded,
            size: 58,
            color: RedesignColors.indigo,
          ),
          title: 'La supervisión no se pudo enviar',
          message:
              'Tus datos siguen guardados. Puedes reintentar el envío o volver al formulario a revisarlos.',
          errorDetail: errorMsg,
          value: numeroSolicitud,
          actions: [
            CustomElevatedButton(
              text: 'Reintentar envío',
              color: RedesignColors.green,
              onPressed: onRetry,
            ),
            CustomOutLineButton(
              text: 'Revisar formulario',
              color: RedesignColors.border,
              textColor: RedesignColors.ink,
              borderRadius: 12,
              onPressed: onReview,
            ),
            TextButton(
              onPressed: onClose,
              child: const Text(
                'Salir sin enviar',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: RedesignColors.inkMuted,
                ),
              ),
            ),
          ],
        ),
    };
  }
}

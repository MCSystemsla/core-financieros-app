import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/sending_status_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Resultado de un envío o sincronización, con el estilo del rediseño
/// ([SendingStatusView]): animación en el círculo de estado, título, lista de
/// lo que se envió y detalle de lo que no se pudo sincronizar.
class SuccessClayWidget extends StatelessWidget {
  final String lottieAsset;

  /// Título. Si está vacío se usa uno según el resultado.
  final String text;

  /// Texto bajo el título. Si es null se arma con los conteos.
  final String? message;
  final bool? repeat;
  final bool? isSucess;
  final bool isUploadingForms;
  final VoidCallback? onDownloadComplete;
  final List<String> unsyncedCatalogos;
  final List<String> solicitudesSent;

  const SuccessClayWidget({
    super.key,
    required this.lottieAsset,
    required this.text,
    this.message,
    this.repeat = true,
    this.isSucess = false,
    this.isUploadingForms = false,
    this.onDownloadComplete,
    this.unsyncedCatalogos = const [],
    this.solicitudesSent = const [],
  });

  bool get _hasPendientes => unsyncedCatalogos.isNotEmpty;

  String get _title {
    if (text.trim().isNotEmpty) return text;
    if (_hasPendientes) return 'Sincronización incompleta';
    return solicitudesSent.isNotEmpty ? 'Todo enviado' : 'Listo';
  }

  String get _message {
    if (message != null) return message!;
    final enviados = solicitudesSent.length;
    final pendientes = unsyncedCatalogos.length;
    if (_hasPendientes) {
      return pendientes == 1
          ? 'Un catálogo no se pudo sincronizar. Revisa tu conexión e '
              'inténtalo de nuevo.'
          : '$pendientes catálogos no se pudieron sincronizar. Revisa tu '
              'conexión e inténtalo de nuevo.';
    }
    if (enviados == 0) return 'El proceso terminó correctamente.';
    return enviados == 1
        ? 'Se envió 1 registro al servidor.'
        : 'Se enviaron $enviados registros al servidor.';
  }

  void _onContinuar(BuildContext context) {
    if (onDownloadComplete != null) return onDownloadComplete!();
    if (isUploadingForms) return context.pushReplacement('/');
    if (context.canPop()) return context.pop();
    context.push('/');
  }

  @override
  Widget build(BuildContext context) {
    final isSuccess = isSucess ?? false;

    return SendingStatusView(
      artTint:
          _hasPendientes ? RedesignColors.amberTint : RedesignColors.greenTint,
      art: SendingStatusLottie(
        asset: lottieAsset,
        repeat: repeat ?? true,
      ),
      celebrate: isSuccess && !_hasPendientes,
      title: _title,
      message: _message,
      steps: [
        for (final enviado in solicitudesSent)
          SendingStep(label: enviado, state: SendingStepState.done),
      ],
      errorDetail: _hasPendientes
          ? unsyncedCatalogos.map((c) => '• $c').join('\n')
          : null,
      actions: [
        if (isSuccess)
          CustomElevatedButton(
            text: 'Continuar',
            color: RedesignColors.green,
            onPressed: () => _onContinuar(context),
          ),
      ],
    );
  }
}

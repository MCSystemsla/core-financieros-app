import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/sending_status_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Estado "en progreso" de un envío o sincronización, con el estilo del
/// rediseño: animación Lottie en el círculo de estado, título, mensaje, barra
/// de progreso indeterminada y un aviso al pie.
///
/// Es la pareja de [SendingStatusView] (que muestra el resultado) y reemplaza
/// a `DownloadCatalogoLoading` en las pantallas migradas.
class SendingProgressView extends StatelessWidget {
  final String lottieAsset;
  final String title;
  final String message;

  /// Fondo del círculo de la animación.
  final Color tint;

  /// Color de la barra de progreso.
  final Color accent;

  /// Aviso al pie. Si es null no se muestra.
  final String? hint;

  const SendingProgressView({
    super.key,
    required this.lottieAsset,
    required this.title,
    this.message = 'Esto puede tardar unos segundos.',
    this.tint = RedesignColors.indigoTint,
    this.accent = RedesignColors.indigo,
    this.hint = 'No cierres la app ni pierdas la conexión mientras termina.',
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: constraints.maxHeight - 28),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(),
                    Center(
                      child: Container(
                        height: 132,
                        width: 132,
                        decoration: BoxDecoration(
                          color: tint,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: SendingStatusLottie(asset: lottieAsset),
                      ),
                    ),
                    const Gap(24),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        height: 1.15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                        color: RedesignColors.ink,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13.5,
                        height: 1.45,
                        color: RedesignColors.inkMuted,
                      ),
                    ),
                    const Gap(24),
                    Center(
                      child: SizedBox(
                        width: 180,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(99),
                          child: LinearProgressIndicator(
                            minHeight: 5,
                            color: accent,
                            backgroundColor: RedesignColors.border,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (hint != null) ...[
                      const Gap(24),
                      _HintBox(text: hint!),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HintBox extends StatelessWidget {
  final String text;
  const _HintBox({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: RedesignColors.tagBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: RedesignColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: 18,
            color: RedesignColors.inkMuted,
          ),
          const Gap(10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.5,
                height: 1.4,
                color: RedesignColors.inkMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

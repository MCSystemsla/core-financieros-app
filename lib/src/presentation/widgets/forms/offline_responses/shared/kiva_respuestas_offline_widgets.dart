import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// Piezas del rediseño 2026 para revisar y enviar las respuestas Kiva
/// guardadas en el teléfono (`ConfirmationOfflineResponsesScreen`).

/// Respuesta de solo lectura: pregunta arriba, valor abajo.
///
/// Normaliza lo que llega de la base local: `true`/`false` se muestran como
/// Sí/No, y `null`, vacío, `'null'` o `'N/A'` como "Sin respuesta".
class KivaRespuestaWidget extends StatelessWidget {
  final String title;
  final String? initialValue;
  const KivaRespuestaWidget({
    super.key,
    required this.title,
    this.initialValue,
  });

  static String? _normalizar(String? value) {
    final texto = value?.trim() ?? '';
    if (texto.isEmpty || const {'null', 'n/a'}.contains(texto.toLowerCase())) {
      return null;
    }
    return switch (texto.toLowerCase()) {
      'true' => 'Sí',
      'false' => 'No',
      _ => texto,
    };
  }

  @override
  Widget build(BuildContext context) {
    final valor = _normalizar(initialValue);
    final pregunta = title.trim().replaceAll(RegExp(r'\s*\*+$'), '');

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: RedesignColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pregunta,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.35,
              fontWeight: FontWeight.w500,
              color: RedesignColors.inkMuted,
            ),
          ),
          const Gap(6),
          Text(
            valor ?? 'Sin respuesta',
            style: TextStyle(
              fontSize: 15,
              height: 1.4,
              fontWeight: valor == null ? FontWeight.w400 : FontWeight.w600,
              fontStyle: valor == null ? FontStyle.italic : FontStyle.normal,
              color:
                  valor == null ? RedesignColors.chevron : RedesignColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}

/// Scroll con el padding del rediseño para la lista de respuestas.
class KivaRespuestasScroll extends StatelessWidget {
  final Widget child;
  const KivaRespuestasScroll({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
      child: child,
    );
  }
}

/// Decide qué se ve según la carga local de las respuestas:
/// `null` cargando, `false` no hay respuestas guardadas para esta solicitud,
/// `true` las respuestas ([child]).
///
/// No se usa el `status` de `SolicitudesPendientesLocalDbCubit` porque es
/// global: mientras carga, o si no encuentra el registro, su estado conserva
/// las respuestas de la última solicitud abierta.
class KivaRespuestasBody extends StatelessWidget {
  final bool? encontradas;
  final Widget child;
  const KivaRespuestasBody({
    super.key,
    required this.encontradas,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return switch (encontradas) {
      null => const Center(
          child: CircularProgressIndicator(color: RedesignColors.teal),
        ),
      false => const _SinRespuestas(),
      true => child,
    };
  }
}

class _SinRespuestas extends StatelessWidget {
  const _SinRespuestas();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: RedesignColors.amberTint,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.inventory_2_outlined,
                color: RedesignColors.amber,
                size: 30,
              ),
            ),
            const Gap(18),
            const Text(
              'No hay respuestas guardadas',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: RedesignColors.ink,
              ),
            ),
            const Gap(8),
            const Text(
              'Este formulario Kiva no tiene respuestas en el teléfono. '
              'Vuelve a la lista y llénalo de nuevo.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.45,
                color: RedesignColors.inkMuted,
              ),
            ),
            const Gap(20),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: RedesignColors.ink,
                side: const BorderSide(color: RedesignColors.border),
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () => Navigator.of(context).maybePop(),
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Botones "Salir" / "Enviar" al final de las respuestas.
///
/// Mientras [disabled] es `true` (enviando respuestas o imágenes) ambos
/// botones quedan bloqueados y "Enviar" muestra un spinner. Sin conexión,
/// "Enviar" se deshabilita y se muestra un aviso.
class KivaEnviarActions extends StatelessWidget {
  final VoidCallback? onPreviousPressed;
  final VoidCallback? onNextPressed;
  final String previousTitle;
  final String nextTitle;
  final bool? disabled;
  const KivaEnviarActions({
    super.key,
    required this.onPreviousPressed,
    required this.onNextPressed,
    required this.previousTitle,
    required this.nextTitle,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final enviando = disabled ?? true;
    final sinConexion = context.select<InternetConnectionCubit, bool>(
      (cubit) => cubit.state.connectionStatus == ConnectionStatus.disconnected,
    );
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    );

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          children: [
            if (sinConexion) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: RedesignColors.amberTint,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.wifi_off_rounded,
                      size: 18,
                      color: RedesignColors.amber,
                    ),
                    Gap(10),
                    Expanded(
                      child: Text(
                        'Necesitas conexión para enviar el formulario.',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: RedesignColors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(12),
            ],
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      foregroundColor: RedesignColors.ink,
                      side: const BorderSide(color: RedesignColors.border),
                      shape: shape,
                    ),
                    onPressed: enviando ? null : onPreviousPressed,
                    child: Text(previousTitle),
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: RedesignColors.teal,
                      disabledBackgroundColor: RedesignColors.tagBackground,
                      shape: shape,
                    ),
                    onPressed: enviando || sinConexion ? null : onNextPressed,
                    child: enviando
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.2,
                              color: RedesignColors.teal,
                            ),
                          )
                        : Text(nextTitle),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Aviso de envío terminado. Al aceptar cierra el diálogo y luego la
/// pantalla: con [needGoBack] vuelve a la pantalla anterior (historial Kiva)
/// devolviendo `true`; si no, vuelve al inicio.
///
/// Antes el botón solo cerraba el diálogo cuando venía del historial, y la
/// pantalla quedaba abierta con "Enviar" activo para un segundo envío.
Future<void> mostrarKivaEnviadoDialog({
  required BuildContext context,
  required bool imagenesEnviadas,
  required bool needGoBack,
}) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: RedesignColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 26, 22, 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: imagenesEnviadas
                      ? RedesignColors.greenTint
                      : RedesignColors.amberTint,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  imagenesEnviadas
                      ? Icons.check_rounded
                      : Icons.image_not_supported_outlined,
                  size: 30,
                  color: imagenesEnviadas
                      ? RedesignColors.green
                      : RedesignColors.amber,
                ),
              ),
              const Gap(16),
              const Text(
                'Formulario Kiva enviado',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: RedesignColors.ink,
                ),
              ),
              const Gap(8),
              Text(
                imagenesEnviadas
                    ? 'Las respuestas y las imágenes se enviaron correctamente.'
                    : 'Las respuestas se enviaron, pero las imágenes no se '
                        'pudieron subir. Reintenta desde el historial Kiva.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13.5,
                  height: 1.45,
                  color: RedesignColors.inkMuted,
                ),
              ),
              const Gap(20),
              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  backgroundColor: RedesignColors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('Listo'),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  if (!context.mounted) return;
  if (needGoBack) {
    Navigator.of(context).pop(true);
  } else {
    context.go('/');
  }
}

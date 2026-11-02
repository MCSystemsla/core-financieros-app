import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/borrador_sin_numero/local_db/analisis_borrador_sin_numero_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/borrador_sin_numero/modulo_borrador_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/info_row_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum AccionBorradorSinNumero { usar, ahoraNo, descartar }

String _tipoSolicitudLabel(String tipo) => switch (tipo) {
      'NUEVAMENOR' => 'Nueva',
      'ASALARIADO' => 'Asalariado',
      'REPRESTAMO' => 'Represtamo',
      _ => tipo,
    };

String _moduloLabel(ModuloBorradorHn modulo) => switch (modulo) {
      ModuloBorradorHn.analisis => 'Análisis',
      ModuloBorradorHn.planInversion => 'Plan de inversión',
      ModuloBorradorHn.fiadores => 'Fiadores',
      ModuloBorradorHn.imagenes => 'Imágenes del negocio',
      ModuloBorradorHn.ubicacion => 'Ubicación',
    };

/// Pregunta si se usan los datos que el asesor capturó offline para una
/// solicitud sin número (SPEC 06) en la solicitud AUT con la misma cédula y
/// tipo. "Descartar" pide confirmación dentro del mismo diálogo.
class UsarBorradorSinNumeroDialog extends StatefulWidget {
  final AnalisisBorradorSinNumeroHnLocalDb borrador;
  final String numeroSolicitud;
  const UsarBorradorSinNumeroDialog({
    super.key,
    required this.borrador,
    required this.numeroSolicitud,
  });

  /// Devuelve la acción elegida. Cerrar el diálogo cuenta como "Ahora no".
  static Future<AccionBorradorSinNumero> show(
    BuildContext context, {
    required AnalisisBorradorSinNumeroHnLocalDb borrador,
    required String numeroSolicitud,
  }) async {
    final accion = await showDialog<AccionBorradorSinNumero>(
      context: context,
      builder: (_) => UsarBorradorSinNumeroDialog(
        borrador: borrador,
        numeroSolicitud: numeroSolicitud,
      ),
    );
    return accion ?? AccionBorradorSinNumero.ahoraNo;
  }

  @override
  State<UsarBorradorSinNumeroDialog> createState() =>
      _UsarBorradorSinNumeroDialogState();
}

class _UsarBorradorSinNumeroDialogState
    extends State<UsarBorradorSinNumeroDialog> {
  bool _confirmandoDescarte = false;

  void _cerrar(AccionBorradorSinNumero accion) =>
      Navigator.of(context).pop(accion);

  @override
  Widget build(BuildContext context) {
    final borrador = widget.borrador;
    return Dialog(
      backgroundColor: RedesignColors.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _confirmandoDescarte
                  ? '¿Descartar los datos guardados?'
                  : '¿Usar datos guardados?',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: RedesignColors.ink,
              ),
            ),
            const Gap(6),
            Text(
              _confirmandoDescarte
                  ? 'Se borran del teléfono el análisis, el plan de inversión, '
                      'los fiadores, las imágenes y la ubicación que capturaste '
                      'sin número. No se pueden recuperar.'
                  : 'Tienes datos capturados sin conexión para este cliente. '
                      'Puedes pasarlos a la solicitud ${widget.numeroSolicitud}.',
              style: const TextStyle(
                fontSize: 14,
                height: 1.35,
                color: RedesignColors.inkMuted,
              ),
            ),
            const Gap(16),
            InfoRowWidget(
              icon: Icons.person_2_outlined,
              color: RedesignColors.indigo,
              background: RedesignColors.indigoTint,
              label: 'Cliente',
              value: borrador.nombreCompleto,
            ),
            const Gap(8),
            InfoRowWidget(
              icon: Icons.badge_outlined,
              color: RedesignColors.teal,
              background: RedesignColors.tealTint,
              label: 'Cédula',
              value: borrador.cedula,
            ),
            const Gap(8),
            InfoRowWidget(
              icon: Icons.description_outlined,
              color: RedesignColors.green,
              background: RedesignColors.greenTint,
              label: 'Tipo',
              value: _tipoSolicitudLabel(borrador.tipoSolicitud),
            ),
            const Gap(8),
            InfoRowWidget(
              icon: Icons.event_outlined,
              color: RedesignColors.amber,
              background: RedesignColors.amberTint,
              label: 'Capturado',
              value: borrador.fechaCreacion.formatDate(),
            ),
            const Gap(20),
            if (_confirmandoDescarte) ...[
              CustomElevatedButton(
                text: 'Sí, descartar',
                color: RedesignColors.red,
                onPressed: () => _cerrar(AccionBorradorSinNumero.descartar),
              ),
              const Gap(8),
              _TextAction(
                text: 'Volver',
                onPressed: () => setState(() => _confirmandoDescarte = false),
              ),
            ] else ...[
              CustomElevatedButton(
                text: 'Usar',
                color: RedesignColors.green,
                onPressed: () => _cerrar(AccionBorradorSinNumero.usar),
              ),
              const Gap(8),
              _TextAction(
                text: 'Ahora no',
                onPressed: () => _cerrar(AccionBorradorSinNumero.ahoraNo),
              ),
              _TextAction(
                text: 'Descartar',
                color: RedesignColors.red,
                onPressed: () => setState(() => _confirmandoDescarte = true),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Resumen después de "Usar": qué módulos se pasaron a la solicitud y cuáles
/// no, y por qué.
class ResumenVinculoBorradorDialog extends StatelessWidget {
  final VinculoBorradorResultado resultado;
  const ResumenVinculoBorradorDialog({super.key, required this.resultado});

  static Future<void> show(
    BuildContext context, {
    required VinculoBorradorResultado resultado,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => ResumenVinculoBorradorDialog(resultado: resultado),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: RedesignColors.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Datos vinculados',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: RedesignColors.ink,
              ),
            ),
            const Gap(16),
            if (resultado.vinculados.isEmpty &&
                resultado.conDatosPrevios.isEmpty &&
                !resultado.analisisDescartadoPorMonto)
              const Text(
                'No había datos guardados para pasar.',
                style: TextStyle(fontSize: 14, color: RedesignColors.inkMuted),
              ),
            for (final modulo in resultado.vinculados) ...[
              InfoRowWidget(
                icon: Icons.check_circle_outline_rounded,
                color: RedesignColors.green,
                background: RedesignColors.greenTint,
                label: _moduloLabel(modulo),
                value: 'Se pasó a la solicitud',
              ),
              const Gap(8),
            ],
            for (final modulo in resultado.conDatosPrevios) ...[
              InfoRowWidget(
                icon: Icons.info_outline_rounded,
                color: RedesignColors.amber,
                background: RedesignColors.amberTint,
                label: _moduloLabel(modulo),
                value: 'No se pasó: la solicitud ya tenía datos',
              ),
              const Gap(8),
            ],
            if (resultado.analisisDescartadoPorMonto) ...[
              InfoRowWidget(
                icon: Icons.warning_amber_rounded,
                color: RedesignColors.red,
                background: RedesignColors.redTint,
                label: _moduloLabel(ModuloBorradorHn.analisis),
                value: 'El monto cambió, el análisis debe hacerse de nuevo',
              ),
              const Gap(8),
            ],
            const Gap(12),
            CustomElevatedButton(
              text: 'Entendido',
              color: RedesignColors.ink,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextAction extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  const _TextAction({
    required this.text,
    required this.onPressed,
    this.color = RedesignColors.inkMuted,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: color, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

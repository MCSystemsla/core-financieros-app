import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_icon_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

/// Piezas visuales compartidas por las listas de solicitudes Kiva
/// (`KivaFormScreen` en línea y `OfflineFormKivaScreen` sin conexión).

/// Búsqueda inline con botón para limpiar.
class KivaBusquedaField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;

  const KivaBusquedaField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Buscar por nombre, número o cédula',
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: RedesignColors.border),
    );

    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      style: const TextStyle(fontSize: 14.5, color: RedesignColors.ink),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: RedesignColors.chevron,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: RedesignColors.inkMuted,
        ),
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, _) => value.text.isEmpty
              ? const SizedBox.shrink()
              : IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: RedesignColors.inkMuted,
                  ),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                ),
        ),
        filled: true,
        fillColor: RedesignColors.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: const BorderSide(color: RedesignColors.teal, width: 1.4),
        ),
      ),
    );
  }
}

/// Tarjeta de una solicitud Kiva: ícono de estado, nombre, subtítulo y tags.
class KivaSolicitudTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color background;
  final String titulo;
  final String subtitulo;
  final List<Widget> tags;
  final VoidCallback? onTap;

  const KivaSolicitudTile({
    super.key,
    required this.icon,
    required this.color,
    required this.background,
    required this.titulo,
    required this.subtitulo,
    required this.tags,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Material(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap == null
              ? null
              : () {
                  HapticFeedback.selectionClick();
                  onTap!();
                },
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: RedesignColors.border),
            ),
            child: Row(
              children: [
                ModuleIconTile(
                  icon: icon,
                  color: color,
                  background: background,
                ),
                const Gap(13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        titulo,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.15,
                          color: RedesignColors.ink,
                        ),
                      ),
                      if (subtitulo.trim().isNotEmpty) ...[
                        const Gap(3),
                        Text(
                          subtitulo,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.35,
                            color: RedesignColors.inkMuted,
                          ),
                        ),
                      ],
                      if (tags.isNotEmpty) ...[
                        const Gap(8),
                        Wrap(spacing: 6, runSpacing: 6, children: tags),
                      ],
                    ],
                  ),
                ),
                const Gap(10),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: RedesignColors.chevron,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Estado vacío / error / sin resultados centrado, con acción opcional.
class KivaListaMensaje extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color background;
  final String titulo;
  final String mensaje;
  final String? accion;
  final VoidCallback? onAccion;

  const KivaListaMensaje({
    super.key,
    required this.icon,
    required this.color,
    required this.background,
    required this.titulo,
    required this.mensaje,
    this.accion,
    this.onAccion,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const Gap(18),
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: RedesignColors.ink,
              ),
            ),
            if (mensaje.trim().isNotEmpty) ...[
              const Gap(8),
              Text(
                mensaje,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13.5,
                  height: 1.45,
                  color: RedesignColors.inkMuted,
                ),
              ),
            ],
            if (accion != null) ...[
              const Gap(20),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: RedesignColors.teal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: onAccion,
                child: Text(accion!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Título de sección dentro de la lista ("Sin número", "Descargadas").
class KivaSeccionTitulo extends StatelessWidget {
  final String titulo;
  final int cantidad;

  const KivaSeccionTitulo({
    super.key,
    required this.titulo,
    required this.cantidad,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 6),
      child: Text(
        '${titulo.toUpperCase()} · $cantidad',
        style: const TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
          color: RedesignColors.inkMuted,
        ),
      ),
    );
  }
}

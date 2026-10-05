import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_data_hn.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_garantia/tipo_garantia_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

/// Tarjeta de garantía del análisis HN (rediseño 2026).
///
/// Representa la garantía como un "espacio" a llenar: mientras no tenga bien
/// asignado ni sea DPF se dibuja como un hueco punteado con una acción para
/// asignar el bien; una vez asignada pasa a ser una tarjeta sólida con el
/// color del tipo de garantía y su ícono como marca de agua.
class GarantiaItemCard extends StatefulWidget {
  final int index;
  final GarantiaData garantia;
  final VoidCallback onTap;

  const GarantiaItemCard({
    super.key,
    required this.index,
    required this.garantia,
    required this.onTap,
  });

  @override
  State<GarantiaItemCard> createState() => _GarantiaItemCardState();
}

class _GarantiaItemCardState extends State<GarantiaItemCard> {
  static const _staggerGroupSize = 8;
  static const _radius = 20.0;

  bool _pressed = false;

  bool get _isPendiente =>
      widget.garantia.bienCodigo == null && !widget.garantia.tieneGarantiaDPF;

  void _handleTap() {
    HapticFeedback.selectionClick();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final tipo = _TipoGarantiaVisual.from(widget.garantia.articuloTipo);
    final data = _GarantiaTexts.from(widget.garantia);

    return FadeInUp(
      from: 16,
      duration: const Duration(milliseconds: 320),
      delay: Duration(milliseconds: 40 * (widget.index % _staggerGroupSize)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        child: AnimatedScale(
          scale: _pressed ? 0.97 : 1,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          child: GestureDetector(
            onTap: _handleTap,
            onTapDown: (_) => setState(() => _pressed = true),
            onTapUp: (_) => setState(() => _pressed = false),
            onTapCancel: () => setState(() => _pressed = false),
            child: _isPendiente
                ? _PendienteSlot(tipo: tipo, data: data, radius: _radius)
                : _AsignadaCard(
                    tipo: tipo,
                    data: data,
                    radius: _radius,
                    esDPF: widget.garantia.tieneGarantiaDPF,
                  ),
          ),
        ),
      ),
    );
  }
}

/// Garantía sin bien: hueco punteado que invita a completarlo.
class _PendienteSlot extends StatelessWidget {
  final _TipoGarantiaVisual tipo;
  final _GarantiaTexts data;
  final double radius;
  const _PendienteSlot({
    required this.tipo,
    required this.data,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: tipo.color.withValues(alpha: 0.45),
        radius: radius,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
        decoration: BoxDecoration(
          color: tipo.background.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: RedesignColors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: tipo.color.withValues(alpha: 0.35),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(Icons.add_rounded, color: tipo.color, size: 24),
                ),
                const Gap(14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        [tipo.label, if (data.persona != null) data.persona]
                            .join(' · '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.15,
                          color: RedesignColors.ink,
                        ),
                      ),
                      const Gap(3),
                      Text(
                        data.descripcion ??
                            'Selecciona el bien que respalda esta garantía',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.35,
                          color: RedesignColors.inkMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(14),
            Row(
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  size: 15,
                  color: RedesignColors.amber,
                ),
                const Gap(5),
                const Expanded(
                  child: Text(
                    'Falta asignar un bien',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: RedesignColors.amber,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: tipo.color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Asignar bien',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Gap(6),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 15,
                        color: Colors.white,
                      ),
                    ],
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

/// Garantía con bien asignado (o DPF): tarjeta sólida con el color del tipo.
class _AsignadaCard extends StatelessWidget {
  final _TipoGarantiaVisual tipo;
  final _GarantiaTexts data;
  final double radius;
  final bool esDPF;
  const _AsignadaCard({
    required this.tipo,
    required this.data,
    required this.radius,
    required this.esDPF,
  });

  @override
  Widget build(BuildContext context) {
    final detalle = [
      if (data.persona != null) data.persona!,
      if (data.cobertura != null) '${data.cobertura}% cobertura',
    ].join(' · ');

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            tipo.color,
            Color.lerp(tipo.color, Colors.black, 0.28)!,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: tipo.color.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -18,
            bottom: -22,
            child: Icon(
              tipo.icon,
              size: 120,
              color: Colors.white.withValues(alpha: 0.10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      tipo.icon,
                      size: 15,
                      color: Colors.white.withValues(alpha: 0.75),
                    ),
                    const Gap(6),
                    Text(
                      tipo.label.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: Colors.white.withValues(alpha: 0.75),
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                Text(
                  data.descripcion ?? tipo.label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                    color: Colors.white,
                  ),
                ),
                if (detalle.isNotEmpty) ...[
                  const Gap(3),
                  Text(
                    detalle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
                const Gap(14),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            size: 14,
                            color: Colors.white,
                          ),
                          const Gap(5),
                          Text(
                            esDPF ? 'Garantía DPF' : 'Bien asignado',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 32,
                      width: 32,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.more_horiz_rounded,
                        size: 20,
                        color: tipo.color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;
  const _DashedBorderPainter({required this.color, required this.radius});

  static const _dash = 7.0;
  static const _gap = 5.0;
  static const _strokeWidth = 1.5;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;
    const inset = _strokeWidth / 2;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            inset,
            inset,
            size.width - _strokeWidth,
            size.height - _strokeWidth,
          ),
          Radius.circular(radius),
        ),
      );

    for (final PathMetric metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + _dash),
          paint,
        );
        distance += _dash + _gap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius;
}

class _GarantiaTexts {
  final String? descripcion;
  final String? persona;
  final String? cobertura;

  const _GarantiaTexts({this.descripcion, this.persona, this.cobertura});

  factory _GarantiaTexts.from(GarantiaData garantia) {
    final cobertura = garantia.porcentajeCobertura;
    return _GarantiaTexts(
      descripcion: _firstNotEmpty([garantia.articuloDescripcion]),
      persona: _firstNotEmpty([
        garantia.tipoPersonaValor,
        garantia.tipoPersonaCodigo,
      ]),
      cobertura: cobertura == null || cobertura <= 0
          ? null
          : cobertura == cobertura.roundToDouble()
              ? cobertura.toStringAsFixed(0)
              : cobertura.toStringAsFixed(2),
    );
  }

  static String? _firstNotEmpty(List<String?> values) {
    for (final value in values) {
      if (value != null && value.trim().isNotEmpty) return value.trim();
    }
    return null;
  }
}

class _TipoGarantiaVisual {
  final String label;
  final IconData icon;
  final Color color;
  final Color background;

  const _TipoGarantiaVisual({
    required this.label,
    required this.icon,
    required this.color,
    required this.background,
  });

  factory _TipoGarantiaVisual.from(String? articuloTipo) =>
      switch (articuloTipo?.toTipoGarantiaEnumV2) {
        TipoGarantiaEnumV2.prendaria => const _TipoGarantiaVisual(
            label: 'Prendaria',
            icon: Icons.inventory_2_outlined,
            color: RedesignColors.indigo,
            background: RedesignColors.indigoTint,
          ),
        TipoGarantiaEnumV2.hipotecario => const _TipoGarantiaVisual(
            label: 'Hipotecaria',
            icon: Icons.home_work_outlined,
            color: RedesignColors.purple,
            background: RedesignColors.purpleTint,
          ),
        TipoGarantiaEnumV2.liquido => const _TipoGarantiaVisual(
            label: 'Líquida',
            icon: Icons.savings_outlined,
            color: RedesignColors.teal,
            background: RedesignColors.tealTint,
          ),
        null => _TipoGarantiaVisual(
            label: articuloTipo?.trim().isNotEmpty == true
                ? articuloTipo!.trim()
                : 'Garantía',
            icon: Icons.shield_outlined,
            color: RedesignColors.ink,
            background: RedesignColors.tagBackground,
          ),
      };
}

import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/card_tag_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_icon_tile.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Tarjeta de solicitud de crédito para los listados por estado del rediseño
/// 2026 (mis solicitudes asignadas, rechazar, actualización, supervisiones).
///
/// Reemplaza a `CreditProductDynamicHn`. El chevron solo aparece cuando la fila
/// realmente es accionable ([onTap] distinto de null).
class SolicitudEstadoCard extends StatelessWidget {
  final int index;
  final bool animate;
  final String nombreCliente;
  final String numeroSolicitud;
  final DateTime fecha;
  final String monto;
  final String estado;
  final String? tipoSolicitud;
  final String? nombrePromotor;
  final String? sucursal;
  final VoidCallback? onTap;
  final String currency;

  const SolicitudEstadoCard({
    super.key,
    required this.index,
    this.animate = true,
    required this.nombreCliente,
    required this.numeroSolicitud,
    required this.fecha,
    required this.monto,
    required this.estado,
    this.tipoSolicitud,
    this.nombrePromotor,
    this.sucursal,
    this.onTap,
    this.currency = 'L.',
  });

  static const _staggerGroupSize = 8;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      from: 16,
      duration: animate ? const Duration(milliseconds: 320) : Duration.zero,
      delay: animate
          ? Duration(milliseconds: 40 * (index % _staggerGroupSize))
          : Duration.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Material(
          color: RedesignColors.surface,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: RedesignColors.border),
              ),
              child: Row(
                children: [
                  const ModuleIconTile(
                    icon: Icons.account_balance_outlined,
                    color: RedesignColors.indigo,
                    background: RedesignColors.indigoTint,
                  ),
                  const Gap(13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          nombreCliente,
                          maxLines: 2,
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
                          'Solicitud N. $numeroSolicitud · ${fecha.selectorFormat()}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.35,
                            color: RedesignColors.inkMuted,
                          ),
                        ),
                        const Gap(8),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            CardTagWidget(
                              label: '$currency $monto',
                              color: RedesignColors.green,
                              background: RedesignColors.greenTint,
                            ),
                            if (tipoSolicitud != null &&
                                tipoSolicitud!.isNotEmpty)
                              CardTagWidget(
                                label: tipoSolicitud!,
                                color: RedesignColors.teal,
                                background: RedesignColors.tealTint,
                              ),
                            CardTagWidget(
                              label: estado,
                              color: RedesignColors.amber,
                              background: RedesignColors.amberTint,
                            ),
                          ],
                        ),
                        if (nombrePromotor != null || sucursal != null) ...[
                          const Gap(8),
                          _CardFooterLine(
                            promotor: nombrePromotor,
                            sucursal: sucursal,
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (onTap != null) ...[
                    const Gap(10),
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 20,
                      color: RedesignColors.chevron,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardFooterLine extends StatelessWidget {
  final String? promotor;
  final String? sucursal;
  const _CardFooterLine({this.promotor, this.sucursal});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 11,
      height: 1.3,
      color: RedesignColors.inkMuted,
    );

    return Row(
      children: [
        if (promotor != null) ...[
          const Icon(
            Icons.person_outline,
            size: 14,
            color: RedesignColors.chevron,
          ),
          const Gap(4),
          Expanded(
            child: Text(
              promotor!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: style,
            ),
          ),
        ],
        if (sucursal != null) ...[
          const Gap(8),
          const Icon(
            Icons.location_on_outlined,
            size: 14,
            color: RedesignColors.chevron,
          ),
          const Gap(4),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 110),
            child: Text(
              sucursal!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: style,
            ),
          ),
        ],
      ],
    );
  }
}

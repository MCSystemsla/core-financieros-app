import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/modal_sheet/ni/select_type_analisis_modal_sheet_ni_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/card_tag_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_icon_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart'
    show AnalisisSolicitudesInterceptorType;

class AnalisisCreditCard extends StatelessWidget {
  final int index;
  final bool animate;
  final bool enabled;
  final String title;
  final String subtitle;
  final String description;
  final String numeroSolicitud;
  final String tipoSolicitudString;
  final AnalisisSolicitudesInterceptorType? tipoSolicitud;
  const AnalisisCreditCard({
    super.key,
    required this.index,
    this.animate = true,
    this.enabled = true,
    required this.title,
    required this.subtitle,
    required this.description,
    this.tipoSolicitud,
    required this.numeroSolicitud,
    this.tipoSolicitudString = '',
  });

  static const _staggerGroupSize = 8;

  void _openAnalisisSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => SelectTypeAnalisisModalSheetNiWidget(
        index: index,
        animate: false,
        enabled: true,
        numeroSolicitud: numeroSolicitud,
        tipoSolicitud: tipoSolicitud,
        title: title,
        subtitle: subtitle,
        description: description,
        tipoSolicitudString: tipoSolicitudString,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      from: 16,
      duration: animate ? const Duration(milliseconds: 320) : Duration.zero,
      delay: animate
          ? Duration(milliseconds: 40 * (index % _staggerGroupSize))
          : Duration.zero,
      child: Hero(
        tag: 'analisis-credito-$index',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Material(
            color: RedesignColors.surface,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: enabled ? () => _openAnalisisSheet(context) : null,
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
                            subtitle,
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
                            title,
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
                                label: description,
                                color: RedesignColors.green,
                                background: RedesignColors.greenTint,
                              ),
                              if (tipoSolicitudString.isNotEmpty)
                                CardTagWidget(
                                  label: tipoSolicitudString,
                                  color: RedesignColors.teal,
                                  background: RedesignColors.tealTint,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (enabled) ...[
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
      ),
    );
  }
}

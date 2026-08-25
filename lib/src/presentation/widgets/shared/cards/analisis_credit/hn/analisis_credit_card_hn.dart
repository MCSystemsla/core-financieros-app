import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/cerrar_analisis/cerrar_analisis_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/modal_sheet/select_type_analisis_modal_sheet_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_icon_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AnalisisCreditCardHn extends StatelessWidget {
  final int index;
  final bool animate;
  final bool enabled;
  final String title;
  final String subtitle;
  final String description;
  final String numeroSolicitud;
  final AnalisisSolicitudesInterceptorType? tipoSolicitud;
  final String cedulaCliente;
  final String tipoPersonaCodigo;
  final String monto;
  final String tipoSolicitudString;
  final bool esGrupal;
  final String nombreDelGrupo;
  final int? cicloGrupoId;
  const AnalisisCreditCardHn({
    super.key,
    required this.index,
    this.animate = true,
    this.enabled = true,
    required this.title,
    required this.subtitle,
    required this.description,
    this.tipoSolicitud,
    required this.numeroSolicitud,
    this.cedulaCliente = '',
    this.tipoPersonaCodigo = '',
    this.monto = '0',
    this.tipoSolicitudString = '',
    this.esGrupal = false,
    this.cicloGrupoId,
    this.nombreDelGrupo = '',
  });

  static const _staggerGroupSize = 8;

  void _openAnalisisSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => BlocProvider.value(
        value: context.read<CerrarAnalisisCubit>(),
        child: SelectTypeAnalisisModalSheetWidget(
          index: index,
          animate: false,
          enabled: true,
          numeroSolicitud: numeroSolicitud,
          tipoSolicitud: tipoSolicitud,
          title: title,
          subtitle: subtitle,
          description: description,
          cedulaCliente: cedulaCliente,
          tipoPersonaCodigo: tipoPersonaCodigo,
          monto: monto,
          tipoSolicitudString: tipoSolicitudString,
          esGrupal: esGrupal,
          cicloGrupoId: cicloGrupoId,
        ),
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
          child: _PressableCard(
            onTap: enabled ? () => _openAnalisisSheet(context) : null,
            child: Row(
              children: [
                ModuleIconTile(
                  icon: esGrupal
                      ? Icons.groups_2_outlined
                      : Icons.account_balance_outlined,
                  color:
                      esGrupal ? RedesignColors.purple : RedesignColors.indigo,
                  background: esGrupal
                      ? RedesignColors.purpleTint
                      : RedesignColors.indigoTint,
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
                      if (esGrupal) ...[
                        const Gap(3),
                        Text(
                          'Grupo: $nombreDelGrupo',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            height: 1,
                            color: RedesignColors.inkMuted,
                          ),
                        ),
                      ],
                      const Gap(8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          _CardTag(
                            label: 'L. $description',
                            color: RedesignColors.green,
                            background: RedesignColors.greenTint,
                          ),
                          _CardTag(
                            label: tipoSolicitudString,
                            color: RedesignColors.teal,
                            background: RedesignColors.tealTint,
                          ),
                          if (esGrupal) ...[
                            const _CardTag(
                              label: 'Grupal',
                              color: RedesignColors.purple,
                              background: RedesignColors.purpleTint,
                            ),
                          ]
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
    );
  }
}

class _PressableCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  const _PressableCard({required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
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
          child: child,
        ),
      ),
    );
  }
}

class _CardTag extends StatelessWidget {
  final String label;
  final Color color;
  final Color background;
  const _CardTag({
    required this.label,
    required this.color,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

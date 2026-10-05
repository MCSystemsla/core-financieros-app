import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_data_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_articulo/analisis_articulo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_garantia/analisis_garantia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/fiadores_garantia/fiadores_garantia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/garantia/crear_garantia_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/module_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../bloc/analisis/hn/analisis_anular_garantia/analisis_anular_garantia_cubit.dart';

/// Resumen de garantías de la solicitud y acceso al listado donde se crean y
/// se les asigna el bien.
class TiposGarantiaHNWidget extends StatelessWidget {
  final int numeroSolicitud;
  final String solicitudCodigo;
  final String cedulaCliente;
  const TiposGarantiaHNWidget({
    super.key,
    required this.numeroSolicitud,
    required this.solicitudCodigo,
    required this.cedulaCliente,
  });

  void _goToGarantias(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: context.read<AnalisisGarantiaCubit>(),
            ),
            BlocProvider.value(
              value: context.read<AnalisisArticuloCubit>(),
            ),
            BlocProvider.value(
              value: context.read<FiadoresGarantiaCubit>(),
            ),
            BlocProvider.value(
              value: context.read<AnalisisAnularGarantiaCubit>(),
            ),
          ],
          child: CrearGarantiaScreen(
            numeroSolicitud: numeroSolicitud,
            solicitudCodigo: solicitudCodigo,
            cedulaCliente: cedulaCliente,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalisisGarantiaCubit, AnalisisGarantiaState>(
      builder: (context, state) {
        final isLoading = state.status == Status.inProgress;
        final pendientes =
            state.analisisGarantia.where(_isPendiente).length;

        return Column(
          children: [
            _GarantiasResumenCard(
              isLoading: isLoading,
              isError: state.status == Status.error,
              garantias: state.analisisGarantia,
            ),
            const Gap(12),
            ModuleTileWidget(
              icon: Icons.shield_outlined,
              iconColor: RedesignColors.indigo,
              iconBackground: RedesignColors.indigoTint,
              title: 'Tipos de garantías',
              subtitle: 'Crea garantías y asigna el bien que respalda cada una',
              tag: !isLoading && pendientes > 0
                  ? '$pendientes ${pendientes == 1 ? 'pendiente' : 'pendientes'}'
                  : null,
              onPressed: () => _goToGarantias(context),
            ),
          ],
        );
      },
    );
  }
}

bool _isPendiente(GarantiaData garantia) =>
    garantia.bienCodigo == null && !garantia.tieneGarantiaDPF;

/// Tarjeta de avance: cuántas garantías hay y cuántas ya tienen bien.
/// Cada garantía es un segmento de la barra, verde si está asignada y ámbar si
/// sigue pendiente, igual que las tarjetas del listado.
class _GarantiasResumenCard extends StatelessWidget {
  static const _maxSegmentos = 10;

  final bool isLoading;
  final bool isError;
  final List<GarantiaData> garantias;
  const _GarantiasResumenCard({
    required this.isLoading,
    required this.isError,
    required this.garantias,
  });

  @override
  Widget build(BuildContext context) {
    final total = garantias.length;
    final pendientes = garantias.where(_isPendiente).length;
    final asignadas = total - pendientes;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: RedesignColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                isLoading || isError ? '–' : '$total',
                style: const TextStyle(
                  fontSize: 44,
                  height: 1,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.5,
                  color: RedesignColors.ink,
                ),
              ),
              const Gap(10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    total == 1 ? 'garantía registrada' : 'garantías registradas',
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: RedesignColors.inkMuted,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(16),
          if (isLoading)
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: const LinearProgressIndicator(
                minHeight: 8,
                color: RedesignColors.green,
                backgroundColor: RedesignColors.greenTint,
              ),
            )
          else if (isError)
            const Text(
              'No se pudieron cargar las garantías. Vuelve a abrir la pantalla para reintentar.',
              style: TextStyle(
                fontSize: 12.5,
                height: 1.4,
                color: RedesignColors.red,
              ),
            )
          else if (total == 0)
            const Text(
              'Aún no hay garantías. Entra a "Tipos de garantías" para crear la primera.',
              style: TextStyle(
                fontSize: 12.5,
                height: 1.4,
                color: RedesignColors.inkMuted,
              ),
            )
          else ...[
            _ProgresoBar(
              asignadas: asignadas,
              total: total,
              segmentado: total <= _maxSegmentos,
            ),
            const Gap(14),
            Row(
              children: [
                _StatChip(
                  icon: Icons.check_circle_rounded,
                  label: '$asignadas con bien',
                  color: RedesignColors.green,
                  background: RedesignColors.greenTint,
                ),
                const Gap(8),
                if (pendientes > 0)
                  _StatChip(
                    icon: Icons.schedule_rounded,
                    label:
                        '$pendientes ${pendientes == 1 ? 'pendiente' : 'pendientes'}',
                    color: RedesignColors.amber,
                    background: RedesignColors.amberTint,
                  )
                else
                  const _StatChip(
                    icon: Icons.done_all_rounded,
                    label: 'Todo listo',
                    color: RedesignColors.teal,
                    background: RedesignColors.tealTint,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ProgresoBar extends StatelessWidget {
  final int asignadas;
  final int total;
  final bool segmentado;
  const _ProgresoBar({
    required this.asignadas,
    required this.total,
    required this.segmentado,
  });

  @override
  Widget build(BuildContext context) {
    if (!segmentado) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: asignadas / total,
          minHeight: 8,
          color: RedesignColors.green,
          backgroundColor: RedesignColors.amberTint,
        ),
      );
    }

    return Row(
      children: [
        for (var i = 0; i < total; i++) ...[
          if (i > 0) const Gap(4),
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 8,
              decoration: BoxDecoration(
                color: i < asignadas
                    ? RedesignColors.green
                    : RedesignColors.amber.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color background;
  const _StatChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const Gap(5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

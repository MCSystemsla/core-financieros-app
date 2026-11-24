import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/ni/cubit/solicitudes_by_estado_ni/solicitudes_by_estado_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/modal_sheet/show_filter_creditos_by_estado.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/ni/asign_solicitud_asesor/bottom_sheet/show_filter_get_by_cedula_and_numero.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

/// Barra de filtros de las listas NI por estado: campo de búsqueda (abre el
/// filtro por número, cédula o nombre y resume los filtros activos) y botón
/// del filtro por estado.
class FilterContent extends StatelessWidget {
  const FilterContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudesByEstadoNiCubit, SolicitudesByEstadoNiState>(
      builder: (context, state) {
        final cubit = context.read<SolicitudesByEstadoNiCubit>();
        final resumen = _resumenFiltros(state);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: _BusquedaButton(
                  resumen: resumen,
                  onTap: () => showFilterGetByCedualAndNumeroSolicitud(
                    context,
                    state.isNumeroSolicitudFilter,
                    state.numeroSolicitud,
                    state.isCedulaSolicitudFilter,
                    state.cedulaCliente,
                    state.isNombreCompletoFilter,
                    state.nombreCompleto,
                    cubit,
                  ),
                  onLimpiar: () {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        isNumeroSolicitudFilter: false,
                        isCedulaSolicitudFilter: false,
                        isNombreCompletoFilter: false,
                        numeroSolicitud: '',
                        cedulaCliente: '',
                        nombreCompleto: '',
                      ),
                    );
                    cubit.getSolicitudesByEstado(
                      estadoCredito: cubit.state.estadoCredito,
                      isAsignadaToAsesorCredito:
                          cubit.state.isAsignadaToAsesorCredito,
                    );
                  },
                ),
              ),
              const Gap(10),
              _IconoFiltroButton(
                onTap: () => showFilterCreditosByEstado(
                  context,
                  state.estadoCredito,
                  state.isAsignadaToAsesorCredito,
                  cubit,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Texto con los filtros aplicados, o null si no hay ninguno.
  String? _resumenFiltros(SolicitudesByEstadoNiState state) {
    final partes = [
      if (state.isNumeroSolicitudFilter && state.numeroSolicitud.isNotEmpty)
        'N.º ${state.numeroSolicitud}',
      if (state.isCedulaSolicitudFilter && state.cedulaCliente.isNotEmpty)
        state.cedulaCliente,
      if (state.isNombreCompletoFilter &&
          state.nombreCompleto.trim().isNotEmpty)
        state.nombreCompleto.trim(),
    ];
    return partes.isEmpty ? null : partes.join(' · ');
  }
}

class _BusquedaButton extends StatelessWidget {
  final String? resumen;
  final VoidCallback onTap;
  final VoidCallback onLimpiar;

  const _BusquedaButton({
    required this.resumen,
    required this.onTap,
    required this.onLimpiar,
  });

  @override
  Widget build(BuildContext context) {
    final activo = resumen != null;
    final radius = BorderRadius.circular(14);

    return Material(
      color: activo ? RedesignColors.tealTint : RedesignColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(
          color: activo
              ? RedesignColors.teal.withValues(alpha: 0.35)
              : RedesignColors.border,
        ),
      ),
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: SizedBox(
          height: 48,
          child: Row(
            children: [
              const Gap(14),
              Icon(
                activo ? Icons.filter_alt_rounded : Icons.search_rounded,
                size: 20,
                color: activo ? RedesignColors.teal : RedesignColors.inkMuted,
              ),
              const Gap(10),
              Expanded(
                child: Text(
                  resumen ?? 'Buscar por número, cédula o nombre',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: activo ? FontWeight.w600 : FontWeight.w400,
                    color: activo ? RedesignColors.teal : RedesignColors.chevron,
                  ),
                ),
              ),
              if (activo)
                IconButton(
                  tooltip: 'Quitar filtros',
                  onPressed: onLimpiar,
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: RedesignColors.teal,
                  ),
                )
              else
                const Gap(14),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconoFiltroButton extends StatelessWidget {
  final VoidCallback onTap;

  const _IconoFiltroButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(14);

    return Material(
      color: RedesignColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: const BorderSide(color: RedesignColors.border),
      ),
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: const SizedBox(
          width: 48,
          height: 48,
          child: Tooltip(
            message: 'Filtrar por estado',
            child: Icon(
              Icons.tune_rounded,
              size: 20,
              color: RedesignColors.ink,
            ),
          ),
        ),
      ),
    );
  }
}

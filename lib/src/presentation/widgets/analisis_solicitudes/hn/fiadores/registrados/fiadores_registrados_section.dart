import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores/fiador_solicitud_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/fiadores_solicitud/fiadores_solicitud_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/card_tag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

/// Sección "Registrados en el sistema" de `FiadoresHnScreen` (SPEC 10): los
/// fiadores con vínculo activo de la solicitud según el backend.
///
/// Lee [FiadoresSolicitudHnCubit] del contexto. [onTap] es null mientras la
/// tarjeta no navega.
class FiadoresRegistradosSection extends StatelessWidget {
  final VoidCallback onRetry;
  final ValueChanged<FiadorSolicitudHn>? onTap;

  const FiadoresRegistradosSection({
    super.key,
    required this.onRetry,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiadoresSolicitudHnCubit, FiadoresSolicitudHnState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Registrados en el sistema',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
                color: RedesignColors.inkMuted,
              ),
            ),
            const Gap(10),
            ..._contenido(state),
          ],
        );
      },
    );
  }

  List<Widget> _contenido(FiadoresSolicitudHnState state) {
    switch (state.status) {
      case Status.notStarted:
      case Status.inProgress:
        return [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              minHeight: 3,
              color: RedesignColors.green,
              backgroundColor: RedesignColors.greenTint,
            ),
          ),
        ];
      case Status.error:
        return [
          _Mensaje(
            texto: state.errorMsg.isEmpty
                ? 'No se pudieron cargar los fiadores registrados'
                : state.errorMsg,
            color: RedesignColors.red,
            background: RedesignColors.redTint,
            accion: TextButton(
              onPressed: onRetry,
              child: const Text(
                'Reintentar',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: RedesignColors.red,
                ),
              ),
            ),
          ),
        ];
      case Status.done:
        if (state.fiadores.isEmpty) {
          return const [
            _Mensaje(
              texto: 'Esta solicitud aún no tiene fiadores registrados',
              color: RedesignColors.inkMuted,
              background: RedesignColors.tagBackground,
            ),
          ];
        }
        return [
          for (final fiador in state.fiadores) ...[
            _FiadorRegistradoCard(
              fiador: fiador,
              cargando: state.cargandoCedula == fiador.fiador.cedula,
              onTap: onTap == null ? null : () => onTap!(fiador),
            ),
            const Gap(10),
          ],
        ];
    }
  }
}

class _FiadorRegistradoCard extends StatelessWidget {
  final FiadorSolicitudHn fiador;
  final bool cargando;
  final VoidCallback? onTap;

  const _FiadorRegistradoCard({
    required this.fiador,
    required this.cargando,
    required this.onTap,
  });

  /// Mismos colores que las filas Cónyuge/Aval/Codeudor de la pantalla.
  (Color, Color) get _colores => switch (fiador.fiador.tipoFiadorCodigo) {
        'TFD2' => (RedesignColors.purple, RedesignColors.purpleTint),
        'TFD3' => (RedesignColors.teal, RedesignColors.tealTint),
        _ => (RedesignColors.indigo, RedesignColors.indigoTint),
      };

  @override
  Widget build(BuildContext context) {
    final (color, background) = _colores;
    final tipo = fiador.tipoFiadorNombre.isNotEmpty
        ? fiador.tipoFiadorNombre
        : fiador.fiador.tipoFiadorCodigo;

    return InkWell(
      onTap: cargando ? null : onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: RedesignColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: RedesignColors.border),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fiador.nombreCompleto,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.15,
                      color: RedesignColors.ink,
                    ),
                  ),
                  const Gap(3),
                  Text(
                    fiador.fiador.cedula,
                    style: const TextStyle(
                      fontSize: 12,
                      color: RedesignColors.inkMuted,
                    ),
                  ),
                ],
              ),
            ),
            if (tipo.isNotEmpty) ...[
              const Gap(10),
              CardTagWidget(label: tipo, color: color, background: background),
            ],
            const Gap(10),
            if (cargando)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: RedesignColors.green,
                ),
              )
            else
              const Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: RedesignColors.chevron,
              ),
          ],
        ),
      ),
    );
  }
}

class _Mensaje extends StatelessWidget {
  final String texto;
  final Color color;
  final Color background;
  final Widget? accion;

  const _Mensaje({
    required this.texto,
    required this.color,
    required this.background,
    this.accion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 6, 12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              texto,
              style: TextStyle(fontSize: 13, height: 1.35, color: color),
            ),
          ),
          if (accion != null) accion!,
        ],
      ),
    );
  }
}

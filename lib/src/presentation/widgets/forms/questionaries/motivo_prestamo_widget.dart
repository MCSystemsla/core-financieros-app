import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

/// Motivo del préstamo anterior (solo lectura), en los formularios Kiva
/// recurrentes.
class MotivoPrestamoWidget extends StatelessWidget {
  const MotivoPrestamoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final motivoAnterior =
        context.read<KivaRouteCubit>().state.motivoAnterior.trim();

    return KivaPreguntaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'MOTIVO DEL PRÉSTAMO ANTERIOR',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.1,
              color: RedesignColors.inkMuted,
            ),
          ),
          const Gap(8),
          Text(
            motivoAnterior.isEmpty ? 'Sin motivo registrado' : motivoAnterior,
            style: TextStyle(
              fontSize: 15,
              height: 1.4,
              fontWeight:
                  motivoAnterior.isEmpty ? FontWeight.w400 : FontWeight.w600,
              fontStyle:
                  motivoAnterior.isEmpty ? FontStyle.italic : FontStyle.normal,
              color: motivoAnterior.isEmpty
                  ? RedesignColors.chevron
                  : RedesignColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}

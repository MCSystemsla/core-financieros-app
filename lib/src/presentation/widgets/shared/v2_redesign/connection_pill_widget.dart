import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

/// Indicador de conexión del rediseño 2026, para la esquina derecha de las
/// cabeceras. Lee el estado de [InternetConnectionCubit]: verde cuando la
/// conexión está confirmada, gris en cualquier otro estado.
class ConnectionPillWidget extends StatelessWidget {
  const ConnectionPillWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
      builder: (context, state) {
        final isOnline = state.connectionStatus == ConnectionStatus.connected;

        return Container(
          height: 34,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: isOnline
                ? RedesignColors.greenTint
                : RedesignColors.tagBackground,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Row(
            children: [
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isOnline
                      ? RedesignColors.onlineDot
                      : RedesignColors.chevron,
                ),
              ),
              const Gap(7),
              Text(
                isOnline ? 'En línea' : 'Offline',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color:
                      isOnline ? RedesignColors.green : RedesignColors.inkMuted,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/ni/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/ni/cubit/autorizar_solicitud/autorizar_solicitud_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/ni/cubit/solicitudes_by_estado_ni/solicitudes_by_estado_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/close_analisis_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Hoja inferior para autorizar una solicitud de crédito en Nicaragua.
/// Usa el mismo endpoint de autorización que Honduras
/// (`/cartera/solicitudes/general/autorizar-solicitud`).
void showAutorizarSolicitudBottomSheet(
  BuildContext context,
  int numeroSolicitud,
  String tipoSolicitud,
  String nombreCliente,
  SolicitudesByEstadoNiCubit cubit,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (_) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) => AutorizarSolicitudNiCubit(
              SolicitudCreditoRepositoryImpl(),
            ),
          ),
          BlocProvider.value(value: cubit),
        ],
        child: _AutorizarSolicitudSheetContent(
          numeroSolicitud: numeroSolicitud,
          tipoSolicitud: tipoSolicitud,
          nombreCliente: nombreCliente,
          cubit: cubit,
        ),
      );
    },
  );
}

class _AutorizarSolicitudSheetContent extends StatelessWidget {
  final int numeroSolicitud;
  final String tipoSolicitud;
  final String nombreCliente;
  final SolicitudesByEstadoNiCubit cubit;

  const _AutorizarSolicitudSheetContent({
    required this.numeroSolicitud,
    required this.tipoSolicitud,
    required this.nombreCliente,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = AppColors.getSecondaryColor();

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.greyWithOpacityV4,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 22),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.verified_user_outlined,
                    size: 22,
                    color: accent,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Autorizar solicitud',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Al autorizar, la solicitud pasa a la siguiente etapa del proceso de crédito.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.grey,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.greyWithOpacityV4.withOpacity(0.12),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.borderGrey.withOpacity(.4)),
              ),
              child: Column(
                children: [
                  _InfoRow(
                    icon: Icons.tag,
                    label: 'Numero Solicitud',
                    value: '$numeroSolicitud',
                  ),
                  const _Divider(),
                  _InfoRow(
                    icon: Icons.person_outline,
                    label: 'Nombre cliente',
                    value: nombreCliente,
                  ),
                  const _Divider(),
                  _InfoRow(
                    icon: Icons.description_outlined,
                    label: 'Tipo de solicitud',
                    value: tipoSolicitud,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            BlocConsumer<AutorizarSolicitudNiCubit, AutorizarSolicitudNiState>(
              listener: (context, state) {
                if (state is OnAutorizarSolicitudNiSuccess) {
                  CustomAlertDialog(
                    context: context,
                    title: 'Solicitud autorizada exitosamente.',
                    onDone: () {
                      cubit.getSolicitudesByEstado(
                        isAsignadaToAsesorCredito: true,
                      );
                      final navigator = Navigator.of(context);
                      navigator.pop();
                      navigator.pop();
                    },
                  ).showDialog(
                    context,
                    dialogType: DialogType.success,
                  );
                }
                if (state is OnAutorizarSolicitudNiError) {
                  CustomAlertDialog(
                    context: context,
                    title: state.errorMsg,
                    onDone: () => context.pop(),
                  ).showDialog(context, dialogType: DialogType.error);
                }
              },
              builder: (context, state) {
                final isLoading = state is OnAutorizarSolicitudNiLoading;

                return SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    enabled: !isLoading,
                    color: accent,
                    text: isLoading ? 'Procesando...' : 'Autorizar',
                    icon: const Icon(
                      Icons.verified_user,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      CloseAnalisisDialog(
                        context: context,
                        title:
                            '¿Estás seguro que desea autorizar la solicitud?',
                        onYes: () {
                          context.pop();
                          context
                              .read<AutorizarSolicitudNiCubit>()
                              .autorizarSolicitudCredito(
                                numeroSolicitud: numeroSolicitud,
                                tipoSolicitud: tipoSolicitud,
                              );
                        },
                      ).showDialog(
                        context,
                        dialogType: DialogType.infoReverse,
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Cancelar',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.grey,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppColors.borderGrey.withOpacity(.3),
    );
  }
}

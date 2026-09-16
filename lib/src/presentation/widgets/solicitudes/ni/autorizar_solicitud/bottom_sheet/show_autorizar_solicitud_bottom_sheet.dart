import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/ni/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/ni/cubit/autorizar_solicitud/autorizar_solicitud_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitudes_nueva_by_estado/solicitud_nueva_by_estado_cubit.dart';
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
  SolicitudNuevaByEstadoCubit cubit,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
        child: Padding(
          padding: const EdgeInsets.only(
            top: 24,
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.verified_user, size: 24, color: Colors.indigo),
                    SizedBox(width: 8),
                    Text(
                      'Autorizar solicitud',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Al autorizar, la solicitud pasa a la siguiente etapa del proceso de crédito.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Numero Solicitud: $numeroSolicitud',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Nombre cliente: $nombreCliente',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tipo de solicitud: $tipoSolicitud',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 30),
                BlocConsumer<AutorizarSolicitudNiCubit,
                    AutorizarSolicitudNiState>(
                  listener: (context, state) {
                    if (state is OnAutorizarSolicitudNiSuccess) {
                      CustomAlertDialog(
                        context: context,
                        title: 'Solicitud autorizada exitosamente.',
                        onDone: () {
                          cubit.getSolicitudesByEstado(
                            isAsignadaToAsesorCredito: true,
                          );
                          Navigator.of(context).pop();
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
                        color: AppColors.getSecondaryColor(),
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
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      );
    },
  );
}

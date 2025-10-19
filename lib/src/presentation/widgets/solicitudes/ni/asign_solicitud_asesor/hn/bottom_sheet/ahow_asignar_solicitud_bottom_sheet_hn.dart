import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/asesor/asesor.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/asesores_hn/asesores_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/asign_solicitud_to_asesor_hn/asign_solicitud_to_asesor_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitudes_by_estado_hn/solicitudes_by_estado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void showAsignarSolicitudBottomSheetHN(
  BuildContext context,
  int solicitudId,
  String numeroSolicitud,
  String nombreCliente,
  TypeForm typeForm,
  SolicitudesByEstadoHnCubit cubit,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      AsesorData? asesorSeleccionado;
      final formKey = GlobalKey<FormState>();

      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) => AsesoresHnCubit(
              SolicitudesCreditoHnRepositoryImpl(),
            )..getAsesores(),
          ),
          BlocProvider(
            create: (ctx) => AsignSolicitudToAsesorHnCubit(
              SolicitudesCreditoHnRepositoryImpl(),
            ),
          ),
          BlocProvider.value(
            value: cubit,
          ),
        ],
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 24,
            left: 20,
            right: 20,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person_add_alt,
                              size: 24, color: Colors.indigo),
                          const SizedBox(width: 8),
                          Text(
                            'Asignar Solicitud',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Designá al asesor encargado y actualizá el estado de la solicitud.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        numeroSolicitud,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Nombre cliente: $nombreCliente',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                      ),

                      const SizedBox(height: 27),

                      // Asesor
                      Text('Asesor',
                          style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(height: 8),
                      BlocBuilder<AsesoresHnCubit, AsesoresHnState>(
                        builder: (context, state) {
                          return switch (state) {
                            OnAsesoresHnError() =>
                              const Text('Error obteniendo asesores'),
                            OnAsesoresHnLoading() => const LoadingWidget(),
                            OnAsesoresHnSuccess() =>
                              DropdownButtonFormField<AsesorData>(
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 12,
                                ),
                                value: asesorSeleccionado,
                                validator: (value) =>
                                    ClassValidator.validateRequired(
                                  value?.nombre,
                                ),
                                decoration: InputDecoration(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.account_circle_outlined,
                                  ),
                                  hintText: 'Seleccioná un asesor',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 14),
                                ),
                                items: state.asesor.data.map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Text(e.nombre),
                                  );
                                }).toList(),
                                onChanged: (value) =>
                                    setState(() => asesorSeleccionado = value),
                              ),
                            _ => const SizedBox(),
                          };
                        },
                      ),
                      const SizedBox(height: 30),
                      BlocConsumer<AsignSolicitudToAsesorHnCubit,
                          AsignSolicitudToAsesorHnState>(
                        listener: (context, state) {
                          if (state is OnAsignSolicitudToAsesorHnSuccess) {
                            CustomAlertDialog(
                              context: context,
                              title: 'Solicitud asignada exitosamente a asesor',
                              onDone: () {
                                cubit.getSolicitudesByEstado();
                                Navigator.of(context).pop();
                              },
                            ).showDialog(
                              context,
                              dialogType: DialogType.success,
                            );
                          }
                          if (state is OnAsignSolicitudToAsesorHnError) {
                            CustomAlertDialog(
                              context: context,
                              title: state.errorMsg,
                              onDone: () => context.pop(),
                            ).showDialog(context, dialogType: DialogType.error);
                          }
                        },
                        builder: (context, state) {
                          return SizedBox(
                            width: double.infinity,
                            child: CustomElevatedButton(
                              enabled:
                                  state is! OnAsignSolicitudToAsesorHnLoading,
                              color: AppColors.getSecondaryColor(),
                              text: state is OnAsignSolicitudToAsesorHnLoading
                                  ? 'Procesando...'
                                  : 'Guardar cambios',
                              icon: const Icon(
                                Icons.save_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (!formKey.currentState!.validate()) return;
                                context
                                    .read<AsignSolicitudToAsesorHnCubit>()
                                    .asignSolicitudToAsesor(
                                      idSolicitud: solicitudId,
                                      idPromotor: asesorSeleccionado?.id ?? 0,
                                      typeForm: typeForm,
                                    );
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/asesor/asesor.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/asesores/asesores_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/asign_solicitud_to_asesor/asign_solicitud_to_asesor_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';

class CreditProductItem extends StatelessWidget {
  final String nombre;
  final String cuota;
  final String monto;
  final String estadoCodigo;
  final String solicitudId;
  final String sucursal;
  final String? nombreCliente;
  final TypeForm typeForm;

  const CreditProductItem({
    super.key,
    required this.nombre,
    required this.cuota,
    required this.monto,
    required this.estadoCodigo,
    required this.sucursal,
    required this.typeForm,
    required this.solicitudId,
    this.nombreCliente,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: () {
          if (estadoCodigo != 'REG') {
            CustomAlertDialog(
              context: context,
              title:
                  'Solo se puede asignar una solicitud cuando el estado es REG',
              onDone: () => context.pop(),
            ).showDialog(context);
            return;
          }
          showAsignarSolicitudBottomSheet(
            context,
            int.tryParse(solicitudId) ?? 0,
            typeForm,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título principal
            Row(
              children: [
                const Icon(Icons.account_balance, color: Colors.indigo),
                const SizedBox(width: 8),
                Text(
                  nombre,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                const Icon(Icons.chevron_right),
              ],
            ),
            const SizedBox(height: 12),

            // Datos principales
            Row(
              children: [
                _InfoTag(icon: Icons.percent, label: 'Cuota', value: cuota),
                _InfoTag(
                    icon: Icons.monetization_on, label: 'Monto', value: monto),
                _InfoTag(
                  icon: Icons.star_outline,
                  label: 'Estado',
                  value: estadoCodigo,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Aval + sucursal
            Row(
              children: [
                Icon(Icons.person_2_outlined,
                    size: 18, color: Colors.grey[600]),
                const SizedBox(width: 4),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: Text(
                    nombreCliente ?? 'N/A',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(sucursal, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTag extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTag({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.blueGrey),
          const SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(fontSize: 11, color: Colors.grey)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}

void showAsignarSolicitudBottomSheet(
  BuildContext context,
  int solicitudId,
  TypeForm typeForm,
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
            create: (ctx) => AsesoresCubit(
              SolicitudCreditoRepositoryImpl(),
            )..getAsesores(),
          ),
          BlocProvider(
            create: (ctx) => AsignSolicitudToAsesorCubit(
              SolicitudCreditoRepositoryImpl(),
            ),
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
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey[600]),
                      ),

                      const SizedBox(height: 27),

                      // Asesor
                      Text('Asesor',
                          style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(height: 8),
                      BlocBuilder<AsesoresCubit, AsesoresState>(
                        builder: (context, state) {
                          return switch (state) {
                            OnAsesoresError() =>
                              const Text('Error obteniendo asesores'),
                            OnAsesoresLoading() => const LoadingWidget(),
                            OnAsesoresSuccess() =>
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
                      BlocConsumer<AsignSolicitudToAsesorCubit,
                          AsignSolicitudToAsesorState>(
                        listener: (context, state) {
                          if (state is OnAsignSolicitudToAsesorSuccess) {
                            CustomAlertDialog(
                              context: context,
                              title:
                                  'Solicitud asignada exitosamente a promotor',
                              onDone: () {
                                context.pop();
                              },
                            ).showDialog(
                              context,
                              dialogType: DialogType.success,
                            );
                          }
                          if (state is OnAsignSolicitudToAsesorError) {
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
                                  state is! OnAsignSolicitudToAsesorLoading,
                              color: AppColors.getSecondaryColor(),
                              text: state is OnAsignSolicitudToAsesorLoading
                                  ? 'Procesando...'
                                  : 'Guardar cambios',
                              icon: const Icon(
                                Icons.save_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (!formKey.currentState!.validate()) return;
                                context
                                    .read<AsignSolicitudToAsesorCubit>()
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

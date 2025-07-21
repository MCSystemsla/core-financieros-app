import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitudes_nueva_by_estado/solicitud_nueva_by_estado_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

void showFilterGetByCedualAndNumeroSolicitud(
  BuildContext context,
  bool isNumeroSolicitudFilter,
  String? numeroSolicitud,
  bool isCedulaSolicitudFilter,
  String? cedulaCliente,
  SolicitudNuevaByEstadoCubit cubit,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return BlocProvider.value(
        value: cubit,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 24,
            left: 20,
            right: 20,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              final formKey = GlobalKey<FormState>();
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.filter_alt_rounded,
                            size: 24,
                            color: Colors.indigo,
                          ),
                          const Gap(15),
                          Text(
                            'Filtrar por tipo de solicitud',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const Gap(10),
                      Text(
                        'Filtra las solicitudes por Cedula Cliente y Numero Solciitud',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey[600]),
                      ),
                      const Gap(20),
                      SwitchListTile(
                        value: isNumeroSolicitudFilter,
                        onChanged: (value) {
                          setState(() {
                            isNumeroSolicitudFilter = value;
                          });
                        },
                        title: const Text('Numero Solicitud'),
                        subtitle: const Text(
                          'Filtra las solicitudes por numero de solicitud',
                        ),
                      ),
                      if (isNumeroSolicitudFilter)
                        FadeIn(
                          child: OutlineTextfieldWidget(
                            initialValue: numeroSolicitud,
                            onChange: (value) {
                              numeroSolicitud = value;
                            },
                            validator: (value) =>
                                ClassValidator.validateRequired(value),
                            title: 'Ingresa el numero de solicitud',
                            hintText: 'Ej: 33234',
                            icon: const Icon(Icons.request_page),
                            textInputType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      const Gap(20),
                      SwitchListTile(
                        value: isCedulaSolicitudFilter,
                        onChanged: (value) {
                          setState(() {
                            isCedulaSolicitudFilter = value;
                          });
                        },
                        title: const Text('Cedula del Cliente'),
                        subtitle: const Text(
                          'Filtra las solicitudes por cedula del cliente',
                        ),
                      ),
                      if (isCedulaSolicitudFilter)
                        FadeIn(
                          child: OutlineTextfieldWidget(
                            initialValue: cedulaCliente,
                            validator: (value) =>
                                ClassValidator.validateRequired(value),
                            title: 'Ingresa cedula del Cliente',
                            hintText: 'Ej: 0809199901218T',
                            icon: const Icon(Icons.person),
                            onChange: (value) {
                              cedulaCliente = value;
                            },
                            inputFormatters: [
                              UpperCaseTextFormatter(),
                            ],
                          ),
                        ),
                      const Gap(20),
                      CustomElevatedButton(
                        onPressed: () {
                          cubit.getSolicitudesByEstado(
                            isNumeroSolicitudFilter: false,
                            isCedulaSolicitudFilter: false,
                            numeroSolicitud: null,
                            cedulaCliente: null,
                          );
                          context.pop();
                        },
                        text: 'Limpiar Filtros',
                        color: AppColors.red,
                        icon: const Icon(
                          Icons.filter_alt_off_rounded,
                          color: Colors.white,
                        ),
                      ),
                      const Gap(20),
                      CustomElevatedButton(
                        enabled:
                            isNumeroSolicitudFilter || isCedulaSolicitudFilter,
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          if (!isNumeroSolicitudFilter) {
                            numeroSolicitud = null;
                          }
                          if (!isCedulaSolicitudFilter) {
                            cedulaCliente = null;
                          }
                          cubit.getSolicitudesByEstado(
                            isNumeroSolicitudFilter: isNumeroSolicitudFilter,
                            isCedulaSolicitudFilter: isCedulaSolicitudFilter,
                            numeroSolicitud: numeroSolicitud,
                            cedulaCliente: cedulaCliente,
                          );
                          context.pop();
                        },
                        text: 'Guardar Cambios',
                        color: AppColors.getSecondaryColor(),
                        icon: const Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                      ),
                      const Gap(20),
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

import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_user_location/analisis_user_location_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationCardContainer extends StatelessWidget {
  final Position position;
  final GoogleMapController controller;
  final String documentoCliente;
  final int numeroSolicitud;
  final String tipoSolicitud;
  const LocationCardContainer({
    super.key,
    required this.position,
    required this.controller,
    required this.documentoCliente,
    required this.numeroSolicitud,
    required this.tipoSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SlideInUp(
        duration: const Duration(milliseconds: 200),
        child: Container(
          height: size.height * 0.4,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 42,
                    height: 5,
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                UserLocationContent(
                  position: position,
                  controller: controller,
                  documentoCliente: documentoCliente,
                  numeroSolicitud: numeroSolicitud,
                  tipoSolicitud: tipoSolicitud,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserLocationContent extends StatefulWidget {
  final Position position;
  final GoogleMapController controller;
  final String documentoCliente;
  final int numeroSolicitud;
  final String tipoSolicitud;
  const UserLocationContent({
    super.key,
    required this.position,
    required this.controller,
    required this.documentoCliente,
    required this.numeroSolicitud,
    required this.tipoSolicitud,
  });

  @override
  State<UserLocationContent> createState() => _UserLocationContentState();
}

class _UserLocationContentState extends State<UserLocationContent> {
  String? ubicacionGpsCodigo;
  String? referencia;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    context.read<AnalisisUserLocationCubit>().getPlaceAddressByLatLang(
          latitude: widget.position.latitude,
          longitude: widget.position.longitude,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnalisisUserLocationCubit, AnalisisUserLocationState>(
      listenWhen: (previous, current) =>
          previous.statusCreation != current.statusCreation,
      listener: (context, state) {
        if (state.statusCreation == Status.error) {
          CustomAlertDialog(
            context: context,
            title: state.errorMsg,
            onDone: () => context.pop(),
          ).showDialog(
            context,
            dialogType: DialogType.error,
          );
        }
        if (state.statusCreation == Status.done) {
          CustomAlertDialog(
            context: context,
            title: 'La ubicación del cliente fue registrada exitosamente',
            onDone: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AnalisisInterceptorByFlavor(),
              ),
            ),
          ).showDialog(
            context,
            dialogType: DialogType.success,
          );
        }
      },
      builder: (context, state) {
        return switch (state.status) {
          Status.inProgress => const Column(
              children: [
                Gap(30),
                LoadingWidget(),
              ],
            ),
          Status.error => Text('Error: ${state.errorMsg}'),
          Status.done => Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(8),
                  Text(
                    'Ubicación actual',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Gap(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.place_rounded,
                        size: 18,
                        color: AppColors.getPrimaryColor(),
                      ),
                      const Gap(6),
                      Expanded(
                        child: Text(
                          state.placeAddress,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey.shade700,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  SearchDropdownWidget(
                    codigo: 'UBICACIONGPS',
                    title: 'Tipo de ubicación',
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    onChanged: (v) {
                      if (v == null) return;
                      ubicacionGpsCodigo = v.value;
                    },
                  ),
                  const Gap(16),
                  OutlineTextfieldWidget(
                    title: 'Referencia adicional',
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    icon: Icon(
                      Icons.location_on_outlined,
                      color: AppColors.getPrimaryColor(),
                    ),
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    onChange: (value) {
                      referencia = value;
                    },
                  ),
                  const Gap(24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton.icon(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        context
                            .read<AnalisisUserLocationCubit>()
                            .createUserLocation(
                              latlng: LatLng(
                                widget.position.latitude,
                                widget.position.longitude,
                              ),
                              documentoCliente: widget.documentoCliente,
                              numeroSolicitud: widget.numeroSolicitud,
                              ubicacionGpsCodigo: ubicacionGpsCodigo!,
                              tipoSolicitud: widget.tipoSolicitud,
                              controller: widget.controller,
                              referencia: referencia!,
                            );
                      },
                      icon: state.statusCreation == Status.inProgress
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 5,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.check_circle_rounded),
                      label: Text(
                        state.statusCreation == Status.inProgress
                            ? 'Enviando...'
                            : 'Guardar ubicación',
                      ),
                    ),
                  ),
                  const Gap(20),
                ],
              ),
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}

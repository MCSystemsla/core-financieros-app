import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_user_location/analisis_user_location_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationCardContainer extends StatelessWidget {
  final LatLng position;
  final GoogleMapController controller;
  final String documentoCliente;
  final int numeroSolicitud;
  final String tipoSolicitud;
  final String? ubicacionGpsCodigo;
  final String? referenciaAdicional;
  const LocationCardContainer({
    super.key,
    required this.position,
    required this.controller,
    required this.documentoCliente,
    required this.numeroSolicitud,
    required this.tipoSolicitud,
    this.ubicacionGpsCodigo,
    this.referenciaAdicional,
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
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          decoration: BoxDecoration(
            color: RedesignColors.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: RedesignColors.ink.withValues(alpha: 0.12),
                blurRadius: 24,
                offset: const Offset(0, -6),
              ),
            ],
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
                    decoration: BoxDecoration(
                      color: RedesignColors.border,
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
                  referenciaAdicional: referenciaAdicional,
                  ubicacionGpsCodigo: ubicacionGpsCodigo,
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
  final LatLng position;
  final GoogleMapController controller;
  final String documentoCliente;
  final int numeroSolicitud;
  final String tipoSolicitud;
  final String? ubicacionGpsCodigo;
  final String? referenciaAdicional;
  const UserLocationContent({
    super.key,
    required this.position,
    required this.controller,
    required this.documentoCliente,
    required this.numeroSolicitud,
    required this.tipoSolicitud,
    this.ubicacionGpsCodigo,
    this.referenciaAdicional,
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
    if (widget.ubicacionGpsCodigo != null ||
        widget.referenciaAdicional != null) {
      ubicacionGpsCodigo = widget.ubicacionGpsCodigo;
      referencia = widget.referenciaAdicional;
    }
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
            dialogType: DialogType.warning,
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
                  const Gap(16),
                  const Text(
                    'Registrar ubicación',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: RedesignColors.ink,
                    ),
                  ),
                  const Gap(4),
                  const Text(
                    'Confirma la dirección y completa los datos.',
                    style: TextStyle(
                      fontSize: 13,
                      color: RedesignColors.inkMuted,
                    ),
                  ),
                  const Gap(14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: RedesignColors.background,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: RedesignColors.border),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: RedesignColors.tealTint,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.place_rounded,
                            size: 18,
                            color: RedesignColors.teal,
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'DIRECCIÓN DETECTADA',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  letterSpacing: 0.6,
                                  fontWeight: FontWeight.w700,
                                  color: RedesignColors.inkMuted,
                                ),
                              ),
                              const Gap(2),
                              Text(
                                state.placeAddress,
                                style: const TextStyle(
                                  fontSize: 13.5,
                                  height: 1.3,
                                  fontWeight: FontWeight.w600,
                                  color: RedesignColors.ink,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                  SearchDropdownWidget(
                    selectedItem: Item(
                      name: ubicacionGpsCodigo ?? '',
                      value: ubicacionGpsCodigo ?? '',
                    ),
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
                    initialValue: referencia,
                    title: 'Referencia adicional',
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    icon: const Icon(
                      Icons.location_on_outlined,
                      color: RedesignColors.teal,
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
                    height: 52,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: RedesignColors.ink,
                        foregroundColor: RedesignColors.surface,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
                                strokeWidth: 2.5,
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

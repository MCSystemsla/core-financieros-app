import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/ubicacion_cliente/ubicacion_cliente_hn_local_db.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mejora_vivienda/mejora_vivienda_entorno_social.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/status_item_card/status_item_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/geolocation_permission/geolocation_permission_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../bloc/geolocation/geolocation_cubit.dart';

class UbicacionClienteOfflineHnScreen extends StatelessWidget {
  final String numeroSolicitud;
  const UbicacionClienteOfflineHnScreen({
    super.key,
    required this.numeroSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => GeolocationCubit(
            GeolocationService(),
          )..getCurrentLocation(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ubicacion del cliente'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: BlocBuilder<GeolocationCubit, GeolocationState>(
          builder: (context, state) {
            return switch (state) {
              OnGeolocationLoading() => const LoadingWidget(),
              OnGeolocationPermissionDenied() => GeolocationPermissionWidget(
                  title: 'Debes permitir el acceso a la ubicación.',
                  onPressed: () {
                    context.read<GeolocationCubit>().getCurrentLocation();
                  },
                ),
              OnGeolocationServiceDisabled() => GeolocationPermissionWidget(
                  title:
                      'El servicio de ubicación no está habilitado en tu dispositivo.',
                  onPressed: () => openAppSettings(),
                ),
              OnGeolocationServiceError() => OnErrorWidget(
                  onPressed: () {
                    context.read<GeolocationCubit>().getCurrentLocation();
                  },
                  errorMsg: state.errorMsg,
                ),
              OnGeolocationSuccess() => UbicacionGpsFormCard(
                  position: state.position,
                  numeroSolicitud: numeroSolicitud,
                ),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}

class UbicacionGpsFormCard extends StatefulWidget {
  final Position? position;
  final String numeroSolicitud;
  const UbicacionGpsFormCard({
    super.key,
    this.position,
    required this.numeroSolicitud,
  });

  @override
  State<UbicacionGpsFormCard> createState() => _UbicacionGpsFormCardState();
}

class _UbicacionGpsFormCardState extends State<UbicacionGpsFormCard> {
  String? tipoUbicacionCodigo;
  String? referenciaAdicional;
  String? tipoUbicacionNombre;
  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: Colors.grey.withValues(alpha: 0.15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _UbicacionesGuardadas(
                  numeroSolicitud: widget.numeroSolicitud,
                ),
                const Gap(30),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color:
                            AppColors.getPrimaryColor().withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.location_pin,
                        color: AppColors.getPrimaryColor(),
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Registrar ubicación',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const Gap(2),
                          Text(
                            'Guarda la ubicación actual del cliente',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey.shade600,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const Gap(24),

                SearchDropdownWidget(
                  codigo: 'UBICACIONGPS',
                  title: 'Tipo de ubicación',
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  onChanged: (v) {
                    if (v == null) return;
                    tipoUbicacionCodigo = v.value;
                    tipoUbicacionNombre = v.name;
                  },
                ),

                const Gap(18),

                OutlineTextfieldWidget(
                  title: 'Referencia adicional',
                  validator: (value) => ClassValidator.validateRequired(value),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  icon: Icon(
                    Icons.edit_location_alt_outlined,
                    color: AppColors.getPrimaryColor(),
                  ),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  hintText: 'Ej: Casa color verde frente a pulpería',
                  onChange: (value) {
                    referenciaAdicional = value;
                  },
                ),

                const Gap(24),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.grey.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.gps_fixed_rounded,
                        size: 20,
                        color: AppColors.getPrimaryColor(),
                      ),
                      const Gap(10),
                      Expanded(
                        child: Text(
                          '${widget.position?.latitude}, ${widget.position?.longitude}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),

                const Gap(28),

                /// BOTON
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.getPrimaryColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (!formKey.currentState!.validate()) return;
                      final ubicacionCliente = UbicacionClienteHnLocalDb(
                        latitude: widget.position?.latitude,
                        longitude: widget.position?.longitude,
                        tipoUbicacionCodigo: tipoUbicacionCodigo,
                        numeroSolicitud: (widget.numeroSolicitud),
                        referenciaAdicional: referenciaAdicional,
                        tipoUbicacionNombre: tipoUbicacionNombre,
                      );
                      final isSaved = localDbProvider.saveUbicacionCliente(
                        ubicacionCliente: ubicacionCliente,
                      );
                      if (isSaved) {
                        showV2CustomSnackbar(
                          context,
                          title: 'Ubicación guardada exitosamente',
                          message:
                              'Podras enviar la ubicacion cuando estes en modo online',
                          type: SnackbarType.success,
                        );

                        setState(() {});
                      }
                    },
                    icon: const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Guardar ubicación',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UbicacionesGuardadas extends StatefulWidget {
  final String numeroSolicitud;

  const _UbicacionesGuardadas({
    required this.numeroSolicitud,
  });

  @override
  State<_UbicacionesGuardadas> createState() => _UbicacionesGuardadasState();
}

class _UbicacionesGuardadasState extends State<_UbicacionesGuardadas> {
  late final AnalisisBoxServiceHn localDbProvider;

  @override
  void initState() {
    super.initState();

    localDbProvider = global<AnalisisBoxServiceHn>();
  }

  @override
  Widget build(BuildContext context) {
    final ubicacionesClienteList =
        localDbProvider.getAllClientesUbicacionesByNumeroSolicitud(
      widget.numeroSolicitud,
    );

    if (ubicacionesClienteList.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 180,
      child: ListView.builder(
        itemCount: ubicacionesClienteList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final item = ubicacionesClienteList[index];

          return StatusItemCard(
            item: StatusItem(
              name: item.tipoUbicacionNombre ?? '',
              status: StatusComiteGrupalIntegranteEnum.completo,
              tipoSolicitud: '',
              numeroSolicitud: 0,
            ),
            onTap: () {},
          );
        },
      ),
    );
  }
}

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/data/custom_map_style.dart';
import 'package:core_financiero_app/src/config/helpers/google_api/places/google_places_helper.dart';
import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_user_location/analisis_user_location_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/geolocation/geolocation_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/client_location/location_card_container.dart';
import 'package:core_financiero_app/src/presentation/widgets/client_location/location_saved_container.dart';
import 'package:core_financiero_app/src/presentation/widgets/client_location/select_location_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/geolocation_permission/geolocation_permission_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/header_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class UbiacacionClienteHnScreen extends StatefulWidget {
  final String documentoCliente;
  final int numeroSolicitud;
  final String tipoSolicitud;
  const UbiacacionClienteHnScreen({
    super.key,
    required this.documentoCliente,
    required this.numeroSolicitud,
    required this.tipoSolicitud,
  });

  @override
  State<UbiacacionClienteHnScreen> createState() =>
      _UbiacacionClienteHnScreenState();
}

class _UbiacacionClienteHnScreenState extends State<UbiacacionClienteHnScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => GeolocationCubit(
            GeolocationService(),
          )..getCurrentLocation(),
        ),
        BlocProvider(
          create: (ctx) => AnalisisUserLocationCubit(
            GooglePlacesHelperImpl(),
          ),
        ),
      ],
      child: Scaffold(
        backgroundColor: RedesignColors.background,
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
              OnGeolocationSuccess() => _MapContentWidget(
                  position: state.position,
                  documentoCliente: widget.documentoCliente,
                  numeroSolicitud: widget.numeroSolicitud,
                  tipoSolicitud: widget.tipoSolicitud,
                ),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}

class _MapContentWidget extends StatefulWidget {
  final Position position;
  final String documentoCliente;
  final int numeroSolicitud;
  final String tipoSolicitud;
  const _MapContentWidget({
    required this.position,
    required this.documentoCliente,
    required this.numeroSolicitud,
    required this.tipoSolicitud,
  });

  @override
  State<_MapContentWidget> createState() => _MapContentWidgetState();
}

class _MapContentWidgetState extends State<_MapContentWidget> {
  GoogleMapController? _controller;

  bool isUserSelectedLocation = false;
  LatLng? position;
  String? ubicacionGpsCodigo;
  String? referenciaAdicional;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(14.0998805, -87.1888407),
    zoom: 14.4746,
  );

  getCurrentLocation({required LatLng latLng}) {
    return CameraPosition(
      bearing: 192.8334901395799,
      target: latLng,
      tilt: 59.440717697143555,
      zoom: 19.151926040649414,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localProvider = global<AnalisisBoxServiceHn>();
    final ubicacionesGuardadas =
        localProvider.getAllClientesUbicacionesByNumeroSolicitud(
      widget.numeroSolicitud.toString(),
    );
    return Stack(
      children: [
        AbsorbPointer(
          absorbing: true,
          child: GoogleMap(
            style: customMapStyle,
            zoomControlsEnabled: false,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;

              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  getCurrentLocation(
                    latLng: LatLng(
                      widget.position.latitude,
                      widget.position.longitude,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const Center(child: _MapPinWidget()),
        IgnorePointer(
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  RedesignColors.background.withValues(alpha: 0.95),
                  RedesignColors.background.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                child: Row(
                  children: [
                    HeaderBackButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const Gap(10),
                    Expanded(
                      child: _MapTitleWidget(
                        numeroSolicitud: widget.numeroSolicitud,
                      ),
                    ),
                  ],
                ),
              ),
              if (ubicacionesGuardadas.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
                  child: Text(
                    'UBICACIONES GUARDADAS · ${ubicacionesGuardadas.length}',
                    style: const TextStyle(
                      fontSize: 11,
                      letterSpacing: 0.6,
                      fontWeight: FontWeight.w700,
                      color: RedesignColors.inkMuted,
                    ),
                  ),
                ),
                SizedBox(
                  height: 136,
                  // Con la ubicación ya confirmada el formulario está abierto:
                  // se bloquea la lista para que la posición no cambie debajo.
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isUserSelectedLocation ? 0.55 : 1,
                    child: AbsorbPointer(
                      absorbing: isUserSelectedLocation,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        itemCount: ubicacionesGuardadas.length,
                        itemBuilder: (_, index) {
                          final item = ubicacionesGuardadas[index];

                          return UbicacionGuardadaCard(
                            ubicacion: item,
                            isSelected: position != null &&
                                position!.latitude == item.latitude &&
                                position!.longitude == item.longitude,
                            onTap: () {
                              final latLng = LatLng(
                                item.latitude ?? 0,
                                item.longitude ?? 0,
                              );
                              setState(() {
                                position = latLng;
                                ubicacionGpsCodigo = item.tipoUbicacionCodigo;
                                referenciaAdicional = item.referenciaAdicional;
                              });

                              _controller?.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  getCurrentLocation(latLng: latLng),
                                ),
                              );
                            },
                            onUnpin: () {
                              setState(() {
                                position = null;
                                ubicacionGpsCodigo = null;
                                referenciaAdicional = null;
                              });

                              _controller?.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  getCurrentLocation(
                                    latLng: LatLng(
                                      widget.position.latitude,
                                      widget.position.longitude,
                                    ),
                                  ),
                                ),
                              );
                            },
                            onDelete: () {
                              setState(() {
                                localProvider.deleteRowByNumeroSolicitud(
                                  widget.numeroSolicitud.toString(),
                                );
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (isUserSelectedLocation) ...[
          LocationCardContainer(
            position: position ??
                LatLng(
                  widget.position.latitude,
                  widget.position.longitude,
                ),
            controller: _controller!,
            documentoCliente: widget.documentoCliente,
            numeroSolicitud: widget.numeroSolicitud,
            tipoSolicitud: widget.tipoSolicitud,
            referenciaAdicional: referenciaAdicional,
            ubicacionGpsCodigo: ubicacionGpsCodigo,
          ),
        ],
        if (!isUserSelectedLocation) ...[
          SelectLocationWidget(
            onTap: () {
              setState(() {
                isUserSelectedLocation = true;
              });
            },
          ),
        ],
      ],
    );
  }
}

class _MapTitleWidget extends StatelessWidget {
  final int numeroSolicitud;
  const _MapTitleWidget({required this.numeroSolicitud});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: RedesignColors.border),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.map_outlined,
            size: 18,
            color: RedesignColors.teal,
          ),
          const Gap(8),
          const Expanded(
            child: Text(
              'Ubicación del cliente',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: RedesignColors.ink,
              ),
            ),
          ),
          Text(
            '#$numeroSolicitud',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: RedesignColors.inkMuted,
            ),
          ),
        ],
      ),
    );
  }
}

/// Pin fijo en el centro del mapa. Se desplaza hacia arriba la mitad de su
/// alto para que la punta (no el centro del ícono) marque el centro de la
/// cámara, que es el punto que se guarda.
class _MapPinWidget extends StatelessWidget {
  const _MapPinWidget();

  static const double _pinSize = 52;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Transform.translate(
        offset: const Offset(0, -_pinSize / 2),
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: -3,
              child: Container(
                width: 14,
                height: 6,
                decoration: BoxDecoration(
                  color: RedesignColors.ink.withValues(alpha: 0.25),
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(14, 6)),
                ),
              ),
            ),
            Icon(
              Icons.location_on_rounded,
              size: _pinSize,
              color: AppColors.getPrimaryColor(),
              shadows: [
                Shadow(
                  color: RedesignColors.ink.withValues(alpha: 0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

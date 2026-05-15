import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/data/custom_map_style.dart';
import 'package:core_financiero_app/src/config/helpers/google_api/places/google_places_helper.dart';
import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_user_location/analisis_user_location_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/geolocation/geolocation_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/client_location/location_card_container.dart';
import 'package:core_financiero_app/src/presentation/widgets/client_location/location_saved_container.dart';
import 'package:core_financiero_app/src/presentation/widgets/client_location/select_location_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/geolocation_permission/geolocation_permission_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        SafeArea(
          child: Container(
            height: 280,
            margin: const EdgeInsets.only(left: 10, right: 10, top: 25),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: ubicacionesGuardadas.length,
              itemBuilder: (_, index) {
                final item = ubicacionesGuardadas[index];

                return UbicacionGuardadaCard(
                  ubicacion: item,
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
        Positioned(
          top: 10,
          left: 10,
          child: SafeArea(
            child: IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Center(
          child: Icon(
            Icons.location_on_rounded,
            color: AppColors.getPrimaryColor(),
            size: 50,
          ),
        ),
      ],
    );
  }
}

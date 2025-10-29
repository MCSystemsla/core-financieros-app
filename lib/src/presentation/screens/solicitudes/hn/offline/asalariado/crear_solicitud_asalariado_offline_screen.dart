import 'dart:io';

import 'package:camera/camera.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitud_asalariado_hn_db_local.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/geolocation/geolocation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/calculo_cuota/calculo_cuota_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_aslariado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/offline/crear_solicitud_offline_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/actividades_economicas_alias_filtered_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/navbar/navbar.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/solicitudes_offline/forms/solcitud_asalariado_offline_7.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/solicitudes_offline/forms/solicitud_asalariado_offline_1.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/solicitudes_offline/forms/solicitud_asalariado_offline_2.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/solicitudes_offline/forms/solicitud_asalariado_offline_3.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/solicitudes_offline/forms/solicitud_asalariado_offline_4.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/solicitudes_offline/forms/solicitud_asalariado_offline_5.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/solicitudes_offline/forms/solicitud_asalariado_offline_6.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/solicitudes_offline/forms/solicitud_asalariado_offline_8.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/solicitudes_offline/forms/solicitud_asalariado_offline_9.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/photo_cedula_client_widget.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CrearSolicitudAsalariadoOfflineScreen extends StatelessWidget {
  final SolicitudAsalariadoHnDbLocal solicitudAsalariadoHnDbLocal;
  const CrearSolicitudAsalariadoOfflineScreen({
    super.key,
    required this.solicitudAsalariadoHnDbLocal,
  });

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<SolicitudesHnBoxService>();
    final imagesCedula = localDbProvider.getCedula(
      cedula: solicitudAsalariadoHnDbLocal.cedula!,
      tipoSolicitud: 'ASALARIADO',
    );
    final pageController = PageController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => CalculoCuotaCubit(),
        ),
        BlocProvider(
          create: (ctx) => GeolocationCubit(
            GeolocationService(),
          ),
        ),
        BlocProvider(
          create: (ctx) => SolicitudAslariadoHnCubit(
            SolicitudesCreditoHnRepositoryImpl(),
            global<SolicitudesHnBoxService>(),
          )
            ..initAutoSave(uuid: solicitudAsalariadoHnDbLocal.uuid)
            ..loadFromLocalDb(solicitudAsalariadoHnDbLocal),
        ),
      ],
      child: Scaffold(
        body: PopScope(
          canPop: false,
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.build),
              onPressed: () {
                buildActividadesEconomicasAliasFilteredDropdown(
                  context: context,
                );
              },
            ),
            body: Column(
              children: [
                const Navbar(
                  title: 'Crear nueva Solicitud Asalariado',
                ),
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: [
                      Hero(
                        transitionOnUserGestures: true,
                        tag: 'cedulaFrontal',
                        child: PhotoCedulaClientWidget(
                          onNextPressed: () {},
                          controller: pageController,
                          fotoCedulaFrontal: XFile(
                              imagesCedula?.imageFrontCedula ?? 'NO PATH'),
                          fotoCedulaTrasera:
                              XFile(imagesCedula?.imageBackCedula ?? 'NO PATH'),
                          onCedulaFrontalPressed: () {
                            context.pushTransparentRoute(
                              PhotoCedulaImagePreview(
                                imagesCedula: File(
                                  imagesCedula?.imageFrontCedula ?? '',
                                ),
                              ),
                            );
                          },
                          onCedulaTraseraPressed: () {
                            context.pushTransparentRoute(
                              PhotoCedulaImagePreview(
                                imagesCedula: File(
                                  imagesCedula?.imageBackCedula ?? '',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SolicitudAsalariadoOffline1(
                        controller: pageController,
                      ),
                      SolicitudAsalariadoOffline2(
                        controller: pageController,
                      ),
                      SolicitudAsalariadoOffline3(
                        controller: pageController,
                      ),
                      SolicitudAsalariadoOffline4(
                        controller: pageController,
                      ),
                      SolicitudAsalariadoOffline5(
                        controller: pageController,
                      ),
                      SolicitudAsalariadoOffline6(
                        controller: pageController,
                      ),
                      SolcitudAsalariadoOffline7(
                        controller: pageController,
                      ),
                      SolicitudAsalariadoOffline8(
                        controller: pageController,
                      ),
                      SolicitudAsalariadoOffline9(
                        controller: pageController,
                      ),
                    ],
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

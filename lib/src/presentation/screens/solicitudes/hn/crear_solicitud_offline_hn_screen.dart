import 'dart:io';

import 'package:camera/camera.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/nuevamenor/local_db/solicitud_nueva_menor_hn_local_db.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/geolocation/geolocation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/calculo_cuota/calculo_cuota_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/offline/crear_solicitud_offline_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/actividades_economicas_alias_filtered_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/navbar/navbar.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/solicitudes_offline/forms/nueva_menor_offline_hn_1.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/solicitudes_offline/forms/nueva_menor_offline_hn_2.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/solicitudes_offline/forms/nueva_menor_offline_hn_3.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/solicitudes_offline/forms/nueva_menor_offline_hn_4.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/solicitudes_offline/forms/nueva_menor_offline_hn_5.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/solicitudes_offline/forms/nueva_menor_offline_hn_6.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/solicitudes_offline/forms/nueva_menor_offline_hn_7.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/solicitudes_offline/forms/nueva_menor_offline_hn_8.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/photo_cedula_client_widget.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/solicitudes/hn/cubit/solicitud_nueva_menor_hn_cubit.dart';

class CrearSolicitudOfflineHnScreen extends StatelessWidget {
  final SolicitudNuevaMenorHnLocalDb solicitudNuevaMenorHnLocalDb;
  const CrearSolicitudOfflineHnScreen({
    super.key,
    required this.solicitudNuevaMenorHnLocalDb,
  });

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<SolicitudesHnBoxService>();
    final imagesCedula = localDbProvider.getCedula(
      cedula: solicitudNuevaMenorHnLocalDb.cedula!,
      tipoSolicitud: 'NUEVA_MENOR',
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
          create: (ctx) => SolicitudNuevaMenorHnCubit(
            SolicitudesCreditoHnRepositoryImpl(),
            global<SolicitudesHnBoxService>(),
          )
            ..initAutoSave(uuid: solicitudNuevaMenorHnLocalDb.uuid)
            ..loadFromLocalDb(solicitudNuevaMenorHnLocalDb),
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
                  title: 'Crear nueva Solicitud Nueva',
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
                      NuevaMenorOfflineHn1(
                        controller: pageController,
                      ),
                      NuevaMenorOfflineHn2(
                        controller: pageController,
                      ),
                      NuevaMenorOfflineHn3(
                        controller: pageController,
                      ),
                      NuevaMenorOfflineHn4(
                        controller: pageController,
                      ),
                      NuevaMenorOfflineHn5(
                        controller: pageController,
                      ),
                      NuevaMenorOfflineHn6(
                        controller: pageController,
                      ),
                      NuevaMenorOfflineHn7(
                        controller: pageController,
                      ),
                      NuevaMenorOfflineHn8(
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

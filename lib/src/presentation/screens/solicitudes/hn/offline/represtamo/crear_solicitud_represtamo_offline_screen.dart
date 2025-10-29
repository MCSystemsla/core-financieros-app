import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/represtamo/local_db/solicitud_represtamo_hn_local_db.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/geolocation/geolocation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/calculo_cuota/calculo_cuota_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_represtamo_hn/solicitud_represtamo_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/actividades_economicas_alias_filtered_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/navbar/navbar.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/represtamo/solicitudes_offline/forms/represtamo_form__hn_offline_1.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/represtamo/solicitudes_offline/forms/represtamo_form_hn_offline_2.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/represtamo/solicitudes_offline/forms/represtamo_form_hn_offline_3.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/represtamo/solicitudes_offline/forms/represtamo_form_hn_offline_4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CrearSolicitudReprestamoOfflineScreen extends StatelessWidget {
  final SolicitudReprestamoHnLocalDb solicitudReprestamoHnLocalDb;
  const CrearSolicitudReprestamoOfflineScreen({
    super.key,
    required this.solicitudReprestamoHnLocalDb,
  });

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<SolicitudesHnBoxService>();
    final imagesCedula = localDbProvider.getCedula(
      cedula: solicitudReprestamoHnLocalDb.cedula!,
      tipoSolicitud: 'REPRESTAMO',
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
          create: (ctx) => SolicitudReprestamoHnCubit(
            SolicitudesCreditoHnRepositoryImpl(),
            global<SolicitudesHnBoxService>(),
          )
            ..initAutoSave(uuid: solicitudReprestamoHnLocalDb.uuid)
            ..loadFromLocalDb(solicitudReprestamoHnLocalDb),
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
                  title: 'Crear nueva Solicitud Represtamo',
                ),
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: [
                      // Hero(
                      //   transitionOnUserGestures: true,
                      //   tag: 'cedulaFrontal',
                      //   child: PhotoCedulaClientWidget(
                      //     onNextPressed: () {},
                      //     controller: pageController,
                      //     fotoCedulaFrontal: XFile(
                      //         imagesCedula?.imageFrontCedula ?? 'NO PATH'),
                      //     fotoCedulaTrasera:
                      //         XFile(imagesCedula?.imageBackCedula ?? 'NO PATH'),
                      //     onCedulaFrontalPressed: () {
                      //       context.pushTransparentRoute(
                      //         PhotoCedulaImagePreview(
                      //           imagesCedula: File(
                      //             imagesCedula?.imageFrontCedula ?? '',
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //     onCedulaTraseraPressed: () {
                      //       context.pushTransparentRoute(
                      //         PhotoCedulaImagePreview(
                      //           imagesCedula: File(
                      //             imagesCedula?.imageBackCedula ?? '',
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                      ReprestamoFormHNOffline1(
                        controller: pageController,
                      ),
                      ReprestamoFormHnOffline2(
                        controller: pageController,
                      ),
                      ReprestamoFormHnOffline3(
                        controller: pageController,
                      ),
                      ReprestamoFormHnOffline4(
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

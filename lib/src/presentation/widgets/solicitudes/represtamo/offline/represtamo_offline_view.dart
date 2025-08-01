import 'dart:io';

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/represtamo_responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/geolocation/geolocation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/calculo_cuota/calculo_cuota_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_represtamo/solicitud_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/offline/crear_solicitud_offline_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/navbar/navbar.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/photo_cedula_client_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/offline/represtamo_offline_form1.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/offline/represtamo_offline_form2.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/offline/represtamo_offline_form3.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/offline/represtamo_offline_form4.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/offline/represtamo_offline_form5.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ReprestamoOfflineView extends StatelessWidget {
  final ReprestamoResponsesLocalDb solicitudReprestamoOffline;
  const ReprestamoOfflineView(
      {super.key, required this.solicitudReprestamoOffline});

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();
    final imagesCedula = localDbProvider.getCedula(
      cedula: solicitudReprestamoOffline.cedula!,
      tipoSolicitud: 'REPRESTAMO',
    );

    final controller = PageController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => CalculoCuotaCubit(),
        ),
        BlocProvider(
          create: (ctx) => SolicitudReprestamoCubit(
            SolicitudCreditoRepositoryImpl(),
            localDbProvider,
          ),
        ),
        BlocProvider(
          create: (ctx) => GeolocationCubit(
            GeolocationService(),
          ),
        ),
      ],
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: Column(
            children: [
              const Navbar(
                title: 'Crear nueva Solicitud Represtamo',
                imageUrl: ImageAsset.represtamoBg,
              ),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: [
                    Hero(
                      transitionOnUserGestures: true,
                      tag: 'cedulaFrontal',
                      child: PhotoCedulaClientWidget(
                        controller: controller,
                        onNextPressed: () {},
                        fotoCedulaFrontal:
                            XFile(imagesCedula?.imageFrontCedula ?? 'NO PATH'),
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
                    ReprestamoOfflineForm1(
                      controller: controller,
                      solicitud: solicitudReprestamoOffline,
                    ),
                    ReprestamoOfflineForm2(
                      controller: controller,
                      solicitudReprestamoOffline: solicitudReprestamoOffline,
                    ),
                    ReprestamoOfflineForm3(
                      controller: controller,
                      solicitud: solicitudReprestamoOffline,
                    ),
                    ReprestamoOfflineForm4(
                      controller: controller,
                      solicitud: solicitudReprestamoOffline,
                    ),
                    ReprestamoOfflineForm5(
                      controller: controller,
                      solicitud: solicitudReprestamoOffline,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

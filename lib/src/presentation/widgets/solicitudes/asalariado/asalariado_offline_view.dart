import 'dart:io';

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/asalariado_responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/geolocation/geolocation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/calculo_cuota/calculo_cuota_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/offline/crear_solicitud_offline_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/navbar/navbar.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/offline/asalariado_offline_1.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/offline/asalariado_offline_2.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/offline/asalariado_offline_3.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/offline/asalariado_offline_4.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/offline/asalariado_offline_5.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/offline/asalariado_offline_6.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/offline/asalariado_offline_7.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/photo_cedula_client_widget.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AsalariadoOfflineView extends StatelessWidget {
  final AsalariadoResponsesLocalDb asalariadoResponsesLocalDb;
  const AsalariadoOfflineView({
    super.key,
    required this.asalariadoResponsesLocalDb,
  });

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();
    final imagesCedula =
        localDbProvider.getCedula(cedula: asalariadoResponsesLocalDb.cedula!);

    final controller = PageController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => CalculoCuotaCubit(),
        ),
        BlocProvider(
          create: (ctx) => SolicitudAsalariadoCubit(
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
      child: Scaffold(
        body: Column(
          children: [
            const Navbar(
              title: 'Crear nueva Solicitud Asalariado',
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
                      fotoCedulaFrontal:
                          XFile(imagesCedula?.imageFrontCedula ?? ''),
                      fotoCedulaTrasera:
                          XFile(imagesCedula?.imageBackCedula ?? ''),
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
                  AsalariadoOffline1(
                    controller: controller,
                    asalariadoResponsesLocalDb: asalariadoResponsesLocalDb,
                  ),
                  AsalariadoOffline2(
                    controller: controller,
                    asalariadoResponsesLocalDb: asalariadoResponsesLocalDb,
                  ),
                  AsalariadoOffline3(
                    controller: controller,
                    asalariadoResponsesLocalDb: asalariadoResponsesLocalDb,
                  ),
                  AsalariadoOffline4(
                    controller: controller,
                    asalariadoResponsesLocalDb: asalariadoResponsesLocalDb,
                  ),
                  AsalariadoOffline5(
                    controller: controller,
                    asalariadoResponsesLocalDb: asalariadoResponsesLocalDb,
                  ),
                  AsalariadoOffline6(
                    controller: controller,
                    asalariadoResponsesLocalDb: asalariadoResponsesLocalDb,
                  ),
                  AsalariadoOffline7(
                    controller: controller,
                    asalariadoResponsesLocalDb: asalariadoResponsesLocalDb,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

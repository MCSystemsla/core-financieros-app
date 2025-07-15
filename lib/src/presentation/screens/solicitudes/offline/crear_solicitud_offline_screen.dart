import 'dart:io';

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/responses_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/geolocation/geolocation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/calculo_cuota/calculo_cuota_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/navbar/navbar.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/offline/nueva_menor_offline1_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/offline/nueva_menor_offline2_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/offline/nueva_menor_offline3_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/offline/nueva_menor_offline5_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/offline/nueva_menor_offline6_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/offline/nueva_menor_offline7_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/offline/nueva_menor_offlne4_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/photo_cedula_client_widget.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class CrearSolicitudOfflineScreen extends StatelessWidget {
  final ResponseLocalDb responseLocalDb;
  const CrearSolicitudOfflineScreen({super.key, required this.responseLocalDb});

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();
    final imagesCedula = localDbProvider.getCedula(
      cedula: responseLocalDb.cedula!,
      tipoSolicitud: 'NUEVA_MENOR',
    );
    final pageController = PageController();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => CalculoCuotaCubit(),
        ),
        BlocProvider(
          create: (ctx) => SolicitudNuevaMenorCubit(
            SolicitudCreditoRepositoryImpl(),
            global<ObjectBoxService>(),
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
                title: 'Crear nueva Solicitud Nueva Menor',
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
                        controller: pageController,
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
                    NuevaMenorOffline1(
                      responseLocalDb: responseLocalDb,
                      pageController: pageController,
                    ),
                    NuevaMenorOffline2Widget(
                      controller: pageController,
                      responseLocalDb: responseLocalDb,
                    ),
                    NuevaMenorOffline3Widget(
                      controller: pageController,
                      responseLocalDb: responseLocalDb,
                    ),
                    NuevaMenorOfflne4Widget(
                      pageController: pageController,
                      responseLocalDb: responseLocalDb,
                    ),
                    NuevaMenorOffline5Widget(
                      pageController: pageController,
                      responseLocalDb: responseLocalDb,
                    ),
                    NuevaMenorOffline6Widget(
                      pageController: pageController,
                      responseLocalDb: responseLocalDb,
                    ),
                    NuevaMenorOffline7Widget(
                      pageController: pageController,
                      responseLocalDb: responseLocalDb,
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

class PhotoCedulaImagePreview extends StatelessWidget {
  const PhotoCedulaImagePreview({
    super.key,
    required this.imagesCedula,
  });

  final File imagesCedula;

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () {
        context.pop();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Hero(
            transitionOnUserGestures: true,
            tag: 'cedulaFrontal',
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(imagesCedula),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

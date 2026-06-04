import 'package:camera/camera.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/services/geolocation/geolocation_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/nuevamenor/local_db/solicitud_nueva_menor_hn_local_db.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/geolocation/geolocation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/calculo_cuota/calculo_cuota_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/actividades_economicas_alias_filtered_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/navbar/navbar.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/solicitudes_offline/forms/nueva_menor_historial_crediticio_offline_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/solicitudes_offline/forms/nueva_menor_offline_hn_1.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/solicitudes_offline/forms/nueva_menor_offline_hn_2.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/solicitudes_offline/forms/nueva_menor_offline_hn_3.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/solicitudes_offline/forms/nueva_menor_offline_hn_4.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/solicitudes_offline/forms/nueva_menor_offline_hn_5.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/solicitudes_offline/forms/nueva_menor_offline_hn_6.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/solicitudes_offline/forms/nueva_menor_offline_hn_7.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/solicitudes_offline/forms/nueva_menor_offline_hn_8.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/solicitudes_offline/reenviar_archivos_solicitudes/reenviar_archivos_solicitudes.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/photo_cedula_client_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/solicitudes/hn/cubit/calculo_cuota_hn/calculo_cuota_hn_cubit.dart';
import '../../../../../bloc/solicitudes/hn/cubit/enviar_cedula_solicitud_hn/enviar_cedula_solicitud_hn_cubit.dart';
import '../../../../../bloc/solicitudes/hn/cubit/enviar_firma_digital_hn/enviar_firma_digital_solicitud_hn_cubit.dart';
import '../../../../../bloc/solicitudes/hn/cubit/solicitud_nueva_menor_hn_cubit.dart';

class CrearSolicitudNuevaOfflineHnScreen extends StatelessWidget {
  final SolicitudNuevaMenorHnLocalDb solicitudNuevaMenorHnLocalDb;
  const CrearSolicitudNuevaOfflineHnScreen({
    super.key,
    required this.solicitudNuevaMenorHnLocalDb,
  });

  @override
  Widget build(BuildContext context) {
    final repository = SolicitudesCreditoHnRepositoryImpl();
    final localDbProvider = global<SolicitudesHnBoxService>();
    final imagesCedula = localDbProvider.getCedula(
      cedula: solicitudNuevaMenorHnLocalDb.cedula!,
      tipoSolicitud: 'NUEVA_MENOR',
    );
    final signatureFile = localDbProvider.getSignatureByCedula(
      solicitudNuevaMenorHnLocalDb.cedula!,
      TypeForm.nueva,
    );
    // final signatureImage = localDbProvider.getSignatureByCedula(
    //   solicitudNuevaMenorHnLocalDb.cedula ?? '',
    // );
    final pageController = PageController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => CalculoCuotaCubit(),
        ),
        BlocProvider(
          create: (ctx) => CalculoCuotaHnCubit(),
        ),
        BlocProvider(
          create: (ctx) => GeolocationCubit(
            GeolocationService(),
          ),
        ),
        BlocProvider(
          create: (ctx) => SolicitudNuevaMenorHnCubit(
            repository,
            global<SolicitudesHnBoxService>(),
          )
            ..initAutoSave(uuid: solicitudNuevaMenorHnLocalDb.uuid)
            ..saveCedula(
              cedulaBackPath: imagesCedula?.imageBackCedula,
              cedulaFrontPath: imagesCedula?.imageFrontCedula,
            )
            ..loadFromLocalDb(solicitudNuevaMenorHnLocalDb),
        ),
        BlocProvider(
          create: (ctx) => EnviarCedulaSolicitudHnCubit(
            repository,
          ),
        ),
        BlocProvider(
          create: (ctx) => EnviarFirmaDigitalSolicitudHnCubit(
            repository,
          ),
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
                  child: SafeArea(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pageController,
                      children: [
                        Hero(
                          transitionOnUserGestures: true,
                          tag: 'cedulaFrontal',
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SendFilesSolicitudNuevaContainers(
                                  imagesCedula: imagesCedula,
                                  cedulaCliente:
                                      solicitudNuevaMenorHnLocalDb.cedula ?? '',
                                  numeroSolicitud: solicitudNuevaMenorHnLocalDb
                                          .numeroSolicitud ??
                                      '',
                                  signatureFile: signatureFile,
                                  tipoSolicitud: 'NUEVAMENOR',
                                ),
                                PhotoCedulaClientWidget(
                                  onNextPressed: () {},
                                  controller: pageController,
                                  fotoCedulaFrontal: XFile(
                                    imagesCedula?.imageFrontCedula ?? 'NO PATH',
                                  ),
                                  fotoCedulaTrasera: XFile(
                                    imagesCedula?.imageBackCedula ?? 'NO PATH',
                                  ),
                                  fotoFirma: XFile(
                                    signatureFile?.imageSignature ?? 'NO PATH',
                                  ),
                                  onCedulaFrontalPressed: () {
                                    // context.pushTransparentRoute(
                                    //   PhotoCedulaImagePreview(
                                    //     imagesCedula: File(
                                    //       imagesCedula?.imageFrontCedula ?? '',
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  onCedulaTraseraPressed: () {
                                    // context.pushTransparentRoute(
                                    //   PhotoCedulaImagePreview(
                                    //     imagesCedula: File(
                                    //       imagesCedula?.imageBackCedula ?? '',
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  onFirmaPressed: () {
                                    // context.pushTransparentRoute(
                                    //   PhotoCedulaImagePreview(
                                    //     imagesCedula: File(
                                    //       signatureFile?.imageSignature ?? '',
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                ),
                              ],
                            ),
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
                        NuevaMenorHistorialCrediticioOfflineHn(
                          controller: pageController,
                          uuid: solicitudNuevaMenorHnLocalDb.uuid ?? '',
                        ),
                        // PhootoSignatureWidget(
                        //   controller: pageController,
                        //   fotoSignature: signatureImage != null
                        //       ? XFile(signatureImage.imageSignature ?? 'NO PATH')
                        //       : null,
                        //   onPhotoSignaturePressed: () {},
                        //   onNextPressed: () {
                        //     if (signatureImage == null) {
                        //       CustomAlertDialog(
                        //         context: context,
                        //         title: 'Ingresa una firma válida',
                        //         onDone: () => context.pop(),
                        //       ).showDialog(context);
                        //       return;
                        //     }
                        //     pageController.nextPage(
                        //       duration: const Duration(milliseconds: 300),
                        //       curve: Curves.easeIn,
                        //     );
                        //   },
                        // ),
                        NuevaMenorOfflineHn8(
                          controller: pageController,
                        ),
                      ],
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

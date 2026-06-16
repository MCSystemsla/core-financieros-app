import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:camera/camera.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/imagenes_negocio/imagenes_negocio_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/camera/camera_capture_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/upload_image_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/images_required_popup_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/button_actions_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../bloc/analisis/hn/analisis_imagenes_negocio/analisis_imagenes_negocio_cubit.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ImagenesNegocioHnScreen extends StatefulWidget {
  final String numeroSolicitud;
  final String cedulaCliente;
  final bool isOfflineMode;
  const ImagenesNegocioHnScreen({
    super.key,
    required this.numeroSolicitud,
    required this.cedulaCliente,
    this.isOfflineMode = false,
  });

  @override
  State<ImagenesNegocioHnScreen> createState() =>
      _ImagenesNegocioHnScreenState();
}

class _ImagenesNegocioHnScreenState extends State<ImagenesNegocioHnScreen> {
  XFile? selectedImage;
  String? selectedImage1Path;
  XFile? selectedImage2;
  String? selectedImage2Path;
  XFile? selectedImage3;
  String? selectedImage3Path;

  @override
  void initState() {
    super.initState();
    final localDbProvider = global<AnalisisBoxServiceHn>();
    final imagenesNegocioHnLocalDb =
        localDbProvider.getImagenesNegocioFromLocalDb(
      numeroSolicitud: widget.numeroSolicitud,
    );
    if (imagenesNegocioHnLocalDb != null) {
      selectedImage1Path = imagenesNegocioHnLocalDb.pathFoto1;
      selectedImage2Path = imagenesNegocioHnLocalDb.pathFoto2;
      selectedImage3Path = imagenesNegocioHnLocalDb.pathFoto3;
      selectedImage = XFile(selectedImage1Path!);
      selectedImage2 = XFile(selectedImage2Path!);
      selectedImage3 = XFile(selectedImage3Path!);
    }
  }

  Future<String> _savePath(XFile image) async {
    final appDir = await getApplicationDocumentsDirectory();

    final String folderPath = '${appDir.path}/imagenes_negocio';

    final Directory businessFolder = Directory(folderPath);
    await businessFolder.create(recursive: true);

    final String finalPath = '$folderPath/${image.name}';
    log('📂 Ruta final: $finalPath');

    await File(image.path).copy(finalPath);

    return finalPath;
  }

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<AnalisisBoxServiceHn>();
    return BlocProvider(
      create: (ctx) => AnalisisImagenesNegocioCubit(
        AnalisisRepositoryHNImpl(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Imagenes del Negocio'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MiCreditoProgress(
                    steps: 4,
                    currentStep: 1,
                  ),
                  const Gap(20),
                  Text(
                    'Numero Solicitud: ${widget.numeroSolicitud}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Gap(20),
                  Text(
                    'Las imágenes se utilizarán para evaluar el estado del negocio del cliente y como referencia en futuras solicitudes.',
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Gap(25),
                  UploadImageWidget(
                    selectedImage: selectedImage,
                    title: '1- Foto Negocio',
                    onPressed: () => context.pushTransparentRoute(
                      CameraCaptureScreen(
                        numeroSoicitud: widget.numeroSolicitud,
                        onImageSelected: (image, path) async {
                          if (image == null) return;
                          final savePath = await _savePath(image);

                          setState(() {
                            selectedImage = image;
                            selectedImage1Path = savePath;
                          });
                        },
                      ),
                    ),
                  ),
                  const Gap(20),
                  UploadImageWidget(
                    selectedImage: selectedImage2,
                    title: '2-  Foto Negocio',
                    onPressed: () =>
                        context.pushTransparentRoute(CameraCaptureScreen(
                      numeroSoicitud: widget.numeroSolicitud,
                      onImageSelected: (image, path) async {
                        if (image == null) return;
                        final savePath = await _savePath(image);
                        setState(() {
                          selectedImage2 = image;
                          selectedImage2Path = savePath;
                        });
                      },
                    )),
                  ),
                  const Gap(15),
                  UploadImageWidget(
                    selectedImage: selectedImage3,
                    title: '3- Foto Negocio',
                    onPressed: () => context.pushTransparentRoute(
                      CameraCaptureScreen(
                        numeroSoicitud: widget.numeroSolicitud,
                        onImageSelected: (image, path) async {
                          if (image == null) return;
                          final savePath = await _savePath(image);
                          setState(() {
                            selectedImage3 = image;
                            selectedImage3Path = savePath;
                          });
                        },
                      ),
                    ),
                  ),
                  const Gap(20),
                  BlocConsumer<AnalisisImagenesNegocioCubit,
                      AnalisisImagenesNegocioState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    listener: (context, state) {
                      if (state.status == Status.done) {
                        CustomAlertDialog(
                            context: context,
                            title: 'Imagenes del negocio enviadas exitosamente',
                            onDone: () {
                              if (widget.isOfflineMode) {
                                context.pop();
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const AnalisisInterceptorByFlavor(),
                                ),
                              );
                            }).showDialog(context, dialogType: DialogType.success);
                      }
                      if (state.status == Status.error) {
                        CustomAlertDialog(
                          context: context,
                          title: state.errorMsg,
                          onDone: () => context.pop(),
                        ).showDialog(context, dialogType: DialogType.warning);
                      }
                    },
                    builder: (context, state) {
                      return ButtonActionsWidget(
                        onPreviousPressed: () => context.pop(),
                        disabled: state.status == Status.inProgress,
                        onNextPressed: () {
                          if (selectedImage == null ||
                              selectedImage2 == null ||
                              selectedImage3 == null) {
                            ImagesRequiredPopupDialog(
                              context: context,
                              onDone: () => context.pop(),
                            ).showDialog(context);
                            return;
                          }
                          if (context.mounted) {
                            final imagenNegocio = ImagenesNegocioHnLocalDb(
                              numeroSolicitud: widget.numeroSolicitud,
                              pathFoto1: selectedImage1Path,
                              pathFoto2: selectedImage2Path,
                              pathFoto3: selectedImage3Path,
                            );
                            localDbProvider.saveImagenesNegocioOnLocalDb(
                              imagenNegocioSchema: imagenNegocio,
                            );

                            context
                                .read<AnalisisImagenesNegocioCubit>()
                                .createAnalisisFotoNegocio(
                                  numeroSolicitud:
                                      int.tryParse(widget.numeroSolicitud) ?? 0,
                                  cedulaCliente: widget.cedulaCliente,
                                  imagenNegocio:
                                      selectedImage1Path ?? 'NO PATH',
                                  imagenNegocio2:
                                      selectedImage2Path ?? 'NO PATH',
                                  imagenNegocio3:
                                      selectedImage3Path ?? 'NO PATH',
                                );
                          }
                        },
                        previousTitle: 'button.exit'.tr(),
                        nextTitle: 'Enviar imagenes'.tr(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// Comentado porque no se usa

// class _SelectTypePhotoDestination extends StatelessWidget {
//   const _SelectTypePhotoDestination();

//   @override
//   Widget build(BuildContext context) {
//     return DraggableScrollableSheet(
//       initialChildSize: 0.5,
//       minChildSize: 0.3,
//       maxChildSize: 0.5,
//       expand: false,
//       builder: (_, controller) {
//         return Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//           decoration: BoxDecoration(
//             color: const Color(0xfff9fafb),
//             borderRadius: const BorderRadius.vertical(
//               top: Radius.circular(28),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 // ignore: deprecated_member_use
//                 color: Colors.black.withOpacity(0.12),
//                 blurRadius: 25,
//                 offset: const Offset(0, -3),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               Container(
//                 width: 42,
//                 height: 5,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               const Gap(18),
//               Expanded(
//                 child: ListView(
//                   controller: controller,
//                   children: [
//                     SelectableCardItem(
//                       userHaveDataAlready: false,
//                       icon: Icons.camera_alt_outlined,
//                       color: const Color(0xff1554F6),
//                       title: 'Camara',
//                       subtitle: 'Agregar foto desde camara',
//                       onTap: () {},
//                     ),
//                     SelectableCardItem(
//                       userHaveDataAlready: false,
//                       icon: Icons.add_photo_alternate,
//                       color: const Color(0xff1554F6),
//                       title: 'Galeria',
//                       subtitle: 'Agregar foto desde galeria',
//                       onTap: () {},
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ).fadeIn();
//       },
//     );
//   }
// }

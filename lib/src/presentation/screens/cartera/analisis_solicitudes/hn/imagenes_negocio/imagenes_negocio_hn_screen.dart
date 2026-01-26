import 'package:camera/camera.dart';
import 'package:core_financiero_app/src/presentation/screens/camera/camera_capture_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/upload_image_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/images_required_popup_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/button_actions_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ImagenesNegocioHnScreen extends StatefulWidget {
  final String numeroSolicitud;
  const ImagenesNegocioHnScreen({
    super.key,
    required this.numeroSolicitud,
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imagenes Negocio'),
      ),
      body: SingleChildScrollView(
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
                onPressed: () =>
                    context.pushTransparentRoute(CameraCaptureScreen(
                  numeroSoicitud: widget.numeroSolicitud,
                  onImageSelected: (image, path) {
                    setState(() {
                      selectedImage = image;
                      selectedImage1Path = path;
                    });
                  },
                )),
              ),
              const Gap(20),
              UploadImageWidget(
                selectedImage: selectedImage2,
                title: '2-  Foto Negocio',
                onPressed: () =>
                    context.pushTransparentRoute(CameraCaptureScreen(
                  numeroSoicitud: widget.numeroSolicitud,
                  onImageSelected: (image, path) {
                    setState(() {
                      selectedImage2 = image;
                      selectedImage2Path = path;
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
                    onImageSelected: (image, path) {
                      setState(() {
                        selectedImage3 = image;
                        selectedImage3Path = path;
                      });
                    },
                  ),
                ),
              ),
              const Gap(20),
              ButtonActionsWidget(
                onPreviousPressed: () => context.pop(),
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
                  if (context.mounted) {}
                },
                previousTitle: 'button.exit'.tr(),
                nextTitle: 'button.next'.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

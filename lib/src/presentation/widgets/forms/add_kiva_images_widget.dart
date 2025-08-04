import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/camera/camera_capture_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/upload_image_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/images_required_popup_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/button_actions_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AddKivaImagesWidget extends StatefulWidget {
  final PageController controller;
  const AddKivaImagesWidget({super.key, required this.controller});

  @override
  State<AddKivaImagesWidget> createState() => _AddKivaImagesWidgetState();
}

class _AddKivaImagesWidgetState extends State<AddKivaImagesWidget>
    with AutomaticKeepAliveClientMixin {
  final ImagePicker picker = ImagePicker();
  XFile? selectedImage;
  String? selectedImage1Path;
  XFile? selectedImage2;
  String? selectedImage2Path;
  XFile? selectedImage3;
  String? selectedImage3Path;
  XFile? selectedImage4;
  String? selectedImage4Path;

  @override
  Widget build(BuildContext context) {
    final solicitudCliente = context.read<KivaRouteCubit>().state;

    super.build(context);
    return SingleChildScrollView(
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
              'Cliente: ${solicitudCliente.nombre}\nNumero Solicitud: ${solicitudCliente.numero}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Gap(20),
            Text(
              'forms.saneamiento.title'.tr(),
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(25),
            UploadImageWidget(
              selectedImage: selectedImage,
              title: '1- ${'forms.saneamiento.client_photo'.tr()}',
              onPressed: () => context.pushTransparentRoute(CameraCaptureScreen(
                numeroSoicitud: solicitudCliente.numero,
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
              title: '2-  ${'forms.saneamiento.client_photo'.tr()}',
              onPressed: () => context.pushTransparentRoute(CameraCaptureScreen(
                numeroSoicitud: solicitudCliente.numero,
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
              title: '3-  ${'forms.saneamiento.client_photo'.tr()}',
              onPressed: () => context.pushTransparentRoute(
                CameraCaptureScreen(
                  numeroSoicitud: solicitudCliente.numero,
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
                if (context.mounted) {
                  context.read<UploadUserFileCubit>().saveImages(
                        imagen1: selectedImage1Path!,
                        imagen2: selectedImage2Path!,
                        imagen3: selectedImage3Path!,
                      );
                  widget.controller.nextPage(
                    duration: const Duration(
                      milliseconds: 350,
                    ),
                    curve: Curves.easeIn,
                  );
                }
              },
              previousTitle: 'button.exit'.tr(),
              nextTitle: 'button.next'.tr(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

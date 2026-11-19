import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/camera/camera_capture_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_form_widgets.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/upload_image_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/images_required_popup_dialog.dart';
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
      padding: const EdgeInsets.all(15),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ClienteSolicitudCard(
            nombre: solicitudCliente.nombre,
            numero: solicitudCliente.numero,
          ),
          const Gap(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              'forms.saneamiento.title'.tr(),
              style: const TextStyle(
                fontSize: 13,
                height: 1.5,
                color: RedesignColors.inkMuted,
              ),
            ),
          ),
          const Gap(12),
          UploadImageWidget(
            selectedImage: selectedImage,
            title: '1- ${'forms.saneamiento.client_photo'.tr()}',
            onPressed: () => context.pushTransparentRoute(CameraCaptureScreen(
              numeroSoicitud: solicitudCliente.numero,
              onImageSelected: (image, path) {
                KivaFormScaffold.marcarCambios(context);
                setState(() {
                  selectedImage = image;
                  selectedImage1Path = path;
                });
              },
            )),
          ),
          const Gap(12),
          UploadImageWidget(
            selectedImage: selectedImage2,
            title: '2-  ${'forms.saneamiento.client_photo'.tr()}',
            onPressed: () => context.pushTransparentRoute(CameraCaptureScreen(
              numeroSoicitud: solicitudCliente.numero,
              onImageSelected: (image, path) {
                KivaFormScaffold.marcarCambios(context);
                setState(() {
                  selectedImage2 = image;
                  selectedImage2Path = path;
                });
              },
            )),
          ),
          const Gap(12),
          UploadImageWidget(
            selectedImage: selectedImage3,
            title: '3-  ${'forms.saneamiento.client_photo'.tr()}',
            onPressed: () => context.pushTransparentRoute(
              CameraCaptureScreen(
                numeroSoicitud: solicitudCliente.numero,
                onImageSelected: (image, path) {
                  KivaFormScaffold.marcarCambios(context);
                  setState(() {
                    selectedImage3 = image;
                    selectedImage3Path = path;
                  });
                },
              ),
            ),
          ),
          const Gap(12),
          KivaFormNavegacion(
            onPreviousPressed: () => KivaFormScaffold.salir(context),
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}

/// Cliente y número de solicitud del formulario Kiva, en una tarjeta como las
/// de las preguntas ([KivaPreguntaCard]).
class _ClienteSolicitudCard extends StatelessWidget {
  final String nombre;
  final String numero;

  const _ClienteSolicitudCard({required this.nombre, required this.numero});

  @override
  Widget build(BuildContext context) {
    return KivaPreguntaCard(
      child: Column(
        children: [
          _FilaDato(label: 'Cliente', value: nombre),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(height: 1, color: RedesignColors.border),
          ),
          _FilaDato(label: 'Número de solicitud', value: numero),
        ],
      ),
    );
  }
}

class _FilaDato extends StatelessWidget {
  final String label;
  final String value;

  const _FilaDato({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: RedesignColors.inkMuted),
        ),
        const Gap(12),
        Expanded(
          child: Text(
            value.trim().isEmpty ? '—' : value,
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: RedesignColors.ink,
            ),
          ),
        ),
      ],
    );
  }
}

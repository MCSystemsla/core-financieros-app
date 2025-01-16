import 'dart:developer';
import 'dart:io';

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/icon_border.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class AsesorSignatureWidget extends StatelessWidget {
  final PageController pageController;
  const AsesorSignatureWidget({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    // final imageProvider = context.watch<UploadUserFileCubit>().state;
    final size = MediaQuery.sizeOf(context);
    final controller = SignatureController();
    // final isConnected =
    // context.read<InternetConnectionCubit>().state.isConnected;
    return Column(
      children: [
        const MiCreditoProgress(
          steps: 5,
          currentStep: 5,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Firma Asesor'.tr(),
                  style: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(10),
                Text(
                  'forms.firmar.description'.tr(),
                  style: TextStyle(
                    color: AppColors.greyWithOpacityV4,
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: Stack(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.boxGrey,
                            width: .9,
                            strokeAlign: BorderSide.strokeAlignOutside,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Signature(
                            key: const Key('signature'),
                            controller: controller,
                            // height: size.height * .56,
                            width: size.width * .9,
                            backgroundColor: AppColors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: IconBorder.fromIcon(
                          color: AppColors.red,
                          icon: Icons.delete_forever,
                          onTap: () => controller.clear(),
                          size: const Size(44, 44),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(30),
                CustomElevatedButton(
                  icon: const Icon(
                    Icons.edit,
                    color: AppColors.white,
                  ),
                  positionIcon: PositionIcon.left,
                  text: 'button.send'.tr(),
                  color: context.primaryColor(),
                  onPressed: () async {
                    final directory = await getApplicationDocumentsDirectory();
                    final customDir =
                        Directory('${directory.path}/MySignatures');

                    // Crea el directorio si no existe
                    if (!await customDir.exists()) {
                      await customDir.create(recursive: true);
                      log('Directorio creado: ${customDir.path}');
                    }

                    // Define la ruta de la imagen directamente en el directorio
                    final localPath =
                        '${customDir.path}/${DateTime.now().millisecondsSinceEpoch}.png';

                    // Genera la imagen de la firma
                    final signatureImage = await controller.toPngBytes();

                    if (signatureImage != null) {
                      // Guarda la imagen directamente en el directorio
                      final file = File(localPath);
                      await file.writeAsBytes(signatureImage);
                      log('Firma guardada en: $localPath');
                    } else {
                      log('No se pudo generar la imagen de la firma.');
                      return;
                    }
                    if (context.mounted && localPath.isNotEmpty) {
                      context.read<UploadUserFileCubit>().saveFirmaAsesor(
                            firmaAsesorPath: localPath,
                          );
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                ),
                const Gap(10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

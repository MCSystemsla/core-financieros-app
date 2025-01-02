import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/energia_limpia/energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/migrantes_economicos/migrantes_economicos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/icon_border.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/custom_pop_up.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class MigrantesFormSignature extends StatelessWidget {
  const MigrantesFormSignature({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final controller = SignatureController();
    // final imageProvider = context.watch<UploadUserFileCubit>().state;
    final isConnected =
        context.read<InternetConnectionCubit>().state.isConnected;
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
                  'forms.firmar.title'.tr(),
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
                BlocConsumer<MigrantesEconomicosCubit,
                    MigrantesEconomicosState>(
                  listener: (context, state) async {
                    final status = state.status;
                    if (status == Status.error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          showCloseIcon: true,
                          content: Text(state.errorMsg),
                        ),
                      );
                    }
                    if (state.status == Status.done) {
                      final signatureImage = await controller.toPngBytes();
                      final directory =
                          await getApplicationDocumentsDirectory();
                      final filePath = '${directory.path}/signature.png';

                      // Guarda la imagen en el archivo
                      final file = File(filePath);
                      await file.writeAsBytes(signatureImage!);
                      if (!context.mounted) return;
                      context.read<UploadUserFileCubit>().uploadUserFiles(
                            fotoFirma: file,
                            solicitudId: int.parse(
                              context.read<KivaRouteCubit>().state.solicitudId,
                            ),
                            formularioKiva: context
                                .read<KivaRouteCubit>()
                                .state
                                .currentRoute,
                          );
                      await customPopUp(
                        context: context,
                        size: size,
                        title: 'Formulario Kiva Enviado exitosamente!!',
                        subtitle: 'Las respuestas se han enviado Exitosamente',
                        dialogType: DialogType.success,
                        buttonAcept: true,
                        textButtonAcept: 'Ok',
                        colorButtonAcept: AppColors.getPrimaryColor(),
                        onPressedAccept: () {
                          context.pushReplacement('/');
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomElevatedButton(
                      icon: const Icon(
                        Icons.edit,
                        color: AppColors.white,
                      ),
                      enabled: state.status != Status.inProgress,
                      positionIcon: PositionIcon.left,
                      text: state.status == Status.inProgress
                          ? 'Cargando...'
                          : 'button.send'.tr(),
                      color: context.primaryColor(),
                      onPressed: () async {
                        await customPopUp(
                          context: context,
                          size: size,
                          title:
                              'Confirmas que has leido y confirmado el Formulario Kiva?',
                          dialogType: DialogType.warning,
                          buttonAcept: true,
                          buttonCancel: true,
                          colorButtonCancel: AppColors.red,
                          textButtonAcept: 'Aceptar',
                          textButtonCancel: 'Cancelar',
                          colorButtonAcept: AppColors.getPrimaryColor(),
                          onPressedAccept: () async {
                            final directory =
                                await getApplicationDocumentsDirectory();
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
                            final signatureImage =
                                await controller.toPngBytes();

                            if (signatureImage != null) {
                              // Guarda la imagen directamente en el directorio
                              final file = File(localPath);
                              await file.writeAsBytes(signatureImage);
                              log('Firma guardada en: $localPath');
                            } else {
                              log('No se pudo generar la imagen de la firma.');
                              return;
                            }
                            if (!context.mounted) return;
                            // !isConnected
                            // ? null
                            // ? saveEnergiaLocalDB(
                            //     context,
                            //     state,
                            //     ImageModel()
                            //       ..imagenFirma = localPath
                            //       ..imagen1 = imageProvider.imagen1?.path ??
                            //           'No Path'
                            //       ..imagen2 = imageProvider.imagen2?.path ??
                            //           'No Path'
                            //       ..imagen3 = imageProvider.imagen3?.path ??
                            //           'No Path'
                            //       ..solicitudId = int.tryParse(
                            //         context
                            //             .read<KivaRouteCubit>()
                            //             .state
                            //             .solicitudId,
                            //       )
                            //       ..imagen4 =
                            //           imageProvider.fotoCedula?.path ??
                            //               'No Path',
                            //   )
                            context
                                .read<MigrantesEconomicosCubit>()
                                .sendMigrantesEconomicos();
                            // context.read<EnergiaLimpiaCubit>().sendAnswers();
                            context.pop();
                          },
                          onPressedCancel: () => context.pop(),
                        );
                      },
                    );
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

import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/migrante_economico/migrante_economico_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/migrante_economico/recurrente_migrante_economico_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/migrantes_economicos/migrantes_economicos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
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

import '../../../../bloc/recurrente_migrante_economico/recurrente_migrantes_economicos_cubit.dart';

class MigrantesFormSignature extends StatelessWidget {
  const MigrantesFormSignature({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final controller = SignatureController();
    final imageProvider = context.watch<UploadUserFileCubit>().state;
    final isConnected = context.read<InternetConnectionCubit>().state;
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
                  style: const TextStyle(
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
                            tipoSolicitud: context
                                .read<KivaRouteCubit>()
                                .state
                                .tipoSolicitud,
                            fotoFirma: file.path,
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
                            !isConnected.isConnected ||
                                    !isConnected.isCorrectNetwork
                                ? saveAnswersOnLocalDB(
                                    context,
                                    state,
                                    ImageModel()
                                      ..imagenFirma = localPath
                                      ..imagen1 = imageProvider.imagen1
                                      ..imagen2 = imageProvider.imagen2
                                      ..imagen3 = imageProvider.imagen3
                                      ..imagenAsesor = imageProvider.firmaAsesor
                                      ..solicitudId = int.tryParse(
                                        context
                                            .read<KivaRouteCubit>()
                                            .state
                                            .solicitudId,
                                      )
                                      ..imagen4 = imageProvider.fotoCedula,
                                    !isConnected.isCorrectNetwork
                                        ? 'Se ha perdido conexion a VPN, Se ha guardado el formulario de Manera Local'
                                        : 'Formulario Kiva Guardado Exitosamente!!',
                                  )
                                : context
                                    .read<MigrantesEconomicosCubit>()
                                    .sendMigrantesEconomicos();
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

  void saveAnswersOnLocalDB(
    BuildContext context,
    MigrantesEconomicosState state,
    ImageModel imageModel,
    String msgDialog,
  ) {
    context.read<SolicitudesPendientesLocalDbCubit>().saveImagesLocal(
          imageModel: imageModel,
        );
    context.read<SolicitudesPendientesLocalDbCubit>().saveMigranteEconomicoForm(
          migranteEconomicoDbLocal: MigranteEconomicoDbLocal()
            ..tipoSolicitud = state.tipoSolicitud
            ..database = LocalStorage().database
            ..objSolicitudNuevamenorId = state.objSolicitudNuevamenorId
            ..tieneTrabajo = state.tieneTrabajo
            ..trabajoNegocioDescripcion = state.trabajoNegocioDescripcion
            ..tiempoActividad = state.tiempoActividad
            ..otrosIngresos = state.otrosIngresos
            ..otrosIngresosDescripcion = state.otrosIngresosDescripcion
            ..personasCargo = state.personasCargo
            ..objOrigenUbicacionGeograficaId =
                state.objOrigenUbicacionGeograficaId
            ..motivoDejarPais = state.motivoDejarPais
            ..situacionMigratoria = state.situacionMigratoria
            ..dedicabaPaisOrigen = state.dedicabaPaisOrigen
            ..vivePaisActual = state.vivePaisActual
            ..numeroHijos = state.numeroHijos
            ..edadHijos = state.edadHijos
            ..tipoEstudioHijos = state.tipoEstudioHijos
            ..enviaRemesas = state.enviaRemesas
            ..enviaRemesasExplicacion = state.enviaRemesasExplicacion
            ..quienApoya = state.quienApoya
            ..fortalecerIngresos = state.fortalecerIngresos
            ..fortalecerIngresosExplicacion =
                state.fortalecerIngresosExplicacion
            ..metasFuturo = state.metasFuturo
            ..motivoPrestamo = state.motivoPrestamo
            ..ayudaMejorarCondiciones = state.ayudaMejorarCondiciones
            ..ayudaMejorarCondicionesExplicacion =
                state.ayudaMejorarCondicionesExplicacion
            ..propositosProximos = state.propositosProximos
            ..piensaRegresar = state.piensaRegresar
            ..otrosDatosCliente = state.otrosDatosCliente,
        );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        content: Text(msgDialog),
      ),
    );
    context.pushReplacement('/');
  }
}

class RecurrenteMigrantesFormSignature extends StatelessWidget {
  const RecurrenteMigrantesFormSignature({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final controller = SignatureController();
    final imageProvider = context.watch<UploadUserFileCubit>().state;
    final isConnected = context.read<InternetConnectionCubit>().state;
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
                  style: const TextStyle(
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
                BlocConsumer<RecurrenteMigrantesEconomicosCubit,
                    RecurrenteMigrantesEconomicosState>(
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
                            tipoSolicitud: context
                                .read<KivaRouteCubit>()
                                .state
                                .tipoSolicitud,
                            fotoFirma: file.path,
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
                            !isConnected.isConnected ||
                                    !isConnected.isCorrectNetwork
                                ? saveAnswersOnLocalDB(
                                    context,
                                    state,
                                    ImageModel()
                                      ..imagenFirma = localPath
                                      ..imagen1 = imageProvider.imagen1
                                      ..imagen2 = imageProvider.imagen2
                                      ..imagen3 = imageProvider.imagen3
                                      ..imagenAsesor = imageProvider.firmaAsesor
                                      ..solicitudId = int.tryParse(
                                        context
                                            .read<KivaRouteCubit>()
                                            .state
                                            .solicitudId,
                                      )
                                      ..imagen4 = imageProvider.fotoCedula,
                                    !isConnected.isCorrectNetwork
                                        ? 'Se ha perdido conexion a VPN, Se ha guardado el formulario de Manera Local'
                                        : 'Formulario Kiva Guardado Exitosamente!!',
                                  )
                                : context
                                    .read<RecurrenteMigrantesEconomicosCubit>()
                                    .sendAnswers();
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

  void saveAnswersOnLocalDB(
    BuildContext context,
    RecurrenteMigrantesEconomicosState state,
    ImageModel imageModel,
    String msgDialog,
  ) {
    context.read<SolicitudesPendientesLocalDbCubit>().saveImagesLocal(
          imageModel: imageModel,
        );
    context
        .read<SolicitudesPendientesLocalDbCubit>()
        .saveRecurrentMigranteEconomico(
          recurrenteMigranteEconomicoDbLocal:
              RecurrenteMigranteEconomicoDbLocal()
                ..tipoSolicitud = state.tipoSoliictud
                ..database = LocalStorage().database
                ..objSolicitudRecurrenteId = state.objSolicitudRecurrenteId
                ..tieneTrabajo = state.tieneTrabajo
                ..trabajoNegocioDescripcion = state.trabajoNegocioDescripcion
                ..tiempoActividad = state.tiempoActividad
                ..numeroHijos = state.numeroHijos
                ..edadHijos = state.edadHijos
                ..tipoEstudioHijos = state.tipoEstudioHijos
                ..otrosIngresos = state.otrosIngresos
                ..otrosIngresosDescripcion = state.otrosIngresosDescripcion
                ..personasCargo = state.personasCargo
                ..motivoPrestamo = state.motivoPrestamo
                ..objSolicitudRecurrenteId = state.objSolicitudRecurrenteId
                ..coincideRespuesta = state.coincideRespuesta
                ..explicacionInversion = state.explicacionInversion
                ..apoyanNegocio = state.apoyanNegocio
                ..quienApoya = state.quienApoya
                ..cuantosApoyan = state.cuantosApoyan
                ..mejoraCondiciones = state.mejoraCondiciones
                ..explicacionMejoraCondiciones =
                    state.explicacionMejoraCondiciones
                ..siguienteMeta = state.siguienteMeta,
        );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        content: Text(msgDialog),
      ),
    );
    context.pushReplacement('/');
  }
}

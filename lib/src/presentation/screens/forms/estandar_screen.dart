import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/estandar/estandar_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/estandar/recurrente_estandar_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/estandar/estandar_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/motivo_prestamo/motivo_prestamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_estandar/recurrente_estandart_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/add_kiva_images_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/form_responses.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_image_sending/kiva_image_sending.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/estandar/estandar_aditional_data.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/estandar/estandar_descripcion_del_negocio.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/estandar/estandar_entorno_familiar.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/estandar/estandar_impacto_social.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/no_internet_popup_onkiva.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/icon_border.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/custom_pop_up.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class EstandarScreen extends StatelessWidget {
  final String typeProduct;
  const EstandarScreen({super.key, required this.typeProduct});

  @override
  Widget build(BuildContext context) {
    final isRecurrentForm =
        typeProduct.trim() == 'ScrKivaCreditoEstandarRecurrente';
    final pageController = PageController();
    final repository = ResponsesRepositoryImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => EstandarCubit(repository),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteEstandartCubit(repository),
        ),
        BlocProvider(
          create: (ctx) => ResponseCubit(),
        ),
        BlocProvider(
          create: (ctx) => DepartamentosCubit(DepartamentosRepositoryImpl())
            ..getDepartamentos(),
        ),
        BlocProvider(
          create: (ctx) => MotivoPrestamoCubit(repository)
            ..getMotivoPrestamo(
              numero: int.parse(
                context.read<KivaRouteCubit>().state.solicitudId,
              ),
            ),
        ),
        BlocProvider(
          create: (ctx) => UploadUserFileCubit(repository),
        ),
      ],
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Estandar ${isRecurrentForm ? 'Recurrente' : 'Nuevo'}'),
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              AddKivaImagesWidget(
                controller: pageController,
              ),
              EstandarAditionalData(
                isRecurrenteForm: isRecurrentForm,
                pageController: pageController,
              ),
              EstandarEntornoFamiliar(
                isRecurrenteForm: isRecurrentForm,
                pageController: pageController,
              ),
              EstandarDescripciondelNegocio(
                isRecurrentForm: isRecurrentForm,
                pageController: pageController,
              ),
              EstandarImpactoSocial(
                isRecurrentForm: isRecurrentForm,
                pageController: pageController,
              ),
              FormResponses(
                controller: pageController,
              ),
              isRecurrentForm
                  ? _RecurrentSign(
                      controller: pageController,
                    )
                  : EstandarSign(
                      controller: pageController,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class EstandarSign extends StatefulWidget {
  final PageController controller;
  const EstandarSign({super.key, required this.controller});

  @override
  State<EstandarSign> createState() => _EstandarSignState();
}

class _EstandarSignState extends State<EstandarSign> {
  TypeSigner typeSigner = TypeSigner.ninguno;

  @override
  Widget build(BuildContext context) {
    final imageProvider = context.read<UploadUserFileCubit>().state;
    final size = MediaQuery.sizeOf(context);
    final controller = SignatureController();
    final isConnected = context.read<InternetConnectionCubit>().state;
    return SingleChildScrollView(
      child: Column(
        children: [
          const MiCreditoProgress(
            steps: 5,
            currentStep: 5,
          ),
          const Gap(5),
          Padding(
            padding: const EdgeInsets.all(8),
            child: JLuxDropdown(
              dropdownColor: AppColors.white,
              title: 'Tiene capacidad el usuario para firma?',
              items: ['input.yes'.tr(), 'input.no'.tr()],
              onChanged: (item) {
                setState(() {
                  typeSigner = item == 'input.yes'.tr()
                      ? TypeSigner.cliente
                      : TypeSigner.asesor;
                });
              },
              toStringItem: (item) => item,
              hintText: 'input.select_option'.tr(),
            ),
          ),
          if (typeSigner != TypeSigner.ninguno)
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' ${typeSigner == TypeSigner.cliente ? 'forms.firmar.title'.tr() : 'Firma de Representante de Micrédito'}',
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
                  const Gap(5),
                  Stack(
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
                            height: size.height * .56,
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
                  const Gap(30),
                  BlocConsumer<EstandarCubit, EstandarState>(
                    listener: (context, state) async {
                      final status = state.status;
                      if (status == Status.error) {
                        CustomAlertDialog(
                          context: context,
                          title: state.errorMsg,
                          onDone: () => context.pop(),
                        ).showDialog(context, dialogType: DialogType.error);
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
                        CustomAlertDialog(
                          context: context,
                          title: 'Formulario Kiva enviado exitosamente!!',
                          subtitle:
                              'Las respuestas se han enviado Exitosamente.',
                          onDone: () {
                            if (!context.mounted) return;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => BlocProvider.value(
                                  value: context.read<UploadUserFileCubit>(),
                                  child: KivaImageSending(
                                    solicitudId: context
                                        .read<KivaRouteCubit>()
                                        .state
                                        .solicitudId,
                                    onRetry: () {
                                      context
                                          .read<UploadUserFileCubit>()
                                          .uploadUserFiles(
                                            typeSigner: typeSigner,
                                            cedula: context
                                                .read<KivaRouteCubit>()
                                                .state
                                                .cedula,
                                            numero: context
                                                .read<KivaRouteCubit>()
                                                .state
                                                .numero,
                                            tipoSolicitud: context
                                                .read<KivaRouteCubit>()
                                                .state
                                                .tipoSolicitud,
                                            fotoFirma: file.path,
                                            solicitudId: int.parse(
                                              context
                                                  .read<KivaRouteCubit>()
                                                  .state
                                                  .solicitudId,
                                            ),
                                            formularioKiva: context
                                                .read<KivaRouteCubit>()
                                                .state
                                                .nombreFormularioKiva,
                                          );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ).showDialog(context, dialogType: DialogType.success);
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
                          FocusScope.of(context).unfocus();
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
                              FocusScope.of(context).unfocus();
                              context
                                  .read<SolicitudesPendientesLocalDbCubit>()
                                  .updateIsSendedOnSolicitud(
                                    solicitudId: context
                                        .read<KivaRouteCubit>()
                                        .state
                                        .solicitudId,
                                  );

                              final localPath =
                                  await KivaFile.saveImageSignature(
                                controller: controller,
                              );
                              if (!context.mounted) return;
                              await saveOfflineResponses(
                                context,
                                state,
                                ImageModel()
                                  ..typeSigner = typeSigner.name
                                  ..imagenFirma = localPath
                                  ..imagen1 = imageProvider.imagen1
                                  ..imagen2 = imageProvider.imagen2
                                  ..imagen3 = imageProvider.imagen3
                                  ..solicitudId = int.tryParse(
                                    context
                                        .read<KivaRouteCubit>()
                                        .state
                                        .solicitudId,
                                  ),
                              );
                              if (!context.mounted) return;
                              if (isConnected.isConnected) {
                                context.read<EstandarCubit>().sendAnswers();
                              }
                              context.pop();
                            },
                            onPressedCancel: () => context.pop(),
                          );
                        },
                      );
                    },
                  ),
                  const Gap(10),
                  Expanded(
                    flex: 0,
                    child: CustomElevatedButton(
                      alignment: MainAxisAlignment.center,
                      text: 'Regresar',
                      color: Colors.red,
                      onPressed: () => widget.controller.previousPage(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeIn,
                      ),
                    ),
                  ),
                  const Gap(10),
                ],
              ),
            ),
        ],
      ),
    );
  }

  saveOfflineResponses(
    BuildContext context,
    EstandarState state,
    ImageModel imageModel,
  ) {
    final isConnected =
        context.read<InternetConnectionCubit>().state.isConnected;
    context.read<SolicitudesPendientesLocalDbCubit>().saveImagesLocal(
          imageModel: imageModel,
        );
    context.read<SolicitudesPendientesLocalDbCubit>().saveEstandarForm(
          estandarDBLocal: EstandarDbLocal()
            ..tipoSolicitud = state.tipoSolicitud
            ..apoyanNegocio = state.apoyanNegocio
            ..cuantosApoyan = state.cuantosApoyan
            ..comoMejoraVida = state.comoMejoraVida
            ..database = LocalStorage().database
            ..edadHijos = state.edadHijos
            ..inicioNegocio = DateTime.parse(state.inicioNegocio)
            ..motivoPrestamo = state.motivoPrestamo
            ..negocioProximosAnios = state.negocioProximosAnios
            ..numeroHijos = state.numeroHijos
            ..objOrigenCatalogoValorId = state.objOrigenCatalogoValorId
            ..objSolicitudNuevamenorId = state.objSolicitudNuevamenorId
            ..otrosDatosCliente = state.otrosDatosCliente
            ..otrosIngresos = state.otrosIngresos
            ..otrosIngresosDescripcion = state.otrosIngresosDescripcion
            ..personasCargo = state.personasCargo
            ..planesFuturo = state.planesFuturo
            ..publicitarNegocio = state.publicitarNegocio
            ..tipoEstudioHijos = state.tipoEstudioHijos,
        );
    if (!isConnected) {
      return NoInternetPopUpOnKiva(
        context: context,
        header: '',
      ).showDialog(context, dialogType: DialogType.info);
    }
  }
}

class _RecurrentSign extends StatefulWidget {
  final PageController controller;
  const _RecurrentSign({required this.controller});

  @override
  State<_RecurrentSign> createState() => _RecurrentSignState();
}

class _RecurrentSignState extends State<_RecurrentSign> {
  TypeSigner typeSigner = TypeSigner.ninguno;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final controller = SignatureController();
    final isConnected = context.read<InternetConnectionCubit>().state;
    final imageProvider = context.watch<UploadUserFileCubit>().state;
    return SingleChildScrollView(
      child: Column(
        children: [
          const MiCreditoProgress(
            steps: 5,
            currentStep: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: JLuxDropdown(
              dropdownColor: AppColors.white,
              title: 'Tiene capacidad el usuario para firma?',
              items: ['input.yes'.tr(), 'input.no'.tr()],
              onChanged: (item) {
                setState(() {
                  typeSigner = item == 'input.yes'.tr()
                      ? TypeSigner.cliente
                      : TypeSigner.asesor;
                });
              },
              toStringItem: (item) => item,
              hintText: 'input.select_option'.tr(),
            ),
          ),
          if (typeSigner != TypeSigner.ninguno)
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' ${typeSigner == TypeSigner.cliente ? 'forms.firmar.title'.tr() : 'Firma de Representante de Micrédito'}',
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
                  Stack(
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
                            height: size.height * .56,
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
                  const Gap(30),
                  BlocConsumer<RecurrenteEstandartCubit,
                      RecurrenteEstandartState>(
                    listener: (context, state) async {
                      final directory =
                          await getApplicationDocumentsDirectory();
                      final filePath = '${directory.path}/signature.png';

                      final signatureImage = await controller.toPngBytes();

                      // Guarda la imagen en el archivo
                      final file = File(filePath);
                      await file.writeAsBytes(signatureImage!);
                      if (!context.mounted) return;
                      final status = state.status;
                      if (status == Status.error) {
                        CustomAlertDialog(
                          context: context,
                          title: state.erroMsg,
                          onDone: () => context.pop(),
                        ).showDialog(context, dialogType: DialogType.error);
                      }
                      if (state.status == Status.done) {
                        if (!context.mounted) return;
                        if (isConnected.isConnected) {
                          await customPopUp(
                            context: context,
                            dismissOnTouchOutside: false,
                            size: size,
                            title: 'Formulario Kiva Enviado exitosamente!!',
                            subtitle:
                                'Las respuestas se han enviado Exitosamente',
                            dialogType: DialogType.success,
                            buttonAcept: true,
                            textButtonAcept: 'Ok',
                            colorButtonAcept: AppColors.getPrimaryColor(),
                            onPressedAccept: () {
                              if (!context.mounted) return;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => BlocProvider.value(
                                    value: context.read<UploadUserFileCubit>(),
                                    child: KivaImageSending(
                                      solicitudId: context
                                          .read<KivaRouteCubit>()
                                          .state
                                          .solicitudId,
                                      onRetry: () {
                                        context
                                            .read<UploadUserFileCubit>()
                                            .uploadUserFiles(
                                              typeSigner: typeSigner,
                                              cedula: context
                                                  .read<KivaRouteCubit>()
                                                  .state
                                                  .cedula,
                                              numero: context
                                                  .read<KivaRouteCubit>()
                                                  .state
                                                  .numero,
                                              tipoSolicitud: context
                                                  .read<KivaRouteCubit>()
                                                  .state
                                                  .tipoSolicitud,
                                              fotoFirma: file.path,
                                              solicitudId: int.parse(
                                                context
                                                    .read<KivaRouteCubit>()
                                                    .state
                                                    .solicitudId,
                                              ),
                                              formularioKiva: context
                                                  .read<KivaRouteCubit>()
                                                  .state
                                                  .nombreFormularioKiva,
                                            );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
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
                              context
                                  .read<SolicitudesPendientesLocalDbCubit>()
                                  .updateIsSendedOnSolicitud(
                                    solicitudId: context
                                        .read<KivaRouteCubit>()
                                        .state
                                        .solicitudId,
                                  );
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

                              await saveOfflineResponses(
                                context,
                                state,
                                ImageModel()
                                  ..typeSigner = typeSigner.name
                                  ..imagenFirma = localPath
                                  ..imagen1 = imageProvider.imagen1
                                  ..imagen2 = imageProvider.imagen2
                                  ..imagen3 = imageProvider.imagen3
                                  ..solicitudId = int.parse(
                                    context
                                        .read<KivaRouteCubit>()
                                        .state
                                        .solicitudId,
                                  ),
                                size,
                                '',
                              );
                              if (!context.mounted) return;
                              if (isConnected.isConnected) {
                                context
                                    .read<RecurrenteEstandartCubit>()
                                    .sendAnswers();
                                if (!context.mounted) return;
                              }
                              context.pop();
                            },
                            onPressedCancel: () => context.pop(),
                          );
                        },
                      );
                    },
                  ),
                  const Gap(10),
                  Expanded(
                    flex: 0,
                    child: CustomElevatedButton(
                      alignment: MainAxisAlignment.center,
                      text: 'Regresar',
                      color: Colors.red,
                      onPressed: () => widget.controller.previousPage(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeIn,
                      ),
                    ),
                  ),
                  const Gap(10),
                ],
              ),
            ),
        ],
      ),
    );
  }

  saveOfflineResponses(
    BuildContext context,
    RecurrenteEstandartState state,
    ImageModel imageModel,
    Size size,
    String msgDialog,
  ) async {
    if (!context.mounted) return;
    final isConnected =
        context.read<InternetConnectionCubit>().state.isConnected;

    context.read<SolicitudesPendientesLocalDbCubit>().saveImagesLocal(
          imageModel: imageModel,
        );

    context.read<SolicitudesPendientesLocalDbCubit>().saveRecurrentEstandarForm(
          recurrenteEstandarModel: RecurrenteEstandarDbLocal()
            ..apoyanNegocio = state.apoyanNegocio
            ..tipoSolicitud = state.tipoSolitud
            ..coincideRespuesta = state.coincideRespuesta
            ..comoFortalece = state.comoFortalece
            ..comoMejoraEntorno = state.comoMejoraEntorno
            ..cuantosApoyan = state.cuantosApoyan
            ..database = state.database
            ..edadHijos = state.edadHijos
            ..explicacionInversion = state.explicacionInversion
            ..motivoPrestamo = state.motivoPrestamo
            ..numeroHijos = state.numeroHijos
            ..objSolicitudRecurrenteId =
                int.tryParse(context.read<KivaRouteCubit>().state.solicitudId)
            ..otrosIngresos = state.otrosIngresos
            ..otrosIngresosDescripcion = state.otrosIngresosDescripcion
            ..personaAutoSuficiente = state.personaAutoSuficiente
            ..tipoEstudioHijos = state.tipoEstudioHijos
            ..siguientePaso = state.siguientePaso
            ..personasCargo = state.personasCargo,
        );
    if (!isConnected) {
      return NoInternetPopUpOnKiva(
        context: context,
        info: msgDialog,
        header: '',
      ).showDialog(context, dialogType: DialogType.info);
    }
  }

  saveResponsesOnLocalDb(
    BuildContext context,
    RecurrenteEstandartState state,
    ImageModel imageModel,
  ) async {
    if (!context.mounted) return;

    context.read<SolicitudesPendientesLocalDbCubit>().saveImagesLocal(
          imageModel: imageModel,
        );

    context.read<SolicitudesPendientesLocalDbCubit>().saveRecurrentEstandarForm(
          recurrenteEstandarModel: RecurrenteEstandarDbLocal()
            ..apoyanNegocio = state.apoyanNegocio
            ..tipoSolicitud = state.tipoSolitud
            ..coincideRespuesta = state.coincideRespuesta
            ..comoFortalece = state.comoFortalece
            ..comoMejoraEntorno = state.comoMejoraEntorno
            ..cuantosApoyan = state.cuantosApoyan
            ..database = state.database
            ..edadHijos = state.edadHijos
            ..explicacionInversion = state.explicacionInversion
            ..motivoPrestamo = state.motivoPrestamo
            ..numeroHijos = state.numeroHijos
            ..objSolicitudRecurrenteId =
                int.tryParse(context.read<KivaRouteCubit>().state.solicitudId)
            ..otrosIngresos = state.otrosIngresos
            ..otrosIngresosDescripcion = state.otrosIngresosDescripcion
            ..personaAutoSuficiente = state.personaAutoSuficiente
            ..tipoEstudioHijos = state.tipoEstudioHijos
            ..siguientePaso = state.siguientePaso
            ..personasCargo = state.personasCargo,
        );
  }
}

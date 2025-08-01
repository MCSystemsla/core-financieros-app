import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/mujer_emprende/mujer_emprende_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/mujer_emprende/recurrente_mujer_emprende_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/motivo_prestamo/motivo_prestamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/mujer_emprende/mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_mujer_emprende/recurrente_mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_image_sending/kiva_image_sending.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mujer_emprende/descripcion_y_desarrollo_del_negocio_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mujer_emprende/mujer_emprende_entorno_social_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mujer_emprende/mujer_emprende_impacto_social_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/no_vpn_popup_onkiva.dart';
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

class MujerEmprenderScreen extends StatelessWidget {
  final String typeProduct;
  const MujerEmprenderScreen({super.key, required this.typeProduct});

  @override
  Widget build(BuildContext context) {
    final repository = ResponsesRepositoryImpl();
    final isRecurrentForm = typeProduct == 'ScrKivaMujerEmprendeRecurrente';
    final pageController = PageController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ResponseCubit(),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteMujerEmprendeCubit(repository),
        ),
        BlocProvider(
          create: (ctx) => MujerEmprendeCubit(repository),
        ),
        BlocProvider(
          create: (ctx) => DepartamentosCubit(DepartamentosRepositoryImpl())
            ..getDepartamentos(),
        ),
        BlocProvider(
          create: (ctx) => UploadUserFileCubit(repository),
        ),
        BlocProvider(
          create: (ctx) => MotivoPrestamoCubit(repository)
            ..getMotivoPrestamo(
              numero: int.parse(
                context.read<KivaRouteCubit>().state.solicitudId,
              ),
            ),
        ),
      ],
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
                'Mujer Emprende ${isRecurrentForm ? 'Recurrente' : 'Nuevo'}'),
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              SaneamientoContent(
                controller: pageController,
              ),
              MujerEmprendeEntornoSocialWidget(
                pageController: pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              DescripcionYDesarrolloDelNegocioWidget(
                pageController: pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              MujerEmprendeImpactoSocial(
                pageController: pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              FormResponses(
                controller: pageController,
              ),
              isRecurrentForm
                  ? _RecurrentSignSignature(
                      controller: pageController,
                    )
                  : _SignSignature(
                      controller: pageController,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecurrentSignSignature extends StatefulWidget {
  final PageController controller;
  const _RecurrentSignSignature({required this.controller});

  @override
  State<_RecurrentSignSignature> createState() =>
      _RecurrentSignSignatureState();
}

class _RecurrentSignSignatureState extends State<_RecurrentSignSignature> {
  TypeSigner typeSigner = TypeSigner.ninguno;
  @override
  void initState() {
    super.initState();
    context.read<InternetConnectionCubit>().getInternetStatusConnection();
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = context.watch<UploadUserFileCubit>().state;
    final size = MediaQuery.sizeOf(context);
    final controller = SignatureController();
    final isConnected = context.read<InternetConnectionCubit>().state;
    return Column(
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
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
                  BlocConsumer<RecurrenteMujerEmprendeCubit,
                      RecurrenteMujerEmprendeState>(
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

                              await saveOnLocalDB(
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
                                '',
                              );
                              if (!context.mounted) return;
                              if (isConnected.isConnected) {
                                context
                                    .read<RecurrenteMujerEmprendeCubit>()
                                    .sendAnswers();
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
          ),
      ],
    );
  }

  saveOnLocalDB(
    BuildContext context,
    RecurrenteMujerEmprendeState state,
    ImageModel imageModel,
    String msgDialog,
  ) {
    final isConnected =
        context.read<InternetConnectionCubit>().state.isConnected;
    context.read<SolicitudesPendientesLocalDbCubit>().saveImagesLocal(
          imageModel: imageModel,
        );
    context
        .read<SolicitudesPendientesLocalDbCubit>()
        .saveRecurrenteMujerEmprendeForm(
          recurrenteMujerEmprendeDbLocal: RecurrenteMujerEmprendeDbLocal()
            ..tipoSolicitud = state.tipoSolicitud
            ..alcanzaraMeta = state.alcanzaraMeta
            ..apoyanNegocio = state.apoyanNegocio
            ..coincideRespuesta = state.coincideRespuesta
            ..comoAyudo = state.comoAyudo
            ..cuantosApoyan = state.cuantosApoyan
            ..database = state.database
            ..edadHijos = state.edadHijos
            ..explicacionAlcanzaraMeta = state.explicacionAlcanzaraMeta
            ..explicacionInversion = state.explicacionInversion
            ..mejoraraEntorno = state.mejoraraEntorno
            ..mejoraraEntornoExplicacion = state.mejoraraEntornoExplicacion
            ..motivoPrestamo = state.motivoPrestamo
            ..numeroHijos = state.numeroHijos
            ..objSolicitudRecurrenteId = state.objSolicitudRecurrenteId
            ..otrosIngresos = state.otrosIngresos
            ..otrosIngresosDescripcion = state.otrosIngresosDescripcion
            ..personasCargo = state.personasCargo
            ..siguientePaso = state.siguientePaso
            ..tieneTrabajo = state.tieneTrabajo
            ..tieneTrabajoDescripcion = state.tieneTrabajoDescripcion
            ..tipoEstudioHijos = state.tipoEstudioHijos,
        );
    if (!isConnected) {
      return NoVpnPopUpOnKiva(
        context: context,
        info: msgDialog,
        header: '',
      ).showDialog(context, dialogType: DialogType.info);
    }
  }
}

class _SignSignature extends StatefulWidget {
  final PageController controller;
  const _SignSignature({required this.controller});

  @override
  State<_SignSignature> createState() => _SignSignatureState();
}

class _SignSignatureState extends State<_SignSignature> {
  TypeSigner typeSigner = TypeSigner.ninguno;
  @override
  void initState() {
    super.initState();
    context.read<InternetConnectionCubit>().getInternetStatusConnection();
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = context.watch<UploadUserFileCubit>().state;
    final size = MediaQuery.sizeOf(context);
    final controller = SignatureController();
    final isConnected = context.read<InternetConnectionCubit>().state;
    return Column(
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
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
                  BlocConsumer<MujerEmprendeCubit, MujerEmprendeState>(
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

                              await saveAnwersLocalDb(
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
                                '',
                              );
                              if (!context.mounted) return;
                              if (isConnected.isConnected) {
                                context
                                    .read<MujerEmprendeCubit>()
                                    .sendAnswers();
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
          ),
      ],
    );
  }

  saveAnwersLocalDb(
    BuildContext context,
    MujerEmprendeState state,
    ImageModel imageModel,
    String msgDialog,
  ) async {
    final isConnected =
        context.read<InternetConnectionCubit>().state.isConnected;
    context.read<SolicitudesPendientesLocalDbCubit>().saveImagesLocal(
          imageModel: imageModel,
        );
    context.read<SolicitudesPendientesLocalDbCubit>().saveMujerEmprendeForm(
          mujerEmprendeDbLocal: MujerEmprendeDbLocal()
            ..tipoSolicitud = state.tipoSolicitud
            ..comoImpactariaNegocio = state.comoImpactariaNegocio
            ..comoMejoraCalidadVida = state.comoMejoraCalidadVida
            ..conocioMujerEmprende = state.conocioMujerEmprende
            ..database = state.database
            ..edadHijos = state.edadHijos
            ..impulsoOptar = state.impulsoOptar
            ..motivoEmprender = state.motivoEmprender
            ..motivoPrestamo = state.motivoPrestamo
            ..numeroHijos = state.numeroHijos
            ..objOrigenCatalogoValorId = state.objOrigenCatalogoValorId
            ..objSolicitudNuevamenorId = state.objSolicitudNuevamenorId
            ..otrosDatosCliente = state.otrosDatosCliente
            ..otrosIngresos = state.otrosIngresos
            ..otrosIngresosDescripcion = state.otrosIngresosDescripcion
            ..personasCargo = state.personasCargo
            ..quienApoya = state.quienApoya
            ..tipoEstudioHijos = state.tipoEstudioHijos,
        );
    if (!isConnected) {
      return NoVpnPopUpOnKiva(
        context: context,
        info: msgDialog,
        header: '',
      ).showDialog(context, dialogType: DialogType.info);
    }
  }
}

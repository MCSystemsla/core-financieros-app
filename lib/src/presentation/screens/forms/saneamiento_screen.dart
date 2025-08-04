import 'dart:developer';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/saneamiento/recurrente_saneamiento_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/saneamiento/saneamiento_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/agua_y_saneamiento/agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/motivo_prestamo/motivo_prestamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_agua_y_saniamiento/recurrente_agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/add_kiva_images_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/form_responses.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_image_sending/kiva_image_sending.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/saneamiento/descripcion_y_desarrollo_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/saneamiento/entorno_social_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/saneamiento/saneamiento_impacto_social.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/no_internet_popup_onkiva.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/icon_border.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/custom_pop_up.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class SaneamientoScreen extends StatefulWidget {
  final String typeProduct;

  const SaneamientoScreen({super.key, required this.typeProduct});

  @override
  State<SaneamientoScreen> createState() => _SaneamientoScreenState();
}

class _SaneamientoScreenState extends State<SaneamientoScreen> {
  final PageController _pageController = PageController();

  late DateTime _selectedDate;
  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final repository = ResponsesRepositoryImpl();
    final isRecurrentForm =
        widget.typeProduct == 'ScrKivaAguaSaneamientoRecurrente';
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ResponseCubit(),
        ),
        BlocProvider(
          create: (ctx) => DepartamentosCubit(
            DepartamentosRepositoryImpl(),
          )..getDepartamentos(),
        ),
        BlocProvider(
          create: (ctx) => AguaYSaneamientoCubit(repository),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteAguaYSaneamientoCubit(repository),
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
                '${'forms.saneamiento.appbar'.tr()} ${isRecurrentForm ? 'Recurrente' : 'Nuevo'}'),
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              AddKivaImagesWidget(
                controller: _pageController,
              ),
              EntornoSocialWidget(
                controller: _pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              DescripcionYDesarrolloWidget(
                controller: _pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              ImpactoSocialKivaWidget(
                controller: _pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              FormResponses(
                controller: _pageController,
              ),
              isRecurrentForm
                  ? _RecurrentSign(
                      controller: _pageController,
                    )
                  : _SaneamientoSign(
                      controller: _pageController,
                    ),
            ],
          ),
        ),
      ),
    );
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
                  BlocConsumer<RecurrenteAguaYSaneamientoCubit,
                      RecurrenteAguaYSaneamientoState>(
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
                              final localPath =
                                  await KivaFile.saveImageSignature(
                                controller: controller,
                              );
                              if (!context.mounted) return;

                              await saveAnswersOnLocalDB(
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
                                    .read<RecurrenteAguaYSaneamientoCubit>()
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

  saveAnswersOnLocalDB(
    BuildContext context,
    RecurrenteAguaYSaneamientoState state,
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
        .saveRecurrentSaneamientoForm(
          recurrenteSaneamientoDbLocal: RecurrenteSaneamientoDbLocal()
            ..alcanzaraMeta = state.alcanzaraMeta
            ..tipoSolicitud = state.tipoSolicitud
            ..coincideRespuesta = state.coincideRespuesta
            ..comoAyudoCondiciones = state.comoAyudoCondiciones
            ..comoMejoraCondicionesEntorno = state.comoMejoraCondicionesEntorno
            ..database = state.database
            ..edadHijos = state.edadHijos
            ..explicacionAlcanzaraMeta = state.explicacionAlcanzaraMeta
            ..explicacionInversion = state.explicacionInversion
            ..motivoPrestamo = state.motivoPrestamo
            ..numeroHijos = state.numeroHijos
            ..objSolicitudRecurrenteId = state.objSolicitudRecurrenteId
            ..otrosDatosCliente = state.otrosDatosCliente
            ..otrosIngresos = state.otrosIngresos
            ..otrosIngresosDescripcion = state.otrosIngresosDescripcion
            ..personasCargo = state.personasCargo
            ..quienApoya = state.quienApoya
            ..siguientePaso = state.siguientePaso
            ..tiempoActividad = state.tiempoActividad
            ..tieneTrabajo = state.tieneTrabajo
            ..trabajoNegocioDescripcion = state.trabajoNegocioDescripcion
            ..tipoEstudioHijos = state.tipoEstudioHijos,
        );
    if (!isConnected) {
      return NoInternetPopUpOnKiva(
        context: context,
        info: msgDialog,
        header: '',
      ).showDialog(context, dialogType: DialogType.info);
    }
  }
}

class _SaneamientoSign extends StatefulWidget {
  final PageController controller;
  const _SaneamientoSign({required this.controller});

  @override
  State<_SaneamientoSign> createState() => _SaneamientoSignState();
}

class _SaneamientoSignState extends State<_SaneamientoSign> {
  TypeSigner typeSigner = TypeSigner.ninguno;
  @override
  void initState() {
    super.initState();
    context.read<InternetConnectionCubit>().getInternetStatusConnection();
  }

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
                  BlocConsumer<AguaYSaneamientoCubit, AguaYSaneamientoState>(
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

                              await saveAnswersOnLocalDB(
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
                                    .read<AguaYSaneamientoCubit>()
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

  saveAnswersOnLocalDB(
    BuildContext context,
    AguaYSaneamientoState state,
    ImageModel imageModel,
    String msgDialog,
  ) async {
    final isConnected =
        context.read<InternetConnectionCubit>().state.isConnected;
    context.read<SolicitudesPendientesLocalDbCubit>().saveImagesLocal(
          imageModel: imageModel,
        );
    context.read<SolicitudesPendientesLocalDbCubit>().saveSaneamientoForm(
          saneamientoDbLocal: SaneamientoDbLocal()
            ..tipoSolicitud = state.tipoSolicitud
            ..cumpliriaPropuesta = state.cumpliriaPropuesta
            ..database = state.database
            ..edadHijos = state.edadHijos
            ..explicacionCumpliriaPropuesta =
                state.explicacionCumpliriaPropuesta
            ..importanciaMejorarCondiciones =
                state.importanciaMejorarCondiciones
            ..mejoraCalidadVida = state.mejoraCalidadVida
            ..metasProximas = state.metasProximas
            ..motivacionCredito = state.motivacionCredito
            ..motivoPrestamo = state.motivoPrestamo
            ..numeroHijos = state.numeroHijos
            ..objOrigenCatalogoValorId = state.objOrigenCatalogoValorId
            ..objSolicitudNuevamenorId = state.solicitudNuevamenorId
            ..otrosDatosCliente = state.otrosDatosCliente
            ..otrosIngresos = state.otrosIngresos
            ..otrosIngresosDescripcion = state.otrosIngresosDescripcion
            ..personasCargo = state.personasCargo
            ..siguienteProyectoCalidadVida = state.siguienteProyectoCalidadVida
            ..tiempoActividad = state.tiempoActividad
            ..tieneTrabajo = state.tieneTrabajo
            ..tipoEstudioHijos = state.tipoEstudioHijos
            ..trabajoNegocioDescripcion = state.trabajoNegocioDescripcion,
        );
    if (!isConnected) {
      return NoInternetPopUpOnKiva(
        context: context,
        info: msgDialog,
        header: '',
      ).showDialog(context, dialogType: DialogType.info);
    }
  }
}

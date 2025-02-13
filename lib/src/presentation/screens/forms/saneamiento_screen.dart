import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/estandar/estandar_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/mejora_vivienda/mejora_vivienda_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/saneamiento/recurrente_saneamiento_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/saneamiento/saneamiento_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/agua_y_saneamiento/agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/estandar/estandar_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/motivo_prestamo/motivo_prestamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/mejora_vivienda/mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_agua_y_saniamiento/recurrente_agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/mejora_de_vivienda_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/asesor_signature_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/saneamiento/descripcion_y_desarrollo_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/saneamiento/entorno_social_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/saneamiento/saneamiento_impacto_social.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/no_vpn_popup_onkiva.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/icon_border.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/custom_pop_up.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/upload_image_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
// import 'package:path/path.dart' as path; // Para manejar nombres de archivo

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
    _selectedDate = DateTime.now();
    super.initState();
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
        widget.typeProduct == 'AGUA Y SANEAMIENTO RECURRENTE';
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
              SaneamientoContent(
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
              AsesorSignatureWidget(
                pageController: _pageController,
              ),
              isRecurrentForm
                  ? const _RecurrentSign()
                  : const _SaneamientoSign(),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecurrentSign extends StatefulWidget {
  const _RecurrentSign();

  @override
  State<_RecurrentSign> createState() => _RecurrentSignState();
}

class _RecurrentSignState extends State<_RecurrentSign> {
  @override
  void initState() {
    context.read<InternetConnectionCubit>().getInternetStatusConnection();

    super.initState();
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
                      context.read<UploadUserFileCubit>().uploadUserFiles(
                            numero: context.read<KivaRouteCubit>().state.numero,
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
                        dismissOnTouchOutside: false,
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
                                ? await saveAnswersOnLocalDB(
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
                                      ),
                                    !isConnected.isCorrectNetwork
                                        ? 'Se ha perdido conexion a VPN, Se ha guardado el formulario de Manera Local'
                                        : 'Formulario Kiva Guardado Exitosamente!!',
                                  )
                                : context
                                    .read<RecurrenteAguaYSaneamientoCubit>()
                                    .sendAnswers();
                            if (!context.mounted) return;
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

  saveAnswersOnLocalDB(
    BuildContext context,
    RecurrenteAguaYSaneamientoState state,
    ImageModel imageModel,
    String msgDialog,
  ) {
    final isVpnConnected =
        context.read<InternetConnectionCubit>().state.isCorrectNetwork;
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

    return NoVpnPopUpOnKiva(
      context: context,
      info: msgDialog,
      header: '',
      isVpnConnected: isVpnConnected,
    ).showDialog(context, dialogType: DialogType.info);
  }
}

class EstandarSign extends StatefulWidget {
  const EstandarSign({super.key});

  @override
  State<EstandarSign> createState() => _EstandarSignState();
}

class _EstandarSignState extends State<EstandarSign> {
  @override
  void initState() {
    context.read<InternetConnectionCubit>().getInternetStatusConnection();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = context.read<UploadUserFileCubit>().state;
    final size = MediaQuery.sizeOf(context);
    final controller = SignatureController();
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
                      context.read<UploadUserFileCubit>().uploadUserFiles(
                            numero: context.read<KivaRouteCubit>().state.numero,
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
                        dismissOnTouchOutside: false,
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
                                ? await saveOfflineResponses(
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
                                      ),
                                    !isConnected.isCorrectNetwork
                                        ? 'Se ha perdido conexion a VPN, Se ha guardado el formulario de Manera Local'
                                        : 'Formulario Kiva Guardado Exitosamente!!',
                                  )
                                : context.read<EstandarCubit>().sendAnswers();
                            if (!context.mounted) return;
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

  saveOfflineResponses(
    BuildContext context,
    EstandarState state,
    ImageModel imageModel,
    String msgDialog,
  ) {
    final isVpnConnected =
        context.read<InternetConnectionCubit>().state.isCorrectNetwork;
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

    return NoVpnPopUpOnKiva(
      context: context,
      info: msgDialog,
      header: '',
      isVpnConnected: isVpnConnected,
    ).showDialog(context, dialogType: DialogType.info);
  }
}

class SaneamientoContent extends StatefulWidget {
  final PageController controller;
  const SaneamientoContent({super.key, required this.controller});

  @override
  State<SaneamientoContent> createState() => _SaneamientoContentState();
}

class _SaneamientoContentState extends State<SaneamientoContent>
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
    final solicitudCliente = context.read<KivaRouteCubit>().state.nombre;
    final size = MediaQuery.sizeOf(context);
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
              'Cliente: $solicitudCliente',
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
              onPressed: () async {
                await picker
                    .pickImage(
                  source: ImageSource.camera,
                  maxHeight: 600,
                  maxWidth: 600,
                  imageQuality: 85,
                )
                    .then(
                  (XFile? photo) async {
                    if (photo != null) {
                      final appDir = await getApplicationDocumentsDirectory();
                      final customDir = Directory('${appDir.path}/MyImages');

                      // Crea el directorio si no existe
                      if (!await customDir.exists()) {
                        await customDir.create(recursive: true);
                        log('Directorio creado: ${customDir.path}');
                      }
                      // Define la ruta de la imagen en el directorio
                      final localPath =
                          '${customDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

                      // Copia la imagen seleccionada al directorio
                      final imageFile = File(photo.path);
                      await imageFile.copy(localPath);
                      selectedImage = photo;
                      selectedImage1Path = localPath;

                      setState(() {});
                    }
                  },
                );
              },
            ),
            const Gap(20),
            UploadImageWidget(
              selectedImage: selectedImage2,
              title: '2-  ${'forms.saneamiento.client_photo'.tr()}',
              onPressed: () async {
                await picker
                    .pickImage(
                  source: ImageSource.camera,
                  maxHeight: 600,
                  maxWidth: 600,
                  imageQuality: 85,
                )
                    .then(
                  (XFile? photo) async {
                    if (photo != null) {
                      final appDir = await getApplicationDocumentsDirectory();
                      final customDir = Directory('${appDir.path}/MyImages');

                      // Crea el directorio si no existe
                      if (!await customDir.exists()) {
                        await customDir.create(recursive: true);
                        log('Directorio creado: ${customDir.path}');
                      }
                      // Define la ruta de la imagen en el directorio
                      final localPath =
                          '${customDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

                      // Copia la imagen seleccionada al directorio
                      final imageFile = File(photo.path);
                      await imageFile.copy(localPath);
                      selectedImage2 = photo;
                      selectedImage2Path = localPath;
                      setState(() {});
                    }
                  },
                );
              },
            ),
            const Gap(15),
            UploadImageWidget(
              selectedImage: selectedImage3,
              title: '3-  ${'forms.saneamiento.client_photo'.tr()}',
              onPressed: () async {
                await picker
                    .pickImage(
                  source: ImageSource.camera,
                  maxHeight: 600,
                  maxWidth: 600,
                  imageQuality: 85,
                )
                    .then(
                  (XFile? photo) async {
                    if (photo != null) {
                      final appDir = await getApplicationDocumentsDirectory();
                      final customDir = Directory('${appDir.path}/MyImages');

                      // Crea el directorio si no existe
                      if (!await customDir.exists()) {
                        await customDir.create(recursive: true);
                        log('Directorio creado: ${customDir.path}');
                      }
                      // Define la ruta de la imagen en el directorio
                      final localPath =
                          '${customDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

                      // Copia la imagen seleccionada al directorio
                      final imageFile = File(photo.path);
                      await imageFile.copy(localPath);

                      selectedImage3 = photo;
                      selectedImage3Path = localPath;
                      setState(() {});
                    }
                  },
                );
              },
            ),
            // UploadImageWidget(
            //   selectedImage: selectedImage4,
            //   title: '4-  ${'Agregar foto de cedula'.tr()}',
            //   onPressed: () async {
            //     await picker
            //         .pickImage(
            //       source: ImageSource.camera,
            //       maxHeight: 600,
            //       maxWidth: 600,
            //       imageQuality: 85,
            //     )
            //         .then(
            //       (XFile? photo) async {
            //         if (photo != null) {
            //           final appDir = await getApplicationDocumentsDirectory();
            //           final customDir = Directory('${appDir.path}/MyImages');

            //           // Crea el directorio si no existe
            //           if (!await customDir.exists()) {
            //             await customDir.create(recursive: true);
            //             log('Directorio creado: ${customDir.path}');
            //           }
            //           // Define la ruta de la imagen en el directorio
            //           final localPath =
            //               '${customDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

            //           // Copia la imagen seleccionada al directorio
            //           final imageFile = File(photo.path);
            //           await imageFile.copy(localPath);
            //           selectedImage4 = photo;
            //           selectedImage4Path = localPath;
            //           setState(() {});
            //         }
            //       },
            //     );
            //   },
            // ),
            const Gap(20),
            ButtonActionsWidget(
              onPreviousPressed: () {
                context.pop();
              },
              onNextPressed: () async {
                if (selectedImage == null ||
                    selectedImage2 == null ||
                    selectedImage3 == null) {
                  await customPopUp(
                    context: context,
                    dismissOnTouchOutside: false,
                    size: size,
                    title: 'Las imagenes son obligatorias',
                    subtitle: 'Rellena todas las imagenes solicitadas',
                    dialogType: DialogType.warning,
                    buttonAcept: true,
                    textButtonAcept: 'Ok',
                    colorButtonAcept: AppColors.getPrimaryColor(),
                    onPressedAccept: () {
                      context.pop();
                    },
                  );
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

class ButtonActionsWidget extends StatelessWidget {
  final void Function()? onPreviousPressed;
  final void Function()? onNextPressed;
  final String previousTitle;
  final String nextTitle;
  final bool? disabled;
  const ButtonActionsWidget({
    super.key,
    required this.onPreviousPressed,
    required this.onNextPressed,
    required this.previousTitle,
    required this.nextTitle,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: CustomElevatedButton(
              alignment: MainAxisAlignment.center,
              text: previousTitle,
              color: Colors.red,
              onPressed: () => onPreviousPressed!(),
            ),
          ),
          const Gap(20),
          Expanded(
            child: disabled == null || disabled == true
                ? const CircularProgressIndicator()
                : CustomElevatedButton(
                    alignment: MainAxisAlignment.center,
                    text: nextTitle,
                    color: AppColors.getPrimaryColor(),
                    onPressed: () => onNextPressed!(),
                  ),
          )
        ],
      ),
    );
  }
}

class _SaneamientoSign extends StatefulWidget {
  const _SaneamientoSign();

  @override
  State<_SaneamientoSign> createState() => _SaneamientoSignState();
}

class _SaneamientoSignState extends State<_SaneamientoSign> {
  @override
  void initState() {
    context.read<InternetConnectionCubit>().getInternetStatusConnection();

    super.initState();
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
                      context.read<UploadUserFileCubit>().uploadUserFiles(
                            numero: context.read<KivaRouteCubit>().state.numero,
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
                        dismissOnTouchOutside: false,
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
                                ? await saveAnswersOnLocalDB(
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
                                      ),
                                    !isConnected.isCorrectNetwork
                                        ? 'Se ha perdido conexion a VPN, Se ha guardado el formulario de Manera Local'
                                        : 'Formulario Kiva Guardado Exitosamente!!',
                                  )
                                : context
                                    .read<AguaYSaneamientoCubit>()
                                    .sendAnswers();
                            if (!context.mounted) return;
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

  saveAnswersOnLocalDB(
    BuildContext context,
    AguaYSaneamientoState state,
    ImageModel imageModel,
    String msgDialog,
  ) async {
    final isVpnConnected =
        context.read<InternetConnectionCubit>().state.isCorrectNetwork;
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

    return NoVpnPopUpOnKiva(
      context: context,
      info: msgDialog,
      header: '',
      isVpnConnected: isVpnConnected,
    ).showDialog(context, dialogType: DialogType.info);
  }
}

class SignQuestionaryWidget extends StatefulWidget {
  const SignQuestionaryWidget({super.key});

  @override
  State<SignQuestionaryWidget> createState() => _SignQuestionaryWidgetState();
}

class _SignQuestionaryWidgetState extends State<SignQuestionaryWidget> {
  @override
  void initState() {
    context.read<InternetConnectionCubit>().getInternetStatusConnection();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final controller = SignatureController();
    final isConnected = context.watch<InternetConnectionCubit>().state;
    final imageProvider = context.watch<UploadUserFileCubit>().state;

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
                BlocConsumer<MejoraViviendaCubit, MejoraViviendaState>(
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
                      context.read<UploadUserFileCubit>().uploadUserFiles(
                            numero: context.read<KivaRouteCubit>().state.numero,
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
                        dismissOnTouchOutside: false,
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
                                ? await saveMejoraViviendaForm(
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
                                      ),
                                    !isConnected.isCorrectNetwork
                                        ? 'Se ha perdido conexion a VPN, Se ha guardado el formulario de Manera Local'
                                        : 'Formulario Kiva Guardado Exitosamente!!',
                                  )
                                : context
                                    .read<MejoraViviendaCubit>()
                                    .sendAnswers();
                            if (!context.mounted) return;
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

  saveMejoraViviendaForm(
    BuildContext ctx,
    MejoraViviendaState state,
    ImageModel imageModel,
    String msgDialog,
  ) async {
    if (!context.mounted) return;
    final isVpnConnected =
        context.read<InternetConnectionCubit>().state.isCorrectNetwork;
    context.read<SolicitudesPendientesLocalDbCubit>().saveImagesLocal(
          imageModel: imageModel,
        );
    context.read<SolicitudesPendientesLocalDbCubit>().saveMejoraViviendaForm(
          mejoraViviendaDBLocal: MejoraViviendaDbLocal()
            ..tipoSolicitud = state.tipoSolicitud
            ..comoAyudara = state.comoAyudara
            ..database = LocalStorage().database
            ..edadHijos = state.edadHijos
            ..motivoPrestamo = state.motivoPrestamo
            ..necesidadesComunidad = state.necesidadesComunidad
            ..numeroHijos = state.numeroHijos
            ..objOrigenCatalogoValorId = state.objOrigenCatalogoValorId
            ..objTipoComunidadId = state.objTipoComunidadId
            ..otrosDatosCliente = state.otrosDatosCliente
            ..otrosIngresos = state.otrosIngresos
            ..otrosIngresosDescripcion = state.otrosIngresosDescripcion
            ..personasCargo = state.personasCargo
            ..planesFuturo = state.planesFuturo
            ..solicitudNuevamenorId = state.solicitudNuevamenorId
            ..tiempoActividad = state.tiempoActividad
            ..tipoEstudioHijos = state.tipoEstudioHijos
            ..trabajoNegocioDescripcion = state.trabajoNegocioDescripcion
            ..username = '',
        );

    return NoVpnPopUpOnKiva(
      context: context,
      info: msgDialog,
      header: '',
      isVpnConnected: isVpnConnected,
    ).showDialog(context, dialogType: DialogType.info);
  }
}

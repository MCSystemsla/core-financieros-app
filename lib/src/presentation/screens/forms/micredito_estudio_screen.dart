import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/micredi_estudio/micredi_estudio_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/micredi_estudio/recurrente_micredi_estudio_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/micredi_estudio/micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/motivo_prestamo/motivo_prestamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_micredi_estudio/recurrente_micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/screens.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/asesor_signature_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/micredi_estudio/descripcion_academica.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/motivo_prestamo_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/no_vpn_popup_onkiva.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/icon_border.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
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

class MiCreditoEstudioScreen extends StatelessWidget {
  final String typeProduct;
  const MiCreditoEstudioScreen({super.key, required this.typeProduct});

  @override
  Widget build(BuildContext context) {
    final isRecurrentForm = typeProduct == 'MICREDIESTUDIO RECURRENTE';
    final PageController pageController = PageController();
    final repository = ResponsesRepositoryImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ResponseCubit(),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteMicrediEstudioCubit(repository),
        ),
        BlocProvider(
          create: (ctx) => MicrediEstudioCubit(repository),
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
                'MiCredi Estudio  ${isRecurrentForm ? 'Recurrente' : 'Nuevo'}'
                    .tr()),
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              SaneamientoContent(
                controller: pageController,
              ),
              _EntornoSocialEstudioWidget(
                controller: pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              DescripcionAcademica(
                pageController: pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              if (isRecurrentForm)
                MicreditoCreditoAnterior(
                  pageController: pageController,
                ),
              _ImpactoSocialCrediEstudioWidget(
                controller: pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              FormResponses(controller: pageController),
              AsesorSignatureWidget(
                pageController: pageController,
              ),
              isRecurrentForm
                  ? const _RecurrentSigntature()
                  : const _SignUserSignature(),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecurrentSigntature extends StatefulWidget {
  const _RecurrentSigntature();

  @override
  State<_RecurrentSigntature> createState() => _RecurrentSigntatureState();
}

class _RecurrentSigntatureState extends State<_RecurrentSigntature> {
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
                BlocConsumer<RecurrenteMicrediEstudioCubit,
                    RecurrenteMicrediEstudioState>(
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
                                ? await saveFormAnswers(
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
                                    .read<RecurrenteMicrediEstudioCubit>()
                                    .sendAnswers();
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

  saveFormAnswers(
    BuildContext context,
    RecurrenteMicrediEstudioState state,
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
        .saveRecurrentMiCrediEstudioForm(
          recurrenteMiCrediEstudioModelDbLocal:
              RecurrenteMiCrediEstudioDbLocal()
                ..tipoSolicitud = state.tipoSolicitud
                ..alcanzaraMeta = state.alcanzaraMeta
                ..carrera = state.carrera
                ..coincideRespuesta = state.coincideRespuesta
                ..comoAyudaCrecer = state.comoAyudaCrecer
                ..comoAyudoProfesionalmente = state.comoAyudoProfesionalmente
                ..database = state.database
                ..edadHijos = state.edadHijos
                ..explicacionAlcanzaraMeta = state.explicacionAlcanzaraMeta
                ..explicacionInversion = state.explicacionInversion
                ..motivoPrestamo = state.motivoPrestamo
                ..numeroHijos = state.numeroHijos
                ..objSolicitudRecurrenteId = state.objSolicitudRecurrenteId
                ..otrosIngresos = state.otrosIngresos
                ..otrosIngresosDescripcion = state.otrosIngresosDescripcion
                ..personasCargo = state.personasCargo
                ..quienApoya = state.quienApoya
                ..siguientePaso = state.siguientePaso
                ..tiempoActividad = state.tiempoActividad
                ..tiempoCarrera = state.tiempoCarrera
                ..tieneTrabajo = state.tieneTrabajo
                ..tipoEstudioHijos = state.tipoEstudioHijos
                ..trabajoNegocioDescripcion = state.trabajoNegocioDescripcion
                ..universidad = state.universidad,
        );

    return NoVpnPopUpOnKiva(
      context: context,
      info: msgDialog,
      header: '',
      isVpnConnected: isVpnConnected,
    ).showDialog(context, dialogType: DialogType.info);
  }
}

class MicreditoCreditoAnterior extends StatefulWidget {
  final PageController pageController;
  const MicreditoCreditoAnterior({
    super.key,
    required this.pageController,
  });

  @override
  State<MicreditoCreditoAnterior> createState() =>
      _MicreditoCreditoAnteriorState();
}

class _MicreditoCreditoAnteriorState extends State<MicreditoCreditoAnterior>
    with AutomaticKeepAliveClientMixin {
  String? coincideRespuesta;
  final explicacionInversion = TextEditingController();
  final comoAyudoProfesionalmente = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MiCreditoProgress(
                steps: 5,
                currentStep: 2,
              ),
              const Gap(20),
              Text(
                'Descripción del crédito anterior MiCrédiEstudio'.tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const MotivoPrestamoWidget(),
              const Gap(20),
              WhiteCard(
                padding: const EdgeInsets.all(5),
                child: JLuxDropdown(
                  isContainIcon: true,
                  validator: (value) {
                    if (value == null) return 'input.input_validator'.tr();

                    return null;
                  },
                  title:
                      '¿Coincide la respuesta del cliente con el formato anterior?'
                          .tr(),
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    coincideRespuesta = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              const Gap(20),
              if (coincideRespuesta == 'input.no'.tr())
                CommentaryWidget(
                  title:
                      '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                  textEditingController: explicacionInversion,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'input.input_validator'.tr();
                    }
                    return null;
                  },
                ),
              const Gap(20),
              CommentaryWidget(
                title:
                    '¿De qué manera ayudó este préstamo Kiva en su vida profesional?*',
                textEditingController: comoAyudoProfesionalmente,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(20),
              ButtonActionsWidget(
                onPreviousPressed: () {
                  widget.pageController.previousPage(
                    duration: const Duration(
                      milliseconds: 350,
                    ),
                    curve: Curves.easeIn,
                  );
                },
                onNextPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    context.read<RecurrenteMicrediEstudioCubit>().saveAnswers(
                          coincideRespuesta:
                              coincideRespuesta == 'input.yes'.tr(),
                          explicacionInversion:
                              explicacionInversion.text.trim(),
                          comoAyudoProfesionalmente:
                              comoAyudoProfesionalmente.text.trim(),
                          objSolicitudRecurrenteId: int.parse(
                            context.read<KivaRouteCubit>().state.solicitudId,
                          ),
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question:
                              '¿Coincide la respuesta del cliente con el formato anterior?',
                          response: coincideRespuesta ?? 'N/A',
                        ),
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question:
                              '¿Coincide la respuesta del cliente con el formato anterior?',
                          response: coincideRespuesta ?? 'N/A',
                        ),
                        if (coincideRespuesta == 'input.no'.tr())
                          Response(
                            index: widget.pageController.page?.toInt() ?? 0,
                            question:
                                '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                            response: explicacionInversion.text.trim(),
                          ),
                        Response(
                          index: widget.pageController.page?.toInt() ?? 0,
                          question:
                              '¿De qué manera ayudó este préstamo Kiva en su vida profesional?*',
                          response: comoAyudoProfesionalmente.text.trim(),
                        ),
                      ],
                    );
                    widget.pageController.nextPage(
                      duration: const Duration(
                        milliseconds: 350,
                      ),
                      curve: Curves.easeIn,
                    );
                  }
                },
                previousTitle: 'button.previous'.tr(),
                nextTitle: 'button.next'.tr(),
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SignUserSignature extends StatefulWidget {
  const _SignUserSignature();

  @override
  State<_SignUserSignature> createState() => _SignUserSignatureState();
}

class _SignUserSignatureState extends State<_SignUserSignature> {
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
                BlocConsumer<MicrediEstudioCubit, MicrediEstudioState>(
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
                                ? await saveOnLocalDB(
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
                                    .read<MicrediEstudioCubit>()
                                    .sendAnswers();
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

  saveOnLocalDB(
    BuildContext context,
    MicrediEstudioState state,
    ImageModel imageModel,
    String msgDialog,
  ) async {
    final isVpnConnected =
        context.read<InternetConnectionCubit>().state.isCorrectNetwork;
    context.read<SolicitudesPendientesLocalDbCubit>().saveImagesLocal(
          imageModel: imageModel,
        );
    context.read<SolicitudesPendientesLocalDbCubit>().saveMiCrediEstudioForm(
          miCrediEstudioModelDbLocal: MiCrediEstudioDbLocal()
            ..tipoSolicitud = state.tipoSolicitud
            ..aspiraLaboralmente = state.aspiraLaboralmente
            ..carrera = state.carrera
            ..comoAyudaCrecer = state.comoAyudaCrecer
            ..cualEstudio = state.cualEstudio
            ..database = state.database
            ..edadHijos = state.edadHijos
            ..explicacionRelizandoProfesionalmente =
                state.explicacionRelizandoProfesionalmente
            ..motivoCarrera = state.motivoCarrera
            ..motivoPrestamo = state.motivoPrestamo
            ..numeroHijos = state.numeroHijos
            ..objOrigenCatalogoValorId = state.objOrigenCatalogoValorId
            ..objSolicitudNuevamenorId = state.objSolicitudNuevamenorId
            ..ocupacionPadres = state.ocupacionPadres
            ..optarOtroEstudio = state.optarOtroEstudio
            ..otrosDatosCliente = state.otrosDatosCliente
            ..otrosIngresos = state.otrosIngresos
            ..otrosIngresosDescripcion = state.otrosIngresosDescripcion
            ..personasCargo = state.personasCargo
            ..planFuturo = state.planFuturo
            ..quienApoya = state.quienApoya
            ..relizandoProfesionalmente = state.relizandoProfesionalmente
            ..tiempoActividad = state.tiempoActividad
            ..tiempoCarrera = state.tiempoCarrera
            ..tieneTrabajo = state.tieneTrabajo
            ..tipoEstudioHijos = state.tipoEstudioHijos
            ..trabajoNegocioDescripcion = state.trabajoNegocioDescripcion
            ..universidad = state.universidad,
        );

    return NoVpnPopUpOnKiva(
      context: context,
      info: msgDialog,
      header: '',
      isVpnConnected: isVpnConnected,
    ).showDialog(context, dialogType: DialogType.info);
  }
}

class _EntornoSocialEstudioWidget extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController controller;
  const _EntornoSocialEstudioWidget({
    required this.controller,
    required this.isRecurrentForm,
  });

  @override
  State<_EntornoSocialEstudioWidget> createState() =>
      _EntornoSocialEstudioWidgetState();
}

class _EntornoSocialEstudioWidgetState
    extends State<_EntornoSocialEstudioWidget>
    with AutomaticKeepAliveClientMixin {
  String? itemSelected;
  String? tieneTrabajo;
  String? otrosIngresos;
  String? objOrigenCatalogoValorId;
  String? tipoEstudioHijos;
  final question1Controller = TextEditingController();
  final question2Controller = TextEditingController();
  final question3Controller = TextEditingController();
  final question4Controller = TextEditingController();
  final question5Controller = TextEditingController();
  final question6Controller = TextEditingController();
  final question7Controller = TextEditingController();
  final questio8Controller = TextEditingController();
  final trabajoNegocioDescripcion = TextEditingController();
  final tiempoActividad = TextEditingController();
  final otrosIngresosDescripcion = TextEditingController();
  final personasCargo = TextEditingController();
  final numeroHijos = TextEditingController();
  final edadHijos = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final solicitudesProvider =
          context.read<SolicitudesPendientesLocalDbCubit>();
      await solicitudesProvider.getDepartamentos();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();
    final items = localDbProvider.departmentsBox.getAll();
    final departmentos =
        items.map((e) => Item(name: e.nombre, value: e.valor)).toList();

    super.build(context);
    return switch (widget.isRecurrentForm) {
      true => _RecurrentForm(
          pageController: widget.controller,
        ),
      false => SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MiCreditoProgress(
                    steps: 5,
                    currentStep: 2,
                  ),
                  const Gap(20),
                  Text(
                    'forms.entorno_familiar.title'.tr(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Gap(10),
                  WhiteCard(
                    padding: const EdgeInsets.all(5),
                    child: JLuxDropdown(
                      isContainIcon: true,
                      validator: (value) {
                        if (value == null) return 'input.input_validator'.tr();

                        return null;
                      },
                      title: '¿Tiene algún trabajo o negocio? ¿Cuál?'.tr(),
                      items: ['input.yes'.tr(), 'input.no'.tr()],
                      onChanged: (item) {
                        if (item == null) return;
                        tieneTrabajo = item;
                        setState(() {});
                      },
                      toStringItem: (item) {
                        return item;
                      },
                      hintText: 'input.select_option'.tr(),
                    ),
                  ),
                  if (tieneTrabajo == 'input.yes'.tr())
                    CommentaryWidget(
                      title: 'Cual?',
                      textEditingController: trabajoNegocioDescripcion,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                    ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Tiempo de la actividad (MESES)'.tr(),
                    textEditingController: tiempoActividad,
                    textInputType: TextInputType.number,
                    validator: (value) {
                      final numero = int.tryParse(value);
                      if (numero == null || numero < 0 || numero >= 255) {
                        return 'Valor no valido'.tr();
                      }
                      return null;
                    },
                  ),
                  WhiteCard(
                    padding: const EdgeInsets.all(5),
                    child: JLuxDropdown(
                      isContainIcon: true,
                      validator: (value) {
                        if (value == null) return 'input.input_validator'.tr();

                        return null;
                      },
                      title: '¿Tiene otros ingresos?¿Cuales?*'.tr(),
                      items: ['input.yes'.tr(), 'input.no'.tr()],
                      onChanged: (item) {
                        if (item == null) return;
                        setState(() {
                          otrosIngresos = item;
                        });
                      },
                      toStringItem: (item) {
                        return item;
                      },
                      hintText: 'input.select_option'.tr(),
                    ),
                  ),
                  const Gap(20),
                  if (otrosIngresos == 'Si')
                    CommentaryWidget(
                      title: 'forms.entorno_familiar.question6'.tr(),
                      textEditingController: otrosIngresosDescripcion,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                    ),
                  WhiteCard(
                    marginTop: 15,
                    padding: const EdgeInsets.all(10),
                    child: JLuxDropdown(
                      isContainIcon: true,
                      // isLoading: state.status == Status.inProgress,
                      title: 'forms.entorno_familiar.person_origin'.tr(),
                      items: departmentos,
                      onChanged: (item) {
                        if (item == null) return;
                        objOrigenCatalogoValorId = item.value;
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                      toStringItem: (item) => item.name,
                      hintText: 'input.select_department'.tr(),
                    ),
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Número de personas a cargo:*'.tr(),
                    textEditingController: personasCargo,
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      final numero = int.tryParse(value);
                      if (numero == null || numero < 0 || numero >= 255) {
                        return 'Valor no valido'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Número de hijos:*'.tr(),
                    textEditingController: numeroHijos,
                    textInputType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      final numero = int.tryParse(value);
                      if (numero == null || numero < 0 || numero >= 255) {
                        return 'Valor no valido'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'forms.entorno_familiar.childs_age'.tr(),
                    textEditingController: edadHijos,
                  ),
                  WhiteCard(
                    padding: const EdgeInsets.all(5),
                    child: JLuxDropdown(
                      isContainIcon: true,
                      validator: (value) {
                        if (value == null) return 'input.input_validator'.tr();
                        return null;
                      },
                      title: '¿Qué tipo de estudios reciben sus hijos?'.tr(),
                      items: const [
                        'Ninguno',
                        'Preescolar',
                        'Primaria',
                        'Secundaria',
                        'Técnico',
                        'Universitario'
                      ],
                      onChanged: (item) {
                        if (item == null) return;
                        tipoEstudioHijos = item;
                        setState(() {});
                      },
                      toStringItem: (item) {
                        return item;
                      },
                      hintText: 'input.select_option'.tr(),
                    ),
                  ),
                  const Gap(20),
                  ButtonActionsWidget(
                    onPreviousPressed: () {
                      widget.controller.previousPage(
                        duration: const Duration(
                          milliseconds: 350,
                        ),
                        curve: Curves.easeIn,
                      );
                    },
                    onNextPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        context.read<MicrediEstudioCubit>().saveAnswers(
                              tipoSolicitud: context
                                  .read<KivaRouteCubit>()
                                  .state
                                  .tipoSolicitud,
                              tieneTrabajo: tieneTrabajo == 'input.yes'.tr(),
                              trabajoNegocioDescripcion:
                                  trabajoNegocioDescripcion.text.trim(),
                              tiempoActividad: int.tryParse(
                                tiempoActividad.text.trim(),
                              ),
                              otrosIngresos: otrosIngresos == 'input.yes'.tr(),
                              otrosIngresosDescripcion:
                                  otrosIngresosDescripcion.text.trim(),
                              objOrigenCatalogoValorId:
                                  objOrigenCatalogoValorId,
                              personasCargo:
                                  int.tryParse(personasCargo.text.trim()),
                              numeroHijos:
                                  int.tryParse(numeroHijos.text.trim()),
                              edadHijos: edadHijos.text.trim(),
                              tipoEstudioHijos: tipoEstudioHijos,
                            );
                        widget.controller.nextPage(
                          duration: const Duration(
                            milliseconds: 350,
                          ),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    previousTitle: 'button.previous'.tr(),
                    nextTitle: 'button.next'.tr(),
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ),
        ),
    };
  }

  @override
  bool get wantKeepAlive => true;
}

class _RecurrentForm extends StatefulWidget {
  final PageController pageController;
  const _RecurrentForm({required this.pageController});

  @override
  State<_RecurrentForm> createState() => _RecurrentFormState();
}

class _RecurrentFormState extends State<_RecurrentForm>
    with AutomaticKeepAliveClientMixin {
  String? tipoEstudioHijos;
  String? tieneTrabajo;
  String? otrosIngresos;
  final trabajoNegocioDescripcion = TextEditingController();
  final tiempoActividad = TextEditingController();
  final otrosIngresosDescripcion = TextEditingController();
  final personasCargo = TextEditingController();
  final numeroHijos = TextEditingController();
  final edadHijos = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MiCreditoProgress(
                steps: 3,
                currentStep: 2,
              ),
              const Gap(20),
              Text(
                'Descripción del entorno familiar'.tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(20),
              WhiteCard(
                padding: const EdgeInsets.all(5),
                child: JLuxDropdown(
                  isContainIcon: true,
                  validator: (value) {
                    if (value == null) return 'input.input_validator'.tr();

                    return null;
                  },
                  title: '¿Tiene algún trabajo o negocio? ¿Cuál?'.tr(),
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    tieneTrabajo = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              if (tieneTrabajo == 'input.yes'.tr())
                CommentaryWidget(
                  title: 'Cual?',
                  textEditingController: trabajoNegocioDescripcion,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'input.input_validator'.tr();
                    }
                    return null;
                  },
                ),
              const Gap(20),
              CommentaryWidget(
                title: 'Tiempo de la actividad (MESES)',
                textEditingController: tiempoActividad,
                textInputType: TextInputType.number,
              ),
              const Gap(20),
              WhiteCard(
                padding: const EdgeInsets.all(5),
                child: JLuxDropdown(
                  isContainIcon: true,
                  validator: (value) {
                    if (value == null) return 'input.input_validator'.tr();

                    return null;
                  },
                  title: '¿Tiene otros ingresos?'.tr(),
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    otrosIngresos = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              if (otrosIngresos == 'input.yes'.tr())
                CommentaryWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'input.input_validator'.tr();
                    }
                    return null;
                  },
                  title: '¿Cuáles?',
                  textEditingController: otrosIngresosDescripcion,
                ),
              CommentaryWidget(
                title: 'Número de personas a cargo:*',
                textEditingController: personasCargo,
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'Número de hijos:*',
                textEditingController: numeroHijos,
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(20),
              CommentaryWidget(
                title: '¿Que edades tienen sus hijos? ',
                textEditingController: edadHijos,
              ),
              const Gap(20),
              WhiteCard(
                padding: const EdgeInsets.all(5),
                child: JLuxDropdown(
                  isContainIcon: true,
                  validator: (value) {
                    if (value == null) return 'input.input_validator'.tr();
                    return null;
                  },
                  title: '¿Qué tipo de estudios reciben sus hijos?'.tr(),
                  items: const [
                    'Ninguno',
                    'Preescolar',
                    'Primaria',
                    'Secundaria',
                    'Técnico',
                    'Universitario'
                  ],
                  onChanged: (item) {
                    if (item == null) return;
                    tipoEstudioHijos = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
              ),
              const Gap(20),
              ButtonActionsWidget(
                onPreviousPressed: () {
                  widget.pageController.previousPage(
                    duration: const Duration(
                      milliseconds: 350,
                    ),
                    curve: Curves.easeIn,
                  );
                },
                onNextPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    context.read<RecurrenteMicrediEstudioCubit>().saveAnswers(
                          tipoSolicitud: context
                              .read<KivaRouteCubit>()
                              .state
                              .tipoSolicitud,
                          tieneTrabajo: tieneTrabajo == 'input.yes'.tr(),
                          trabajoNegocioDescripcion:
                              trabajoNegocioDescripcion.text.trim(),
                          tiempoActividad:
                              int.tryParse(tiempoActividad.text.trim()),
                          otrosIngresos: otrosIngresos == 'input.yes'.tr(),
                          otrosIngresosDescripcion:
                              otrosIngresosDescripcion.text.trim(),
                          personasCargo:
                              int.tryParse(personasCargo.text.trim()),
                          numeroHijos: int.tryParse(numeroHijos.text.trim()),
                          edadHijos: edadHijos.text.trim(),
                          tipoEstudioHijos: tipoEstudioHijos,
                        );
                    widget.pageController.nextPage(
                      duration: const Duration(
                        milliseconds: 350,
                      ),
                      curve: Curves.easeIn,
                    );
                  }
                },
                previousTitle: 'button.previous'.tr(),
                nextTitle: 'button.next'.tr(),
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ImpactoSocialCrediEstudioWidget extends StatefulWidget {
  final bool isRecurrentForm;
  final PageController controller;
  const _ImpactoSocialCrediEstudioWidget(
      {required this.controller, required this.isRecurrentForm});

  @override
  State<_ImpactoSocialCrediEstudioWidget> createState() =>
      _ImpactoSocialCrediEstudioWidgetState();
}

class _ImpactoSocialCrediEstudioWidgetState
    extends State<_ImpactoSocialCrediEstudioWidget>
    with AutomaticKeepAliveClientMixin {
  final question1Controller = TextEditingController();
  final question2Controller = TextEditingController();
  final question3Controller = TextEditingController();
  final question4Controller = TextEditingController();
  final question5Controller = TextEditingController();
  final question6Controller = TextEditingController();
  final cualEstudio = TextEditingController();
  String? optarOtroEstudio;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return switch (widget.isRecurrentForm) {
      true => _RecurrentFormImpactoSocial(
          pageController: widget.controller,
        ),
      false => SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MiCreditoProgress(
                    steps: 3,
                    currentStep: 2,
                  ),
                  const Gap(20),
                  Text(
                    'forms.mejora_de_vivienda.impacto_social.title'.tr(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: 'forms.miCredi_estudio.question1'.tr(),
                    textEditingController: question1Controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title:
                        '¿De qué manera este financiamiento le ayudará a crecer profesionalemente? Explique'
                            .tr(),
                    textEditingController: question2Controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  WhiteCard(
                    marginTop: 15,
                    padding: const EdgeInsets.all(10),
                    child: JLuxDropdown(
                      isContainIcon: true,
                      title: '¿Piensa optar a otro estudio superior?*'.tr(),
                      items: ['input.yes'.tr(), 'input.no'.tr()],
                      onChanged: (item) {
                        if (item == null) return;
                        optarOtroEstudio = item;
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                      toStringItem: (item) => item,
                      hintText: 'input.select_option'.tr(),
                    ),
                  ),
                  if (optarOtroEstudio == 'input.yes'.tr())
                    CommentaryWidget(
                      title: 'Porque?',
                      textEditingController: cualEstudio,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'input.input_validator'.tr();
                        }
                        return null;
                      },
                    ),
                  const Gap(10),
                  CommentaryWidget(
                    title:
                        '¿Cuáles son sus planes en los próximos 10 años?*'.tr(),
                    textEditingController: question4Controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: '¿Qué aspira laboralmente?*'.tr(),
                    textEditingController: question5Controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'input.input_validator'.tr();
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: 'Otros datos relevantes e interesantes del cliente'
                        .tr(),
                    textEditingController: question6Controller,
                  ),
                  const Gap(10),
                  ButtonActionsWidget(
                    onPreviousPressed: () {
                      widget.controller.previousPage(
                        duration: const Duration(
                          milliseconds: 350,
                        ),
                        curve: Curves.easeIn,
                      );
                    },
                    onNextPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        context.read<MicrediEstudioCubit>().saveAnswers(
                              motivoPrestamo: question1Controller.text.trim(),
                              comoAyudaCrecer: question2Controller.text.trim(),
                              optarOtroEstudio:
                                  optarOtroEstudio == 'input.yes'.tr(),
                              cualEstudio: cualEstudio.text.trim(),
                              planFuturo: question4Controller.text.trim(),
                              aspiraLaboralmente:
                                  question5Controller.text.trim(),
                              otrosDatosCliente:
                                  question6Controller.text.trim(),
                              objSolicitudNuevamenorId: int.parse(
                                context
                                    .read<KivaRouteCubit>()
                                    .state
                                    .solicitudId,
                              ),
                            );
                        context.read<ResponseCubit>().addResponses(
                          responses: [
                            Response(
                              index: widget.controller.page?.toInt() ?? 0,
                              question: 'forms.miCredi_estudio.question1'.tr(),
                              response: question1Controller.text.trim(),
                            ),
                            Response(
                              index: widget.controller.page?.toInt() ?? 0,
                              question:
                                  '¿De qué manera este financiamiento le ayudará a crecer profesionalemente? Explique'
                                      .tr(),
                              response: question2Controller.text.trim(),
                            ),
                            Response(
                              index: widget.controller.page?.toInt() ?? 0,
                              question:
                                  '¿Piensa optar a otro estudio superior?*'
                                      .tr(),
                              response: optarOtroEstudio ?? 'N/A',
                            ),
                            if (optarOtroEstudio == 'input.yes'.tr())
                              Response(
                                index: widget.controller.page?.toInt() ?? 0,
                                question: 'Porque?'.tr(),
                                response: cualEstudio.text.trim(),
                              ),
                            Response(
                              index: widget.controller.page?.toInt() ?? 0,
                              question:
                                  '¿Cuáles son sus planes en los próximos 10 años?*'
                                      .tr(),
                              response: question4Controller.text.trim(),
                            ),
                            Response(
                              index: widget.controller.page?.toInt() ?? 0,
                              question: '¿Qué aspira laboralmente?*'.tr(),
                              response: question5Controller.text.trim(),
                            ),
                            Response(
                              index: widget.controller.page?.toInt() ?? 0,
                              question:
                                  'Otros datos relevantes e interesantes del cliente'
                                      .tr(),
                              response: question6Controller.text.trim(),
                            ),
                          ],
                        );
                        widget.controller.nextPage(
                          duration: const Duration(
                            milliseconds: 350,
                          ),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    previousTitle: 'button.previous'.tr(),
                    nextTitle: 'button.next'.tr(),
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ),
        ),
    };
  }

  @override
  bool get wantKeepAlive => true;
}

class _RecurrentFormImpactoSocial extends StatefulWidget {
  final PageController pageController;
  const _RecurrentFormImpactoSocial({
    required this.pageController,
  });

  @override
  State<_RecurrentFormImpactoSocial> createState() =>
      _RecurrentFormImpactoSocialState();
}

class _RecurrentFormImpactoSocialState
    extends State<_RecurrentFormImpactoSocial>
    with AutomaticKeepAliveClientMixin {
  final motivoPrestamo = TextEditingController();
  final comoAyudaCrecer = TextEditingController();
  String? alcanzaraMeta;
  final explicacionAlcanzaraMeta = TextEditingController();
  final siguentePaso = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MiCreditoProgress(
                steps: 3,
                currentStep: 2,
              ),
              const Gap(20),
              Text(
                'Impacto Social de Kiva ( Uso específico, objetivos, metas del préstamo)'
                    .tr(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: motivoPrestamo,
                title:
                    '¿En qué piensa invertir este nuevo préstamo de MiCrediestudio?* Explique',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(20),
              CommentaryWidget(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
                textEditingController: comoAyudaCrecer,
                title:
                    '¿Cómo cree usted que este nuevo préstamo le ayude en su crecimiento profesional?*',
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: explicacionAlcanzaraMeta,
                title: 'Explica la meta?',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(20),
              CommentaryWidget(
                textEditingController: siguentePaso,
                title: '¿Cuál sería su siguiente paso?',
              ),
              ButtonActionsWidget(
                onPreviousPressed: () {
                  widget.pageController.previousPage(
                    duration: const Duration(
                      milliseconds: 350,
                    ),
                    curve: Curves.easeIn,
                  );
                },
                onNextPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    context.read<RecurrenteMicrediEstudioCubit>().saveAnswers(
                          motivoPrestamo: motivoPrestamo.text.trim(),
                          comoAyudaCrecer: comoAyudaCrecer.text.trim(),
                          explicacionAlcanzaraMeta:
                              explicacionAlcanzaraMeta.text.trim(),
                          siguientePaso: siguentePaso.text.trim(),
                          objSolicitudRecurrenteId: int.parse(
                            context.read<KivaRouteCubit>().state.solicitudId,
                          ),
                        );
                    context.read<ResponseCubit>().addResponses(
                      responses: [
                        Response(
                          index: 1,
                          question:
                              '¿En qué piensa invertir este nuevo préstamo de MiCrediestudio?* Explique',
                          response: motivoPrestamo.text.trim(),
                        ),
                        Response(
                          index: 1,
                          question:
                              '¿Cómo cree usted que este nuevo préstamo le ayude en su crecimiento profesional?*',
                          response: comoAyudaCrecer.text.trim(),
                        ),
                        Response(
                          index: 1,
                          question:
                              '¿Cree usted que una vez finalizado el pago de este préstamo de MiCréditoEstudio alcanzó su meta académica? ¿Por qué?',
                          response: alcanzaraMeta ?? 'N/A',
                        ),
                        if (alcanzaraMeta == 'input.yes'.tr())
                          Response(
                            index: 1,
                            question: 'Explica la meta?',
                            response: explicacionAlcanzaraMeta.text.trim(),
                          ),
                        Response(
                          index: 1,
                          question: '¿Cuál sería su siguiente paso?',
                          response: siguentePaso.text.trim(),
                        ),
                      ],
                    );
                    widget.pageController.nextPage(
                      duration: const Duration(
                        milliseconds: 350,
                      ),
                      curve: Curves.easeIn,
                    );
                  }
                },
                previousTitle: 'button.previous'.tr(),
                nextTitle: 'button.next'.tr(),
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

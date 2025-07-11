import 'dart:developer';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/energia_limpia_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/recurrente_energia_limpia_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/energia_limpia/energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/motivo_prestamo/motivo_prestamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/mejora_de_vivienda_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_image_sending/kiva_image_sending.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/energia_limpia_adtional_data_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/energia_limpia_credito_anterior.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/energia_limpia_entorno_familiar.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/energia_limpia_impacto_social.dart';
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

class EnergiaLimpiaScreen extends StatelessWidget {
  final String typeProduct;
  const EnergiaLimpiaScreen({super.key, required this.typeProduct});

  @override
  Widget build(BuildContext context) {
    final isRecurrentForm = typeProduct == 'ScrKivaEnergiaLimpiaRecurrente';
    final pageController = PageController();
    final responseRepository = ResponsesRepositoryImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ResponseCubit(),
        ),
        BlocProvider(
          create: (ctx) => UploadUserFileCubit(responseRepository),
        ),
        BlocProvider(
          create: (ctx) => MotivoPrestamoCubit(responseRepository)
            ..getMotivoPrestamo(
              numero: int.parse(
                context.read<KivaRouteCubit>().state.solicitudId,
              ),
            ),
        ),
        BlocProvider(
          create: (ctx) => EnergiaLimpiaCubit(responseRepository),
        ),
        BlocProvider(
          create: (ctx) => DepartamentosCubit(DepartamentosRepositoryImpl())
            ..getDepartamentos(),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteEnergiaLimpiaCubit(responseRepository),
        ),
      ],
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
                'Energia Limpia ${isRecurrentForm ? 'Recurrente' : 'Nuevo'}'),
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              SaneamientoContent(
                controller: pageController,
              ),
              EnergiaLimpiaAditionalDataWidget(
                pageController: pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              EnergiaLimpiaEntornoFamiliar(
                pageController: pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              if (isRecurrentForm)
                EnergiaLimpiaCreditoAnterior(
                  pageController: pageController,
                ),
              EnergiaLimpiaImpactoSocial(
                pageController: pageController,
                isRecurrentForm: isRecurrentForm,
              ),
              // if (isRecurrentForm)
              //   _FormResponses(
              //     controller: pageController,
              //   ),
              FormResponses(
                controller: pageController,
              ),

              isRecurrentForm
                  ? _RecurrentSignQuestionary(controller: pageController)
                  : _SignQuestionary(controller: pageController),
            ],
          ),
        ),
      ),
    );
  }
}

class EnergiaLimpiaUnavezFinalzado extends StatefulWidget {
  const EnergiaLimpiaUnavezFinalzado({
    super.key,
  });

  @override
  State<EnergiaLimpiaUnavezFinalzado> createState() =>
      _EnergiaLimpiaUnavezFinalzadoState();
}

class _EnergiaLimpiaUnavezFinalzadoState
    extends State<EnergiaLimpiaUnavezFinalzado> {
  bool onEditAnswer = false;
  String? newsiguienteMeta;
  @override
  Widget build(BuildContext context) {
    final energiaLimpiaProvider = context.watch<RecurrenteEnergiaLimpiaCubit>();

    return WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 250,
                ),
                child: Text(
                  'Una vez finalizado este préstamo ¿Cuál sería su siguiente meta?',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  onEditAnswer = !onEditAnswer;
                  setState(() {});
                },
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
          const Gap(20),
          Text(
            energiaLimpiaProvider.state.siguienteMeta,
            style: Theme.of(context).textTheme.bodyMedium!,
          ),
          if (onEditAnswer)
            Column(
              children: [
                WhiteCard(
                  padding: const EdgeInsets.all(5),
                  child: CommentaryWidget(
                    title: '',
                    onChange: (value) {
                      newsiguienteMeta = value;
                      setState(() {});
                    },
                    initialValue: energiaLimpiaProvider.state.siguienteMeta,
                  ),
                ),
                const Gap(20),
                CustomElevatedButton(
                  text: 'Guardar',
                  color: AppColors.getPrimaryColor(),
                  onPressed: () {
                    context.read<RecurrenteEnergiaLimpiaCubit>().saveAnswer3(
                          siguienteMeta: newsiguienteMeta,
                        );
                    onEditAnswer = !onEditAnswer;
                    setState(() {});
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class EnergiaLimpiaOrigen extends StatefulWidget {
  const EnergiaLimpiaOrigen({
    super.key,
  });

  @override
  State<EnergiaLimpiaOrigen> createState() => _EnergiaLimpiaOrigenState();
}

class _EnergiaLimpiaOrigenState extends State<EnergiaLimpiaOrigen> {
  bool onEditAnswer = false;
  String? originItem;
  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();
    final items = localDbProvider.departmentsBox.getAll();
    final departmentos =
        items.map((e) => Item(name: e.nombre, value: e.valor)).toList();
    final energiaLimpiaProvider =
        context.watch<RecurrenteEnergiaLimpiaCubit>().state;
    return WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 250,
                ),
                child: Text(
                  '¿De dónde es originario?*',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  onEditAnswer = !onEditAnswer;
                  setState(() {});
                },
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
          const Gap(20),
          Text(
            energiaLimpiaProvider.objTipoComunidadId,
            style: Theme.of(context).textTheme.bodyMedium!,
          ),
          if (onEditAnswer)
            Column(
              children: [
                WhiteCard(
                  marginTop: 15,
                  padding: const EdgeInsets.all(10),
                  child: JLuxDropdown(
                    isContainIcon: false,
                    // isLoading: state.status == Status.inProgress,
                    title: 'forms.entorno_familiar.person_origin'.tr(),
                    items: departmentos,
                    onChanged: (item) {
                      if (item == null) return;
                      originItem = item.value;
                      setState(() {});
                    },
                    toStringItem: (item) => item.name,
                    hintText: 'input.select_department'.tr(),
                  ),
                ),
                const Gap(20),
                CustomElevatedButton(
                  text: 'Guardar',
                  color: AppColors.getPrimaryColor(),
                  onPressed: () {
                    context.read<RecurrenteEnergiaLimpiaCubit>().saveAnswer2(
                          objTipoComunidadId: originItem,
                        );
                    onEditAnswer = !onEditAnswer;
                    setState(() {});
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _RecurrentSignQuestionary extends StatefulWidget {
  final PageController controller;
  const _RecurrentSignQuestionary({required this.controller});

  @override
  State<_RecurrentSignQuestionary> createState() =>
      _RecurrentSignQuestionaryState();
}

class _RecurrentSignQuestionaryState extends State<_RecurrentSignQuestionary> {
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
    final isConnected = context.watch<InternetConnectionCubit>().state;
    return Column(
      children: [
        const MiCreditoProgress(
          steps: 5,
          currentStep: 5,
        ),
        const Gap(10),
        JLuxDropdown(
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
        if (typeSigner != TypeSigner.ninguno) ...[
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
                  BlocConsumer<RecurrenteEnergiaLimpiaCubit,
                      RecurrenteEnergiaLimpiaState>(
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
                        context
                            .read<SolicitudesPendientesLocalDbCubit>()
                            .updateIsSendedOnSolicitud(
                              solicitudId: context
                                  .read<KivaRouteCubit>()
                                  .state
                                  .solicitudId,
                            );
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
                          onPressedAccept: () async {
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
                    },
                    builder: (ctx, state) {
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

                              await saveEnergiaLimpiaAnswers(
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
                                    .read<RecurrenteEnergiaLimpiaCubit>()
                                    .sendAnswers();
                              }
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
      ],
    );
  }

  saveEnergiaLimpiaAnswers(
    BuildContext ctx,
    RecurrenteEnergiaLimpiaState state,
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
        .saveRecurrenteEnergiaLimpia(
          recurrenteEnergiaLimpiaDBLocal: RecurrenteEnergiaLimpiaDbLocal()
            ..coincideRespuesta = state.coincideRespuesta
            ..tipoSolicitud = state.tipoSolicitud
            ..comoMejoraSituacion = state.comoMejoraSituacion
            ..database = LocalStorage().database
            ..edadHijos = state.edadHijos
            ..explicacionInversion = state.explicacionInversion
            ..motivoPrestamo = state.motivoPrestamo
            ..numeroHijos = state.numeroHijos
            ..objSolicitudRecurrenteId = state.objSolicitudRecurrenteId
            ..objTipoComunidadId = state.objTipoComunidadId
            ..otrosIngresos = state.otrosIngresos
            ..otrosIngresosDescripcion = state.otrosIngresosDescripcion
            ..personasCargo = state.personasCargo
            ..quienApoya = state.quienApoya
            ..siguienteMeta = state.siguienteMeta
            ..situacionAntesAhora = state.situacionAntesAhora
            ..tiempoActividad = state.tiempoActividad
            ..tieneProblemasEnergia = state.tieneProblemasEnergia
            ..tieneTrabajo = state.tieneTrabajo
            ..tipoEstudioHijos = state.tipoEstudioHijos
            ..problemasEnergiaDescripcion = state.problemasEnergiaDescripcion
            ..trabajoNegocioDescripcion = state.trabajoNegocioDescripcion,
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

class _SignQuestionary extends StatefulWidget {
  final PageController controller;
  const _SignQuestionary({required this.controller});

  @override
  State<_SignQuestionary> createState() => _SignQuestionaryState();
}

class _SignQuestionaryState extends State<_SignQuestionary> {
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
    final isConnected = context.watch<InternetConnectionCubit>().state;
    return Column(
      children: [
        const MiCreditoProgress(
          steps: 5,
          currentStep: 5,
        ),
        const Gap(13),
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
                  // const SizedBox(height: 20),
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
                  BlocConsumer<EnergiaLimpiaCubit, EnergiaLimpiaState>(
                    listener: (context, state) async {
                      final status = state.status;
                      final signatureImage = await controller.toPngBytes();
                      final directory =
                          await getApplicationDocumentsDirectory();
                      final filePath = '${directory.path}/signature.png';

                      // Guarda la imagen en el archivo
                      if (signatureImage != null) {
                        // Guarda la imagen directamente en el directorio
                        final file = File(filePath);
                        await file.writeAsBytes(signatureImage);
                        log('Firma guardada en: $filePath');
                      } else {
                        log('No se pudo generar la imagen de la firma.');
                        return;
                      }
                      if (!context.mounted) return;
                      if (status == Status.error) {
                        CustomAlertDialog(
                          context: context,
                          title: state.errorMsg,
                          onDone: () => context.pop(),
                        ).showDialog(context, dialogType: DialogType.error);
                      }
                      if (state.status == Status.done) {
                        await customPopUp(
                          context: context,
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
                                            fotoFirma: filePath,
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

                              await saveEnergiaLocalDB(
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
                                    .read<EnergiaLimpiaCubit>()
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

  saveEnergiaLocalDB(
    BuildContext ctx,
    EnergiaLimpiaState state,
    ImageModel imageModel,
    String msgDialog,
  ) {
    final isConnected =
        context.read<InternetConnectionCubit>().state.isConnected;
    ctx.read<SolicitudesPendientesLocalDbCubit>().saveImagesLocal(
          imageModel: imageModel,
        );

    ctx.read<SolicitudesPendientesLocalDbCubit>().saveEnergiaLimpia(
          energiaLimpiaDBLocal: EnergiaLimpiaDbLocal()
            ..database = LocalStorage().database
            ..tipoSolicitud = state.tipoSolicitud
            ..edadHijos = state.edadHijos
            ..motivoPrestamo = state.motivoPrestamo
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
            ..tieneProblemasEnergia = state.tieneProblemasEnergia
            ..tieneTrabajo = state.tieneTrabajo
            ..tipoEstudioHijos = state.tipoEstudioHijos
            ..problemasEnergiaDescripcion = state.problemasEnergiaDescripcion
            ..trabajoNegocioDescripcion = state.trabajoNegocioDescripcion,
        );
    if (!isConnected) {
      return NoVpnPopUpOnKiva(
        context: context,
        info: msgDialog,
        header: '',
      ).showDialog(context, dialogType: DialogType.info);
    }
    // context.pushReplacement('/');
  }
}

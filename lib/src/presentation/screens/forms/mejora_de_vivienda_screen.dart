import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/mejora_vivienda/recurrente_mejora_vivienda_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:core_financiero_app/src/domain/repository/comunidad/comunidad_repository.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/comunidades/comunidades_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/mejora_vivienda/mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/motivo_prestamo/motivo_prestamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_,mejora_vivienda.dart/recurrente_mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/impacto_social_kiva_objetivo.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mejora_vivienda/mejora_vivienda_credito_descrip.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/mejora_vivienda/mejora_vivienda_entorno_social.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/icon_border.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/custom_pop_up.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class MejoraDeViviendaScreen extends StatefulWidget {
  final String typeProducto;
  const MejoraDeViviendaScreen({super.key, required this.typeProducto});

  @override
  State<MejoraDeViviendaScreen> createState() => _MejoraDeViviendaScreenState();
}

class _MejoraDeViviendaScreenState extends State<MejoraDeViviendaScreen> {
  bool? isRecurrentForm;
  @override
  void initState() {
    super.initState();
    isRecurrentForm = widget.typeProducto == 'VIVIENDA REPRESTAMO';
    log(isRecurrentForm.toString());
  }

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => UploadUserFileCubit(ResponsesRepositoryImpl()),
        ),
        BlocProvider(
          create: (ctx) => MejoraViviendaCubit(ResponsesRepositoryImpl()),
        ),
        BlocProvider(
          create: (ctx) => ResponseCubit(),
        ),
        BlocProvider(
          create: (ctx) => DepartamentosCubit(DepartamentosRepositoryImpl())
            ..getDepartamentos(),
        ),
        BlocProvider(
            create: (ctx) =>
                RecurrenteMejoraViviendaCubit(ResponsesRepositoryImpl())),
        BlocProvider(
          create: (ctx) =>
              ComunidadesCubit(ComunidadRepositoryImpl())..getComunidades(),
        ),
        BlocProvider(
          create: (ctx) => MotivoPrestamoCubit(ResponsesRepositoryImpl())
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
                '${'forms.mejora_de_vivienda.title'.tr()} ${isRecurrentForm! ? 'Recurrente' : 'Nuevo'}'),
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              SaneamientoContent(
                controller: pageController,
              ),
              // EntornoSocialWidget(
              //   controller: pageController,
              //   isRecurrentForm: isRecurrentForm,
              // ),
              MejoraViviendaEntornoSocial(
                pageController: pageController,
                isRecurrentForm: isRecurrentForm ?? false,
              ),
              if (isRecurrentForm ?? false)
                MejoraViviendaCreditoDescrip(
                  isRecurrentForm: isRecurrentForm ?? false,
                  pageController: pageController,
                ),
              ImpactoSocialKivaObjetiveWidget(
                isRecurrentForm: isRecurrentForm ?? false,
                controller: pageController,
              ),
              // MetasYAspiracionesWidget(
              //   controller: pageController,
              // ),
              FormResponses(
                controller: pageController,
              ),
              isRecurrentForm ?? false
                  ? const RecurrentSign()
                  : const SignQuestionaryWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class RecurrentSign extends StatelessWidget {
  const RecurrentSign({super.key});

  @override
  Widget build(BuildContext context) {
    final imageProvider = context.watch<UploadUserFileCubit>().state;
    final size = MediaQuery.sizeOf(context);
    final controller = SignatureController();
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
                BlocConsumer<RecurrenteMejoraViviendaCubit,
                    RecurrenteMejoraViviendaState>(
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
                      // context.pushReplacement('/');
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
                        context
                            .read<RecurrenteMejoraViviendaCubit>()
                            .saveAnswers3(
                              objSolicitudRecurrenteId: int.tryParse(
                                context
                                    .read<KivaRouteCubit>()
                                    .state
                                    .solicitudId,
                              ),
                            );
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
                            !isConnected
                                ? saveRecurrentForm(
                                    context,
                                    state,
                                    ImageModel()
                                      ..imagenFirma = localPath
                                      ..imagen1 = imageProvider.imagen1
                                      ..imagen2 = imageProvider.imagen2
                                      ..imagen3 = imageProvider.imagen3
                                      ..solicitudId = int.tryParse(
                                        context
                                            .read<KivaRouteCubit>()
                                            .state
                                            .solicitudId,
                                      )
                                      ..imagen4 = imageProvider.fotoCedula)
                                : context
                                    .read<RecurrenteMejoraViviendaCubit>()
                                    .sendAnswers();
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

  void saveRecurrentForm(BuildContext context,
      RecurrenteMejoraViviendaState state, ImageModel imageModel) {
    context.read<SolicitudesPendientesLocalDbCubit>().saveImagesLocal(
          imageModel: imageModel,
        );
    context
        .read<SolicitudesPendientesLocalDbCubit>()
        .saveRecurrenteMejoraViviendaForm(
          recurrenteMejoraViviendaDBLocal: RecurrenteMejoraViviendaDbLocal()
            ..tipoSolicitud = state.tipoSolicitud
            ..coincideRespuesta = state.coincideRespuesta
            ..database = LocalStorage().database
            ..edadHijos = state.edadHijos
            ..explicacionInversion = state.explicacionInversion
            ..mejoraSeguridadFamilia = state.mejoraSeguridadFamilia
            ..motivoPrestamo = state.motivoPrestamo
            ..necesidadesComunidad = state.necesidadesComunidad
            ..numeroHijos = state.numeroHijos
            ..objSolicitudRecurrenteId = state.objSolicitudRecurrenteId
            ..objTipoComunidadId = state.objTipoComunidadId
            ..otrosIngresos = state.otrosIngresos
            ..otrosIngresosDescripcion = state.otrosIngresosDescripcion
            ..personasCargo = state.personasCargo
            ..quienApoya = state.quienApoya
            ..siguienteMeta = state.siguienteMeta
            ..tiempoActividad = state.tiempoActividad
            ..tieneTrabajo = state.tieneTrabajo
            ..tipoEstudioHijos = state.tipoEstudioHijos
            ..trabajoNegocioDescripcion = state.trabajoNegocioDescripcion
            ..viviendaAntesDespues = state.viviendaAntesDespues,
        );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        content: Text('Formulario Kiva Guardado Exitosamente'),
      ),
    );
    context.pushReplacement('/');
  }
}

class FormResponses extends StatefulWidget {
  final PageController controller;
  const FormResponses({
    super.key,
    required this.controller,
  });

  @override
  State<FormResponses> createState() => _FormResponsesState();
}

class _FormResponsesState extends State<FormResponses> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              'input.form_response'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(15),
            BlocBuilder<ResponseCubit, ResponseState>(
              builder: (context, state) {
                return ListView.separated(
                  itemCount: state.responses.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return const Gap(20);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return _ResponseWidget(
                      response: state.responses[index],
                      controller: widget.controller,
                    );
                  },
                );
              },
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
                widget.controller.nextPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              previousTitle: 'button.previous'.tr(),
              nextTitle: 'button.signed'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResponseWidget extends StatefulWidget {
  final PageController controller;
  final Response response;
  const _ResponseWidget({required this.response, required this.controller});

  @override
  State<_ResponseWidget> createState() => _ResponseWidgetState();
}

class _ResponseWidgetState extends State<_ResponseWidget> {
  bool onEditAnswer = false;
  final answerController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? responseEditedAnswer;

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      child: Form(
        key: formKey,
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
                    widget.response.question,
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
                    // onEditAnswer = !onEditAnswer;
                    widget.controller.animateToPage(
                      widget.response.index,
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeIn,
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: AppColors.getPrimaryColor(),
                  ),
                ),
              ],
            ),
            const Gap(20),
            Text(
              widget.response.response,
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
            if (onEditAnswer)
              CommentaryWidget(
                marginTop: 2,
                initialValue: widget.response.response,
                title: '',
                // textEditingController: answerController,
                onChange: (value) {
                  responseEditedAnswer = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
            if (onEditAnswer)
              CustomElevatedButton(
                text: 'Guardar',
                color: AppColors.getPrimaryColor(),
                onPressed: () {
                  context.read<ResponseCubit>().addResponses(
                    responses: [
                      Response(
                        question: widget.response.question,
                        response: responseEditedAnswer!,
                        index: 1,
                      ),
                    ],
                  );
                  onEditAnswer = !onEditAnswer;
                  setState(() {});
                },
              ),
          ],
        ),
      ),
    );
  }
}

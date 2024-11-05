import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/domain/repository/comunidad/comunidad_repository.dart';
import 'package:core_financiero_app/src/domain/repository/departamentos/departamentos_repository.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/comunidades/comunidades_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/departamentos/departamentos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/energia_limpia/energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/motivo_prestamo/motivo_prestamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/response_cubit/response_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/mejora_de_vivienda_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/energia_limpia_adtional_data_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/energia_limpia_credito_anterior.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/energia_limpia_entorno_familiar.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/energia_limpia_impacto_social.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/responses/energia_limpia_coincide_respuesta.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/responses/energia_limpia_comunidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/responses/energia_limpia_explicacion_invertido.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/responses/energia_limpia_motivo_invertir.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/responses/energia_limpia_nuevo_prestamo.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/responses/energia_limpia_numero_personas.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/responses/energia_limpia_otros_ingresos.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/responses/energia_limpia_otros_ingresos_description.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/responses/energia_limpia_quien_apoya.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/responses/energia_limpia_situacion_antes_y_ahora.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/responses/energia_limpia_tiempo_actividades_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/responses/energia_limpia_tiene_problema_energia.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/responses/energia_limpia_tipo_estudio.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/responses/energia_tiene_trabajo_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/questionaries/energia_limpia/responses/energia_trabajo_descripcion_cual_widget.dart';
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
    final isRecurrentForm = typeProduct == 'ASER RECURRENTE';
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
            ..getMotivoPrestamo(numero: 1071),
        ),
        BlocProvider(
          create: (ctx) => EnergiaLimpiaCubit(responseRepository),
        ),
        BlocProvider(
          create: (ctx) => DepartamentosCubit(DepartamentosRepositoryImpl())
            ..getDepartamentos(),
        ),
        BlocProvider(
          create: (ctx) =>
              ComunidadesCubit(ComunidadRepositoryImpl())..getComunidades(),
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
                  ? const _RecurrentSignQuestionary()
                  : const _SignQuestionary(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormResponses extends StatelessWidget {
  final PageController controller;
  const _FormResponses({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'input.form_response'.tr(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const Gap(10),
            const EnergiaTieneTrabajoWidget(),
            const Gap(10),
            const EnergiaTrabajoDescripcionCualWidget(),
            const Gap(10),
            const EnergiaLimpiaTiempoDeActividadWidget(),
            const Gap(10),
            const EnergiaLimpiaOtrosIngresos(),
            const Gap(10),
            const EnergiaLimpiaOtrosIngresosDescription(),
            const Gap(10),
            // const EnergiaLimpiaOrigen(),
            const Gap(10),
            const EnergiaLimpiaComunidad(),
            const Gap(10),
            const EnergiaLimpiaTieneProblemaEnergia(),
            const Gap(10),
            const EnergiaLimpiaNumeroPersonas(),
            const Gap(10),
            const EnergiaLimpiaTipoEstudio(),
            const Gap(10),
            const EnergiaLimpiaCoincideRespuesta(),
            const Gap(10),
            const EnergiaLimpiaExplicacionInverido(),
            const Gap(10),
            const EnergiaLimpiaSituacionAntesyAhora(),
            const Gap(10),
            const EnergiaLimpiaMotivoInvertir(),
            const Gap(10),
            const EnergiaLimpiaNuevoPrestamo(),
            const Gap(10),
            const EnergiaLimpiaQuienApoyan(),
            const Gap(10),
            const EnergiaLimpiaUnavezFinalzado(),
            const Gap(20),
            ButtonActionsWidget(
              onPreviousPressed: () {
                controller.previousPage(
                  duration: const Duration(
                    milliseconds: 350,
                  ),
                  curve: Curves.easeIn,
                );
              },
              onNextPressed: () {
                controller.nextPage(
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
                BlocBuilder<DepartamentosCubit, DepartamentosState>(
                  builder: (context, state) {
                    return WhiteCard(
                      marginTop: 15,
                      padding: const EdgeInsets.all(10),
                      child: JLuxDropdown(
                        isContainIcon: false,
                        isLoading: state.status == Status.inProgress,
                        title: 'forms.entorno_familiar.person_origin'.tr(),
                        items: state.departamentos,
                        onChanged: (item) {
                          if (item == null) return;
                          originItem = item.valor;
                          setState(() {});
                        },
                        toStringItem: (item) => item.nombre,
                        hintText: 'input.select_department'.tr(),
                      ),
                    );
                  },
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

class _RecurrentSignQuestionary extends StatelessWidget {
  const _RecurrentSignQuestionary();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final controller = SignatureController();
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
                BlocConsumer<RecurrenteEnergiaLimpiaCubit,
                    RecurrenteEnergiaLimpiaState>(
                  listener: (context, state) async {
                    final status = state.status;
                    if (status == Status.error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          showCloseIcon: true,
                          content: Text('Error inesperado'),
                        ),
                      );
                    }
                    if (state.status == Status.done) {
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
                            context.read<UploadUserFileCubit>().uploadUserFiles(
                                  fotoFirma: file,
                                  solicitudId: int.parse(
                                    context
                                        .read<KivaRouteCubit>()
                                        .state
                                        .solicitudId,
                                  ),
                                );
                            context
                                .read<RecurrenteEnergiaLimpiaCubit>()
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
}

class _SignQuestionary extends StatelessWidget {
  const _SignQuestionary();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final controller = SignatureController();
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
                BlocConsumer<EnergiaLimpiaCubit, EnergiaLimpiaState>(
                  listener: (context, state) async {
                    final status = state.status;
                    if (status == Status.error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          showCloseIcon: true,
                          content: Text('Error inesperado'),
                        ),
                      );
                    }
                    if (state.status == Status.done) {
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
                          onPressedAccept: () {
                            context.read<UploadUserFileCubit>().uploadUserFiles(
                                  fotoFirma: file,
                                  solicitudId: int.parse(
                                    context
                                        .read<KivaRouteCubit>()
                                        .state
                                        .solicitudId,
                                  ),
                                );
                            context.read<EnergiaLimpiaCubit>().sendAnswers();
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

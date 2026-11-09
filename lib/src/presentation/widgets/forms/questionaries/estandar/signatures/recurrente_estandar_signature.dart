import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_estandar/recurrente_estandart_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_image_sending/kiva_image_sending.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/no_internet_popup_onkiva.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_firma_widgets.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_form_widgets.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/custom_pop_up.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

import '../../../../../../datasource/local_db/forms/estandar/recurrente_estandar_db_local.dart';
import '../../../../../../datasource/local_db/image_model.dart';
import '../../../../../bloc/internet_connection/internet_connection_cubit.dart';
import '../../../../../bloc/kiva/kiva_route/kiva_route_cubit.dart';
import '../../../../../bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import '../../../../../bloc/upload_user_file/upload_user_file_cubit.dart';

class RecurrentEstandarSignature extends StatefulWidget {
  final PageController controller;
  const RecurrentEstandarSignature({super.key, required this.controller});

  @override
  State<RecurrentEstandarSignature> createState() =>
      _RecurrentEstandarSignatureState();
}

class _RecurrentEstandarSignatureState
    extends State<RecurrentEstandarSignature> {
  TypeSigner typeSigner = TypeSigner.ninguno;
  late final SignatureController _signatureController;

  @override
  void initState() {
    super.initState();
    _signatureController = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
    );
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isConnected = context.read<InternetConnectionCubit>().state;
    final imageProvider = context.watch<UploadUserFileCubit>().state;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDropdownSelector(),
          if (typeSigner != TypeSigner.ninguno) ...[
            const Gap(20),
            KivaFirmaEncabezado(
              firmaCliente: typeSigner == TypeSigner.cliente,
            ),
            const Gap(12),
            KivaFirmaLienzo(controller: _signatureController),
            const Gap(16),
            _ActionButtons(
              signatureController: _signatureController,
              pageController: widget.controller,
              typeSigner: typeSigner,
              size: size,
              isConnected: isConnected,
              imageProvider: imageProvider,
              onSaveOffline: _saveOfflineResponses,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDropdownSelector() {
    return KivaPreguntaCard(
      child: KivaDropdown(
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
    );
  }

  Future<void> _saveOfflineResponses(
    BuildContext context,
    RecurrenteEstandartState state,
    ImageModel imageModel,
    String msgDialog,
  ) async {
    final statusConnection =
        context.read<InternetConnectionCubit>().state.connectionStatus;

    context.read<SolicitudesPendientesLocalDbCubit>().saveImagesLocal(
          imageModel: imageModel,
        );

    final routeState = context.read<KivaRouteCubit>().state;

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
            ..objSolicitudRecurrenteId = int.tryParse(routeState.solicitudId)
            ..otrosIngresos = state.otrosIngresos
            ..otrosIngresosDescripcion = state.otrosIngresosDescripcion
            ..personaAutoSuficiente = state.personaAutoSuficiente
            ..tipoEstudioHijos = state.tipoEstudioHijos
            ..siguientePaso = state.siguientePaso
            ..solicitudCreditoId = routeState.solicitudCreditoId
            ..personasCargo = state.personasCargo,
        );
    final isOffline = statusConnection == ConnectionStatus.disconnected ||
        statusConnection == ConnectionStatus.handleOfflineActivation;

    if (isOffline) {
      if (!context.mounted) return;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;

        NoInternetPopUpOnKiva(
          context: context,
          header: '',
        ).showDialog(context, dialogType: DialogType.info);
      });
    }
  }
}

class _ActionButtons extends StatelessWidget {
  final SignatureController signatureController;
  final PageController pageController;
  final TypeSigner typeSigner;
  final Size size;
  final InternetConnectionState isConnected;
  final UploadUserFileState imageProvider;
  final Future<void> Function(
      BuildContext, RecurrenteEstandartState, ImageModel, String) onSaveOffline;

  const _ActionButtons({
    required this.signatureController,
    required this.pageController,
    required this.typeSigner,
    required this.size,
    required this.isConnected,
    required this.imageProvider,
    required this.onSaveOffline,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecurrenteEstandartCubit, RecurrenteEstandartState>(
      listener: (context, state) => _handleNavigationAndSave(context, state),
      builder: (context, state) {
        return KivaFirmaAcciones(
          enviando: state.status == Status.inProgress,
          onEnviar: () => _showConfirmationDialog(context, state),
          onRegresar: () => pageController.previousPage(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeIn,
          ),
        );
      },
    );
  }

  Future<void> _handleNavigationAndSave(
      BuildContext context, RecurrenteEstandartState state) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/signature.png');
    final signatureImage = await signatureController.toPngBytes();

    if (signatureImage != null) {
      await file.writeAsBytes(signatureImage);
    }

    if (!context.mounted) return;

    if (state.status == Status.error) {
      CustomAlertDialog(
        context: context,
        title: state.erroMsg,
        onDone: () => context.pop(),
      ).showDialog(context, dialogType: DialogType.error);
    }

    if (state.status == Status.done && isConnected.isConnected) {
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
          if (!context.mounted) return;
          final routeState = context.read<KivaRouteCubit>().state;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => BlocProvider.value(
                value: context.read<UploadUserFileCubit>(),
                child: KivaImageSending(
                  solicitudId: routeState.solicitudId,
                  onRetry: () {
                    context.read<UploadUserFileCubit>().uploadUserFiles(
                          typeSigner: typeSigner,
                          cedula: routeState.cedula,
                          numero: routeState.numero,
                          tipoSolicitud: routeState.tipoSolicitud,
                          fotoFirma: file.path,
                          solicitudId: int.parse(routeState.solicitudId),
                          formularioKiva: routeState.nombreFormularioKiva,
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

  Future<void> _showConfirmationDialog(
    BuildContext context,
    RecurrenteEstandartState state,
  ) async {
    await customPopUp(
      context: context,
      size: size,
      title: 'Confirmas que has leido y confirmado el Formulario Kiva?',
      dialogType: DialogType.warning,
      buttonAcept: true,
      buttonCancel: true,
      colorButtonCancel: AppColors.red,
      textButtonAcept: 'Aceptar',
      textButtonCancel: 'Cancelar',
      colorButtonAcept: AppColors.getPrimaryColor(),
      onPressedAccept: () async {
        if (!context.mounted) return;
        final routeState = context.read<KivaRouteCubit>().state;

        context
            .read<SolicitudesPendientesLocalDbCubit>()
            .updateIsSendedOnSolicitud(
              solicitudId: routeState.solicitudId,
            );

        final localPath = await KivaFile.saveImageSignature(
          controller: signatureController,
          numeroSoicitud: routeState.numero,
        );

        if (!context.mounted) return;

        await onSaveOffline(
          context,
          state,
          ImageModel()
            ..typeSigner = typeSigner.name
            ..imagenFirma = localPath
            ..imagen1 = imageProvider.imagen1
            ..imagen2 = imageProvider.imagen2
            ..imagen3 = imageProvider.imagen3
            ..solicitudUuid = routeState.solicitudCreditoId
            ..solicitudId = int.parse(routeState.solicitudId),
          '',
        );

        if (!context.mounted) return;
        if (isConnected.isConnected) {
          context.read<RecurrenteEstandartCubit>().sendAnswers();
        }
        context.pop();
      },
      onPressedCancel: () => context.pop(),
    );
  }
}

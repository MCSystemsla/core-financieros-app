import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/mujer_emprende/recurrente_mujer_emprende_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_image_sending/kiva_image_sending.dart';
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

import '../../../../../bloc/internet_connection/internet_connection_cubit.dart';
import '../../../../../bloc/kiva/kiva_route/kiva_route_cubit.dart';
import '../../../../../bloc/kiva/recurrente_mujer_emprende/recurrente_mujer_emprende_cubit.dart';
import '../../../../../bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import '../../../../../bloc/upload_user_file/upload_user_file_cubit.dart';

class RecurrenteMujerEmprendeSignatureWidget extends StatefulWidget {
  final PageController controller;

  const RecurrenteMujerEmprendeSignatureWidget({
    super.key,
    required this.controller,
  });

  @override
  State<RecurrenteMujerEmprendeSignatureWidget> createState() =>
      _RecurrenteMujerEmprendeSignatureWidgetState();
}

class _RecurrenteMujerEmprendeSignatureWidgetState
    extends State<RecurrenteMujerEmprendeSignatureWidget> {
  TypeSigner _typeSigner = TypeSigner.ninguno;
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

  void _onSignerTypeChanged(String? item) {
    if (item == null) return;
    setState(() {
      _typeSigner =
          item == 'input.yes'.tr() ? TypeSigner.cliente : TypeSigner.asesor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      children: [
        const MiCreditoProgress(steps: 5, currentStep: 5),
        Padding(
          padding: const EdgeInsets.all(12),
          child: JLuxDropdown(
            dropdownColor: AppColors.white,
            title: 'Tiene capacidad el usuario para firma?',
            items: ['input.yes'.tr(), 'input.no'.tr()],
            onChanged: _onSignerTypeChanged,
            toStringItem: (item) => item,
            hintText: 'input.select_option'.tr(),
          ),
        ),
        if (_typeSigner != TypeSigner.ninguno)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _SignatureHeader(typeSigner: _typeSigner),
                  const Gap(20),
                  Expanded(
                    child: _SignaturePad(
                      controller: _signatureController,
                      width: size.width * .9,
                    ),
                  ),
                  const Gap(30),
                  _SignatureActionButtons(
                    signatureController: _signatureController,
                    typeSigner: _typeSigner,
                    pageController: widget.controller,
                    size: size,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _SignatureHeader extends StatelessWidget {
  final TypeSigner typeSigner;

  const _SignatureHeader({required this.typeSigner});

  @override
  Widget build(BuildContext context) {
    final title = typeSigner == TypeSigner.cliente
        ? 'forms.firmar.title'.tr()
        : 'Firma de Representante de Micrédito';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(10),
        Text(
          'forms.firmar.description'.tr(),
          style: TextStyle(color: AppColors.greyWithOpacityV4),
        ),
      ],
    );
  }
}

class _SignaturePad extends StatelessWidget {
  final SignatureController controller;
  final double width;

  const _SignaturePad({
    required this.controller,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              width: width,
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
    );
  }
}

class _SignatureActionButtons extends StatelessWidget {
  final SignatureController signatureController;
  final TypeSigner typeSigner;
  final PageController pageController;
  final Size size;

  const _SignatureActionButtons({
    required this.signatureController,
    required this.typeSigner,
    required this.pageController,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final kivaRoute = context.read<KivaRouteCubit>().state;
    final uploadCubit = context.read<UploadUserFileCubit>();
    final pendingDbCubit = context.read<SolicitudesPendientesLocalDbCubit>();
    final mujerEmprendeCubit = context.read<RecurrenteMujerEmprendeCubit>();

    return BlocConsumer<RecurrenteMujerEmprendeCubit,
        RecurrenteMujerEmprendeState>(
      listener: (context, state) async {
        if (state.status == Status.error) {
          _showErrorDialog(context, state.errorMsg);
        }
        if (state.status == Status.done) {
          await _handleSuccessSubmission(context, kivaRoute, uploadCubit);
        }
      },
      builder: (context, state) {
        final isInProgress = state.status == Status.inProgress;

        return Column(
          children: [
            CustomElevatedButton(
              icon: const Icon(Icons.edit, color: AppColors.white),
              enabled: !isInProgress,
              positionIcon: PositionIcon.left,
              text: isInProgress ? 'Cargando...' : 'button.send'.tr(),
              color: context.primaryColor(),
              onPressed: () => _showConfirmationPopUp(
                context,
                state,
                kivaRoute,
                pendingDbCubit,
                mujerEmprendeCubit,
              ),
            ),
            const Gap(10),
            CustomElevatedButton(
              alignment: MainAxisAlignment.center,
              text: 'Regresar',
              color: Colors.red,
              onPressed: () => pageController.previousPage(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeIn,
              ),
            ),
            const Gap(10),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    CustomAlertDialog(
      context: context,
      title: message,
      onDone: () => context.pop(),
    ).showDialog(context, dialogType: DialogType.error);
  }

  Future<void> _handleSuccessSubmission(
    BuildContext context,
    KivaRouteState kivaRoute,
    UploadUserFileCubit uploadCubit,
  ) async {
    final signatureImage = await signatureController.toPngBytes();
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/signature.png';

    final file = File(filePath);
    await file.writeAsBytes(signatureImage!);

    if (!context.mounted) return;

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
      onPressedAccept: () =>
          _navigateToSendingScreen(context, kivaRoute, uploadCubit, file.path),
    );
  }

  void _navigateToSendingScreen(
    BuildContext context,
    KivaRouteState kivaRoute,
    UploadUserFileCubit uploadCubit,
    String filePath,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => BlocProvider.value(
          value: uploadCubit,
          child: KivaImageSending(
            solicitudId: kivaRoute.solicitudId,
            onRetry: () {
              uploadCubit.uploadUserFiles(
                typeSigner: typeSigner,
                cedula: kivaRoute.cedula,
                numero: kivaRoute.numero,
                tipoSolicitud: kivaRoute.tipoSolicitud,
                fotoFirma: filePath,
                solicitudId: int.parse(kivaRoute.solicitudId),
                formularioKiva: kivaRoute.nombreFormularioKiva,
              );
            },
          ),
        ),
      ),
    );
  }

  void _showConfirmationPopUp(
    BuildContext context,
    RecurrenteMujerEmprendeState state,
    KivaRouteState kivaRoute,
    SolicitudesPendientesLocalDbCubit pendingDbCubit,
    RecurrenteMujerEmprendeCubit mujerEmprendeCubit,
  ) {
    customPopUp(
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
        pendingDbCubit.updateIsSendedOnSolicitud(
            solicitudId: kivaRoute.solicitudId);

        final localPath = await KivaFile.saveImageSignature(
          controller: signatureController,
          numeroSoicitud: kivaRoute.numero,
        );

        if (!context.mounted) return;

        final imageProvider = context.read<UploadUserFileCubit>().state;
        final imageModel = ImageModel()
          ..typeSigner = typeSigner.name
          ..imagenFirma = localPath
          ..imagen1 = imageProvider.imagen1
          ..imagen2 = imageProvider.imagen2
          ..imagen3 = imageProvider.imagen3
          ..solicitudUuid = kivaRoute.solicitudCreditoId
          ..solicitudId = int.tryParse(kivaRoute.solicitudId);

        _processLocalPersistence(context, state, kivaRoute.solicitudCreditoId,
            imageModel, pendingDbCubit);

        if (!context.mounted) return;
        final isConnected =
            context.read<InternetConnectionCubit>().state.isConnected;
        if (isConnected) {
          mujerEmprendeCubit.sendAnswers();
        }
        context.pop();
      },
      onPressedCancel: () => context.pop(),
    );
  }

  void _processLocalPersistence(
    BuildContext context,
    RecurrenteMujerEmprendeState state,
    String solicitudCreditoId,
    ImageModel imageModel,
    SolicitudesPendientesLocalDbCubit pendingDbCubit,
  ) {
    pendingDbCubit.saveImagesLocal(imageModel: imageModel);

    pendingDbCubit.saveRecurrenteMujerEmprendeForm(
      recurrenteMujerEmprendeDbLocal: state.toDbLocal(solicitudCreditoId),
    );
    final statusConnection =
        context.read<InternetConnectionCubit>().state.connectionStatus;
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

extension on RecurrenteMujerEmprendeState {
  RecurrenteMujerEmprendeDbLocal toDbLocal(String solicitudCreditoId) {
    return RecurrenteMujerEmprendeDbLocal()
      ..tipoSolicitud = tipoSolicitud
      ..alcanzaraMeta = alcanzaraMeta
      ..apoyanNegocio = apoyanNegocio
      ..coincideRespuesta = coincideRespuesta
      ..comoAyudo = comoAyudo
      ..cuantosApoyan = cuantosApoyan
      ..database = database
      ..edadHijos = edadHijos
      ..explicacionAlcanzaraMeta = explicacionAlcanzaraMeta
      ..explicacionInversion = explicacionInversion
      ..mejoraraEntorno = mejoraraEntorno
      ..mejoraraEntornoExplicacion = mejoraraEntornoExplicacion
      ..motivoPrestamo = motivoPrestamo
      ..numeroHijos = numeroHijos
      ..objSolicitudRecurrenteId = objSolicitudRecurrenteId
      ..otrosIngresos = otrosIngresos
      ..otrosIngresosDescripcion = otrosIngresosDescripcion
      ..personasCargo = personasCargo
      ..siguientePaso = siguientePaso
      ..tieneTrabajo = tieneTrabajo
      ..tieneTrabajoDescripcion = tieneTrabajoDescripcion
      ..solicitudCreditoId = solicitudCreditoId
      ..tipoEstudioHijos = tipoEstudioHijos;
  }
}

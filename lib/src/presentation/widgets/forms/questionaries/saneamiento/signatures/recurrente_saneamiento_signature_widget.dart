import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/saneamiento/recurrente_saneamiento_db_local.dart';
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
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

import '../../../../../bloc/internet_connection/internet_connection_cubit.dart';
import '../../../../../bloc/kiva/kiva_route/kiva_route_cubit.dart';
import '../../../../../bloc/kiva/recurrente_agua_y_saniamiento/recurrente_agua_y_saneamiento_cubit.dart';
import '../../../../../bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import '../../../../../bloc/upload_user_file/upload_user_file_cubit.dart';

class RecurrenteSaneamientoSignatureWidget extends StatefulWidget {
  final PageController controller;

  const RecurrenteSaneamientoSignatureWidget({
    super.key,
    required this.controller,
  });

  @override
  State<RecurrenteSaneamientoSignatureWidget> createState() =>
      _RecurrenteSaneamientoSignatureWidgetState();
}

class _RecurrenteSaneamientoSignatureWidgetState
    extends State<RecurrenteSaneamientoSignatureWidget> {
  final SignatureController _signatureController = SignatureController();
  TypeSigner _typeSigner = TypeSigner.ninguno;

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uploadState = context.watch<UploadUserFileCubit>().state;
    final size = MediaQuery.sizeOf(context);
    final isConnected =
        context.watch<InternetConnectionCubit>().state.isConnected;

    return Column(
      children: [
        const MiCreditoProgress(steps: 5, currentStep: 5),
        _DropdownSignerSelector(
          typeSigner: _typeSigner,
          onChanged: (selectedType) {
            setState(() => _typeSigner = selectedType);
          },
        ),
        if (_typeSigner != TypeSigner.ninguno)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  SignatureHeaderLabels(typeSigner: _typeSigner),
                  const Gap(20),
                  SignatureCanvasBox(
                    size: size,
                    controller: _signatureController,
                  ),
                  const Gap(30),
                  SubmitSignatureButton(
                    typeSigner: _typeSigner,
                    signatureController: _signatureController,
                    uploadState: uploadState,
                    isConnected: isConnected,
                    size: size,
                  ),
                  const Gap(10),
                  BackButtonSection(pageController: widget.controller),
                  const Gap(10),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _DropdownSignerSelector extends StatelessWidget {
  final TypeSigner typeSigner;
  final ValueChanged<TypeSigner> onChanged;

  const _DropdownSignerSelector({
    required this.typeSigner,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: JLuxDropdown(
        dropdownColor: AppColors.white,
        title: 'Tiene capacidad el usuario para firma?',
        items: ['input.yes'.tr(), 'input.no'.tr()],
        onChanged: (item) {
          if (item == null) return;
          final type =
              item == 'input.yes'.tr() ? TypeSigner.cliente : TypeSigner.asesor;
          onChanged(type);
        },
        toStringItem: (item) => item,
        hintText: 'input.select_option'.tr(),
      ),
    );
  }
}

class SignatureHeaderLabels extends StatelessWidget {
  final TypeSigner typeSigner;

  const SignatureHeaderLabels({super.key, required this.typeSigner});

  @override
  Widget build(BuildContext context) {
    final titleText = typeSigner == TypeSigner.cliente
        ? 'forms.firmar.title'.tr()
        : 'Firma de Representante de Micrédito';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
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

class SignatureCanvasBox extends StatelessWidget {
  final Size size;
  final SignatureController controller;

  const SignatureCanvasBox({
    super.key,
    required this.size,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                key: const Key('signature_pad'),
                controller: controller,
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
    );
  }
}

class SubmitSignatureButton extends StatelessWidget {
  final TypeSigner typeSigner;
  final SignatureController signatureController;
  final UploadUserFileState uploadState;
  final bool isConnected;
  final Size size;

  const SubmitSignatureButton({
    super.key,
    required this.typeSigner,
    required this.signatureController,
    required this.uploadState,
    required this.isConnected,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecurrenteAguaYSaneamientoCubit,
        RecurrenteAguaYSaneamientoState>(
      listener: (context, state) => _onBlocStateChanged(context, state),
      builder: (context, state) {
        final isProcessing = state.status == Status.inProgress;

        return CustomElevatedButton(
          icon: const Icon(Icons.edit, color: AppColors.white),
          enabled: !isProcessing,
          positionIcon: PositionIcon.left,
          text: isProcessing ? 'Cargando...' : 'button.send'.tr(),
          color: context.primaryColor(),
          onPressed: () => _showConfirmationModal(context, state),
        );
      },
    );
  }

  void _showConfirmationModal(
      BuildContext context, RecurrenteAguaYSaneamientoState blocState) async {
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
        final routeCubit = context.read<KivaRouteCubit>();
        final localDbCubit = context.read<SolicitudesPendientesLocalDbCubit>();
        final formCubit = context.read<RecurrenteAguaYSaneamientoCubit>();

        Navigator.pop(context);

        final localSignaturePath =
            await KivaFile.saveImageSignature(controller: signatureController);

        _persistAnswersLocally(
          localDbCubit: localDbCubit,
          routeState: routeCubit.state,
          blocState: blocState,
          signaturePath: localSignaturePath ?? '',
        );

        if (isConnected) {
          formCubit.sendAnswers();
        } else {
          if (!context.mounted) return;
          _showNoInternetWarning(context);
        }
      },
      onPressedCancel: () => Navigator.pop(context),
    );
  }

  void _onBlocStateChanged(
      BuildContext context, RecurrenteAguaYSaneamientoState state) async {
    if (state.status == Status.error) {
      CustomAlertDialog(
        context: context,
        title: state.errorMsg,
        onDone: () => Navigator.pop(context),
      ).showDialog(context, dialogType: DialogType.error);
      return;
    }

    if (state.status == Status.done) {
      final routeCubit = context.read<KivaRouteCubit>();
      final uploadCubit = context.read<UploadUserFileCubit>();

      final signatureBytes = await signatureController.toPngBytes();
      final directory = await getApplicationDocumentsDirectory();
      final targetFile = File('${directory.path}/signature.png');
      await targetFile.writeAsBytes(signatureBytes!);

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
        onPressedAccept: () => _navigateToImageSending(
            context, routeCubit, uploadCubit, targetFile.path),
      );
    }
  }

  void _persistAnswersLocally({
    required SolicitudesPendientesLocalDbCubit localDbCubit,
    required KivaRouteState routeState,
    required RecurrenteAguaYSaneamientoState blocState,
    required String signaturePath,
  }) {
    localDbCubit.updateIsSendedOnSolicitud(solicitudId: routeState.solicitudId);

    final imageModel = ImageModel()
      ..typeSigner = typeSigner.name
      ..imagenFirma = signaturePath
      ..imagen1 = uploadState.imagen1
      ..imagen2 = uploadState.imagen2
      ..imagen3 = uploadState.imagen3
      ..solicitudUuid = routeState.solicitudCreditoId
      ..solicitudId = int.tryParse(routeState.solicitudId);

    localDbCubit.saveImagesLocal(imageModel: imageModel);
    localDbCubit.saveRecurrentSaneamientoForm(
      recurrenteSaneamientoDbLocal: RecurrenteSaneamientoDbLocal()
        ..alcanzaraMeta = blocState.alcanzaraMeta
        ..tipoSolicitud = blocState.tipoSolicitud
        ..coincideRespuesta = blocState.coincideRespuesta
        ..comoAyudoCondiciones = blocState.comoAyudoCondiciones
        ..comoMejoraCondicionesEntorno = blocState.comoMejoraCondicionesEntorno
        ..database = blocState.database
        ..edadHijos = blocState.edadHijos
        ..explicacionAlcanzaraMeta = blocState.explicacionAlcanzaraMeta
        ..explicacionInversion = blocState.explicacionInversion
        ..motivoPrestamo = blocState.motivoPrestamo
        ..numeroHijos = blocState.numeroHijos
        ..objSolicitudRecurrenteId = blocState.objSolicitudRecurrenteId
        ..otrosDatosCliente = blocState.otrosDatosCliente
        ..otrosIngresos = blocState.otrosIngresos
        ..otrosIngresosDescripcion = blocState.otrosIngresosDescripcion
        ..personasCargo = blocState.personasCargo
        ..quienApoya = blocState.quienApoya
        ..siguientePaso = blocState.siguientePaso
        ..tiempoActividad = blocState.tiempoActividad
        ..tieneTrabajo = blocState.tieneTrabajo
        ..trabajoNegocioDescripcion = blocState.trabajoNegocioDescripcion
        ..solicitudCreditoId = routeState.solicitudCreditoId
        ..tipoEstudioHijos = blocState.tipoEstudioHijos,
    );
  }

  void _navigateToImageSending(
    BuildContext context,
    KivaRouteCubit routeCubit,
    UploadUserFileCubit uploadCubit,
    String cachedFilePath,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => BlocProvider.value(
          value: uploadCubit,
          child: KivaImageSending(
            solicitudId: routeCubit.state.solicitudId,
            onRetry: () {
              final currentRoute = routeCubit.state;
              uploadCubit.uploadUserFiles(
                typeSigner: typeSigner,
                cedula: currentRoute.cedula,
                numero: currentRoute.numero,
                tipoSolicitud: currentRoute.tipoSolicitud,
                fotoFirma: cachedFilePath,
                solicitudId: int.parse(currentRoute.solicitudId),
                formularioKiva: currentRoute.nombreFormularioKiva,
              );
            },
          ),
        ),
      ),
    );
  }

  void _showNoInternetWarning(BuildContext context) {
    NoInternetPopUpOnKiva(
      context: context,
      info:
          'Tu formulario ha sido guardado localmente debido a la falta de conexión.',
      header: '',
    ).showDialog(context, dialogType: DialogType.info);
  }
}

class BackButtonSection extends StatelessWidget {
  final PageController pageController;

  const BackButtonSection({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 0,
      child: CustomElevatedButton(
        alignment: MainAxisAlignment.center,
        text: 'Regresar',
        color: Colors.red,
        onPressed: () => pageController.previousPage(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        ),
      ),
    );
  }
}

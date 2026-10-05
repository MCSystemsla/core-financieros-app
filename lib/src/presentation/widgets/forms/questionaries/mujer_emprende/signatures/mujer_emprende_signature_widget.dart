import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/mujer_emprende/mujer_emprende_db_local.dart';
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
import '../../../../../bloc/kiva/mujer_emprende/mujer_emprende_cubit.dart';
import '../../../../../bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import '../../../../../bloc/upload_user_file/upload_user_file_cubit.dart';

class MujerEmprendeSignatureWidget extends StatefulWidget {
  final PageController controller;
  const MujerEmprendeSignatureWidget({super.key, required this.controller});

  @override
  State<MujerEmprendeSignatureWidget> createState() =>
      _MujerEmprendeSignatureWidgetState();
}

class _MujerEmprendeSignatureWidgetState
    extends State<MujerEmprendeSignatureWidget> {
  TypeSigner typeSigner = TypeSigner.ninguno;
  late final SignatureController _signatureController;

  @override
  void initState() {
    super.initState();
    _signatureController = SignatureController();
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

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
                    typeSigner == TypeSigner.cliente
                        ? 'forms.firmar.title'.tr()
                        : 'Firma de Representante de Micrédito',
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
                  const Gap(20),
                  Expanded(child: _buildSignatureCanvas(size)),
                  const Gap(30),
                  _buildActionButtons(size),
                  const Gap(10),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSignatureCanvas(Size size) {
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
              controller: _signatureController,
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
            onTap: () => _signatureController.clear(),
            size: const Size(44, 44),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(Size size) {
    return BlocConsumer<MujerEmprendeCubit, MujerEmprendeState>(
      listener: (context, state) async {
        if (state.status == Status.error) {
          CustomAlertDialog(
            context: context,
            title: state.errorMsg,
            onDone: () => context.pop(),
          ).showDialog(context, dialogType: DialogType.error);
        }

        if (state.status == Status.done) {
          await _handleFormSubmittedSuccessfully(context, size);
        }
      },
      builder: (context, state) {
        final isLoading = state.status == Status.inProgress;

        return Column(
          children: [
            CustomElevatedButton(
              icon: const Icon(Icons.edit, color: AppColors.white),
              enabled: !isLoading,
              positionIcon: PositionIcon.left,
              text: isLoading ? 'Cargando...' : 'button.send'.tr(),
              color: context.primaryColor(),
              onPressed: () => _showConfirmationDialog(context, size, state),
            ),
            const Gap(10),
            CustomElevatedButton(
              alignment: MainAxisAlignment.center,
              text: 'Regresar',
              color: Colors.red,
              onPressed: () => widget.controller.previousPage(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeIn,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showConfirmationDialog(
    BuildContext context,
    Size size,
    MujerEmprendeState state,
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
        final kivaRoute = context.read<KivaRouteCubit>().state;
        final imageProvider = context.read<UploadUserFileCubit>().state;
        final isConnected =
            context.read<InternetConnectionCubit>().state.isConnected;

        context
            .read<SolicitudesPendientesLocalDbCubit>()
            .updateIsSendedOnSolicitud(
              solicitudId: kivaRoute.solicitudId,
            );

        final localPath = await KivaFile.saveImageSignature(
          controller: _signatureController,
          numeroSoicitud: kivaRoute.numero,
        );

        if (!context.mounted) return;

        final imageModel = ImageModel()
          ..typeSigner = typeSigner.name
          ..imagenFirma = localPath
          ..imagen1 = imageProvider.imagen1
          ..imagen2 = imageProvider.imagen2
          ..imagen3 = imageProvider.imagen3
          ..solicitudUuid = kivaRoute.solicitudCreditoId
          ..solicitudId = int.tryParse(kivaRoute.solicitudId);

        await _saveAnswersLocalDb(context, state, imageModel, '');

        if (!context.mounted) return;

        if (isConnected) {
          context.read<MujerEmprendeCubit>().sendAnswers();
        }
        context.pop();
      },
      onPressedCancel: () => context.pop(),
    );
  }

  Future<void> _handleFormSubmittedSuccessfully(
    BuildContext context,
    Size size,
  ) async {
    final signatureImage = await _signatureController.toPngBytes();
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/signature.png';

    final file = File(filePath);
    await file.writeAsBytes(signatureImage!);

    if (!context.mounted) return;

    final kivaRoute = context.read<KivaRouteCubit>().state;

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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => BlocProvider.value(
              value: context.read<UploadUserFileCubit>(),
              child: KivaImageSending(
                solicitudId: kivaRoute.solicitudId,
                onRetry: () async {
                  final currentFile = File(filePath);
                  context.read<UploadUserFileCubit>().uploadUserFiles(
                        typeSigner: typeSigner,
                        cedula: kivaRoute.cedula,
                        numero: kivaRoute.numero,
                        tipoSolicitud: kivaRoute.tipoSolicitud,
                        fotoFirma: currentFile.path,
                        solicitudId: int.parse(kivaRoute.solicitudId),
                        formularioKiva: kivaRoute.nombreFormularioKiva,
                      );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _saveAnswersLocalDb(
    BuildContext context,
    MujerEmprendeState state,
    ImageModel imageModel,
    String msgDialog,
  ) async {
    final solicitudCreditoId =
        context.read<KivaRouteCubit>().state.solicitudCreditoId;

    context
        .read<SolicitudesPendientesLocalDbCubit>()
        .saveImagesLocal(imageModel: imageModel);

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
            ..solicitudCreditoId = solicitudCreditoId
            ..tipoEstudioHijos = state.tipoEstudioHijos,
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

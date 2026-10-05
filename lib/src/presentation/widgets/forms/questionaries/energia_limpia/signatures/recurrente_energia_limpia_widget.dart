import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/recurrente_energia_limpia_db_local.dart';
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
import '../../../../../bloc/kiva/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
import '../../../../../bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import '../../../../../bloc/upload_user_file/upload_user_file_cubit.dart';

class RecurrenteEnergiaLimpiaWidget extends StatefulWidget {
  final PageController controller;
  const RecurrenteEnergiaLimpiaWidget({super.key, required this.controller});

  @override
  State<RecurrenteEnergiaLimpiaWidget> createState() =>
      _RecurrenteEnergiaLimpiaWidgetState();
}

class _RecurrenteEnergiaLimpiaWidgetState
    extends State<RecurrenteEnergiaLimpiaWidget> {
  late final SignatureController _signatureController;
  TypeSigner _typeSigner = TypeSigner.ninguno;

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
    final isConnected =
        context.select((InternetConnectionCubit c) => c.state.isConnected);
    final size = MediaQuery.sizeOf(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          const MiCreditoProgress(steps: 5, currentStep: 5),
          const Gap(10),
          JLuxDropdown(
            title: 'Tiene capacidad el usuario para firma?',
            items: ['input.yes'.tr(), 'input.no'.tr()],
            hintText: 'input.select_option'.tr(),
            toStringItem: (item) => item,
            onChanged: (item) {
              setState(() {
                _typeSigner = item == 'input.yes'.tr()
                    ? TypeSigner.cliente
                    : TypeSigner.asesor;
              });
            },
          ),
          if (_typeSigner != TypeSigner.ninguno) ...[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    _typeSigner == TypeSigner.cliente
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
                  _SignatureCanvas(
                    controller: _signatureController,
                    size: size,
                  ),
                  const Gap(30),
                  _SubmitButton(
                    signatureController: _signatureController,
                    typeSigner: _typeSigner,
                    isConnected: isConnected,
                    pageSize: size,
                    onPreviousPage: _navigateToPreviousPage,
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _navigateToPreviousPage() {
    widget.controller.previousPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  }
}

class _SignatureCanvas extends StatelessWidget {
  final SignatureController controller;
  final Size size;

  const _SignatureCanvas({
    required this.controller,
    required this.size,
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
              height: size.height * .56,
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
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final SignatureController signatureController;
  final TypeSigner typeSigner;
  final bool isConnected;
  final Size pageSize;
  final VoidCallback onPreviousPage;

  const _SubmitButton({
    required this.signatureController,
    required this.typeSigner,
    required this.isConnected,
    required this.pageSize,
    required this.onPreviousPage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecurrenteEnergiaLimpiaCubit,
        RecurrenteEnergiaLimpiaState>(
      listener: (context, state) async {
        if (state.status == Status.error) {
          CustomAlertDialog(
            context: context,
            title: state.errorMsg,
            onDone: () => context.pop(),
          ).showDialog(context, dialogType: DialogType.error);
        }

        if (state.status == Status.done) {
          await _handleSuccessNavigation(context);
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
              onPressed: () => _showConfirmDialog(context, state),
            ),
            const Gap(10),
            CustomElevatedButton(
              alignment: MainAxisAlignment.center,
              text: 'Regresar',
              color: Colors.red,
              onPressed: onPreviousPage,
            ),
          ],
        );
      },
    );
  }

  void _showConfirmDialog(
    BuildContext context,
    RecurrenteEnergiaLimpiaState state,
  ) async {
    await customPopUp(
      context: context,
      size: pageSize,
      title: 'Confirmas que has leido y confirmado el Formulario Kiva?',
      dialogType: DialogType.warning,
      buttonAcept: true,
      buttonCancel: true,
      colorButtonCancel: AppColors.red,
      textButtonAcept: 'Aceptar',
      textButtonCancel: 'Cancelar',
      colorButtonAcept: AppColors.getPrimaryColor(),
      onPressedCancel: () => context.pop(),
      onPressedAccept: () => _onAcceptConfirm(context, state),
    );
  }

  void _onAcceptConfirm(
    BuildContext context,
    RecurrenteEnergiaLimpiaState state,
  ) async {
    final routeCubit = context.read<KivaRouteCubit>().state;

    context.read<SolicitudesPendientesLocalDbCubit>().updateIsSendedOnSolicitud(
          solicitudId: routeCubit.solicitudId,
        );

    final localPath = await KivaFile.saveImageSignature(
      controller: signatureController,
      numeroSoicitud: routeCubit.numero,
    );

    if (!context.mounted) return;

    final imageProvider = context.read<UploadUserFileCubit>().state;
    _saveAnswers(
      context,
      state,
      imageProvider,
      localPath ?? '',
      routeCubit.solicitudCreditoId,
      routeCubit.solicitudId,
    );

    if (!context.mounted) return;
    if (isConnected) {
      context.read<RecurrenteEnergiaLimpiaCubit>().sendAnswers();
    }
    context.pop();
  }

  void _saveAnswers(
    BuildContext context,
    RecurrenteEnergiaLimpiaState state,
    UploadUserFileState imageProvider,
    String localPath,
    String solicitudCreditoId,
    String solicitudId,
  ) {
    final localDbCubit = context.read<SolicitudesPendientesLocalDbCubit>();

    localDbCubit.saveImagesLocal(
      imageModel: ImageModel()
        ..typeSigner = typeSigner.name
        ..imagenFirma = localPath
        ..imagen1 = imageProvider.imagen1
        ..imagen2 = imageProvider.imagen2
        ..imagen3 = imageProvider.imagen3
        ..solicitudUuid = solicitudCreditoId
        ..solicitudId = int.tryParse(solicitudId),
    );

    localDbCubit.saveRecurrenteEnergiaLimpia(
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
        ..solicitudCreditoId = solicitudCreditoId
        ..trabajoNegocioDescripcion = state.trabajoNegocioDescripcion,
    );

    if (!isConnected) {
      NoInternetPopUpOnKiva(
        context: context,
        info: '',
        header: '',
      ).showDialog(context, dialogType: DialogType.info);
    }
  }

  Future<void> _handleSuccessNavigation(BuildContext context) async {
    final routeCubit = context.read<KivaRouteCubit>().state;
    context.read<SolicitudesPendientesLocalDbCubit>().updateIsSendedOnSolicitud(
          solicitudId: routeCubit.solicitudId,
        );

    final signatureImage = await signatureController.toPngBytes();
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/signature.png');
    if (signatureImage != null) {
      await file.writeAsBytes(signatureImage);
    }

    if (!context.mounted) return;

    await customPopUp(
      context: context,
      dismissOnTouchOutside: false,
      size: pageSize,
      title: 'Formulario Kiva Enviado exitosamente!!',
      subtitle: 'Las respuestas se han enviado Exitosamente',
      dialogType: DialogType.success,
      buttonAcept: true,
      textButtonAcept: 'Ok',
      colorButtonAcept: AppColors.getPrimaryColor(),
      onPressedAccept: () => _navigateToImageSending(
        context,
        routeCubit.solicitudId,
        file,
      ),
    );
  }

  void _navigateToImageSending(
    BuildContext context,
    String solicitudId,
    File file,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => BlocProvider.value(
          value: context.read<UploadUserFileCubit>(),
          child: KivaImageSending(
            solicitudId: solicitudId,
            onRetry: () {
              final route = context.read<KivaRouteCubit>().state;
              context.read<UploadUserFileCubit>().uploadUserFiles(
                    typeSigner: typeSigner,
                    cedula: route.cedula,
                    numero: route.numero,
                    tipoSolicitud: route.tipoSolicitud,
                    fotoFirma: file.path,
                    solicitudId: int.parse(route.solicitudId),
                    formularioKiva: route.nombreFormularioKiva,
                  );
            },
          ),
        ),
      ),
    );
  }
}

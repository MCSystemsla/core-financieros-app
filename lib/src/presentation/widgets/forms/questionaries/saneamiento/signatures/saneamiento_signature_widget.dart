import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/saneamiento/saneamiento_db_local.dart';
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
import '../../../../../bloc/kiva/agua_y_saneamiento/agua_y_saneamiento_cubit.dart';
import '../../../../../bloc/kiva/kiva_route/kiva_route_cubit.dart';
import '../../../../../bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import '../../../../../bloc/upload_user_file/upload_user_file_cubit.dart';

class SaneamientoSignatureWidget extends StatefulWidget {
  final PageController controller;

  const SaneamientoSignatureWidget({
    super.key,
    required this.controller,
  });

  @override
  State<SaneamientoSignatureWidget> createState() =>
      _SaneamientoSignatureWidgetState();
}

class _SaneamientoSignatureWidgetState
    extends State<SaneamientoSignatureWidget> {
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isConnected =
        context.select((InternetConnectionCubit c) => c.state.isConnected);

    return Column(
      children: [
        const MiCreditoProgress(steps: 5, currentStep: 5),
        _buildDropdownSelector(),
        if (_typeSigner != TypeSigner.ninguno)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSignatureHeader(),
                  const Gap(20),
                  Expanded(child: _buildSignatureCanvas(size)),
                  const Gap(30),
                  _buildActionButtons(size, isConnected),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDropdownSelector() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: JLuxDropdown(
        dropdownColor: AppColors.white,
        title: 'Tiene capacidad el usuario para firma?',
        items: ['input.yes'.tr(), 'input.no'.tr()],
        onChanged: (item) {
          setState(() {
            _typeSigner = item == 'input.yes'.tr()
                ? TypeSigner.cliente
                : TypeSigner.asesor;
          });
        },
        toStringItem: (item) => item,
        hintText: 'input.select_option'.tr(),
      ),
    );
  }

  Widget _buildSignatureHeader() {
    return Column(
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
          style: TextStyle(
            color: AppColors.greyWithOpacityV4,
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
                strokeAlign: BorderSide.strokeAlignOutside),
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

  Widget _buildActionButtons(Size size, bool isConnected) {
    return Column(
      children: [
        BlocConsumer<AguaYSaneamientoCubit, AguaYSaneamientoState>(
          listener: _handleCubitListener,
          builder: (context, state) {
            final isInProgress = state.status == Status.inProgress;
            return CustomElevatedButton(
              icon: const Icon(Icons.edit, color: AppColors.white),
              enabled: !isInProgress,
              positionIcon: PositionIcon.left,
              text: isInProgress ? 'Cargando...' : 'button.send'.tr(),
              color: context.primaryColor(),
              onPressed: () => _showConfirmationDialog(
                context,
                size,
                state,
                isConnected,
              ),
            );
          },
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
        const Gap(10),
      ],
    );
  }

  void _handleCubitListener(
    BuildContext context,
    AguaYSaneamientoState state,
  ) async {
    if (state.status == Status.error) {
      CustomAlertDialog(
        context: context,
        title: state.errorMsg,
        onDone: () => context.pop(),
      ).showDialog(context, dialogType: DialogType.error);
      return;
    }

    if (state.status == Status.done) {
      final signatureBytes = await _signatureController.toPngBytes();
      if (signatureBytes == null) return;

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/signature.png');
      await file.writeAsBytes(signatureBytes);

      if (!context.mounted) return;

      await customPopUp(
        context: context,
        dismissOnTouchOutside: false,
        size: MediaQuery.sizeOf(context),
        title: 'Formulario Kiva Enviado exitosamente!!',
        subtitle: 'Las respuestas se han enviado Exitosamente',
        dialogType: DialogType.success,
        buttonAcept: true,
        textButtonAcept: 'Ok',
        colorButtonAcept: AppColors.getPrimaryColor(),
        onPressedAccept: () => _navigateToImageSending(context, file),
      );
    }
  }

  void _showConfirmationDialog(BuildContext context, Size size,
      AguaYSaneamientoState state, bool isConnected) {
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
      onPressedCancel: () => context.pop(),
      onPressedAccept: () async {
        final routeState = context.read<KivaRouteCubit>().state;
        final fileState = context.read<UploadUserFileCubit>().state;

        context
            .read<SolicitudesPendientesLocalDbCubit>()
            .updateIsSendedOnSolicitud(
              solicitudId: routeState.solicitudId,
            );

        final localPath = await KivaFile.saveImageSignature(
          controller: _signatureController,
          numeroSoicitud: routeState.numero,
        );

        if (!context.mounted) return;

        final imageModel = ImageModel()
          ..typeSigner = _typeSigner.name
          ..imagenFirma = localPath
          ..imagen1 = fileState.imagen1
          ..imagen2 = fileState.imagen2
          ..imagen3 = fileState.imagen3
          ..solicitudUuid = routeState.solicitudCreditoId
          ..solicitudId = int.tryParse(routeState.solicitudId);

        _processAndSaveData(context, state, imageModel,
            routeState.solicitudCreditoId, isConnected);
        context.pop();
      },
    );
  }

  void _navigateToImageSending(BuildContext context, File file) {
    final routeState = context.read<KivaRouteCubit>().state;
    final uploadCubit = context.read<UploadUserFileCubit>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => BlocProvider.value(
          value: uploadCubit,
          child: KivaImageSending(
            solicitudId: routeState.solicitudId,
            onRetry: () {
              uploadCubit.uploadUserFiles(
                typeSigner: _typeSigner,
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
  }

  void _processAndSaveData(BuildContext context, AguaYSaneamientoState state,
      ImageModel imageModel, String solicitudCreditoId, bool isConnected) {
    final localDbCubit = context.read<SolicitudesPendientesLocalDbCubit>();

    localDbCubit.saveImagesLocal(imageModel: imageModel);

    final localForm = _mapStateToLocalDb(state, solicitudCreditoId);
    localDbCubit.saveSaneamientoForm(saneamientoDbLocal: localForm);

    if (isConnected) {
      context.read<AguaYSaneamientoCubit>().sendAnswers();
    } else {
      NoInternetPopUpOnKiva(
        context: context,
        info: 'forms.error.no_internet'.tr(),
        header: '',
      ).showDialog(context, dialogType: DialogType.info);
    }
  }

  SaneamientoDbLocal _mapStateToLocalDb(
      AguaYSaneamientoState state, String solicitudCreditoId) {
    return SaneamientoDbLocal()
      ..tipoSolicitud = state.tipoSolicitud
      ..cumpliriaPropuesta = state.cumpliriaPropuesta
      ..database = state.database
      ..edadHijos = state.edadHijos
      ..explicacionCumpliriaPropuesta = state.explicacionCumpliriaPropuesta
      ..importanciaMejorarCondiciones = state.importanciaMejorarCondiciones
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
      ..solicitudCreditoId = solicitudCreditoId
      ..trabajoNegocioDescripcion = state.trabajoNegocioDescripcion;
  }
}

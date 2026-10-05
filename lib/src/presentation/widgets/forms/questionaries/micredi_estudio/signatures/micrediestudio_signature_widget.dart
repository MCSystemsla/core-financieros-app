import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/micredi_estudio/micredi_estudio_db_local.dart';
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
import '../../../../../bloc/kiva/micredi_estudio/micredi_estudio_cubit.dart';
import '../../../../../bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import '../../../../../bloc/upload_user_file/upload_user_file_cubit.dart';

class MicrediestudioSignatureWidget extends StatefulWidget {
  final PageController controller;

  const MicrediestudioSignatureWidget({
    super.key,
    required this.controller,
  });

  @override
  State<MicrediestudioSignatureWidget> createState() =>
      _MicrediestudioSignatureWidgetState();
}

class _MicrediestudioSignatureWidgetState
    extends State<MicrediestudioSignatureWidget> {
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
    final imageProvider = context.watch<UploadUserFileCubit>().state;
    final isConnected =
        context.watch<InternetConnectionCubit>().state.isConnected;

    return SingleChildScrollView(
      child: Column(
        children: [
          const MiCreditoProgress(
            steps: 5,
            currentStep: 5,
          ),
          _DropdownSelector(
            onSignerChanged: (selectedSigner) {
              setState(() => _typeSigner = selectedSigner);
            },
          ),
          if (_typeSigner != TypeSigner.ninguno)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _SignatureHeader(typeSigner: _typeSigner),
                  const Gap(20),
                  _SignatureCanvas(
                    controller: _signatureController,
                    size: size,
                  ),
                  const Gap(30),
                  _SubmitActionsButton(
                    signatureController: _signatureController,
                    typeSigner: _typeSigner,
                    imageProvider: imageProvider,
                    isConnected: isConnected,
                    size: size,
                  ),
                  const Gap(10),
                  _BackButton(pageController: widget.controller),
                  const Gap(10),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _DropdownSelector extends StatelessWidget {
  final ValueChanged<TypeSigner> onSignerChanged;

  const _DropdownSelector({required this.onSignerChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: JLuxDropdown(
        dropdownColor: AppColors.white,
        title: 'Tiene capacidad el usuario para firma?',
        items: ['input.yes'.tr(), 'input.no'.tr()],
        hintText: 'input.select_option'.tr(),
        toStringItem: (item) => item,
        onChanged: (item) {
          final signer =
              item == 'input.yes'.tr() ? TypeSigner.cliente : TypeSigner.asesor;
          onSignerChanged(signer);
        },
      ),
    );
  }
}

class _SignatureHeader extends StatelessWidget {
  final TypeSigner typeSigner;

  const _SignatureHeader({required this.typeSigner});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }
}

class _SignatureCanvas extends StatelessWidget {
  final SignatureController controller;
  final Size size;

  const _SignatureCanvas({required this.controller, required this.size});

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

class _SubmitActionsButton extends StatelessWidget {
  final SignatureController signatureController;
  final TypeSigner typeSigner;
  final dynamic imageProvider;
  final bool isConnected;
  final Size size;

  const _SubmitActionsButton({
    required this.signatureController,
    required this.typeSigner,
    required this.imageProvider,
    required this.isConnected,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final kivaRouteCubit = context.read<KivaRouteCubit>();
    final localDbCubit = context.read<SolicitudesPendientesLocalDbCubit>();
    final uploadFileCubit = context.read<UploadUserFileCubit>();
    final micrediEstudioCubit = context.read<MicrediEstudioCubit>();

    return BlocConsumer<MicrediEstudioCubit, MicrediEstudioState>(
      listener: (context, state) async {
        await _onBlocStateListener(
            context, state, kivaRouteCubit, uploadFileCubit);
      },
      builder: (context, state) {
        final isLoading = state.status == Status.inProgress;
        return CustomElevatedButton(
          icon: const Icon(Icons.edit, color: AppColors.white),
          enabled: !isLoading,
          positionIcon: PositionIcon.left,
          text: isLoading ? 'Cargando...' : 'button.send'.tr(),
          color: context.primaryColor(),
          onPressed: () => _confirmAndProcess(
              context, kivaRouteCubit, localDbCubit, micrediEstudioCubit),
        );
      },
    );
  }

  void _confirmAndProcess(
    BuildContext context,
    KivaRouteCubit routeCubit,
    SolicitudesPendientesLocalDbCubit localDbCubit,
    MicrediEstudioCubit micrediCubit,
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
        final routeState = routeCubit.state;
        final micrediState = micrediCubit.state;

        localDbCubit.updateIsSendedOnSolicitud(
          solicitudId: routeState.solicitudId,
        );

        final localPath = await KivaFile.saveImageSignature(
          controller: signatureController,
          numeroSoicitud: routeState.numero,
        );

        localDbCubit.saveImagesLocal(
          imageModel: ImageModel()
            ..typeSigner = typeSigner.name
            ..imagenFirma = localPath
            ..imagen1 = imageProvider.imagen1
            ..imagen2 = imageProvider.imagen2
            ..imagen3 = imageProvider.imagen3
            ..solicitudUuid = routeState.solicitudCreditoId
            ..solicitudId = int.tryParse(routeState.solicitudId),
        );

        localDbCubit.saveMiCrediEstudioForm(
          miCrediEstudioModelDbLocal: MiCrediEstudioDbLocal()
            ..tipoSolicitud = micrediState.tipoSolicitud
            ..aspiraLaboralmente = micrediState.aspiraLaboralmente
            ..carrera = micrediState.carrera
            ..comoAyudaCrecer = micrediState.comoAyudaCrecer
            ..cualEstudio = micrediState.cualEstudio
            ..database = micrediState.database
            ..edadHijos = micrediState.edadHijos
            ..explicacionRelizandoProfesionalmente =
                micrediState.explicacionRelizandoProfesionalmente
            ..motivoCarrera = micrediState.motivoCarrera
            ..motivoPrestamo = micrediState.motivoPrestamo
            ..numeroHijos = micrediState.numeroHijos
            ..objOrigenCatalogoValorId = micrediState.objOrigenCatalogoValorId
            ..objSolicitudNuevamenorId = micrediState.objSolicitudNuevamenorId
            ..ocupacionPadres = micrediState.ocupacionPadres
            ..optarOtroEstudio = micrediState.optarOtroEstudio
            ..otrosDatosCliente = micrediState.otrosDatosCliente
            ..otrosIngresos = micrediState.otrosIngresos
            ..otrosIngresosDescripcion = micrediState.otrosIngresosDescripcion
            ..personasCargo = micrediState.personasCargo
            ..planFuturo = micrediState.planFuturo
            ..quienApoya = micrediState.quienApoya
            ..relizandoProfesionalmente = micrediState.relizandoProfesionalmente
            ..tiempoActividad = micrediState.tiempoActividad
            ..tiempoCarrera = micrediState.tiempoCarrera
            ..tieneTrabajo = micrediState.tieneTrabajo
            ..tipoEstudioHijos = micrediState.tipoEstudioHijos
            ..trabajoNegocioDescripcion = micrediState.trabajoNegocioDescripcion
            ..solicitudCreditoId = routeState.solicitudCreditoId
            ..universidad = micrediState.universidad,
        );

        if (!context.mounted) return;
        context.pop();

        // 4. Evaluar conectividad
        if (isConnected) {
          micrediCubit.sendAnswers();
        } else {
          NoInternetPopUpOnKiva(
            context: context,
            info: 'Guardado en local. No hay conexión a internet.',
            header: '',
          ).showDialog(context, dialogType: DialogType.info);
        }
      },
      onPressedCancel: () => context.pop(),
    );
  }

  Future<void> _onBlocStateListener(
    BuildContext context,
    MicrediEstudioState state,
    KivaRouteCubit routeCubit,
    UploadUserFileCubit uploadFileCubit,
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
      final signatureImage = await signatureController.toPngBytes();
      if (signatureImage == null) return;

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/signature.png';
      final file = File(filePath);
      await file.writeAsBytes(signatureImage);

      if (!context.mounted) return;
      final routeState = routeCubit.state;

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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => BlocProvider.value(
                value: uploadFileCubit,
                child: KivaImageSending(
                  solicitudId: routeState.solicitudId,
                  onRetry: () => uploadFileCubit.uploadUserFiles(
                    typeSigner: typeSigner,
                    cedula: routeState.cedula,
                    numero: routeState.numero,
                    tipoSolicitud: routeState.tipoSolicitud,
                    fotoFirma: file.path,
                    solicitudId: int.parse(routeState.solicitudId),
                    formularioKiva: routeState.nombreFormularioKiva,
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }
}

class _BackButton extends StatelessWidget {
  final PageController pageController;

  const _BackButton({required this.pageController});

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      alignment: MainAxisAlignment.center,
      text: 'Regresar',
      color: Colors.red,
      onPressed: () => pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      ),
    );
  }
}

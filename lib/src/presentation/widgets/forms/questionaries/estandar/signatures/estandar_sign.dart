import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_firma_widgets.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_form_widgets.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/no_internet_popup_onkiva.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/custom_pop_up.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

import '../../../../../../datasource/local_db/forms/estandar/estandar_db_local.dart';
import '../../../../../../datasource/local_db/image_model.dart';
import '../../../../../bloc/internet_connection/internet_connection_cubit.dart';
import '../../../../../bloc/kiva/estandar/estandar_cubit.dart';
import '../../../../../bloc/kiva/kiva_route/kiva_route_cubit.dart';
import '../../../../../bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import '../../../../../bloc/upload_user_file/upload_user_file_cubit.dart';
import '../../../kiva_image_sending/kiva_image_sending.dart';

class EstandarSignature extends StatefulWidget {
  final PageController controller;
  const EstandarSignature({super.key, required this.controller});

  @override
  State<EstandarSignature> createState() => _EstandarSignatureState();
}

class _EstandarSignatureState extends State<EstandarSignature> {
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
              onSaveOffline: saveOfflineResponses,
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

  Future<void> saveOfflineResponses(
    BuildContext context,
    EstandarState state,
    ImageModel imageModel,
  ) async {
    final statusConnection = context.read<InternetConnectionCubit>().state;
    context.read<SolicitudesPendientesLocalDbCubit>().saveImagesLocal(
          imageModel: imageModel,
        );
    final solicitudCreditoId =
        context.read<KivaRouteCubit>().state.solicitudCreditoId;

    context.read<SolicitudesPendientesLocalDbCubit>().saveEstandarForm(
          estandarDBLocal: EstandarDbLocal()
            ..tipoSolicitud = state.tipoSolicitud
            ..apoyanNegocio = state.apoyanNegocio
            ..cuantosApoyan = state.cuantosApoyan
            ..comoMejoraVida = state.comoMejoraVida
            ..database = LocalStorage().database
            ..edadHijos = state.edadHijos
            ..inicioNegocio = DateTime.parse(state.inicioNegocio)
            ..motivoPrestamo = state.motivoPrestamo
            ..negocioProximosAnios = state.negocioProximosAnios
            ..numeroHijos = state.numeroHijos
            ..objOrigenCatalogoValorId = state.objOrigenCatalogoValorId
            ..objSolicitudNuevamenorId = state.objSolicitudNuevamenorId
            ..otrosDatosCliente = state.otrosDatosCliente
            ..otrosIngresos = state.otrosIngresos
            ..otrosIngresosDescripcion = state.otrosIngresosDescripcion
            ..personasCargo = state.personasCargo
            ..planesFuturo = state.planesFuturo
            ..publicitarNegocio = state.publicitarNegocio
            ..solicitudCreditoId = solicitudCreditoId
            ..tipoEstudioHijos = state.tipoEstudioHijos,
        );
    final isOffline =
        statusConnection.connectionStatus == ConnectionStatus.disconnected ||
            statusConnection.connectionStatus ==
                ConnectionStatus.handleOfflineActivation;

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
  final Future<void> Function(BuildContext, EstandarState, ImageModel)
      onSaveOffline;

  const _ActionButtons({
    required this.signatureController,
    required this.pageController,
    required this.typeSigner,
    required this.size,
    required this.onSaveOffline,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EstandarCubit, EstandarState>(
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
      BuildContext context, EstandarState state) async {
    if (state.status == Status.error) {
      CustomAlertDialog(
        context: context,
        title: state.errorMsg,
        onDone: () => context.pop(),
      ).showDialog(context, dialogType: DialogType.error);
    }

    if (state.status == Status.done) {
      final signatureImage = await signatureController.toPngBytes();
      if (signatureImage == null) return;

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/signature.png');
      await file.writeAsBytes(signatureImage);

      if (!context.mounted) return;

      CustomAlertDialog(
        context: context,
        title: 'Formulario Kiva enviado exitosamente!!',
        subtitle: 'Las respuestas se han enviado Exitosamente.',
        onDone: () {
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
      ).showDialog(context, dialogType: DialogType.success);
    }
  }

  Future<void> _showConfirmationDialog(
      BuildContext context, EstandarState state) async {
    FocusScope.of(context).unfocus();
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
        FocusScope.of(context).unfocus();

        if (!context.mounted) return;
        final routeState = context.read<KivaRouteCubit>().state;
        final imageProvider = context.read<UploadUserFileCubit>().state;
        final isConnected = context.read<InternetConnectionCubit>().state;

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
            ..solicitudId = int.tryParse(routeState.solicitudId),
        );

        if (!context.mounted) return;
        if (isConnected.isConnected) {
          context.read<EstandarCubit>().sendAnswers();
        }
        context.pop();
      },
      onPressedCancel: () => context.pop(),
    );
  }
}

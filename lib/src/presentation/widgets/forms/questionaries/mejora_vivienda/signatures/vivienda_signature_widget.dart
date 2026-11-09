import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/mejora_vivienda/mejora_vivienda_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
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

import '../../../../../bloc/internet_connection/internet_connection_cubit.dart';
import '../../../../../bloc/kiva/kiva_route/kiva_route_cubit.dart';
import '../../../../../bloc/kiva/mejora_vivienda/mejora_vivienda_cubit.dart';
import '../../../../../bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import '../../../../../bloc/upload_user_file/upload_user_file_cubit.dart';

class ViviendaSignatureWidget extends StatefulWidget {
  final PageController controller;
  const ViviendaSignatureWidget({super.key, required this.controller});

  @override
  State<ViviendaSignatureWidget> createState() =>
      _ViviendaSignatureWidgettState();
}

class _ViviendaSignatureWidgettState extends State<ViviendaSignatureWidget> {
  TypeSigner _typeSigner = TypeSigner.ninguno;
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

  void _onSignerChanged(String? item) {
    if (item == null) return;
    setState(() {
      _typeSigner =
          item == 'input.yes'.tr() ? TypeSigner.cliente : TypeSigner.asesor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isConnected =
        context.watch<InternetConnectionCubit>().state.isConnected;
    final imageProvider = context.watch<UploadUserFileCubit>().state;
    final kivaRoute = context.watch<KivaRouteCubit>().state;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KivaPreguntaCard(
            child: KivaDropdown(
              title: 'Tiene capacidad el usuario para firma?',
              items: ['input.yes'.tr(), 'input.no'.tr()],
              onChanged: _onSignerChanged,
              toStringItem: (item) => item,
              hintText: 'input.select_option'.tr(),
            ),
          ),
          if (_typeSigner != TypeSigner.ninguno) ...[
            const Gap(20),
            KivaFirmaEncabezado(
              firmaCliente: _typeSigner == TypeSigner.cliente,
            ),
            const Gap(12),
            KivaFirmaLienzo(controller: _signatureController),
            const Gap(16),
            _buildSubmitButton(size, isConnected, imageProvider, kivaRoute),
          ],
        ],
      ),
    );
  }

  Widget _buildSubmitButton(
    Size size,
    bool isConnected,
    UploadUserFileState imageProvider,
    KivaRouteState kivaRoute,
  ) {
    return BlocConsumer<MejoraViviendaCubit, MejoraViviendaState>(
      listener: (context, state) =>
          _handleNavigationAndUpload(context, state, size, kivaRoute),
      builder: (context, state) {
        return KivaFirmaAcciones(
          enviando: state.status == Status.inProgress,
          onEnviar: () => _showConfirmationDialog(
              context, size, isConnected, imageProvider, kivaRoute, state),
          onRegresar: () => widget.controller.previousPage(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeIn,
          ),
        );
      },
    );
  }

  Future<void> _showConfirmationDialog(
    BuildContext context,
    Size size,
    bool isConnected,
    dynamic imageProvider,
    dynamic kivaRoute,
    MejoraViviendaState state,
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
          ..typeSigner = _typeSigner.name
          ..imagenFirma = localPath
          ..imagen1 = imageProvider.imagen1
          ..imagen2 = imageProvider.imagen2
          ..imagen3 = imageProvider.imagen3
          ..solicitudUuid = kivaRoute.solicitudCreditoId
          ..solicitudId = int.tryParse(kivaRoute.solicitudId);

        _saveMejoraViviendaFormLocally(
            context, state, imageModel, kivaRoute.solicitudCreditoId);

        if (isConnected) {
          context.read<MejoraViviendaCubit>().sendAnswers();
        }
        context.pop();
      },
      onPressedCancel: () => context.pop(),
    );
  }

  Future<void> _handleNavigationAndUpload(
    BuildContext context,
    MejoraViviendaState state,
    Size size,
    dynamic kivaRoute,
  ) async {
    if (state.status == Status.error) {
      CustomAlertDialog(
        context: context,
        title: state.errorMsg,
        onDone: () => context.pop(),
      ).showDialog(context, dialogType: DialogType.error);
    }

    if (state.status == Status.done) {
      final signatureImage = await _signatureController.toPngBytes();
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/signature.png');
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
        onPressedAccept: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => BlocProvider.value(
                value: context.read<UploadUserFileCubit>(),
                child: KivaImageSending(
                  solicitudId: kivaRoute.solicitudId,
                  onRetry: () {
                    context.read<UploadUserFileCubit>().uploadUserFiles(
                          typeSigner: _typeSigner,
                          cedula: kivaRoute.cedula,
                          numero: kivaRoute.numero,
                          tipoSolicitud: kivaRoute.tipoSolicitud,
                          fotoFirma: file.path,
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
  }

  void _saveMejoraViviendaFormLocally(
    BuildContext context,
    MejoraViviendaState state,
    ImageModel imageModel,
    String solicitudCreditoId,
  ) {
    final localDbCubit = context.read<SolicitudesPendientesLocalDbCubit>();
    final statusConnection =
        context.read<InternetConnectionCubit>().state.connectionStatus;

    localDbCubit.saveImagesLocal(imageModel: imageModel);
    localDbCubit.saveMejoraViviendaForm(
      mejoraViviendaDBLocal: MejoraViviendaDbLocal()
        ..tipoSolicitud = state.tipoSolicitud
        ..comoAyudara = state.comoAyudara
        ..database = LocalStorage().database
        ..edadHijos = state.edadHijos
        ..motivoPrestamo = state.motivoPrestamo
        ..necesidadesComunidad = state.necesidadesComunidad
        ..numeroHijos = state.numeroHijos
        ..objOrigenCatalogoValorId = state.objOrigenCatalogoValorId
        ..objTipoComunidadId = state.objTipoComunidadId
        ..otrosDatosCliente = state.otrosDatosCliente
        ..otrosIngresos = state.otrosIngresos
        ..otrosIngresosDescripcion = state.otrosIngresosDescripcion
        ..personasCargo = state.personasCargo
        ..planesFuturo = state.planesFuturo
        ..solicitudNuevamenorId = state.solicitudNuevamenorId
        ..tiempoActividad = state.tiempoActividad
        ..tipoEstudioHijos = state.tipoEstudioHijos
        ..trabajoNegocioDescripcion = state.trabajoNegocioDescripcion
        ..solicitudCreditoId = solicitudCreditoId
        ..username = '',
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

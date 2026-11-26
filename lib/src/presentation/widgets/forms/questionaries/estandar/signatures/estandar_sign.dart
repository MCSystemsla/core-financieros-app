import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_envio_widgets.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_firma_widgets.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_form_widgets.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:signature/signature.dart';

import '../../../../../../datasource/local_db/forms/estandar/estandar_db_local.dart';
import '../../../../../../datasource/local_db/image_model.dart';
import '../../../../../bloc/kiva/estandar/estandar_cubit.dart';
import '../../../../../bloc/kiva/kiva_route/kiva_route_cubit.dart';
import '../../../../../bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import '../../../../../bloc/upload_user_file/upload_user_file_cubit.dart';

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
    // Sin conexión, `KivaEnvioScreen` muestra "Guardado en el teléfono".
  }
}

class _ActionButtons extends StatelessWidget {
  final SignatureController signatureController;
  final PageController pageController;
  final TypeSigner typeSigner;
  final Future<void> Function(BuildContext, EstandarState, ImageModel)
      onSaveOffline;

  const _ActionButtons({
    required this.signatureController,
    required this.pageController,
    required this.typeSigner,
    required this.onSaveOffline,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EstandarCubit, EstandarState>(
      builder: (context, state) {
        return KivaFirmaAcciones(
          enviando: state.status == Status.inProgress,
          onEnviar: () => _enviar(context),
          onRegresar: () => pageController.previousPage(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeIn,
          ),
        );
      },
    );
  }

  /// Confirmación, copia local y pantalla de envío (`iniciarEnvioKiva`).
  Future<void> _enviar(BuildContext context) {
    final cubit = context.read<EstandarCubit>();
    return iniciarEnvioKiva<EstandarCubit, EstandarState>(
      context: context,
      firma: signatureController,
      typeSigner: typeSigner,
      formCubit: cubit,
      estadoDe: (state) => state.status,
      errorDe: (state) => state.errorMsg,
      enviarRespuestas: cubit.sendAnswers,
      guardarEnTelefono: () => _guardarEnTelefono(context, cubit.state),
    );
  }

  Future<void> _guardarEnTelefono(
    BuildContext context,
    EstandarState state,
  ) async {
    final routeState = context.read<KivaRouteCubit>().state;
    final imageProvider = context.read<UploadUserFileCubit>().state;

    context.read<SolicitudesPendientesLocalDbCubit>().updateIsSendedOnSolicitud(
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
  }
}

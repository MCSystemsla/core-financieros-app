import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_estandar/recurrente_estandart_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_envio_widgets.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_firma_widgets.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_form_widgets.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:signature/signature.dart';

import '../../../../../../datasource/local_db/forms/estandar/recurrente_estandar_db_local.dart';
import '../../../../../../datasource/local_db/image_model.dart';
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
  ) async {
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
    // Sin conexión, `KivaEnvioScreen` muestra "Guardado en el teléfono".
  }
}

class _ActionButtons extends StatelessWidget {
  final SignatureController signatureController;
  final PageController pageController;
  final TypeSigner typeSigner;
  final Future<void> Function(
      BuildContext, RecurrenteEstandartState, ImageModel) onSaveOffline;

  const _ActionButtons({
    required this.signatureController,
    required this.pageController,
    required this.typeSigner,
    required this.onSaveOffline,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecurrenteEstandartCubit, RecurrenteEstandartState>(
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
    final cubit = context.read<RecurrenteEstandartCubit>();
    return iniciarEnvioKiva<RecurrenteEstandartCubit, RecurrenteEstandartState>(
      context: context,
      firma: signatureController,
      typeSigner: typeSigner,
      formCubit: cubit,
      estadoDe: (state) => state.status,
      errorDe: (state) => state.erroMsg,
      enviarRespuestas: cubit.sendAnswers,
      guardarEnTelefono: () => _guardarEnTelefono(context, cubit.state),
    );
  }

  Future<void> _guardarEnTelefono(
    BuildContext context,
    RecurrenteEstandartState state,
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
        ..solicitudId = int.parse(routeState.solicitudId),
    );
  }
}

import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/mujer_emprende/recurrente_mujer_emprende_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KivaPreguntaCard(
            child: KivaDropdown(
              title: 'Tiene capacidad el usuario para firma?',
              items: ['input.yes'.tr(), 'input.no'.tr()],
              onChanged: _onSignerTypeChanged,
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
            _SignatureActionButtons(
              signatureController: _signatureController,
              typeSigner: _typeSigner,
              pageController: widget.controller,
            ),
          ],
        ],
      ),
    );
  }
}

class _SignatureActionButtons extends StatelessWidget {
  final SignatureController signatureController;
  final TypeSigner typeSigner;
  final PageController pageController;

  const _SignatureActionButtons({
    required this.signatureController,
    required this.typeSigner,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final kivaRoute = context.read<KivaRouteCubit>().state;
    final pendingDbCubit = context.read<SolicitudesPendientesLocalDbCubit>();
    final mujerEmprendeCubit = context.read<RecurrenteMujerEmprendeCubit>();

    return BlocBuilder<RecurrenteMujerEmprendeCubit,
        RecurrenteMujerEmprendeState>(
      builder: (context, state) {
        return KivaFirmaAcciones(
          enviando: state.status == Status.inProgress,
          onEnviar: () => _enviar(
            context,
            kivaRoute,
            pendingDbCubit,
            mujerEmprendeCubit,
          ),
          onRegresar: () => pageController.previousPage(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeIn,
          ),
        );
      },
    );
  }

  /// Confirmación, copia local y pantalla de envío (`iniciarEnvioKiva`).
  Future<void> _enviar(
    BuildContext context,
    KivaRouteState kivaRoute,
    SolicitudesPendientesLocalDbCubit pendingDbCubit,
    RecurrenteMujerEmprendeCubit mujerEmprendeCubit,
  ) {
    return iniciarEnvioKiva<RecurrenteMujerEmprendeCubit,
        RecurrenteMujerEmprendeState>(
      context: context,
      firma: signatureController,
      typeSigner: typeSigner,
      formCubit: mujerEmprendeCubit,
      estadoDe: (state) => state.status,
      errorDe: (state) => state.errorMsg,
      enviarRespuestas: mujerEmprendeCubit.sendAnswers,
      guardarEnTelefono: () => _guardarEnTelefono(
        context,
        mujerEmprendeCubit.state,
        kivaRoute,
        pendingDbCubit,
      ),
    );
  }

  Future<void> _guardarEnTelefono(
    BuildContext context,
    RecurrenteMujerEmprendeState state,
    KivaRouteState kivaRoute,
    SolicitudesPendientesLocalDbCubit pendingDbCubit,
  ) async {
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

    _processLocalPersistence(
        state, kivaRoute.solicitudCreditoId, imageModel, pendingDbCubit);
  }

  void _processLocalPersistence(
    RecurrenteMujerEmprendeState state,
    String solicitudCreditoId,
    ImageModel imageModel,
    SolicitudesPendientesLocalDbCubit pendingDbCubit,
  ) {
    pendingDbCubit.saveImagesLocal(imageModel: imageModel);

    pendingDbCubit.saveRecurrenteMujerEmprendeForm(
      recurrenteMujerEmprendeDbLocal: state.toDbLocal(solicitudCreditoId),
    );
    // Sin conexión, `KivaEnvioScreen` muestra "Guardado en el teléfono".
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

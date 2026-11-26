import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/mujer_emprende/mujer_emprende_db_local.dart';
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KivaPreguntaCard(
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
          ),
          if (typeSigner != TypeSigner.ninguno) ...[
            const Gap(20),
            KivaFirmaEncabezado(
              firmaCliente: typeSigner == TypeSigner.cliente,
            ),
            const Gap(12),
            KivaFirmaLienzo(controller: _signatureController),
            const Gap(16),
            _buildActionButtons(),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return BlocBuilder<MujerEmprendeCubit, MujerEmprendeState>(
      builder: (context, state) {
        return KivaFirmaAcciones(
          enviando: state.status == Status.inProgress,
          onEnviar: () => _enviar(context),
          onRegresar: () => widget.controller.previousPage(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeIn,
          ),
        );
      },
    );
  }

  /// Confirmación, copia local y pantalla de envío (`iniciarEnvioKiva`).
  Future<void> _enviar(BuildContext context) {
    final cubit = context.read<MujerEmprendeCubit>();
    return iniciarEnvioKiva<MujerEmprendeCubit, MujerEmprendeState>(
      context: context,
      firma: _signatureController,
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
    MujerEmprendeState state,
  ) async {
    final kivaRoute = context.read<KivaRouteCubit>().state;
    final imageProvider = context.read<UploadUserFileCubit>().state;

    context.read<SolicitudesPendientesLocalDbCubit>().updateIsSendedOnSolicitud(
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
    // Sin conexión, `KivaEnvioScreen` muestra "Guardado en el teléfono".
  }
}

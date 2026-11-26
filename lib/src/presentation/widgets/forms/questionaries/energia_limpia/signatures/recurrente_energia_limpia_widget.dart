import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/recurrente_energia_limpia_db_local.dart';
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KivaPreguntaCard(
            child: KivaDropdown(
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
          ),
          if (_typeSigner != TypeSigner.ninguno) ...[
            const Gap(20),
            KivaFirmaEncabezado(
              firmaCliente: _typeSigner == TypeSigner.cliente,
            ),
            const Gap(12),
            KivaFirmaLienzo(controller: _signatureController),
            const Gap(16),
            _SubmitButton(
              signatureController: _signatureController,
              typeSigner: _typeSigner,
              onPreviousPage: _navigateToPreviousPage,
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

class _SubmitButton extends StatelessWidget {
  final SignatureController signatureController;
  final TypeSigner typeSigner;
  final VoidCallback onPreviousPage;

  const _SubmitButton({
    required this.signatureController,
    required this.typeSigner,
    required this.onPreviousPage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecurrenteEnergiaLimpiaCubit,
        RecurrenteEnergiaLimpiaState>(
      builder: (context, state) {
        return KivaFirmaAcciones(
          enviando: state.status == Status.inProgress,
          onEnviar: () => _enviar(context),
          onRegresar: onPreviousPage,
        );
      },
    );
  }

  /// Confirmación, copia local y pantalla de envío (`iniciarEnvioKiva`).
  Future<void> _enviar(BuildContext context) {
    final cubit = context.read<RecurrenteEnergiaLimpiaCubit>();
    return iniciarEnvioKiva<RecurrenteEnergiaLimpiaCubit,
        RecurrenteEnergiaLimpiaState>(
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
    // Sin conexión, `KivaEnvioScreen` muestra "Guardado en el teléfono".
  }
}

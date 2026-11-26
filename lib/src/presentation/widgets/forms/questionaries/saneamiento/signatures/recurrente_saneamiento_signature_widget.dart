import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/saneamiento/recurrente_saneamiento_db_local.dart';
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
import '../../../../../bloc/kiva/recurrente_agua_y_saniamiento/recurrente_agua_y_saneamiento_cubit.dart';
import '../../../../../bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import '../../../../../bloc/upload_user_file/upload_user_file_cubit.dart';

class RecurrenteSaneamientoSignatureWidget extends StatefulWidget {
  final PageController controller;

  const RecurrenteSaneamientoSignatureWidget({
    super.key,
    required this.controller,
  });

  @override
  State<RecurrenteSaneamientoSignatureWidget> createState() =>
      _RecurrenteSaneamientoSignatureWidgetState();
}

class _RecurrenteSaneamientoSignatureWidgetState
    extends State<RecurrenteSaneamientoSignatureWidget> {
  final SignatureController _signatureController = SignatureController();
  TypeSigner _typeSigner = TypeSigner.ninguno;

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uploadState = context.watch<UploadUserFileCubit>().state;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DropdownSignerSelector(
            typeSigner: _typeSigner,
            onChanged: (selectedType) {
              setState(() => _typeSigner = selectedType);
            },
          ),
          if (_typeSigner != TypeSigner.ninguno) ...[
            const Gap(20),
            KivaFirmaEncabezado(
              firmaCliente: _typeSigner == TypeSigner.cliente,
            ),
            const Gap(12),
            KivaFirmaLienzo(controller: _signatureController),
            const Gap(16),
            SubmitSignatureButton(
              typeSigner: _typeSigner,
              signatureController: _signatureController,
              uploadState: uploadState,
              pageController: widget.controller,
            ),
          ],
        ],
      ),
    );
  }
}

class _DropdownSignerSelector extends StatelessWidget {
  final TypeSigner typeSigner;
  final ValueChanged<TypeSigner> onChanged;

  const _DropdownSignerSelector({
    required this.typeSigner,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return KivaPreguntaCard(
      child: KivaDropdown(
        title: 'Tiene capacidad el usuario para firma?',
        items: ['input.yes'.tr(), 'input.no'.tr()],
        onChanged: (item) {
          if (item == null) return;
          final type =
              item == 'input.yes'.tr() ? TypeSigner.cliente : TypeSigner.asesor;
          onChanged(type);
        },
        toStringItem: (item) => item,
        hintText: 'input.select_option'.tr(),
      ),
    );
  }
}

class SubmitSignatureButton extends StatelessWidget {
  final TypeSigner typeSigner;
  final SignatureController signatureController;
  final UploadUserFileState uploadState;
  final PageController pageController;

  const SubmitSignatureButton({
    super.key,
    required this.typeSigner,
    required this.signatureController,
    required this.uploadState,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecurrenteAguaYSaneamientoCubit,
        RecurrenteAguaYSaneamientoState>(
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
    final formCubit = context.read<RecurrenteAguaYSaneamientoCubit>();
    return iniciarEnvioKiva<RecurrenteAguaYSaneamientoCubit,
        RecurrenteAguaYSaneamientoState>(
      context: context,
      firma: signatureController,
      typeSigner: typeSigner,
      formCubit: formCubit,
      estadoDe: (state) => state.status,
      errorDe: (state) => state.errorMsg,
      enviarRespuestas: formCubit.sendAnswers,
      guardarEnTelefono: () => _guardarEnTelefono(context, formCubit.state),
    );
  }

  Future<void> _guardarEnTelefono(
    BuildContext context,
    RecurrenteAguaYSaneamientoState blocState,
  ) async {
    final routeCubit = context.read<KivaRouteCubit>();
    final localDbCubit = context.read<SolicitudesPendientesLocalDbCubit>();

    final localSignaturePath =
        await KivaFile.saveImageSignature(controller: signatureController);

    _persistAnswersLocally(
      localDbCubit: localDbCubit,
      routeState: routeCubit.state,
      blocState: blocState,
      signaturePath: localSignaturePath ?? '',
    );
    // Sin conexión, `KivaEnvioScreen` muestra "Guardado en el teléfono".
  }

  void _persistAnswersLocally({
    required SolicitudesPendientesLocalDbCubit localDbCubit,
    required KivaRouteState routeState,
    required RecurrenteAguaYSaneamientoState blocState,
    required String signaturePath,
  }) {
    localDbCubit.updateIsSendedOnSolicitud(solicitudId: routeState.solicitudId);

    final imageModel = ImageModel()
      ..typeSigner = typeSigner.name
      ..imagenFirma = signaturePath
      ..imagen1 = uploadState.imagen1
      ..imagen2 = uploadState.imagen2
      ..imagen3 = uploadState.imagen3
      ..solicitudUuid = routeState.solicitudCreditoId
      ..solicitudId = int.tryParse(routeState.solicitudId);

    localDbCubit.saveImagesLocal(imageModel: imageModel);
    localDbCubit.saveRecurrentSaneamientoForm(
      recurrenteSaneamientoDbLocal: RecurrenteSaneamientoDbLocal()
        ..alcanzaraMeta = blocState.alcanzaraMeta
        ..tipoSolicitud = blocState.tipoSolicitud
        ..coincideRespuesta = blocState.coincideRespuesta
        ..comoAyudoCondiciones = blocState.comoAyudoCondiciones
        ..comoMejoraCondicionesEntorno = blocState.comoMejoraCondicionesEntorno
        ..database = blocState.database
        ..edadHijos = blocState.edadHijos
        ..explicacionAlcanzaraMeta = blocState.explicacionAlcanzaraMeta
        ..explicacionInversion = blocState.explicacionInversion
        ..motivoPrestamo = blocState.motivoPrestamo
        ..numeroHijos = blocState.numeroHijos
        ..objSolicitudRecurrenteId = blocState.objSolicitudRecurrenteId
        ..otrosDatosCliente = blocState.otrosDatosCliente
        ..otrosIngresos = blocState.otrosIngresos
        ..otrosIngresosDescripcion = blocState.otrosIngresosDescripcion
        ..personasCargo = blocState.personasCargo
        ..quienApoya = blocState.quienApoya
        ..siguientePaso = blocState.siguientePaso
        ..tiempoActividad = blocState.tiempoActividad
        ..tieneTrabajo = blocState.tieneTrabajo
        ..trabajoNegocioDescripcion = blocState.trabajoNegocioDescripcion
        ..solicitudCreditoId = routeState.solicitudCreditoId
        ..tipoEstudioHijos = blocState.tipoEstudioHijos,
    );
  }
}

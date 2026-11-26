import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/energia_limpia_db_local.dart';
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

import '../../../../../bloc/kiva/energia_limpia/energia_limpia_cubit.dart';
import '../../../../../bloc/kiva/kiva_route/kiva_route_cubit.dart';
import '../../../../../bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import '../../../../../bloc/upload_user_file/upload_user_file_cubit.dart';

class EnergiaLimpiaSignatureWidget extends StatefulWidget {
  final PageController controller;

  const EnergiaLimpiaSignatureWidget({
    super.key,
    required this.controller,
  });

  @override
  State<EnergiaLimpiaSignatureWidget> createState() =>
      _EnergiaLimpiaSignatureWidgetState();
}

class _EnergiaLimpiaSignatureWidgetState
    extends State<EnergiaLimpiaSignatureWidget> {
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DropdownSelector(
            onSignerChanged: (selectedSigner) {
              setState(() => _typeSigner = selectedSigner);
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
            _SubmitButtonActions(
              signatureController: _signatureController,
              pageController: widget.controller,
              typeSigner: _typeSigner,
            ),
          ],
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
    return KivaPreguntaCard(
      child: KivaDropdown(
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

class _SubmitButtonActions extends StatelessWidget {
  final SignatureController signatureController;
  final PageController pageController;
  final TypeSigner typeSigner;

  const _SubmitButtonActions({
    required this.signatureController,
    required this.pageController,
    required this.typeSigner,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnergiaLimpiaCubit, EnergiaLimpiaState>(
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
    final energiaCubit = context.read<EnergiaLimpiaCubit>();
    return iniciarEnvioKiva<EnergiaLimpiaCubit, EnergiaLimpiaState>(
      context: context,
      firma: signatureController,
      typeSigner: typeSigner,
      formCubit: energiaCubit,
      estadoDe: (state) => state.status,
      errorDe: (state) => state.errorMsg,
      enviarRespuestas: energiaCubit.sendAnswers,
      guardarEnTelefono: () => _guardarEnTelefono(
        context.read<KivaRouteCubit>(),
        context.read<SolicitudesPendientesLocalDbCubit>(),
        energiaCubit,
        context.read<UploadUserFileCubit>().state,
      ),
    );
  }

  Future<void> _guardarEnTelefono(
    KivaRouteCubit routeCubit,
    SolicitudesPendientesLocalDbCubit localDbCubit,
    EnergiaLimpiaCubit energiaCubit,
    UploadUserFileState imageState,
  ) async {
    final routeState = routeCubit.state;

    localDbCubit.updateIsSendedOnSolicitud(
        solicitudId: routeState.solicitudId);

    final localPath = await KivaFile.saveImageSignature(
      controller: signatureController,
      numeroSoicitud: routeState.numero,
    );

    final imageModel = ImageModel()
      ..typeSigner = typeSigner.name
      ..imagenFirma = localPath
      ..imagen1 = imageState.imagen1
      ..imagen2 = imageState.imagen2
      ..imagen3 = imageState.imagen3
      ..solicitudUuid = routeState.solicitudCreditoId
      ..solicitudId = int.tryParse(routeState.solicitudId);

    localDbCubit.saveImagesLocal(imageModel: imageModel);
    localDbCubit.saveEnergiaLimpia(
      energiaLimpiaDBLocal: EnergiaLimpiaDbLocal()
        ..database = LocalStorage().database
        ..solicitudCreditoId = routeState.solicitudCreditoId
        ..tipoSolicitud = energiaCubit.state.tipoSolicitud
        ..edadHijos = energiaCubit.state.edadHijos
        ..motivoPrestamo = energiaCubit.state.motivoPrestamo
        ..numeroHijos = energiaCubit.state.numeroHijos
        ..objOrigenCatalogoValorId =
            energiaCubit.state.objOrigenCatalogoValorId
        ..objTipoComunidadId = energiaCubit.state.objTipoComunidadId
        ..otrosDatosCliente = energiaCubit.state.otrosDatosCliente
        ..otrosIngresos = energiaCubit.state.otrosIngresos
        ..otrosIngresosDescripcion =
            energiaCubit.state.otrosIngresosDescripcion
        ..personasCargo = energiaCubit.state.personasCargo
        ..planesFuturo = energiaCubit.state.planesFuturo
        ..solicitudNuevamenorId = energiaCubit.state.solicitudNuevamenorId
        ..tiempoActividad = energiaCubit.state.tiempoActividad
        ..tieneProblemasEnergia = energiaCubit.state.tieneProblemasEnergia
        ..tieneTrabajo = energiaCubit.state.tieneTrabajo
        ..tipoEstudioHijos = energiaCubit.state.tipoEstudioHijos
        ..problemasEnergiaDescripcion =
            energiaCubit.state.problemasEnergiaDescripcion
        ..trabajoNegocioDescripcion =
            energiaCubit.state.trabajoNegocioDescripcion,
    );
    // Sin conexión, `KivaEnvioScreen` muestra "Guardado en el teléfono".
  }
}

import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/micredi_estudio/micredi_estudio_db_local.dart';
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
            _SubmitActionsButton(
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

class _SubmitActionsButton extends StatelessWidget {
  final SignatureController signatureController;
  final PageController pageController;
  final TypeSigner typeSigner;

  const _SubmitActionsButton({
    required this.signatureController,
    required this.pageController,
    required this.typeSigner,
  });

  @override
  Widget build(BuildContext context) {
    final kivaRouteCubit = context.read<KivaRouteCubit>();
    final localDbCubit = context.read<SolicitudesPendientesLocalDbCubit>();
    final micrediEstudioCubit = context.read<MicrediEstudioCubit>();

    return BlocBuilder<MicrediEstudioCubit, MicrediEstudioState>(
      builder: (context, state) {
        return KivaFirmaAcciones(
          enviando: state.status == Status.inProgress,
          onEnviar: () => _enviar(
              context, kivaRouteCubit, localDbCubit, micrediEstudioCubit),
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
    KivaRouteCubit routeCubit,
    SolicitudesPendientesLocalDbCubit localDbCubit,
    MicrediEstudioCubit micrediCubit,
  ) {
    return iniciarEnvioKiva<MicrediEstudioCubit, MicrediEstudioState>(
      context: context,
      firma: signatureController,
      typeSigner: typeSigner,
      formCubit: micrediCubit,
      estadoDe: (state) => state.status,
      errorDe: (state) => state.errorMsg,
      enviarRespuestas: micrediCubit.sendAnswers,
      guardarEnTelefono: () => _guardarEnTelefono(
        routeCubit,
        localDbCubit,
        micrediCubit,
        context.read<UploadUserFileCubit>().state,
      ),
    );
  }

  Future<void> _guardarEnTelefono(
    KivaRouteCubit routeCubit,
    SolicitudesPendientesLocalDbCubit localDbCubit,
    MicrediEstudioCubit micrediCubit,
    UploadUserFileState imageProvider,
  ) async {
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
    // Sin conexión, `KivaEnvioScreen` muestra "Guardado en el teléfono".
  }
}

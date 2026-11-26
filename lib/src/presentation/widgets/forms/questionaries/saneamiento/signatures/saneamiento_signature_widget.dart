import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/saneamiento/saneamiento_db_local.dart';
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

import '../../../../../bloc/kiva/agua_y_saneamiento/agua_y_saneamiento_cubit.dart';
import '../../../../../bloc/kiva/kiva_route/kiva_route_cubit.dart';
import '../../../../../bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import '../../../../../bloc/upload_user_file/upload_user_file_cubit.dart';

class SaneamientoSignatureWidget extends StatefulWidget {
  final PageController controller;

  const SaneamientoSignatureWidget({
    super.key,
    required this.controller,
  });

  @override
  State<SaneamientoSignatureWidget> createState() =>
      _SaneamientoSignatureWidgetState();
}

class _SaneamientoSignatureWidgetState
    extends State<SaneamientoSignatureWidget> {
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
          _buildDropdownSelector(),
          if (_typeSigner != TypeSigner.ninguno) ...[
            const Gap(20),
            KivaFirmaEncabezado(
              firmaCliente: _typeSigner == TypeSigner.cliente,
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

  Widget _buildDropdownSelector() {
    return KivaPreguntaCard(
      child: KivaDropdown(
        title: 'Tiene capacidad el usuario para firma?',
        items: ['input.yes'.tr(), 'input.no'.tr()],
        onChanged: (item) {
          setState(() {
            _typeSigner = item == 'input.yes'.tr()
                ? TypeSigner.cliente
                : TypeSigner.asesor;
          });
        },
        toStringItem: (item) => item,
        hintText: 'input.select_option'.tr(),
      ),
    );
  }

  Widget _buildActionButtons() {
    return BlocBuilder<AguaYSaneamientoCubit, AguaYSaneamientoState>(
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
    final cubit = context.read<AguaYSaneamientoCubit>();
    return iniciarEnvioKiva<AguaYSaneamientoCubit, AguaYSaneamientoState>(
      context: context,
      firma: _signatureController,
      typeSigner: _typeSigner,
      formCubit: cubit,
      estadoDe: (state) => state.status,
      errorDe: (state) => state.errorMsg,
      enviarRespuestas: cubit.sendAnswers,
      guardarEnTelefono: () => _guardarEnTelefono(context, cubit.state),
    );
  }

  Future<void> _guardarEnTelefono(
    BuildContext context,
    AguaYSaneamientoState state,
  ) async {
    final routeState = context.read<KivaRouteCubit>().state;
    final fileState = context.read<UploadUserFileCubit>().state;

    context.read<SolicitudesPendientesLocalDbCubit>().updateIsSendedOnSolicitud(
          solicitudId: routeState.solicitudId,
        );

    final localPath = await KivaFile.saveImageSignature(
      controller: _signatureController,
      numeroSoicitud: routeState.numero,
    );

    if (!context.mounted) return;

    final imageModel = ImageModel()
      ..typeSigner = _typeSigner.name
      ..imagenFirma = localPath
      ..imagen1 = fileState.imagen1
      ..imagen2 = fileState.imagen2
      ..imagen3 = fileState.imagen3
      ..solicitudUuid = routeState.solicitudCreditoId
      ..solicitudId = int.tryParse(routeState.solicitudId);

    _processAndSaveData(
        context, state, imageModel, routeState.solicitudCreditoId);
  }

  void _processAndSaveData(BuildContext context, AguaYSaneamientoState state,
      ImageModel imageModel, String solicitudCreditoId) {
    final localDbCubit = context.read<SolicitudesPendientesLocalDbCubit>();

    localDbCubit.saveImagesLocal(imageModel: imageModel);

    final localForm = _mapStateToLocalDb(state, solicitudCreditoId);
    localDbCubit.saveSaneamientoForm(saneamientoDbLocal: localForm);
    // Sin conexión, `KivaEnvioScreen` muestra "Guardado en el teléfono".
  }

  SaneamientoDbLocal _mapStateToLocalDb(
      AguaYSaneamientoState state, String solicitudCreditoId) {
    return SaneamientoDbLocal()
      ..tipoSolicitud = state.tipoSolicitud
      ..cumpliriaPropuesta = state.cumpliriaPropuesta
      ..database = state.database
      ..edadHijos = state.edadHijos
      ..explicacionCumpliriaPropuesta = state.explicacionCumpliriaPropuesta
      ..importanciaMejorarCondiciones = state.importanciaMejorarCondiciones
      ..mejoraCalidadVida = state.mejoraCalidadVida
      ..metasProximas = state.metasProximas
      ..motivacionCredito = state.motivacionCredito
      ..motivoPrestamo = state.motivoPrestamo
      ..numeroHijos = state.numeroHijos
      ..objOrigenCatalogoValorId = state.objOrigenCatalogoValorId
      ..objSolicitudNuevamenorId = state.solicitudNuevamenorId
      ..otrosDatosCliente = state.otrosDatosCliente
      ..otrosIngresos = state.otrosIngresos
      ..otrosIngresosDescripcion = state.otrosIngresosDescripcion
      ..personasCargo = state.personasCargo
      ..siguienteProyectoCalidadVida = state.siguienteProyectoCalidadVida
      ..tiempoActividad = state.tiempoActividad
      ..tieneTrabajo = state.tieneTrabajo
      ..tipoEstudioHijos = state.tipoEstudioHijos
      ..solicitudCreditoId = solicitudCreditoId
      ..trabajoNegocioDescripcion = state.trabajoNegocioDescripcion;
  }
}

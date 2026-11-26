import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/mejora_vivienda/mejora_vivienda_db_local.dart';
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
            _buildSubmitButton(),
          ],
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<MejoraViviendaCubit, MejoraViviendaState>(
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
    final cubit = context.read<MejoraViviendaCubit>();
    return iniciarEnvioKiva<MejoraViviendaCubit, MejoraViviendaState>(
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
    MejoraViviendaState state,
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
      ..typeSigner = _typeSigner.name
      ..imagenFirma = localPath
      ..imagen1 = imageProvider.imagen1
      ..imagen2 = imageProvider.imagen2
      ..imagen3 = imageProvider.imagen3
      ..solicitudUuid = kivaRoute.solicitudCreditoId
      ..solicitudId = int.tryParse(kivaRoute.solicitudId);

    _saveMejoraViviendaFormLocally(
        context, state, imageModel, kivaRoute.solicitudCreditoId);
  }

  void _saveMejoraViviendaFormLocally(
    BuildContext context,
    MejoraViviendaState state,
    ImageModel imageModel,
    String solicitudCreditoId,
  ) {
    final localDbCubit = context.read<SolicitudesPendientesLocalDbCubit>();

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

    // Sin conexión, `KivaEnvioScreen` muestra "Guardado en el teléfono".
  }
}

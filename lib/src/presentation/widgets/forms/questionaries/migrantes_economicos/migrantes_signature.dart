import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/migrante_economico/migrante_economico_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/migrante_economico/recurrente_migrante_economico_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/migrantes_economicos/migrantes_economicos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_envio_widgets.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_firma_widgets.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_form_widgets.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:signature/signature.dart';

import '../../../../bloc/kiva/recurrente_migrante_economico/recurrente_migrantes_economicos_cubit.dart';

class MigrantesFormSignature extends StatefulWidget {
  final PageController controller;
  const MigrantesFormSignature({
    super.key,
    required this.controller,
  });

  @override
  State<MigrantesFormSignature> createState() => _MigrantesFormSignatureState();
}

class _MigrantesFormSignatureState extends State<MigrantesFormSignature> {
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
            BlocBuilder<MigrantesEconomicosCubit, MigrantesEconomicosState>(
              builder: (context, state) {
                return KivaFirmaAcciones(
                  enviando: state.status == Status.inProgress,
                  onRegresar: () => widget.controller.previousPage(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeIn,
                  ),
                  onEnviar: () => _enviar(context),
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  /// Confirmación, copia local y pantalla de envío (`iniciarEnvioKiva`).
  Future<void> _enviar(BuildContext context) {
    final cubit = context.read<MigrantesEconomicosCubit>();
    return iniciarEnvioKiva<MigrantesEconomicosCubit, MigrantesEconomicosState>(
      context: context,
      firma: _signatureController,
      typeSigner: typeSigner,
      formCubit: cubit,
      estadoDe: (state) => state.status,
      errorDe: (state) => state.errorMsg,
      enviarRespuestas: cubit.sendMigrantesEconomicos,
      guardarEnTelefono: () => _guardarEnTelefono(context, cubit.state),
    );
  }

  Future<void> _guardarEnTelefono(
    BuildContext context,
    MigrantesEconomicosState state,
  ) async {
    final imageProvider = context.read<UploadUserFileCubit>().state;
    context
        .read<SolicitudesPendientesLocalDbCubit>()
        .updateIsSendedOnSolicitud(
          solicitudId: context.read<KivaRouteCubit>().state.solicitudId,
        );
    final localPath = await KivaFile.saveImageSignature(
      controller: _signatureController,
      numeroSoicitud: context.read<KivaRouteCubit>().state.numero,
    );

    if (!context.mounted) return;

    await saveAnswersOnLocalDB(
      context,
      state,
      ImageModel()
        ..typeSigner = typeSigner.name
        ..imagenFirma = localPath
        ..imagen1 = imageProvider.imagen1
        ..imagen2 = imageProvider.imagen2
        ..imagen3 = imageProvider.imagen3
        ..solicitudId = int.tryParse(
          context.read<KivaRouteCubit>().state.solicitudId,
        ),
    );
  }

  saveAnswersOnLocalDB(
    BuildContext context,
    MigrantesEconomicosState state,
    ImageModel imageModel,
  ) {
    context.read<SolicitudesPendientesLocalDbCubit>().saveImagesLocal(
          imageModel: imageModel,
        );
    context.read<SolicitudesPendientesLocalDbCubit>().saveMigranteEconomicoForm(
          migranteEconomicoDbLocal: MigranteEconomicoDbLocal()
            ..tipoSolicitud = state.tipoSolicitud
            ..database = LocalStorage().database
            ..objSolicitudNuevamenorId = state.objSolicitudNuevamenorId
            ..tieneTrabajo = state.tieneTrabajo
            ..trabajoNegocioDescripcion = state.trabajoNegocioDescripcion
            ..tiempoActividad = state.tiempoActividad
            ..otrosIngresos = state.otrosIngresos
            ..otrosIngresosDescripcion = state.otrosIngresosDescripcion
            ..personasCargo = state.personasCargo
            ..objOrigenUbicacionGeograficaId =
                state.objOrigenUbicacionGeograficaId
            ..motivoDejarPais = state.motivoDejarPais
            ..situacionMigratoria = state.situacionMigratoria
            ..dedicabaPaisOrigen = state.dedicabaPaisOrigen
            ..vivePaisActual = state.vivePaisActual
            ..numeroHijos = state.numeroHijos
            ..edadHijos = state.edadHijos
            ..tipoEstudioHijos = state.tipoEstudioHijos
            ..enviaRemesas = state.enviaRemesas
            ..enviaRemesasExplicacion = state.enviaRemesasExplicacion
            ..quienApoya = state.quienApoya
            ..fortalecerIngresos = state.fortalecerIngresos
            ..fortalecerIngresosExplicacion =
                state.fortalecerIngresosExplicacion
            ..metasFuturo = state.metasFuturo
            ..motivoPrestamo = state.motivoPrestamo
            ..ayudaMejorarCondiciones = state.ayudaMejorarCondiciones
            ..ayudaMejorarCondicionesExplicacion =
                state.ayudaMejorarCondicionesExplicacion
            ..propositosProximos = state.propositosProximos
            ..piensaRegresar = state.piensaRegresar
            ..otrosDatosCliente = state.otrosDatosCliente,
        );
    // Sin conexión, `KivaEnvioScreen` muestra "Guardado en el teléfono".
  }
}

class RecurrenteMigrantesFormSignature extends StatefulWidget {
  final PageController controller;
  const RecurrenteMigrantesFormSignature({
    super.key,
    required this.controller,
  });

  @override
  State<RecurrenteMigrantesFormSignature> createState() =>
      _RecurrenteMigrantesFormSignatureState();
}

class _RecurrenteMigrantesFormSignatureState
    extends State<RecurrenteMigrantesFormSignature> {
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
            BlocBuilder<RecurrenteMigrantesEconomicosCubit,
                RecurrenteMigrantesEconomicosState>(
              builder: (context, state) {
                return KivaFirmaAcciones(
                  enviando: state.status == Status.inProgress,
                  onRegresar: () => widget.controller.previousPage(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeIn,
                  ),
                  onEnviar: () => _enviar(context),
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  /// Confirmación, copia local y pantalla de envío (`iniciarEnvioKiva`).
  Future<void> _enviar(BuildContext context) {
    final cubit = context.read<RecurrenteMigrantesEconomicosCubit>();
    return iniciarEnvioKiva<RecurrenteMigrantesEconomicosCubit,
        RecurrenteMigrantesEconomicosState>(
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
    RecurrenteMigrantesEconomicosState state,
  ) async {
    final imageProvider = context.read<UploadUserFileCubit>().state;
    context
        .read<SolicitudesPendientesLocalDbCubit>()
        .updateIsSendedOnSolicitud(
          solicitudId: context.read<KivaRouteCubit>().state.solicitudId,
        );
    final localPath = await KivaFile.saveImageSignature(
      controller: _signatureController,
      numeroSoicitud: context.read<KivaRouteCubit>().state.numero,
    );

    if (!context.mounted) return;

    await saveAnswersOnLocalDB(
      context,
      state,
      ImageModel()
        ..typeSigner = typeSigner.name
        ..imagenFirma = localPath
        ..imagen1 = imageProvider.imagen1
        ..imagen2 = imageProvider.imagen2
        ..imagen3 = imageProvider.imagen3
        ..solicitudId = int.tryParse(
          context.read<KivaRouteCubit>().state.solicitudId,
        ),
    );
  }

  saveAnswersOnLocalDB(
    BuildContext context,
    RecurrenteMigrantesEconomicosState state,
    ImageModel imageModel,
  ) {
    context.read<SolicitudesPendientesLocalDbCubit>().saveImagesLocal(
          imageModel: imageModel,
        );
    context
        .read<SolicitudesPendientesLocalDbCubit>()
        .saveRecurrentMigranteEconomico(
          recurrenteMigranteEconomicoDbLocal:
              RecurrenteMigranteEconomicoDbLocal()
                ..tipoSolicitud = state.tipoSoliictud
                ..database = LocalStorage().database
                ..objSolicitudRecurrenteId = state.objSolicitudRecurrenteId
                ..tieneTrabajo = state.tieneTrabajo
                ..trabajoNegocioDescripcion = state.trabajoNegocioDescripcion
                ..tiempoActividad = state.tiempoActividad
                ..numeroHijos = state.numeroHijos
                ..edadHijos = state.edadHijos
                ..tipoEstudioHijos = state.tipoEstudioHijos
                ..otrosIngresos = state.otrosIngresos
                ..otrosIngresosDescripcion = state.otrosIngresosDescripcion
                ..personasCargo = state.personasCargo
                ..motivoPrestamo = state.motivoPrestamo
                ..objSolicitudRecurrenteId = state.objSolicitudRecurrenteId
                ..coincideRespuesta = state.coincideRespuesta
                ..explicacionInversion = state.explicacionInversion
                ..apoyanNegocio = state.apoyanNegocio
                ..quienApoya = state.quienApoya
                ..cuantosApoyan = state.cuantosApoyan
                ..mejoraCondiciones = state.mejoraCondiciones
                ..explicacionMejoraCondiciones =
                    state.explicacionMejoraCondiciones
                ..siguienteMeta = state.siguienteMeta,
        );
    // Sin conexión, `KivaEnvioScreen` muestra "Guardado en el teléfono".
  }
}

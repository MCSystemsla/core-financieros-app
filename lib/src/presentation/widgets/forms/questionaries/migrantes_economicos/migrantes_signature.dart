import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/kiva/kiva_file.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/migrante_economico/migrante_economico_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/forms/migrante_economico/recurrente_migrante_economico_db_local.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/migrantes_economicos/migrantes_economicos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_image_sending/kiva_image_sending.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/no_internet_popup_onkiva.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_firma_widgets.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_form_widgets.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/custom_pop_up.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final controller = SignatureController();
    final imageProvider = context.watch<UploadUserFileCubit>().state;
    final isConnected = context.read<InternetConnectionCubit>().state;
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
            KivaFirmaLienzo(controller: controller),
            const Gap(16),
            BlocConsumer<MigrantesEconomicosCubit, MigrantesEconomicosState>(
              listener: (context, state) async {
                final status = state.status;
                if (status == Status.error) {
                  CustomAlertDialog(
                    context: context,
                    title: state.errorMsg,
                    onDone: () => context.pop(),
                  ).showDialog(context, dialogType: DialogType.error);
                }
                if (state.status == Status.done) {
                  final signatureImage = await controller.toPngBytes();
                  final directory = await getApplicationDocumentsDirectory();
                  final filePath = '${directory.path}/signature.png';

                  // Guarda la imagen en el archivo
                  final file = File(filePath);
                  await file.writeAsBytes(signatureImage!);
                  if (!context.mounted) return;

                  await customPopUp(
                    context: context,
                    size: size,
                    title: 'Formulario Kiva Enviado exitosamente!!',
                    subtitle: 'Las respuestas se han enviado Exitosamente',
                    dialogType: DialogType.success,
                    buttonAcept: true,
                    textButtonAcept: 'Ok',
                    colorButtonAcept: AppColors.getPrimaryColor(),
                    onPressedAccept: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => BlocProvider.value(
                            value: context.read<UploadUserFileCubit>(),
                            child: KivaImageSending(
                              solicitudId: context
                                  .read<KivaRouteCubit>()
                                  .state
                                  .solicitudId,
                              onRetry: () {
                                context
                                    .read<UploadUserFileCubit>()
                                    .uploadUserFiles(
                                      typeSigner: typeSigner,
                                      cedula: context
                                          .read<KivaRouteCubit>()
                                          .state
                                          .cedula,
                                      numero: context
                                          .read<KivaRouteCubit>()
                                          .state
                                          .numero,
                                      tipoSolicitud: context
                                          .read<KivaRouteCubit>()
                                          .state
                                          .tipoSolicitud,
                                      fotoFirma: file.path,
                                      solicitudId: int.parse(
                                        context
                                            .read<KivaRouteCubit>()
                                            .state
                                            .solicitudId,
                                      ),
                                      formularioKiva: context
                                          .read<KivaRouteCubit>()
                                          .state
                                          .nombreFormularioKiva,
                                    );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                return KivaFirmaAcciones(
                  enviando: state.status == Status.inProgress,
                  onRegresar: () => widget.controller.previousPage(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeIn,
                  ),
                  onEnviar: () async {
                    await customPopUp(
                      context: context,
                      size: size,
                      title:
                          'Confirmas que has leido y confirmado el Formulario Kiva?',
                      dialogType: DialogType.warning,
                      buttonAcept: true,
                      buttonCancel: true,
                      colorButtonCancel: AppColors.red,
                      textButtonAcept: 'Aceptar',
                      textButtonCancel: 'Cancelar',
                      colorButtonAcept: AppColors.getPrimaryColor(),
                      onPressedAccept: () async {
                        context
                            .read<SolicitudesPendientesLocalDbCubit>()
                            .updateIsSendedOnSolicitud(
                              solicitudId: context
                                  .read<KivaRouteCubit>()
                                  .state
                                  .solicitudId,
                            );
                        final localPath = await KivaFile.saveImageSignature(
                          controller: controller,
                          numeroSoicitud:
                              context.read<KivaRouteCubit>().state.numero,
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
                          '',
                        );
                        if (!context.mounted) return;
                        if (isConnected.isConnected) {
                          context
                              .read<MigrantesEconomicosCubit>()
                              .sendMigrantesEconomicos();
                        }
                        context.pop();
                      },
                      onPressedCancel: () => context.pop(),
                    );
                  },
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  saveAnswersOnLocalDB(
    BuildContext context,
    MigrantesEconomicosState state,
    ImageModel imageModel,
    String msgDialog,
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
    final statusConnection =
        context.read<InternetConnectionCubit>().state.connectionStatus;
    final isOffline = statusConnection == ConnectionStatus.disconnected ||
        statusConnection == ConnectionStatus.handleOfflineActivation;
    if (isOffline) {
      if (!context.mounted) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        NoInternetPopUpOnKiva(
          context: context,
          header: '',
        ).showDialog(context, dialogType: DialogType.info);
      });
    }
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final controller = SignatureController();
    final imageProvider = context.watch<UploadUserFileCubit>().state;
    final isConnected = context.read<InternetConnectionCubit>().state;
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
            KivaFirmaLienzo(controller: controller),
            const Gap(16),
            BlocConsumer<RecurrenteMigrantesEconomicosCubit,
                RecurrenteMigrantesEconomicosState>(
              listener: (context, state) async {
                final status = state.status;
                if (status == Status.error) {
                  CustomAlertDialog(
                    context: context,
                    title: state.errorMsg,
                    onDone: () => context.pop(),
                  ).showDialog(context, dialogType: DialogType.error);
                }
                if (state.status == Status.done) {
                  final signatureImage = await controller.toPngBytes();
                  final directory = await getApplicationDocumentsDirectory();
                  final filePath = '${directory.path}/signature.png';

                  // Guarda la imagen en el archivo
                  final file = File(filePath);
                  await file.writeAsBytes(signatureImage!);
                  if (!context.mounted) return;

                  await customPopUp(
                    context: context,
                    size: size,
                    title: 'Formulario Kiva Enviado exitosamente!!',
                    subtitle: 'Las respuestas se han enviado Exitosamente',
                    dialogType: DialogType.success,
                    buttonAcept: true,
                    textButtonAcept: 'Ok',
                    colorButtonAcept: AppColors.getPrimaryColor(),
                    onPressedAccept: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => BlocProvider.value(
                            value: context.read<UploadUserFileCubit>(),
                            child: KivaImageSending(
                              solicitudId: context
                                  .read<KivaRouteCubit>()
                                  .state
                                  .solicitudId,
                              onRetry: () {
                                context
                                    .read<UploadUserFileCubit>()
                                    .uploadUserFiles(
                                      typeSigner: typeSigner,
                                      cedula: context
                                          .read<KivaRouteCubit>()
                                          .state
                                          .cedula,
                                      numero: context
                                          .read<KivaRouteCubit>()
                                          .state
                                          .numero,
                                      tipoSolicitud: context
                                          .read<KivaRouteCubit>()
                                          .state
                                          .tipoSolicitud,
                                      fotoFirma: file.path,
                                      solicitudId: int.parse(
                                        context
                                            .read<KivaRouteCubit>()
                                            .state
                                            .solicitudId,
                                      ),
                                      formularioKiva: context
                                          .read<KivaRouteCubit>()
                                          .state
                                          .nombreFormularioKiva,
                                    );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                return KivaFirmaAcciones(
                  enviando: state.status == Status.inProgress,
                  onRegresar: () => widget.controller.previousPage(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeIn,
                  ),
                  onEnviar: () async {
                    await customPopUp(
                      context: context,
                      size: size,
                      title:
                          'Confirmas que has leido y confirmado el Formulario Kiva?',
                      dialogType: DialogType.warning,
                      buttonAcept: true,
                      buttonCancel: true,
                      colorButtonCancel: AppColors.red,
                      textButtonAcept: 'Aceptar',
                      textButtonCancel: 'Cancelar',
                      colorButtonAcept: AppColors.getPrimaryColor(),
                      onPressedAccept: () async {
                        context
                            .read<SolicitudesPendientesLocalDbCubit>()
                            .updateIsSendedOnSolicitud(
                              solicitudId: context
                                  .read<KivaRouteCubit>()
                                  .state
                                  .solicitudId,
                            );
                        final localPath = await KivaFile.saveImageSignature(
                          controller: controller,
                          numeroSoicitud:
                              context.read<KivaRouteCubit>().state.numero,
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
                          '',
                        );
                        if (!context.mounted) return;
                        if (isConnected.isConnected) {
                          context
                              .read<RecurrenteMigrantesEconomicosCubit>()
                              .sendAnswers();
                        }
                        context.pop();
                      },
                      onPressedCancel: () => context.pop(),
                    );
                  },
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  saveAnswersOnLocalDB(
    BuildContext context,
    RecurrenteMigrantesEconomicosState state,
    ImageModel imageModel,
    String msgDialog,
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
    final statusConnection =
        context.read<InternetConnectionCubit>().state.connectionStatus;
    final isOffline = statusConnection == ConnectionStatus.disconnected ||
        statusConnection == ConnectionStatus.handleOfflineActivation;
    if (isOffline) {
      if (!context.mounted) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        NoInternetPopUpOnKiva(
          context: context,
          header: '',
        ).showDialog(context, dialogType: DialogType.info);
      });
    }
  }
}

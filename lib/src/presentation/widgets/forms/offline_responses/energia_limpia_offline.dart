import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/datasource/forms/energia_limpia/energia_limpia_model.dart';
import 'package:core_financiero_app/src/datasource/forms/energia_limpia/recurrente_energia_limpia.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/energia_limpia/energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/shared/kiva_respuestas_offline_widgets.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class EnergiaLImpiaOffline extends StatefulWidget {
  final int solicitudId;
  final bool needGoBack;
  const EnergiaLImpiaOffline({
    super.key,
    required this.solicitudId,
    this.needGoBack = false,
  });

  @override
  State<EnergiaLImpiaOffline> createState() => _EnergiaLImpiaOfflineState();
}

class _EnergiaLImpiaOfflineState extends State<EnergiaLImpiaOffline> {
  ImageModel? imageModel;
  bool? _respuestasEncontradas;
  @override
  void initState() {
    super.initState();
    initFunctions();
  }

  Future<void> initFunctions() async {
    final solicitudesProvider =
        context.read<SolicitudesPendientesLocalDbCubit>();
    imageModel = await solicitudesProvider.getImagesModel(widget.solicitudId);
    final respuestas =
        await solicitudesProvider.getEnergiaLimpia(widget.solicitudId);
    if (!mounted) return;
    setState(() => _respuestasEncontradas = respuestas != null);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, state) {
        return BlocConsumer<EnergiaLimpiaCubit, EnergiaLimpiaState>(
          listener: (context, status) async {
            if (status.status == Status.error) {
              CustomAlertDialog(
                context: context,
                title: status.errorMsg,
                onDone: () => context.pop(),
              ).showDialog(context, dialogType: DialogType.error);
            }
            if (status.status == Status.done) {
              final imagesSended = await context
                  .read<UploadUserFileCubit>()
                  .uploadUserFilesOffline(
                    typeSigner: imageModel?.typeSigner ?? '',
                    cedula: context.read<KivaRouteCubit>().state.cedula,
                    numero: context.read<KivaRouteCubit>().state.numero,
                    tipoSolicitud:
                        context.read<KivaRouteCubit>().state.tipoSolicitud,
                    imagen1: imageModel?.imagen1 ?? 'NO PATH',
                    imagen2: imageModel?.imagen2 ?? 'NO PATH',
                    imagen3: imageModel?.imagen3 ?? 'NO PATH',
                    fotoFirma: imageModel?.imagenFirma ?? 'NO PATH',
                    solicitudId: widget.solicitudId,
                    formularioKiva: context
                        .read<KivaRouteCubit>()
                        .state
                        .nombreFormularioKiva,
                  );
              if (imagesSended && context.mounted) {
                await context
                    .read<SolicitudesPendientesLocalDbCubit>()
                    .updateIsImagesSendedOnSolicitud(
                      solicitudId: widget.solicitudId.toString(),
                    );
              }
              // context
              //     .read<SolicitudesPendientesLocalDbCubit>()
              //     .removeWhenFormIsUpload(
              //       widget.solicitudId,
              //       context.read<KivaRouteCubit>().state.currentRoute,
              //     );
              if (!context.mounted) return;

              await mostrarKivaEnviadoDialog(
                context: context,
                imagenesEnviadas: imagesSended,
                needGoBack: widget.needGoBack,
              );
            }
          },
          builder: (context, response) {
            return KivaRespuestasBody(
              encontradas: _respuestasEncontradas,
              child: KivaRespuestasScroll(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    KivaRespuestaWidget(
                      title: '¿Tiene otros ingresos?¿Cuales?*',
                      initialValue:
                          state.energiaLimpiaDbLocal?.otrosIngresos ?? false
                              ? 'input.yes'.tr()
                              : 'input.no'.tr(),
                    ),
                    KivaRespuestaWidget(
                      title: 'Cuales Otros Ingresos?',
                      initialValue: state
                              .energiaLimpiaDbLocal?.otrosIngresosDescripcion ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: 'Su comunidad es:',
                      initialValue:
                          state.energiaLimpiaDbLocal?.objTipoComunidadId ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿Usted tiene problemas de energía eléctrica en su comunidad?',
                      initialValue:
                          state.energiaLimpiaDbLocal?.tieneProblemasEnergia ??
                                  false
                              ? 'input.yes'.tr()
                              : 'input.no'.tr(),
                    ),
                    KivaRespuestaWidget(
                      title: 'Cantidad de hijos:*',
                      initialValue:
                          state.energiaLimpiaDbLocal?.numeroHijos.toString() ??
                              '0',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Qué edades tienen sus hijos?',
                      initialValue:
                          state.energiaLimpiaDbLocal?.edadHijos ?? 'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Qué tipo de estudios reciben sus hijos?',
                      initialValue:
                          state.energiaLimpiaDbLocal?.tipoEstudioHijos ?? 'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿Por qué y para qué solicitó el préstamo? Explique.*',
                      initialValue:
                          state.energiaLimpiaDbLocal?.motivoPrestamo ?? 'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Cuáles son sus planes para los próximos años?',
                      initialValue:
                          state.energiaLimpiaDbLocal?.planesFuturo ?? 'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          'Otros datos relevantes e interesantes del cliente',
                      initialValue:
                          state.energiaLimpiaDbLocal?.otrosDatosCliente ??
                              'N/A',
                    ),
                    BlocBuilder<UploadUserFileCubit, UploadUserFileState>(
                      builder: (context, imageState) {
                        return KivaEnviarActions(
                          disabled: state.status == Status.inProgress ||
                              response.status == Status.inProgress ||
                              imageState.status == Status.inProgress,
                          onPreviousPressed: () {
                            context.pop();
                          },
                          onNextPressed: () {
                            context
                                .read<EnergiaLimpiaCubit>()
                                .sendOfflineAnswers(
                                  energiaLimpia: EnergiaLimpiaModel(
                                    tipoSolicitud: state.energiaLimpiaDbLocal
                                            ?.tipoSolicitud ??
                                        '',
                                    problemasEnergiaDescripcion: state
                                            .energiaLimpiaDbLocal
                                            ?.problemasEnergiaDescripcion ??
                                        '',
                                    database:
                                        state.energiaLimpiaDbLocal?.database ??
                                            '',
                                    solicitudNuevamenorId: state
                                            .energiaLimpiaDbLocal
                                            ?.solicitudNuevamenorId ??
                                        0,
                                    tieneTrabajo: state.energiaLimpiaDbLocal
                                            ?.tieneTrabajo ??
                                        false,
                                    trabajoNegocioDescripcion: state
                                            .energiaLimpiaDbLocal
                                            ?.trabajoNegocioDescripcion ??
                                        '',
                                    tiempoActividad: state.energiaLimpiaDbLocal
                                            ?.tiempoActividad ??
                                        0,
                                    otrosIngresos: state.energiaLimpiaDbLocal
                                            ?.otrosIngresos ??
                                        false,
                                    otrosIngresosDescripcion: state
                                            .energiaLimpiaDbLocal
                                            ?.otrosIngresosDescripcion ??
                                        '',
                                    objOrigenCatalogoValorId: state
                                            .energiaLimpiaDbLocal
                                            ?.objOrigenCatalogoValorId ??
                                        '',
                                    objTipoComunidadId: state
                                            .energiaLimpiaDbLocal
                                            ?.objTipoComunidadId ??
                                        '',
                                    tieneProblemasEnergia: state
                                            .energiaLimpiaDbLocal
                                            ?.tieneProblemasEnergia ??
                                        false,
                                    personasCargo: state.energiaLimpiaDbLocal
                                            ?.personasCargo ??
                                        '',
                                    numeroHijos: state.energiaLimpiaDbLocal
                                            ?.numeroHijos ??
                                        0,
                                    edadHijos:
                                        state.energiaLimpiaDbLocal?.edadHijos ??
                                            '',
                                    tipoEstudioHijos: state.energiaLimpiaDbLocal
                                            ?.tipoEstudioHijos ??
                                        '',
                                    motivoPrestamo: state.energiaLimpiaDbLocal
                                            ?.motivoPrestamo ??
                                        '',
                                    planesFuturo: state.energiaLimpiaDbLocal
                                            ?.planesFuturo ??
                                        '',
                                    otrosDatosCliente: state
                                            .energiaLimpiaDbLocal
                                            ?.otrosDatosCliente ??
                                        '',
                                  ),
                                );
                          },
                          previousTitle: 'button.previous'.tr(),
                          nextTitle: 'Enviar'.tr(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class RecurrenteEnergiaLimpiaOffline extends StatefulWidget {
  final int solicitudId;
  final bool needGoBack;
  const RecurrenteEnergiaLimpiaOffline({
    super.key,
    required this.solicitudId,
    this.needGoBack = false,
  });

  @override
  State<RecurrenteEnergiaLimpiaOffline> createState() =>
      _RecurrenteEnergiaLimpiaOfflineState();
}

class _RecurrenteEnergiaLimpiaOfflineState
    extends State<RecurrenteEnergiaLimpiaOffline> {
  ImageModel? imageModel;
  bool? _respuestasEncontradas;
  @override
  void initState() {
    super.initState();
    initFunctions();
  }

  Future<void> initFunctions() async {
    final solicitudesProvider =
        context.read<SolicitudesPendientesLocalDbCubit>();
    imageModel = await solicitudesProvider.getImagesModel(widget.solicitudId);
    final respuestas = await solicitudesProvider
        .getEnergiaLimpiaRecurrente(widget.solicitudId);
    if (!mounted) return;
    setState(() => _respuestasEncontradas = respuestas != null);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, state) {
        return BlocConsumer<RecurrenteEnergiaLimpiaCubit,
            RecurrenteEnergiaLimpiaState>(
          listener: (context, status) async {
            if (status.status == Status.error) {
              CustomAlertDialog(
                context: context,
                title: status.errorMsg,
                onDone: () => context.pop(),
              ).showDialog(context, dialogType: DialogType.error);
            }
            if (status.status == Status.done) {
              final imagesSended = await context
                  .read<UploadUserFileCubit>()
                  .uploadUserFilesOffline(
                    typeSigner: imageModel?.typeSigner ?? '',
                    cedula: context.read<KivaRouteCubit>().state.cedula,
                    numero: context.read<KivaRouteCubit>().state.numero,
                    tipoSolicitud:
                        context.read<KivaRouteCubit>().state.tipoSolicitud,
                    imagen1: imageModel?.imagen1 ?? 'NO PATH',
                    imagen2: imageModel?.imagen2 ?? 'NO PATH',
                    imagen3: imageModel?.imagen3 ?? 'NO PATH',
                    fotoFirma: imageModel?.imagenFirma ?? 'NO PATH',
                    solicitudId: widget.solicitudId,
                    formularioKiva: context
                        .read<KivaRouteCubit>()
                        .state
                        .nombreFormularioKiva,
                  );
              if (imagesSended && context.mounted) {
                await context
                    .read<SolicitudesPendientesLocalDbCubit>()
                    .updateIsImagesSendedOnSolicitud(
                      solicitudId: widget.solicitudId.toString(),
                    );
              }
              // context
              //     .read<SolicitudesPendientesLocalDbCubit>()
              //     .removeWhenFormIsUpload(
              //       widget.solicitudId,
              //       context.read<KivaRouteCubit>().state.currentRoute,
              //     );
              if (!context.mounted) return;

              await mostrarKivaEnviadoDialog(
                context: context,
                imagenesEnviadas: imagesSended,
                needGoBack: widget.needGoBack,
              );
            }
          },
          builder: (context, response) {
            return KivaRespuestasBody(
              encontradas: _respuestasEncontradas,
              child: KivaRespuestasScroll(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    KivaRespuestaWidget(
                      title: 'Tiene otros ingresos?¿Cuales?*',
                      initialValue:
                          state.recurrenteEnergiaLimpiaDbLocal?.otrosIngresos ??
                                  false
                              ? 'input.yes'.tr()
                              : 'input.no'.tr(),
                    ),
                    KivaRespuestaWidget(
                      title: 'Ingrese los otros ingresos',
                      initialValue: state.recurrenteEnergiaLimpiaDbLocal
                              ?.otrosIngresosDescripcion ??
                          'N/A',
                    ),
                    const Gap(10),
                    KivaRespuestaWidget(
                      title: 'Su comunidad es:',
                      initialValue: state.recurrenteEnergiaLimpiaDbLocal
                              ?.objTipoComunidadId ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿Usted tiene problemas de energía eléctrica en su comunidad?',
                      initialValue: state.recurrenteEnergiaLimpiaDbLocal
                                  ?.tieneProblemasEnergia ??
                              false
                          ? 'input.yes'.tr()
                          : 'input.no'.tr(),
                    ),
                    KivaRespuestaWidget(
                      title: 'Cantidad de hijos:*',
                      initialValue: state
                              .recurrenteEnergiaLimpiaDbLocal?.numeroHijos
                              .toString() ??
                          '0',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Qué edades tienen sus hijos?',
                      initialValue:
                          state.recurrenteEnergiaLimpiaDbLocal?.edadHijos ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Qué tipo de estudios reciben sus hijos?',
                      initialValue: state.recurrenteEnergiaLimpiaDbLocal
                              ?.tipoEstudioHijos ??
                          'N/A',
                    ),
                    const KivaRespuestaWidget(
                        title:
                            '¿Coincide la respuesta del cliente con el formato anterior?'),
                    KivaRespuestaWidget(
                      title:
                          '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                      initialValue: state.recurrenteEnergiaLimpiaDbLocal
                              ?.explicacionInversion ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿Cómo era su situación antes de adquirir esta solución energética y cómo es ahora ?',
                      initialValue: state.recurrenteEnergiaLimpiaDbLocal
                              ?.situacionAntesAhora ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿En qué piensa invertir este nuevo crédito de energía limpia?* Explique',
                      initialValue: state
                              .recurrenteEnergiaLimpiaDbLocal?.motivoPrestamo ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿Cómo cree usted que este nuevo préstamo vaya a mejorar su situación y la de su familia?*',
                      initialValue: state.recurrenteEnergiaLimpiaDbLocal
                              ?.comoMejoraSituacion ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿Quién o quiénes le estarían apoyando en esta nueva inversión?*',
                      initialValue:
                          state.recurrenteEnergiaLimpiaDbLocal?.quienApoya ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          'Una vez finalizado este préstamo ¿Cuál sería su siguiente meta?',
                      initialValue:
                          state.recurrenteEnergiaLimpiaDbLocal?.siguienteMeta ??
                              'N/A',
                    ),
                    BlocBuilder<UploadUserFileCubit, UploadUserFileState>(
                      builder: (context, imageState) {
                        return KivaEnviarActions(
                          disabled: state.status == Status.inProgress ||
                              response.status == Status.inProgress ||
                              imageState.status == Status.inProgress,
                          onPreviousPressed: () {
                            context.pop();
                          },
                          onNextPressed: () {
                            context
                                .read<RecurrenteEnergiaLimpiaCubit>()
                                .sendOfflineAnswers(
                                  recurrenteEnergiaLimpia:
                                      RecurrenteEnergiaLimpiaModel(
                                    tipoSolicitud: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.tipoSolicitud ??
                                        '',
                                    problemasEnergiaDescripcion: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.problemasEnergiaDescripcion ??
                                        '',
                                    database: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.database ??
                                        '',
                                    tieneTrabajo: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.tieneTrabajo ??
                                        false,
                                    trabajoNegocioDescripcion: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.trabajoNegocioDescripcion ??
                                        '',
                                    tiempoActividad: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.tiempoActividad ??
                                        0,
                                    otrosIngresos: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.otrosIngresos ??
                                        false,
                                    otrosIngresosDescripcion: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.otrosIngresosDescripcion ??
                                        '',
                                    objTipoComunidadId: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.objTipoComunidadId ??
                                        '',
                                    tieneProblemasEnergia: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.tieneProblemasEnergia ??
                                        false,
                                    personasCargo: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.personasCargo ??
                                        '',
                                    numeroHijos: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.numeroHijos ??
                                        0,
                                    edadHijos: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.edadHijos ??
                                        '',
                                    tipoEstudioHijos: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.tipoEstudioHijos ??
                                        '',
                                    motivoPrestamo: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.motivoPrestamo ??
                                        '',
                                    objSolicitudRecurrenteId: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.objSolicitudRecurrenteId ??
                                        0,
                                    coincideRespuesta: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.coincideRespuesta ??
                                        false,
                                    explicacionInversion: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.explicacionInversion ??
                                        '',
                                    situacionAntesAhora: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.situacionAntesAhora ??
                                        '',
                                    comoMejoraSituacion: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.comoMejoraSituacion ??
                                        '',
                                    quienApoya: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.quienApoya ??
                                        '',
                                    siguienteMeta: state
                                            .recurrenteEnergiaLimpiaDbLocal
                                            ?.siguienteMeta ??
                                        '',
                                  ),
                                );
                          },
                          previousTitle: 'button.previous'.tr(),
                          nextTitle: 'Enviar'.tr(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

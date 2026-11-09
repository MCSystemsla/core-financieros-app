import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/datasource/forms/mujer_emprende/mujer_emprende_model.dart';
import 'package:core_financiero_app/src/datasource/forms/mujer_emprende/recurrente_mujer_emprende.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/mujer_emprende/mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_mujer_emprende/recurrente_mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/shared/kiva_respuestas_offline_widgets.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class MujerEmprendeOffline extends StatefulWidget {
  final int solicitudId;
  final bool needGoBack;
  const MujerEmprendeOffline({
    super.key,
    required this.solicitudId,
    this.needGoBack = false,
  });

  @override
  State<MujerEmprendeOffline> createState() => _MujerEmprendeOfflineState();
}

class _MujerEmprendeOfflineState extends State<MujerEmprendeOffline> {
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
        await solicitudesProvider.getMujerEmprende(widget.solicitudId);
    if (!mounted) return;
    setState(() => _respuestasEncontradas = respuestas != null);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, state) {
        return BlocConsumer<MujerEmprendeCubit, MujerEmprendeState>(
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
                    const Gap(10),
                    KivaRespuestaWidget(
                      initialValue:
                          state.mujerEmprendeDbLocal?.otrosIngresos ?? false
                              ? 'input.yes'.tr()
                              : 'input.no'.tr(),
                      title: '¿Tiene otros ingresos?¿Cuales?*',
                    ),
                    KivaRespuestaWidget(
                      title: 'Cuales',
                      initialValue: state
                              .mujerEmprendeDbLocal?.otrosIngresosDescripcion ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: 'forms.entorno_familiar.person_origin'.tr(),
                      initialValue: state
                              .mujerEmprendeDbLocal?.objOrigenCatalogoValorId ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: 'Número de personas a cargo:*',
                      initialValue: state.mujerEmprendeDbLocal?.personasCargo
                              .toString() ??
                          '0',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Que edades tienen sus hijos?',
                      initialValue:
                          state.mujerEmprendeDbLocal?.edadHijos ?? '0',
                    ),
                    KivaRespuestaWidget(
                      title: 'Cantidad de hijos:*',
                      initialValue:
                          state.mujerEmprendeDbLocal?.numeroHijos.toString() ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      initialValue:
                          state.mujerEmprendeDbLocal?.tipoEstudioHijos ?? 'N/A',
                      title: '¿Qué tipo de estudios reciben sus hijos?',
                    ),
                    KivaRespuestaWidget(
                      title:
                          'Cuéntenos, ¿Qué la motivó a emprender su negocio?*',
                      initialValue:
                          state.mujerEmprendeDbLocal?.motivoEmprender ?? 'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          'Coméntenos, ¿ Cómo conoció el proyecto de Mujer Emprende en MiCrédito?',
                      initialValue:
                          state.mujerEmprendeDbLocal?.conocioMujerEmprende ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Qué la impulsó a optar a este tipo de crédito?*',
                      initialValue:
                          state.mujerEmprendeDbLocal?.impulsoOptar ?? 'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Para qué solicitó este préstamo?* Explique',
                      initialValue:
                          state.mujerEmprendeDbLocal?.motivoPrestamo ?? 'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿Quién o quiénes le estarían apoyando en su emprendimiento?*',
                      initialValue:
                          state.mujerEmprendeDbLocal?.quienApoya ?? 'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿De qué manera este financiamiento va impactar en su negocio ?*',
                      initialValue:
                          state.mujerEmprendeDbLocal?.comoImpactariaNegocio ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿Cómo cree usted que este crédito va a mejorar su calidad de vida?*',
                      initialValue:
                          state.mujerEmprendeDbLocal?.comoMejoraCalidadVida ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          'Otros datos relevantes e interesantes del cliente',
                      initialValue:
                          state.mujerEmprendeDbLocal?.otrosDatosCliente ??
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
                                .read<MujerEmprendeCubit>()
                                .sendOfflineAnswers(
                                  mujerEmprendeModel: MujerEmprendeModel(
                                    tipoSolicitud: state.mujerEmprendeDbLocal
                                            ?.tipoSolicitud ??
                                        '',
                                    tiempoActividad: state.mujerEmprendeDbLocal
                                            ?.tiempoActividad ??
                                        0,
                                    tieneTrabajo: state.mujerEmprendeDbLocal
                                            ?.tieneTrabajo ??
                                        false,
                                    trabajoNegocioDescripcion: state
                                            .mujerEmprendeDbLocal
                                            ?.trabajoNegocioDescripcion ??
                                        '',
                                    database:
                                        state.mujerEmprendeDbLocal?.database ??
                                            '',
                                    objSolicitudNuevamenorId: state
                                            .mujerEmprendeDbLocal
                                            ?.objSolicitudNuevamenorId ??
                                        0,
                                    otrosIngresos: state.mujerEmprendeDbLocal
                                            ?.otrosIngresos ??
                                        false,
                                    otrosIngresosDescripcion: state
                                            .mujerEmprendeDbLocal
                                            ?.otrosIngresosDescripcion ??
                                        '',
                                    objOrigenCatalogoValorId: state
                                            .mujerEmprendeDbLocal
                                            ?.objOrigenCatalogoValorId ??
                                        '',
                                    personasCargo: state.mujerEmprendeDbLocal
                                            ?.personasCargo ??
                                        0,
                                    numeroHijos: state.mujerEmprendeDbLocal
                                            ?.numeroHijos ??
                                        0,
                                    edadHijos:
                                        state.mujerEmprendeDbLocal?.edadHijos ??
                                            '',
                                    tipoEstudioHijos: state.mujerEmprendeDbLocal
                                            ?.tipoEstudioHijos ??
                                        '',
                                    motivoEmprender: state.mujerEmprendeDbLocal
                                            ?.motivoEmprender ??
                                        '',
                                    conocioMujerEmprende: state
                                            .mujerEmprendeDbLocal
                                            ?.conocioMujerEmprende ??
                                        '',
                                    impulsoOptar: state.mujerEmprendeDbLocal
                                            ?.impulsoOptar ??
                                        '',
                                    motivoPrestamo: state.mujerEmprendeDbLocal
                                            ?.motivoPrestamo ??
                                        '',
                                    quienApoya: state
                                            .mujerEmprendeDbLocal?.quienApoya ??
                                        '',
                                    comoImpactariaNegocio: state
                                            .mujerEmprendeDbLocal
                                            ?.comoImpactariaNegocio ??
                                        '',
                                    comoMejoraCalidadVida: state
                                            .mujerEmprendeDbLocal
                                            ?.comoMejoraCalidadVida ??
                                        '',
                                    otrosDatosCliente: state
                                            .mujerEmprendeDbLocal
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

class RecurrenteMujerEmprendeOffline extends StatefulWidget {
  final int solicitudId;
  final bool needGoBack;
  const RecurrenteMujerEmprendeOffline({
    super.key,
    required this.solicitudId,
    this.needGoBack = false,
  });

  @override
  State<RecurrenteMujerEmprendeOffline> createState() =>
      _RecurrenteMujerEmprendeOfflineState();
}

class _RecurrenteMujerEmprendeOfflineState
    extends State<RecurrenteMujerEmprendeOffline> {
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
    final respuestas =
        await solicitudesProvider.getRecurrentMujerEmprende(widget.solicitudId);
    imageModel = await solicitudesProvider.getImagesModel(widget.solicitudId);
    if (!mounted) return;
    setState(() => _respuestasEncontradas = respuestas != null);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, state) {
        return BlocConsumer<RecurrenteMujerEmprendeCubit,
            RecurrenteMujerEmprendeState>(
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
                    const Gap(10),
                    KivaRespuestaWidget(
                      initialValue:
                          state.recurrenteMujerEmprende?.otrosIngresos ?? false
                              ? 'input.yes'.tr()
                              : 'input.no'.tr(),
                      title: '¿Tiene otros ingresos?¿Cuales?*',
                    ),
                    KivaRespuestaWidget(
                      title: 'Cuales?',
                      initialValue: state.recurrenteMujerEmprende
                              ?.otrosIngresosDescripcion ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: 'Cantidad de hijos:*',
                      initialValue: state.recurrenteMujerEmprende?.numeroHijos
                              .toString() ??
                          '0',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Que edades tienen sus hijos?',
                      initialValue:
                          state.recurrenteMujerEmprende?.edadHijos ?? 'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Qué tipo de estudios reciben sus hijos?',
                      initialValue:
                          state.recurrenteMujerEmprende?.edadHijos ?? 'N/A',
                    ),
                    KivaRespuestaWidget(
                      initialValue:
                          state.recurrenteMujerEmprende?.coincideRespuesta ??
                                  false
                              ? 'input.yes'.tr()
                              : 'input.no'.tr(),
                      title:
                          '¿Coincide la respuesta del cliente con el formato anterior?',
                    ),
                    KivaRespuestaWidget(
                      initialValue:
                          state.recurrenteMujerEmprende?.explicacionInversion ??
                              'N/A',
                      title:
                          '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                    ),
                    KivaRespuestaWidget(
                      title: '¿De qué manera le ayudó este préstamo Kiva?*',
                      initialValue:
                          state.recurrenteMujerEmprende?.comoAyudo ?? 'N/A',
                    ),
                    KivaRespuestaWidget(
                      initialValue:
                          state.recurrenteMujerEmprende?.motivoPrestamo ??
                              'N/A',
                      title:
                          '¿En qué piensa invertir este nuevo préstamo de Mujer Emprende?* Explique',
                    ),
                    KivaRespuestaWidget(
                      initialValue:
                          state.recurrenteMujerEmprende?.apoyanNegocio ?? false
                              ? 'input.yes'.tr()
                              : 'input.no'.tr(),
                      title: '¿Hay alguien que le apoye en su negocio?'.tr(),
                    ),
                    KivaRespuestaWidget(
                      initialValue:
                          state.recurrenteMujerEmprende?.cuantosApoyan ?? 'N/A',
                      title: 'De ser positivo, favor responder cuántas personas'
                          .tr(),
                    ),
                    KivaRespuestaWidget(
                        initialValue:
                            state.recurrenteMujerEmprende?.mejoraraEntorno ??
                                    false
                                ? 'input.yes'.tr()
                                : 'input.no'.tr(),
                        title:
                            '¿Considera usted que este nuevo préstamo fortalezca su negocio, mejore sus condiciones de vida y entorno familiar?'),
                    KivaRespuestaWidget(
                      title: '¿Porqué?*',
                      initialValue: state.recurrenteMujerEmprende
                              ?.mejoraraEntornoExplicacion ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: 'A futuro ¿Cuál sería su siguiente paso?',
                      initialValue:
                          state.recurrenteMujerEmprende?.siguientePaso ?? 'N/A',
                    ),
                    KivaRespuestaWidget(
                        initialValue:
                            state.recurrenteMujerEmprende?.alcanzaraMeta ??
                                    false
                                ? 'input.yes'.tr()
                                : 'input.no'.tr(),
                        title:
                            '¿Cree usted que una vez finalizado el pago de este préstamo de Mujer Emprende alcanzó su meta?'),
                    KivaRespuestaWidget(
                      title: '¿Por qué?*',
                      initialValue: state.recurrenteMujerEmprende
                              ?.explicacionAlcanzaraMeta ??
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
                                .read<RecurrenteMujerEmprendeCubit>()
                                .sendOfflineAnswers(
                                  recurrenteMujerEmprende:
                                      RecurrenteMujerEmprendeModel(
                                    tipoSolicitud: state.recurrenteMujerEmprende
                                            ?.tipoSolicitud ??
                                        '',
                                    tiempoActividad: state
                                            .recurrenteMujerEmprende
                                            ?.tiempoActividad ??
                                        0,
                                    database: state.recurrenteMujerEmprende
                                            ?.database ??
                                        '',
                                    otrosIngresos: state.recurrenteMujerEmprende
                                            ?.otrosIngresos ??
                                        false,
                                    otrosIngresosDescripcion: state
                                            .recurrenteMujerEmprende
                                            ?.otrosIngresosDescripcion ??
                                        '',
                                    personasCargo: state.recurrenteMujerEmprende
                                            ?.personasCargo ??
                                        0,
                                    numeroHijos: state.recurrenteMujerEmprende
                                            ?.numeroHijos ??
                                        0,
                                    edadHijos: state.recurrenteMujerEmprende
                                            ?.edadHijos ??
                                        '',
                                    tipoEstudioHijos: state
                                            .recurrenteMujerEmprende
                                            ?.tipoEstudioHijos ??
                                        '',
                                    motivoPrestamo: state
                                            .recurrenteMujerEmprende
                                            ?.motivoPrestamo ??
                                        '',
                                    objSolicitudRecurrenteId: state
                                            .recurrenteMujerEmprende
                                            ?.objSolicitudRecurrenteId ??
                                        0,
                                    coincideRespuesta: state
                                            .recurrenteMujerEmprende
                                            ?.coincideRespuesta ??
                                        false,
                                    explicacionInversion: state
                                            .recurrenteMujerEmprende
                                            ?.explicacionInversion ??
                                        '',
                                    comoAyudo: state.recurrenteMujerEmprende
                                            ?.comoAyudo ??
                                        '',
                                    apoyanNegocio: state.recurrenteMujerEmprende
                                            ?.apoyanNegocio ??
                                        false,
                                    cuantosApoyan: state.recurrenteMujerEmprende
                                            ?.cuantosApoyan ??
                                        '',
                                    mejoraraEntorno: state
                                            .recurrenteMujerEmprende
                                            ?.mejoraraEntorno ??
                                        false,
                                    mejoraraEntornoExplicacion: state
                                            .recurrenteMujerEmprende
                                            ?.mejoraraEntornoExplicacion ??
                                        '',
                                    siguientePaso: state.recurrenteMujerEmprende
                                            ?.siguientePaso ??
                                        '',
                                    alcanzaraMeta: state.recurrenteMujerEmprende
                                            ?.alcanzaraMeta ??
                                        false,
                                    explicacionAlcanzaraMeta: state
                                            .recurrenteMujerEmprende
                                            ?.explicacionAlcanzaraMeta ??
                                        '',
                                    tieneTrabajo: state.recurrenteMujerEmprende
                                            ?.tieneTrabajo ??
                                        false,
                                    tieneTrabajoDescripcion: state
                                            .recurrenteMujerEmprende
                                            ?.tieneTrabajoDescripcion ??
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

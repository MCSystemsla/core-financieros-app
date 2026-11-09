import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/datasource/forms/estandar/estandar_model.dart';
import 'package:core_financiero_app/src/datasource/forms/estandar/recurrente_estandar_model.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/estandar/estandar_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_estandar/recurrente_estandart_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/shared/kiva_respuestas_offline_widgets.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EstandarOfflineForm extends StatefulWidget {
  final bool needGoBack;
  final String typeProduct;
  final int solicitudId;

  const EstandarOfflineForm({
    super.key,
    required this.typeProduct,
    required this.solicitudId,
    this.needGoBack = false,
  });

  @override
  State<EstandarOfflineForm> createState() => _EstandarOfflineFormState();
}

class _EstandarOfflineFormState extends State<EstandarOfflineForm> {
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
        await solicitudesProvider.getRecurrentEstandar(widget.solicitudId);
    if (!mounted) return;
    setState(() => _respuestasEncontradas = respuestas != null);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, resp) {
        return BlocConsumer<RecurrenteEstandartCubit, RecurrenteEstandartState>(
          listener: (context, state) async {
            if (state.status == Status.error) {
              CustomAlertDialog(
                context: context,
                title: state.erroMsg,
                onDone: () => context.pop(),
              ).showDialog(context, dialogType: DialogType.error);
            }
            if (state.status == Status.done) {
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

              if (!context.mounted) return;
              // context
              //     .read<SolicitudesPendientesLocalDbCubit>()
              //     .removeWhenFormIsUpload(
              //       widget.solicitudId,
              //       widget.typeProduct,
              //     );
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
                      initialValue: resp
                          .recurrenteEstandarDbLocal?.otrosIngresos
                          .toString(),
                    ),
                    KivaRespuestaWidget(
                      title: '¿Cuales?*',
                      initialValue: resp.recurrenteEstandarDbLocal
                              ?.otrosIngresosDescripcion ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: 'Cantidad de hijos:*',
                      initialValue: resp.recurrenteEstandarDbLocal?.numeroHijos
                              .toString() ??
                          '0',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Que edades tienen sus hijos?',
                      initialValue: resp.recurrenteEstandarDbLocal?.edadHijos
                              .toString() ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Qué tipo de estudios reciben sus hijos?',
                      initialValue: resp
                              .recurrenteEstandarDbLocal?.tipoEstudioHijos
                              .toString() ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿Coincide la respuesta del cliente con el formato anterior?',
                      initialValue: resp
                              .recurrenteEstandarDbLocal?.coincideRespuesta
                              .toString() ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          'Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                      initialValue: resp
                              .recurrenteEstandarDbLocal?.explicacionInversion
                              .toString() ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Hay alguien que le apoye en su negocio?',
                      initialValue: resp
                              .recurrenteEstandarDbLocal?.apoyanNegocio
                              .toString() ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          'De ser positivo, favor responder cuántas personas',
                      initialValue: resp
                              .recurrenteEstandarDbLocal?.cuantosApoyan
                              .toString() ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿Cómo este crédito ha constribuido a mejorar su calidad de vida y empoderarse de su negocio? Explique.',
                      initialValue: resp
                              .recurrenteEstandarDbLocal?.comoMejoraEntorno
                              .toString() ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿En qué piensa invertir este nuevo préstamo? Explique',
                      initialValue: resp
                              .recurrenteEstandarDbLocal?.motivoPrestamo
                              .toString() ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿Considera usted que este nuevo préstamo continúe fortaleciendo su negocio y generando mayores ganancias que beneficien a su familia? Explique ',
                      initialValue: resp
                              .recurrenteEstandarDbLocal?.comoFortalece
                              .toString() ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: 'A futuro ¿Cuál seria su siguiente paso?*',
                      initialValue: resp
                              .recurrenteEstandarDbLocal?.siguientePaso
                              .toString() ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          'Una vez finalizado el pago de este préstamo ¿ Podría ser una persona auto suficiente?',
                      initialValue: resp
                              .recurrenteEstandarDbLocal?.personaAutoSuficiente
                              .toString() ??
                          'N/A',
                    ),
                    BlocBuilder<UploadUserFileCubit, UploadUserFileState>(
                      builder: (context, imageState) {
                        return KivaEnviarActions(
                          disabled: resp.status == Status.inProgress ||
                              response.status == Status.inProgress ||
                              imageState.status == Status.inProgress,
                          onPreviousPressed: () {
                            context.pop();
                          },
                          onNextPressed: () {
                            context
                                .read<RecurrenteEstandartCubit>()
                                .sendOfflineAnswers(
                                    recurrentEstandarModel:
                                        RecurrenteEstandarModel(
                                  tipoSolicitud: resp.recurrenteEstandarDbLocal
                                          ?.tipoSolicitud ??
                                      '',
                                  tiempoActividad: resp
                                          .recurrenteEstandarDbLocal
                                          ?.tiempoActividad ??
                                      0,
                                  tieneTrabajo: resp.recurrenteEstandarDbLocal
                                          ?.tieneTrabajo ??
                                      false,
                                  trabajoNegocioDescripcion: resp
                                          .recurrenteEstandarDbLocal
                                          ?.trabajoDescripcion ??
                                      '',
                                  database: resp.recurrenteEstandarDbLocal
                                          ?.database ??
                                      '',
                                  otrosIngresos: resp.recurrenteEstandarDbLocal
                                          ?.otrosIngresos ??
                                      false,
                                  otrosIngresosDescripcion: resp
                                          .recurrenteEstandarDbLocal
                                          ?.otrosIngresosDescripcion ??
                                      '',
                                  personasCargo: resp.recurrenteEstandarDbLocal
                                          ?.personasCargo ??
                                      0,
                                  numeroHijos: resp.recurrenteEstandarDbLocal
                                          ?.numeroHijos ??
                                      0,
                                  edadHijos: resp.recurrenteEstandarDbLocal
                                          ?.edadHijos ??
                                      '',
                                  tipoEstudioHijos: resp
                                          .recurrenteEstandarDbLocal
                                          ?.tipoEstudioHijos ??
                                      '',
                                  apoyanNegocio: resp.recurrenteEstandarDbLocal
                                          ?.apoyanNegocio ??
                                      false,
                                  cuantosApoyan: resp.recurrenteEstandarDbLocal
                                          ?.cuantosApoyan ??
                                      '',
                                  objSolicitudRecurrenteId: resp
                                          .recurrenteEstandarDbLocal
                                          ?.objSolicitudRecurrenteId ??
                                      0,
                                  coincideRespuesta: resp
                                          .recurrenteEstandarDbLocal
                                          ?.coincideRespuesta ??
                                      false,
                                  explicacionInversion: resp
                                          .recurrenteEstandarDbLocal
                                          ?.explicacionInversion ??
                                      '',
                                  comoMejoraEntorno: resp
                                          .recurrenteEstandarDbLocal
                                          ?.comoMejoraEntorno ??
                                      '',
                                  motivoPrestamo: resp.recurrenteEstandarDbLocal
                                          ?.motivoPrestamo ??
                                      '',
                                  comoFortalece: resp.recurrenteEstandarDbLocal
                                          ?.comoFortalece ??
                                      '',
                                  siguientePaso: resp.recurrenteEstandarDbLocal
                                          ?.siguientePaso ??
                                      '',
                                  personaAutoSuficiente: resp
                                          .recurrenteEstandarDbLocal
                                          ?.personaAutoSuficiente ??
                                      '',
                                ));
                          },
                          previousTitle: 'Salir',
                          nextTitle: 'Enviar',
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

class EstandarForm extends StatefulWidget {
  final int solicitudId;
  final bool needGoBack;
  const EstandarForm({
    super.key,
    required this.solicitudId,
    this.needGoBack = false,
  });

  @override
  State<EstandarForm> createState() => _EstandarFormState();
}

class _EstandarFormState extends State<EstandarForm> {
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
        await solicitudesProvider.getEstandar(widget.solicitudId);
    if (!mounted) return;
    setState(() => _respuestasEncontradas = respuestas != null);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, state) {
        return BlocConsumer<EstandarCubit, EstandarState>(
          listener: (context, stateEstandar) async {
            if (stateEstandar.status == Status.error) {
              CustomAlertDialog(
                context: context,
                title: stateEstandar.errorMsg,
                onDone: () => context.pop(),
              ).showDialog(context, dialogType: DialogType.error);
            }
            if (stateEstandar.status == Status.done) {
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
                          state.estandarDbLocal?.otrosIngresos ?? false
                              ? 'input.yes'.tr()
                              : 'input.no'.tr(),
                    ),
                    KivaRespuestaWidget(
                      title: 'Cuales?',
                      initialValue:
                          state.estandarDbLocal?.otrosIngresosDescripcion ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: 'forms.entorno_familiar.person_origin'.tr(),
                      initialValue:
                          state.estandarDbLocal?.objOrigenCatalogoValorId ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: 'Cantidad de hijos:*',
                      initialValue:
                          state.estandarDbLocal?.numeroHijos.toString() ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Que edades tienen sus hijos?',
                      initialValue:
                          state.estandarDbLocal?.edadHijos.toString() ?? 'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Qué tipo de estudios reciben sus hijos?',
                      initialValue:
                          state.estandarDbLocal?.tipoEstudioHijos.toString() ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Cuenténos cómo inició su negocio?*',
                      initialValue:
                          state.estandarDbLocal?.inicioNegocio.toString() ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿Hay alguien que le apoye en su negocio? de ser positivo,?',
                      initialValue:
                          state.estandarDbLocal?.apoyanNegocio.toString() ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: 'Favor responder cuántas personas',
                      initialValue:
                          state.estandarDbLocal?.cuantosApoyan.toString() ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿En qué tipo de lugares le gustaría dar a conocer su producto? ¿Por qué?*',
                      initialValue:
                          state.estandarDbLocal?.publicitarNegocio.toString() ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Cómo mira su negocio en los proximos años?*',
                      initialValue: state.estandarDbLocal?.negocioProximosAnios
                              .toString() ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Para qué solicitó el préstamo? Explique',
                      initialValue:
                          state.estandarDbLocal?.motivoPrestamo.toString() ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿Cuáles son sus planes personales para los proximos 5 años?*',
                      initialValue:
                          state.estandarDbLocal?.planesFuturo.toString() ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿Cómo este crédito fortalecerá su negocio y mejorará sus condiciones de vida?*',
                      initialValue:
                          state.estandarDbLocal?.comoMejoraVida.toString() ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          'Otros datos relevantes e interesantes del cliente',
                      initialValue:
                          state.estandarDbLocal?.otrosDatosCliente.toString() ??
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
                            context.read<EstandarCubit>().sendOffilneAnswers(
                                  estandarModel: EstandarModel(
                                    tipoSolicitud:
                                        state.estandarDbLocal?.tipoSolicitud ??
                                            '',
                                    tiempoActividad: state
                                            .estandarDbLocal?.tiempoActividad ??
                                        0,
                                    tieneTrabajo:
                                        state.estandarDbLocal?.tieneTrabajo ??
                                            false,
                                    trabajoNegocioDescripcion: state
                                            .estandarDbLocal
                                            ?.trabajoNegocioDescripcion ??
                                        '',
                                    objSolicitudNuevamenorId: state
                                            .estandarDbLocal
                                            ?.objSolicitudNuevamenorId ??
                                        0,
                                    database:
                                        state.estandarDbLocal?.database ?? '',
                                    otrosIngresos:
                                        state.estandarDbLocal?.otrosIngresos ??
                                            false,
                                    otrosIngresosDescripcion: state
                                            .estandarDbLocal
                                            ?.otrosIngresosDescripcion ??
                                        '',
                                    objOrigenCatalogoValorId: state
                                            .estandarDbLocal
                                            ?.objOrigenCatalogoValorId ??
                                        '',
                                    personasCargo:
                                        state.estandarDbLocal?.personasCargo ??
                                            0,
                                    numeroHijos:
                                        state.estandarDbLocal?.numeroHijos ?? 0,
                                    edadHijos:
                                        state.estandarDbLocal?.edadHijos ?? '',
                                    tipoEstudioHijos: state.estandarDbLocal
                                            ?.tipoEstudioHijos ??
                                        '',
                                    inicioNegocio:
                                        state.estandarDbLocal?.inicioNegocio ??
                                            DateTime.now(),
                                    apoyanNegocio:
                                        state.estandarDbLocal?.apoyanNegocio ??
                                            false,
                                    cuantosApoyan:
                                        state.estandarDbLocal?.cuantosApoyan ??
                                            '',
                                    publicitarNegocio: state.estandarDbLocal
                                            ?.publicitarNegocio ??
                                        '',
                                    negocioProximosAnios: state.estandarDbLocal
                                            ?.negocioProximosAnios ??
                                        '',
                                    motivoPrestamo:
                                        state.estandarDbLocal?.motivoPrestamo ??
                                            '',
                                    comoMejoraVida:
                                        state.estandarDbLocal?.comoMejoraVida ??
                                            '',
                                    planesFuturo:
                                        state.estandarDbLocal?.planesFuturo ??
                                            '',
                                    otrosDatosCliente: state.estandarDbLocal
                                            ?.otrosDatosCliente ??
                                        '',
                                  ),
                                );
                          },
                          previousTitle: 'Salir',
                          nextTitle: 'Enviar',
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

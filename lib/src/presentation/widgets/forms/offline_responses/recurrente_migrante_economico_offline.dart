import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/datasource/forms/migrantes-economicos/recurrente_migrante_economico.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_migrante_economico/recurrente_migrantes_economicos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/shared/kiva_respuestas_offline_widgets.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RecurrenteMigranteEconomicoOffline extends StatefulWidget {
  final int solicitudId;
  final bool needGoBack;
  const RecurrenteMigranteEconomicoOffline({
    super.key,
    required this.solicitudId,
    this.needGoBack = false,
  });

  @override
  State<RecurrenteMigranteEconomicoOffline> createState() =>
      _RecurrenteMigranteEconomicoOfflineState();
}

class _RecurrenteMigranteEconomicoOfflineState
    extends State<RecurrenteMigranteEconomicoOffline> {
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
    final respuestas = await solicitudesProvider
        .getRecurrentMigranteEconomico(widget.solicitudId);
    imageModel = await solicitudesProvider.getImagesModel(widget.solicitudId);
    if (!mounted) return;
    setState(() => _respuestasEncontradas = respuestas != null);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, state) {
        return BlocConsumer<RecurrenteMigrantesEconomicosCubit,
            RecurrenteMigrantesEconomicosState>(
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
                    imagen1: imageModel?.imagen1 ?? 'NO PATH',
                    imagen2: imageModel?.imagen2 ?? 'NO PATH',
                    imagen3: imageModel?.imagen3 ?? 'NO PATH',
                    fotoFirma: imageModel?.imagenFirma ?? 'NO PATH',
                    solicitudId: widget.solicitudId,
                    tipoSolicitud:
                        context.read<KivaRouteCubit>().state.tipoSolicitud,
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
                      initialValue: state.recurrenteMigranteEconomicoDbLocal
                                  ?.otrosIngresos ??
                              false
                          ? 'input.yes'.tr()
                          : 'input.no'.tr(),
                      title: '¿Tiene otros ingresos?',
                    ),
                    if (state.recurrenteMigranteEconomicoDbLocal
                            ?.otrosIngresos ??
                        false)
                      KivaRespuestaWidget(
                        title: 'Cuales Otros Ingresos?',
                        initialValue: state.recurrenteMigranteEconomicoDbLocal
                                ?.otrosIngresosDescripcion ??
                            'N/A',
                      ),
                    KivaRespuestaWidget(
                      title: 'Cantidad de hijos:*',
                      initialValue: state
                              .recurrenteMigranteEconomicoDbLocal?.numeroHijos
                              ?.toString() ??
                          '0',
                    ),
                    KivaRespuestaWidget(
                      initialValue:
                          state.recurrenteMigranteEconomicoDbLocal?.edadHijos ??
                              '0',
                      title: '¿Qué edades tienen sus hijos?',
                    ),
                    KivaRespuestaWidget(
                      initialValue: state.recurrenteMigranteEconomicoDbLocal
                              ?.tipoEstudioHijos ??
                          'N/A',
                      title: '¿Qué tipo de estudios reciben sus hijos?',
                    ),
                    KivaRespuestaWidget(
                      initialValue: state.recurrenteMigranteEconomicoDbLocal
                                  ?.coincideRespuesta ??
                              false
                          ? 'input.yes'.tr()
                          : 'input.no'.tr(),
                      title:
                          '¿Coincide la respuesta del cliente con el formato anterior?'
                              .tr(),
                    ),
                    if (state.recurrenteMigranteEconomicoDbLocal
                            ?.coincideRespuesta ==
                        false)
                      KivaRespuestaWidget(
                        initialValue: state.recurrenteMigranteEconomicoDbLocal
                                ?.explicacionInversion ??
                            'N/A',
                        title:
                            'Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                      ),
                    KivaRespuestaWidget(
                      initialValue: state.recurrenteMigranteEconomicoDbLocal
                                  ?.apoyanNegocio ??
                              false
                          ? 'input.yes'.tr()
                          : 'input.no'.tr(),
                      title: '¿Hay alguien que le apoye en su negocio?'.tr(),
                    ),
                    if (state.recurrenteMigranteEconomicoDbLocal
                            ?.apoyanNegocio ??
                        false)
                      KivaRespuestaWidget(
                        initialValue: state.recurrenteMigranteEconomicoDbLocal
                                ?.cuantosApoyan ??
                            '0',
                        title:
                            'De ser positivo, favor responder cuántas personas.',
                      ),
                    KivaRespuestaWidget(
                      initialValue: state.recurrenteMigranteEconomicoDbLocal
                              ?.motivoPrestamo ??
                          'N/A',
                      title: '¿Para qué solicitó este nuevo crédito?',
                    ),
                    KivaRespuestaWidget(
                      initialValue: state
                              .recurrenteMigranteEconomicoDbLocal?.quienApoya ??
                          'N/A',
                      title:
                          '¿Hay alguien que le esté apoyando en este nuevo préstamo?',
                    ),
                    KivaRespuestaWidget(
                      initialValue: state.recurrenteMigranteEconomicoDbLocal
                                  ?.mejoraCondiciones ??
                              false
                          ? 'input.yes'.tr()
                          : 'input.no'.tr(),
                      title:
                          '¿Usted considera que esta nueva inversión le ayudará a mejorar sus condiciones de vida?',
                    ),
                    KivaRespuestaWidget(
                      initialValue: state.recurrenteMigranteEconomicoDbLocal
                              ?.explicacionMejoraCondiciones ??
                          'N/A',
                      title: '¿Por qué?',
                    ),
                    KivaRespuestaWidget(
                      initialValue: state.recurrenteMigranteEconomicoDbLocal
                              ?.siguienteMeta ??
                          'N/A',
                      title:
                          'Una vez finalizado este préstamo ¿Cuál sería su siguiente meta?',
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
                                .read<RecurrenteMigrantesEconomicosCubit>()
                                .sendOfflineAnswers(
                                  recurrenteMigranteEcomico:
                                      MigrantesEconomicosRecurrente(
                                    tipoSolicitud: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.tipoSolicitud ??
                                        '',
                                    database: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.database ??
                                        '',
                                    tieneTrabajo: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.tieneTrabajo ??
                                        false,
                                    trabajoNegocioDescripcion: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.trabajoNegocioDescripcion ??
                                        '',
                                    tiempoActividad: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.tiempoActividad ??
                                        0,
                                    numeroHijos: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.numeroHijos ??
                                        0,
                                    edadHijos: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.edadHijos ??
                                        '',
                                    tipoEstudioHijos: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.tipoEstudioHijos ??
                                        '',
                                    otrosIngresos: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.otrosIngresos ??
                                        false,
                                    otrosIngresosDescripcion: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.otrosIngresosDescripcion ??
                                        '',
                                    personasCargo: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.personasCargo ??
                                        0,
                                    motivoPrestamo: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.motivoPrestamo ??
                                        '',
                                    objSolicitudRecurrenteId: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.objSolicitudRecurrenteId ??
                                        0,
                                    coincideRespuesta: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.coincideRespuesta ??
                                        false,
                                    explicacionInversion: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.explicacionInversion ??
                                        '',
                                    apoyanNegocio: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.apoyanNegocio ??
                                        false,
                                    quienApoya: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.quienApoya ??
                                        '',
                                    cuantosApoyan: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.cuantosApoyan ??
                                        '',
                                    mejoraCondiciones: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.mejoraCondiciones ??
                                        false,
                                    explicacionMejoraCondiciones: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.explicacionMejoraCondiciones ??
                                        '',
                                    siguienteMeta: state
                                            .recurrenteMigranteEconomicoDbLocal
                                            ?.siguienteMeta ??
                                        '',
                                  ),
                                );
                          },
                          previousTitle: 'Salir'.tr(),
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

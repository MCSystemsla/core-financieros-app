import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/forms/migrantes-economicos/migrantes_ecomicos.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/migrantes_economicos/migrantes_economicos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/shared/kiva_respuestas_offline_widgets.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MigranteEconomicoOffline extends StatefulWidget {
  final int solicitudId;
  final bool needGoBack;
  const MigranteEconomicoOffline({
    super.key,
    required this.solicitudId,
    this.needGoBack = false,
  });

  @override
  State<MigranteEconomicoOffline> createState() =>
      _MigranteEconomicoOfflineState();
}

class _MigranteEconomicoOfflineState extends State<MigranteEconomicoOffline> {
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
        await solicitudesProvider.getMigranteEconomico(widget.solicitudId);
    imageModel = await solicitudesProvider.getImagesModel(widget.solicitudId);
    if (!mounted) return;
    setState(() => _respuestasEncontradas = respuestas != null);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, state) {
        return BlocConsumer<MigrantesEconomicosCubit, MigrantesEconomicosState>(
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
                      initialValue:
                          state.migranteEconomicoDbLocal?.otrosIngresos ?? false
                              ? 'input.yes'.tr()
                              : 'input.no'.tr(),
                      title: '¿Tiene otros ingresos?¿Cuales?*',
                    ),
                    if (state.migranteEconomicoDbLocal?.otrosIngresos ?? false)
                      KivaRespuestaWidget(
                        title: 'Cuales Otros Ingresos?',
                        initialValue: state.migranteEconomicoDbLocal
                                ?.otrosIngresosDescripcion ??
                            'N/A',
                      ),
                    KivaRespuestaWidget(
                      title: 'forms.entorno_familiar.person_origin'.tr(),
                      initialValue: state.migranteEconomicoDbLocal
                              ?.objOrigenUbicacionGeograficaId ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Qué le motivó a dejar su país natal?',
                      initialValue:
                          state.migranteEconomicoDbLocal?.motivoDejarPais ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Cuál es su situación migratoria en éste país?',
                      initialValue:
                          state.migranteEconomicoDbLocal?.situacionMigratoria ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿En su país de origen a qué se dedicaba?',
                      initialValue:
                          state.migranteEconomicoDbLocal?.dedicabaPaisOrigen ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Con quién vive en este país?',
                      initialValue:
                          state.migranteEconomicoDbLocal?.vivePaisActual ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: 'Cantidad de hijos:*',
                      initialValue: state.migranteEconomicoDbLocal?.numeroHijos
                              ?.toString() ??
                          '0',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Qué edades tienen sus hijos?',
                      initialValue:
                          state.migranteEconomicoDbLocal?.edadHijos ?? 'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Qué tipo de estudios reciben sus hijos?',
                      initialValue:
                          state.migranteEconomicoDbLocal?.tipoEstudioHijos ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Envía remesas a su país de origen?',
                      initialValue:
                          state.migranteEconomicoDbLocal?.enviaRemesas ?? false
                              ? 'input.yes'.tr()
                              : 'input.no'.tr(),
                    ),
                    if (state.migranteEconomicoDbLocal?.enviaRemesas ?? false)
                      KivaRespuestaWidget(
                        title: '¿Por qué lo hace?',
                        initialValue: state.migranteEconomicoDbLocal
                                ?.enviaRemesasExplicacion ??
                            'N/A',
                      ),
                    KivaRespuestaWidget(
                      initialValue:
                          state.migranteEconomicoDbLocal?.quienApoya ?? 'N/A',
                      title: '¿Quién o quiénes le apoyan para salir adelante?',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿Le gustaría fortalecer su negocio o ingresos económicos?'
                              .tr(),
                      initialValue:
                          state.migranteEconomicoDbLocal?.fortalecerIngresos ??
                                  false
                              ? 'input.yes'.tr()
                              : 'input.no'.tr(),
                    ),
                    if (state.migranteEconomicoDbLocal?.fortalecerIngresos ??
                        false)
                      KivaRespuestaWidget(
                        title: '¿Porqué?',
                        initialValue: state.migranteEconomicoDbLocal
                                ?.fortalecerIngresosExplicacion ??
                            'N/A',
                      ),
                    KivaRespuestaWidget(
                      title: '¿Cuáles son las metas a futuro que tiene?',
                      initialValue:
                          state.migranteEconomicoDbLocal?.metasFuturo ?? 'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Para qué solicitó el crédito?'.tr(),
                      initialValue:
                          state.migranteEconomicoDbLocal?.motivoPrestamo ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿Usted considera que esta nueva inversión le ayudará a mejorar sus condiciones de vida?'
                              .tr(),
                      initialValue: state.migranteEconomicoDbLocal
                                  ?.ayudaMejorarCondiciones ??
                              false
                          ? 'input.yes'.tr()
                          : 'input.no'.tr(),
                    ),
                    if (state.migranteEconomicoDbLocal
                            ?.ayudaMejorarCondiciones ??
                        false)
                      KivaRespuestaWidget(
                        title: '¿Por qué?'.tr(),
                        initialValue: state.migranteEconomicoDbLocal
                                ?.ayudaMejorarCondicionesExplicacion ??
                            'N/A',
                      ),
                    KivaRespuestaWidget(
                      title:
                          '¿Cuáles son sus propósitos para los próximos años?'
                              .tr(),
                      initialValue:
                          state.migranteEconomicoDbLocal?.propositosProximos ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Piensa regresar a su país natal algún día?'.tr(),
                      initialValue:
                          state.migranteEconomicoDbLocal?.piensaRegresar ??
                              'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: 'Otros datos relevantes e interesantes del cliente'
                          .tr(),
                      initialValue:
                          state.migranteEconomicoDbLocal?.otrosDatosCliente ??
                              'N/A',
                    ),
                    BlocBuilder<UploadUserFileCubit, UploadUserFileState>(
                      builder: (_, imageState) {
                        return KivaEnviarActions(
                          disabled: state.status == Status.inProgress ||
                              response.status == Status.inProgress ||
                              imageState.status == Status.inProgress,
                          onPreviousPressed: () {
                            context.pop();
                          },
                          onNextPressed: () {
                            context
                                .read<MigrantesEconomicosCubit>()
                                .sendOfflineAnswers(
                                  migrantesEconomicos: MigrantesEconomicos(
                                    tipoSolicitud: state
                                            .migranteEconomicoDbLocal
                                            ?.tipoSolicitud ??
                                        '',
                                    database: LocalStorage().database,
                                    objSolicitudNuevamenorId: int.tryParse(
                                            context
                                                .read<KivaRouteCubit>()
                                                .state
                                                .solicitudId) ??
                                        0,
                                    tieneTrabajo: state.migranteEconomicoDbLocal
                                            ?.tieneTrabajo ??
                                        false,
                                    trabajoNegocioDescripcion: state
                                            .migranteEconomicoDbLocal
                                            ?.trabajoNegocioDescripcion ??
                                        '',
                                    tiempoActividad: state
                                            .migranteEconomicoDbLocal
                                            ?.tiempoActividad ??
                                        0,
                                    otrosIngresos: state
                                            .migranteEconomicoDbLocal
                                            ?.otrosIngresos ??
                                        false,
                                    otrosIngresosDescripcion: state
                                            .migranteEconomicoDbLocal
                                            ?.otrosIngresosDescripcion ??
                                        '',
                                    personasCargo: state
                                            .migranteEconomicoDbLocal
                                            ?.personasCargo ??
                                        0,
                                    objOrigenUbicacionGeograficaId: state
                                            .migranteEconomicoDbLocal
                                            ?.objOrigenUbicacionGeograficaId ??
                                        '',
                                    motivoDejarPais: state
                                            .migranteEconomicoDbLocal
                                            ?.motivoDejarPais ??
                                        '',
                                    situacionMigratoria: state
                                            .migranteEconomicoDbLocal
                                            ?.situacionMigratoria ??
                                        '',
                                    dedicabaPaisOrigen: state
                                            .migranteEconomicoDbLocal
                                            ?.dedicabaPaisOrigen ??
                                        '',
                                    vivePaisActual: state
                                            .migranteEconomicoDbLocal
                                            ?.vivePaisActual ??
                                        '',
                                    numeroHijos: state.migranteEconomicoDbLocal
                                            ?.numeroHijos ??
                                        0,
                                    edadHijos: state.migranteEconomicoDbLocal
                                            ?.edadHijos ??
                                        '',
                                    tipoEstudioHijos: state
                                            .migranteEconomicoDbLocal
                                            ?.tipoEstudioHijos ??
                                        '',
                                    enviaRemesas: state.migranteEconomicoDbLocal
                                            ?.enviaRemesas ??
                                        false,
                                    enviaRemesasExplicacion: state
                                            .migranteEconomicoDbLocal
                                            ?.enviaRemesasExplicacion ??
                                        '',
                                    quienApoya: state.migranteEconomicoDbLocal
                                            ?.quienApoya ??
                                        '',
                                    fortalecerIngresos: state
                                            .migranteEconomicoDbLocal
                                            ?.fortalecerIngresos ??
                                        false,
                                    fortalecerIngresosExplicacion: state
                                            .migranteEconomicoDbLocal
                                            ?.fortalecerIngresosExplicacion ??
                                        '',
                                    metasFuturo: state.migranteEconomicoDbLocal
                                            ?.metasFuturo ??
                                        '',
                                    motivoPrestamo: state
                                            .migranteEconomicoDbLocal
                                            ?.motivoPrestamo ??
                                        '',
                                    ayudaMejorarCondiciones: state
                                            .migranteEconomicoDbLocal
                                            ?.ayudaMejorarCondiciones ??
                                        false,
                                    ayudaMejorarCondicionesExplicacion: state
                                            .migranteEconomicoDbLocal
                                            ?.ayudaMejorarCondicionesExplicacion ??
                                        '',
                                    propositosProximos: state
                                            .migranteEconomicoDbLocal
                                            ?.propositosProximos ??
                                        '',
                                    piensaRegresar: state
                                            .migranteEconomicoDbLocal
                                            ?.piensaRegresar ??
                                        '',
                                    otrosDatosCliente: state
                                            .migranteEconomicoDbLocal
                                            ?.otrosDatosCliente ??
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

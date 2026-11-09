import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/datasource/forms/micredi_estudio/micredi_estudio_model.dart';
import 'package:core_financiero_app/src/datasource/forms/micredi_estudio/recurrente_micredi_estudio_model.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/micredi_estudio/micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_micredi_estudio/recurrente_micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/shared/kiva_respuestas_offline_widgets.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class MicrediEstudioForm extends StatefulWidget {
  final int solicitudId;
  final bool needGoBack;

  const MicrediEstudioForm({
    super.key,
    required this.solicitudId,
    this.needGoBack = false,
  });

  @override
  State<MicrediEstudioForm> createState() => _MicrediEstudioFormState();
}

class _MicrediEstudioFormState extends State<MicrediEstudioForm> {
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
        await solicitudesProvider.getMiCrediEstudio(widget.solicitudId);
    if (!mounted) return;
    setState(() => _respuestasEncontradas = respuestas != null);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, state) {
        return BlocConsumer<MicrediEstudioCubit, MicrediEstudioState>(
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
                      title: 'Profesión u Oficio:',
                      initialValue: state.miCrediEstudioDbLocal?.tieneTrabajo
                              .toString() ??
                          '',
                    ),
                    const Gap(10),
                    KivaRespuestaWidget(
                      title: 'Cual?',
                      initialValue: state.miCrediEstudioDbLocal
                              ?.trabajoNegocioDescripcion ??
                          '',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Tiene otros ingresos?¿Cuales?*',
                      initialValue:
                          state.miCrediEstudioDbLocal?.otrosIngresos ?? false
                              ? 'input.yes'.tr()
                              : 'input.no'.tr(),
                    ),
                    KivaRespuestaWidget(
                      title: 'forms.entorno_familiar.question6'.tr(),
                      initialValue: state.miCrediEstudioDbLocal
                              ?.otrosIngresosDescripcion ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: 'forms.entorno_familiar.person_origin'.tr(),
                      initialValue: state.miCrediEstudioDbLocal
                              ?.objOrigenCatalogoValorId ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: 'Cantidad de hijos:*'.tr(),
                      initialValue:
                          state.miCrediEstudioDbLocal?.numeroHijos.toString() ??
                              '0',
                    ),
                    KivaRespuestaWidget(
                      title: 'forms.entorno_familiar.childs_age'.tr(),
                      initialValue:
                          state.miCrediEstudioDbLocal?.edadHijos.toString() ??
                              '0',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Qué tipo de estudios reciben sus hijos?',
                      initialValue: state
                              .miCrediEstudioDbLocal?.tipoEstudioHijos
                              .toString() ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: 'Carrera:',
                      initialValue: state.miCrediEstudioDbLocal?.carrera ?? '',
                    ),
                    KivaRespuestaWidget(
                      title: 'Universidad a la que pertenece:',
                      initialValue:
                          state.miCrediEstudioDbLocal?.universidad ?? '',
                    ),
                    KivaRespuestaWidget(
                      title: 'Años de la carrera:',
                      initialValue: state.miCrediEstudioDbLocal?.tiempoCarrera
                              .toString() ??
                          '',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Qué te motivó a elegir esa carrera?',
                      initialValue:
                          state.miCrediEstudioDbLocal?.motivoCarrera ?? '',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿Sentís que te estás realizando profesionalmente?*',
                      initialValue: state.miCrediEstudioDbLocal
                                  ?.relizandoProfesionalmente ??
                              false
                          ? 'input.yes'.tr()
                          : 'inpit.no'.tr(),
                    ),
                    KivaRespuestaWidget(
                      title: 'Por que?',
                      initialValue: state.miCrediEstudioDbLocal
                              ?.explicacionRelizandoProfesionalmente ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Quién o quiénes te apoyan en tus estudios?*',
                      initialValue:
                          state.miCrediEstudioDbLocal?.quienApoya ?? 'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿En qué trabaja o qué negocio tienen tus padres o tutores?*',
                      initialValue:
                          state.miCrediEstudioDbLocal?.ocupacionPadres ?? 'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: 'forms.miCredi_estudio.question1'.tr(),
                      initialValue:
                          state.miCrediEstudioDbLocal?.motivoPrestamo ?? 'N/A',
                    ),
                    const Gap(10),
                    KivaRespuestaWidget(
                      title:
                          '¿De qué manera este financiamiento le ayudará a crecer profesionalemente? Explique'
                              .tr(),
                      initialValue:
                          state.miCrediEstudioDbLocal?.comoAyudaCrecer ?? 'N/A',
                    ),
                    const Gap(10),
                    KivaRespuestaWidget(
                      initialValue:
                          state.miCrediEstudioDbLocal?.optarOtroEstudio ?? false
                              ? 'input.yes'.tr()
                              : 'input.no'.tr(),
                      title: '¿Piensa optar a otro estudio superior?*',
                    ),
                    KivaRespuestaWidget(
                      title: 'Porque?',
                      initialValue:
                          state.miCrediEstudioDbLocal?.cualEstudio ?? 'N/A',
                    ),
                    const Gap(10),
                    KivaRespuestaWidget(
                      title: '¿Cuáles son sus planes en los próximos 10 años?*'
                          .tr(),
                      initialValue:
                          state.miCrediEstudioDbLocal?.planFuturo ?? 'N/A',
                    ),
                    const Gap(10),
                    KivaRespuestaWidget(
                      title: '¿Qué aspira laboralmente?*'.tr(),
                      initialValue:
                          state.miCrediEstudioDbLocal?.aspiraLaboralmente ??
                              'N/A',
                    ),
                    const Gap(10),
                    KivaRespuestaWidget(
                      title: 'Otros datos relevantes e interesantes del cliente'
                          .tr(),
                      initialValue:
                          state.miCrediEstudioDbLocal?.otrosDatosCliente ??
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
                                .read<MicrediEstudioCubit>()
                                .sendOfflineAnswers(
                                  miCrediEstudioModel: MiCrediEstudioModel(
                                    tipoSolitud: state.miCrediEstudioDbLocal
                                            ?.tipoSolicitud ??
                                        '',
                                    database:
                                        state.miCrediEstudioDbLocal?.database ??
                                            '',
                                    objSolicitudNuevamenorId: state
                                            .miCrediEstudioDbLocal
                                            ?.objSolicitudNuevamenorId ??
                                        0,
                                    tieneTrabajo: state.miCrediEstudioDbLocal
                                            ?.tieneTrabajo ??
                                        false,
                                    trabajoNegocioDescripcion: state
                                            .miCrediEstudioDbLocal
                                            ?.trabajoNegocioDescripcion ??
                                        'N/A',
                                    tiempoActividad: state.miCrediEstudioDbLocal
                                            ?.tiempoActividad ??
                                        0,
                                    otrosIngresos: state.miCrediEstudioDbLocal
                                            ?.otrosIngresos ??
                                        false,
                                    otrosIngresosDescripcion: state
                                            .miCrediEstudioDbLocal
                                            ?.otrosIngresosDescripcion ??
                                        '',
                                    objOrigenCatalogoValorId: state
                                            .miCrediEstudioDbLocal
                                            ?.objOrigenCatalogoValorId ??
                                        '',
                                    personasCargo: state.miCrediEstudioDbLocal
                                            ?.personasCargo ??
                                        0,
                                    numeroHijos: state.miCrediEstudioDbLocal
                                            ?.numeroHijos ??
                                        0,
                                    edadHijos: state
                                            .miCrediEstudioDbLocal?.edadHijos ??
                                        '',
                                    tipoEstudioHijos: state
                                            .miCrediEstudioDbLocal
                                            ?.tipoEstudioHijos ??
                                        '',
                                    carrera:
                                        state.miCrediEstudioDbLocal?.carrera ??
                                            '',
                                    tiempoCarrera: state.miCrediEstudioDbLocal
                                            ?.tiempoCarrera ??
                                        0,
                                    universidad: state.miCrediEstudioDbLocal
                                            ?.universidad ??
                                        '',
                                    motivoCarrera: state.miCrediEstudioDbLocal
                                            ?.motivoCarrera ??
                                        '',
                                    relizandoProfesionalmente: state
                                            .miCrediEstudioDbLocal
                                            ?.relizandoProfesionalmente ??
                                        false,
                                    explicacionRelizandoProfesionalmente: state
                                            .miCrediEstudioDbLocal
                                            ?.explicacionRelizandoProfesionalmente ??
                                        '',
                                    quienApoya: state.miCrediEstudioDbLocal
                                            ?.quienApoya ??
                                        '',
                                    ocupacionPadres: state.miCrediEstudioDbLocal
                                            ?.ocupacionPadres ??
                                        '',
                                    motivoPrestamo: state.miCrediEstudioDbLocal
                                            ?.motivoPrestamo ??
                                        '',
                                    comoAyudaCrecer: state.miCrediEstudioDbLocal
                                            ?.comoAyudaCrecer ??
                                        '',
                                    optarOtroEstudio: state
                                            .miCrediEstudioDbLocal
                                            ?.optarOtroEstudio ??
                                        false,
                                    cualEstudio: state.miCrediEstudioDbLocal
                                            ?.cualEstudio ??
                                        '',
                                    planFuturo: state.miCrediEstudioDbLocal
                                            ?.planFuturo ??
                                        '',
                                    aspiraLaboralmente: state
                                            .miCrediEstudioDbLocal
                                            ?.aspiraLaboralmente ??
                                        '',
                                    otrosDatosCliente: state
                                            .miCrediEstudioDbLocal
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

class MiCrediEstudioRecurrenteForm extends StatefulWidget {
  final int solicitudId;
  final bool needGoBack;
  const MiCrediEstudioRecurrenteForm({
    super.key,
    required this.solicitudId,
    this.needGoBack = false,
  });

  @override
  State<MiCrediEstudioRecurrenteForm> createState() =>
      _MiCrediEstudioRecurrenteFormState();
}

class _MiCrediEstudioRecurrenteFormState
    extends State<MiCrediEstudioRecurrenteForm> {
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
        .getRecurrentMiCrediEstudio(widget.solicitudId);
    if (!mounted) return;
    setState(() => _respuestasEncontradas = respuestas != null);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, state) {
        return BlocConsumer<RecurrenteMicrediEstudioCubit,
            RecurrenteMicrediEstudioState>(
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
                      title: 'Cual?',
                      initialValue: state.recurrenteMiCrediEstudioDbLocal
                              ?.trabajoNegocioDescripcion ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Tiene otros ingresos?',
                      initialValue: state.recurrenteMiCrediEstudioDbLocal
                                  ?.otrosIngresos ??
                              false
                          ? 'input.yes'.tr()
                          : 'input.no'.tr(),
                    ),
                    KivaRespuestaWidget(
                      title: '¿Cuáles?',
                      initialValue: state.recurrenteMiCrediEstudioDbLocal
                              ?.otrosIngresosDescripcion ??
                          '',
                    ),
                    KivaRespuestaWidget(
                      title: 'Cantidad de hijos:*',
                      initialValue: state
                              .recurrenteMiCrediEstudioDbLocal?.numeroHijos
                              .toString() ??
                          '0',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Que edades tienen sus hijos?',
                      initialValue: state
                              .recurrenteMiCrediEstudioDbLocal?.edadHijos
                              .toString() ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: '¿Qué tipo de estudios reciben sus hijos?',
                      initialValue: state
                              .recurrenteMiCrediEstudioDbLocal?.tipoEstudioHijos
                              .toString() ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: 'Carrera:',
                      initialValue: state
                              .recurrenteMiCrediEstudioDbLocal?.carrera
                              .toString() ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title: 'Años de la carrera:',
                      initialValue: state
                              .recurrenteMiCrediEstudioDbLocal?.tiempoCarrera
                              .toString() ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      initialValue: state
                              .recurrenteMiCrediEstudioDbLocal?.universidad
                              .toString() ??
                          'N/A',
                      title: 'Universidad a la que pertenece',
                    ),
                    KivaRespuestaWidget(
                      initialValue: state
                              .recurrenteMiCrediEstudioDbLocal?.quienApoya
                              .toString() ??
                          'N/A',
                      title:
                          '¿Quién o quiénes le estarían apoyando en esta nueva etapa?*',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿Coincide la respuesta del cliente con el formato anterior?',
                      initialValue: state.recurrenteMiCrediEstudioDbLocal
                                  ?.coincideRespuesta ??
                              false
                          ? 'input.yes'.tr()
                          : 'input.no'.tr(),
                    ),
                    KivaRespuestaWidget(
                      title:
                          '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                      initialValue: state.recurrenteMiCrediEstudioDbLocal
                              ?.explicacionInversion ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      title:
                          '¿De qué manera ayudó este préstamo Kiva en su vida profesional?*',
                      initialValue: state.recurrenteMiCrediEstudioDbLocal
                              ?.comoAyudoProfesionalmente ??
                          'N/A',
                    ),
                    KivaRespuestaWidget(
                      initialValue: state.recurrenteMiCrediEstudioDbLocal
                              ?.motivoPrestamo ??
                          'N/A',
                      title:
                          '¿En qué piensa invertir este nuevo préstamo de MiCrediestudio?* Explique',
                    ),
                    KivaRespuestaWidget(
                      initialValue: state.recurrenteMiCrediEstudioDbLocal
                              ?.motivoPrestamo ??
                          'N/A',
                      title:
                          '¿Cómo cree usted que este nuevo préstamo le ayude en su crecimiento profesional?*',
                    ),
                    const KivaRespuestaWidget(
                      title:
                          '¿Cree usted que una vez finalizado el pago de este préstamo de MiCréditoEstudio alcanzó su meta académica? ¿Por qué?',
                    ),
                    KivaRespuestaWidget(
                      initialValue: state.recurrenteMiCrediEstudioDbLocal
                              ?.explicacionAlcanzaraMeta ??
                          'N/A',
                      title: 'Explica la meta?',
                    ),
                    KivaRespuestaWidget(
                      initialValue: state
                              .recurrenteMiCrediEstudioDbLocal?.siguientePaso ??
                          '',
                      title: '¿Cuál sería su siguiente paso?',
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
                                .read<RecurrenteMicrediEstudioCubit>()
                                .sendOfflineAnswers(
                                  recurrenteMicrediEstudioModel:
                                      RecurrenteMiCrediEstudioModel(
                                    tipoSolicitud: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.tipoSolicitud ??
                                        '',
                                    database: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.database ??
                                        '',
                                    tieneTrabajo: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.tieneTrabajo ??
                                        false,
                                    trabajoNegocioDescripcion: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.trabajoNegocioDescripcion ??
                                        '',
                                    tiempoActividad: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.tiempoActividad ??
                                        0,
                                    otrosIngresos: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.otrosIngresos ??
                                        false,
                                    otrosIngresosDescripcion: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.otrosIngresosDescripcion ??
                                        '',
                                    personasCargo: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.personasCargo ??
                                        0,
                                    numeroHijos: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.numeroHijos ??
                                        0,
                                    edadHijos: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.edadHijos ??
                                        '',
                                    tipoEstudioHijos: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.tipoEstudioHijos ??
                                        '',
                                    carrera: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.carrera ??
                                        '',
                                    tiempoCarrera: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.tiempoCarrera ??
                                        0,
                                    universidad: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.universidad ??
                                        '',
                                    quienApoya: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.quienApoya ??
                                        '',
                                    motivoPrestamo: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.motivoPrestamo ??
                                        '',
                                    comoAyudaCrecer: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.comoAyudaCrecer ??
                                        '',
                                    objSolicitudRecurrenteId: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.objSolicitudRecurrenteId ??
                                        0,
                                    coincideRespuesta: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.coincideRespuesta ??
                                        false,
                                    explicacionInversion: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.explicacionInversion ??
                                        '',
                                    comoAyudoProfesionalmente: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.comoAyudoProfesionalmente ??
                                        '',
                                    siguientePaso: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.siguientePaso ??
                                        '',
                                    alcanzaraMeta: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.alcanzaraMeta ??
                                        false,
                                    explicacionAlcanzaraMeta: state
                                            .recurrenteMiCrediEstudioDbLocal
                                            ?.explicacionAlcanzaraMeta ??
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

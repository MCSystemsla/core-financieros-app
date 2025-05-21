import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_answer.dart';
import 'package:core_financiero_app/src/datasource/forms/mejora_vivienda_recurrente.dart';
import 'package:core_financiero_app/src/datasource/local_db/image_model.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/mejora_vivienda/mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_,mejora_vivienda.dart/recurrente_mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/custom_pop_up.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ViviendaNuevaOfflineResponse extends StatefulWidget {
  final int solicitudId;
  const ViviendaNuevaOfflineResponse({
    super.key,
    required this.solicitudId,
  });

  @override
  State<ViviendaNuevaOfflineResponse> createState() =>
      _ViviendaNuevaOfflineResponseState();
}

class _ViviendaNuevaOfflineResponseState
    extends State<ViviendaNuevaOfflineResponse> {
  ImageModel? imageModel;
  @override
  void initState() {
    initFunctions();
    super.initState();
  }

  initFunctions() async {
    final solicitudesProvider =
        context.read<SolicitudesPendientesLocalDbCubit>();
    imageModel = await solicitudesProvider.getImagesModel(widget.solicitudId);
    await solicitudesProvider.getViviendaNueva(widget.solicitudId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, state) {
        return BlocConsumer<MejoraViviendaCubit, MejoraViviendaState>(
          listener: (context, status) async {
            if (status.status == Status.error) {
              CustomAlertDialog(
                context: context,
                title: status.errorMsg,
                onDone: () => context.pop(),
              ).showDialog(context, dialogType: DialogType.error);
            }
            if (status.status == Status.done) {
              context.read<UploadUserFileCubit>().uploadUserFilesOffline(
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
              // context
              //     .read<SolicitudesPendientesLocalDbCubit>()
              //     .removeWhenFormIsUpload(
              //       widget.solicitudId,
              //       context.read<KivaRouteCubit>().state.currentRoute,
              //     );
              await customPopUp(
                context: context,
                dismissOnTouchOutside: false,
                size: size,
                title: 'Formulario Kiva Enviado exitosamente!!',
                subtitle: 'Las respuestas se han enviado Exitosamente',
                dialogType: DialogType.success,
                buttonAcept: true,
                textButtonAcept: 'Ok',
                colorButtonAcept: AppColors.getPrimaryColor(),
                onPressedAccept: () {
                  context.pushReplacement('/');
                },
              );
            }
          },
          builder: (context, response) {
            return switch (state.status) {
              Status.inProgress => const LoadingWidget(),
              Status.done => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        title: '¿Tiene otros ingresos?¿Cuales?*',
                        initialValue:
                            state.mejoraViviendaDbLocal?.otrosIngresos ?? false
                                ? 'input.yes'.tr()
                                : 'input.no'.tr(),
                      ),
                      CommentaryWidget(
                        readOnly: true,
                        initialValue: state.mejoraViviendaDbLocal
                                ?.otrosIngresosDescripcion ??
                            'N/A',
                        title: 'Describe tus otros Ingresos',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        title: 'forms.entorno_familiar.person_origin'.tr(),
                        initialValue: state.mejoraViviendaDbLocal
                                ?.objOrigenCatalogoValorId ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        title: 'Su comunidad es:',
                        initialValue:
                            state.mejoraViviendaDbLocal?.objTipoComunidadId ??
                                'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        initialValue:
                            state.mejoraViviendaDbLocal?.necesidadesComunidad ??
                                'N/A',
                        title: '¿Cuáles son las necesidades en su comunidad?',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        initialValue: state.mejoraViviendaDbLocal?.numeroHijos
                                .toString() ??
                            'N/A',
                        title: 'Cantidad de hijos:*',
                        textInputType: TextInputType.number,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        initialValue:
                            state.mejoraViviendaDbLocal?.edadHijos ?? 'N/A',
                        title: '¿Que edades tienen sus hijos?',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        initialValue:
                            state.mejoraViviendaDbLocal?.tipoEstudioHijos ??
                                'N/A',
                        title: '¿Qué tipo de estudios reciben sus hijos?',
                      ),
                      CommentaryWidget(
                        readOnly: true,
                        title: 'forms.mejora_de_vivienda.question1'.tr(),
                        initialValue:
                            state.mejoraViviendaDbLocal?.motivoPrestamo ??
                                'N/A',
                      ),
                      const Gap(10),
                      CommentaryWidget(
                        readOnly: true,
                        title: 'forms.mejora_de_vivienda.question2'.tr(),
                        initialValue:
                            state.mejoraViviendaDbLocal?.comoAyudara ?? 'N/A',
                      ),
                      const Gap(10),
                      CommentaryWidget(
                        readOnly: true,
                        title: '¿Cuáles son sus planes para los próximos años?',
                        initialValue:
                            state.mejoraViviendaDbLocal?.planesFuturo ?? 'N/A',
                      ),
                      const Gap(10),
                      CommentaryWidget(
                        readOnly: true,
                        initialValue:
                            state.mejoraViviendaDbLocal?.otrosDatosCliente ??
                                'N/A',
                        title:
                            'Otros datos relevantes e interesantes del cliente',
                      ),
                      ButtonActionsWidget(
                        disabled: state.status == Status.inProgress ||
                            response.status == Status.inProgress,
                        onPreviousPressed: () {
                          context.pop();
                        },
                        onNextPressed: () {
                          context
                              .read<MejoraViviendaCubit>()
                              .sendOfflineAnswers(
                                mejoravivienda: MejoraViviendaAnswer(
                                    tipoSolicitud: state.mejoraViviendaDbLocal
                                            ?.tipoSolicitud ??
                                        '',
                                    otrosDatosCliente: state
                                            .mejoraViviendaDbLocal
                                            ?.otrosDatosCliente ??
                                        '',
                                    planesFuturo: state.mejoraViviendaDbLocal
                                            ?.planesFuturo ??
                                        '',
                                    comoAyudara:
                                        state.mejoraViviendaDbLocal?.comoAyudara ??
                                            '',
                                    motivoPrestamo: state.mejoraViviendaDbLocal
                                            ?.motivoPrestamo ??
                                        '',
                                    tipoEstudioHijos: state
                                            .mejoraViviendaDbLocal
                                            ?.tipoEstudioHijos ??
                                        '',
                                    edadHijos:
                                        state.mejoraViviendaDbLocal?.edadHijos ??
                                            '',
                                    numeroHijos: state.mejoraViviendaDbLocal?.numeroHijos ?? 0,
                                    personasCargo: state.mejoraViviendaDbLocal?.personasCargo ?? '',
                                    necesidadesComunidad: state.mejoraViviendaDbLocal?.necesidadesComunidad ?? '',
                                    objTipoComunidadId: state.mejoraViviendaDbLocal?.objTipoComunidadId ?? '',
                                    objOrigenCatalogoValorId: state.mejoraViviendaDbLocal?.objOrigenCatalogoValorId ?? '',
                                    otrosIngresosDescripcion: state.mejoraViviendaDbLocal?.otrosIngresosDescripcion ?? '',
                                    otrosIngresos: state.mejoraViviendaDbLocal?.otrosIngresos ?? false,
                                    tiempoActividad: state.mejoraViviendaDbLocal?.tiempoActividad ?? 0,
                                    solicitudNuevamenorId: state.mejoraViviendaDbLocal?.solicitudNuevamenorId ?? 0,
                                    username: state.mejoraViviendaDbLocal?.username ?? '',
                                    tieneTrabajo: state.mejoraViviendaDbLocal?.tieneTrabajo ?? false,
                                    database: state.mejoraViviendaDbLocal?.database ?? '',
                                    trabajoNegocioDescripcion: state.mejoraViviendaDbLocal?.trabajoNegocioDescripcion ?? ''),
                              );
                        },
                        previousTitle: 'Salir',
                        nextTitle: 'Enviar',
                      ),
                    ],
                  ),
                ),
              _ => const SizedBox(),
            };
          },
        );
      },
    );
  }
}

class RecurrenteViviendaOfflineResponse extends StatefulWidget {
  final int solicitudId;
  const RecurrenteViviendaOfflineResponse({
    super.key,
    required this.solicitudId,
  });

  @override
  State<RecurrenteViviendaOfflineResponse> createState() =>
      _RecurrenteViviendaOfflineResponseState();
}

class _RecurrenteViviendaOfflineResponseState
    extends State<RecurrenteViviendaOfflineResponse> {
  ImageModel? imageModel;
  @override
  void initState() {
    initFunctions();
    super.initState();
  }

  initFunctions() async {
    final solicitudesProvider =
        context.read<SolicitudesPendientesLocalDbCubit>();
    imageModel = await solicitudesProvider.getImagesModel(widget.solicitudId);
    await solicitudesProvider.getRecurrenteViviendaNueva(widget.solicitudId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, state) {
        return BlocConsumer<RecurrenteMejoraViviendaCubit,
            RecurrenteMejoraViviendaState>(
          listener: (context, status) async {
            if (status.status == Status.error) {
              CustomAlertDialog(
                context: context,
                title: status.errorMsg,
                onDone: () => context.pop(),
              ).showDialog(context, dialogType: DialogType.error);
            }
            if (status.status == Status.done) {
              context.read<UploadUserFileCubit>().uploadUserFilesOffline(
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
              // context
              //     .read<SolicitudesPendientesLocalDbCubit>()
              //     .removeWhenFormIsUpload(
              //       widget.solicitudId,
              //       context.read<KivaRouteCubit>().state.currentRoute,
              //     );
              await customPopUp(
                context: context,
                dismissOnTouchOutside: false,
                size: size,
                title: 'Formulario Kiva Enviado exitosamente!!',
                subtitle: 'Las respuestas se han enviado Exitosamente',
                dialogType: DialogType.success,
                buttonAcept: true,
                textButtonAcept: 'Ok',
                colorButtonAcept: AppColors.getPrimaryColor(),
                onPressedAccept: () {
                  context.pushReplacement('/');
                },
              );
            }
          },
          builder: (context, response) {
            return switch (state.status) {
              Status.inProgress => const LoadingWidget(),
              Status.done => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        initialValue: state.recurrenteMejoraViviendaDbLocal
                                    ?.otrosIngresos ??
                                false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                        title: '¿Tiene otros ingresos?¿Cuales?*',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        title: 'Cuales Ingresos son?',
                        initialValue: state.recurrenteMejoraViviendaDbLocal
                                ?.otrosIngresosDescripcion ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        title: 'Su comunidad es:',
                        initialValue: state.recurrenteMejoraViviendaDbLocal
                                ?.objTipoComunidadId ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        initialValue: state.recurrenteMejoraViviendaDbLocal
                                ?.necesidadesComunidad ??
                            'N/A',
                        title: '¿Cuáles son las necesidades en su comunidad?',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        initialValue: state.recurrenteMejoraViviendaDbLocal
                                ?.trabajoNegocioDescripcion ??
                            'N/A',
                        textInputType: TextInputType.number,
                        title: 'Cantidad de hijos:*',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        initialValue:
                            state.recurrenteMejoraViviendaDbLocal?.edadHijos ??
                                'N/A',
                        title: '¿Que edades tienen sus hijos?',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        initialValue: state.recurrenteMejoraViviendaDbLocal
                                ?.tipoEstudioHijos ??
                            'N/A',
                        title: '¿Qué tipo de estudios reciben sus hijos?',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        initialValue: state.recurrenteMejoraViviendaDbLocal
                                    ?.coincideRespuesta ??
                                false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                        title:
                            '¿Coincide la respuesta del cliente con el formato anterior?',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        initialValue: state.recurrenteMejoraViviendaDbLocal
                                ?.explicacionInversion ??
                            'N/A',
                        title:
                            '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        title:
                            '¿Cómo era su vivienda anteriormente y describa como está ahora?',
                        initialValue: state.recurrenteMejoraViviendaDbLocal
                                ?.viviendaAntesDespues ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        initialValue: state.recurrenteMejoraViviendaDbLocal
                                ?.motivoPrestamo ??
                            'N/A',
                        title:
                            '¿En qué piensa invertir este nuevo préstamo de Mejora de Vivienda?* Explique',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        initialValue: state.recurrenteMejoraViviendaDbLocal
                                ?.mejoraSeguridadFamilia ??
                            'N/A',
                        title:
                            '¿Cómo cree usted que este nuevo préstamo vaya a mejorar la seguridad de su familia?*',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        initialValue:
                            state.recurrenteMejoraViviendaDbLocal?.quienApoya ??
                                'N/A',
                        title:
                            '¿Quién o quiénes le estarían apoyando en esta nueva inversión?*',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        initialValue: state.recurrenteMejoraViviendaDbLocal
                                ?.siguienteMeta ??
                            'N/A',
                        title:
                            'Una vez finalizado este préstamo ¿Cuál sería su siguiente meta?',
                      ),
                      const Gap(20),
                      ButtonActionsWidget(
                        disabled: state.status == Status.inProgress ||
                            response.status == Status.inProgress,
                        onPreviousPressed: () {
                          context.pop();
                        },
                        onNextPressed: () {
                          context
                              .read<RecurrenteMejoraViviendaCubit>()
                              .sendOfflineAnswers(
                                recurrentemejoravivienda:
                                    MejoraViviendaRecurrente(
                                  tipoSolicitud: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.tipoSolicitud ??
                                      '',
                                  objSolicitudRecurrenteId: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.objSolicitudRecurrenteId ??
                                      0,
                                  username: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.username ??
                                      '',
                                  tieneTrabajo: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.tieneTrabajo ??
                                      false,
                                  database: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.database ??
                                      '',
                                  trabajoNegocioDescripcion: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.trabajoNegocioDescripcion ??
                                      '',
                                  tiempoActividad: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.tiempoActividad ??
                                      0,
                                  otrosIngresos: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.otrosIngresos ??
                                      false,
                                  otrosIngresosDescripcion: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.otrosIngresosDescripcion ??
                                      '',
                                  objTipoComunidadId: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.objTipoComunidadId ??
                                      '',
                                  necesidadesComunidad: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.necesidadesComunidad ??
                                      '',
                                  personasCargo: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.personasCargo ??
                                      '',
                                  numeroHijos: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.numeroHijos ??
                                      0,
                                  edadHijos: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.edadHijos ??
                                      '',
                                  tipoEstudioHijos: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.tipoEstudioHijos ??
                                      '',
                                  motivoPrestamo: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.motivoPrestamo ??
                                      '',
                                  coincideRespuesta: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.coincideRespuesta ??
                                      false,
                                  explicacionInversion: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.explicacionInversion ??
                                      '',
                                  viviendaAntesDespues: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.viviendaAntesDespues ??
                                      '',
                                  mejoraSeguridadFamilia: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.mejoraSeguridadFamilia ??
                                      '',
                                  quienApoya: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.quienApoya ??
                                      '',
                                  siguienteMeta: state
                                          .recurrenteMejoraViviendaDbLocal
                                          ?.siguienteMeta ??
                                      '',
                                ),
                              );
                        },
                        previousTitle: 'Salir'.tr(),
                        nextTitle: 'Enviar'.tr(),
                      ),
                    ],
                  ),
                ),
              _ => const SizedBox(),
            };
          },
        );
      },
    );
  }
}

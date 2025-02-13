import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/forms/mujer_emprende/mujer_emprende_model.dart';
import 'package:core_financiero_app/src/datasource/forms/mujer_emprende/recurrente_mujer_emprende.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/mujer_emprende/mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_mujer_emprende/recurrente_mujer_emprende_cubit.dart';
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

class MujerEmprendeOffline extends StatefulWidget {
  final int solicitudId;
  const MujerEmprendeOffline({
    super.key,
    required this.solicitudId,
  });

  @override
  State<MujerEmprendeOffline> createState() => _MujerEmprendeOfflineState();
}

class _MujerEmprendeOfflineState extends State<MujerEmprendeOffline> {
  @override
  void initState() {
    initFunctions();
    super.initState();
  }

  initFunctions() async {
    final solicitudesProvider =
        context.read<SolicitudesPendientesLocalDbCubit>();
    await solicitudesProvider.getImagesModel(widget.solicitudId);
    await solicitudesProvider.getMujerEmprende(widget.solicitudId);
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
              context.read<UploadUserFileCubit>().uploadUserFilesOffline(
                    numero: context.read<KivaRouteCubit>().state.tipoSolicitud,
                    tipoSolicitud:
                        context.read<KivaRouteCubit>().state.tipoSolicitud,
                    imagen1: state.imageModel?.imagen1 ?? 'NO PATH',
                    imagen2: state.imageModel?.imagen2 ?? 'NO PATH',
                    imagen3: state.imageModel?.imagen3 ?? 'NO PATH',
                    fotoCedula: state.imageModel?.imagen4 ?? 'NO PATH',
                    fotoFirma: state.imageModel?.imagenFirma ?? 'NO PATH',
                    imagenAsesor: state.imageModel?.imagenAsesor ?? 'NO PATH',
                    solicitudId: widget.solicitudId,
                    formularioKiva:
                        context.read<KivaRouteCubit>().state.currentRoute,
                  );
              context
                  .read<SolicitudesPendientesLocalDbCubit>()
                  .removeWhenFormIsUpload(
                    widget.solicitudId,
                    context.read<KivaRouteCubit>().state.currentRoute,
                  );

              await customPopUp(
                context: context,
                dismissOnTouchOutside: false,
                size: MediaQuery.sizeOf(context),
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
                      const Gap(10),
                      CommentaryWidget(
                        readOnly: true,
                        initialValue:
                            state.mujerEmprendeDbLocal?.otrosIngresos ?? false
                                ? 'input.yes'.tr()
                                : 'input.no'.tr(),
                        title: '¿Tiene otros ingresos?¿Cuales?*',
                      ),
                      CommentaryWidget(
                        readOnly: true,
                        title: 'Cuales',
                        initialValue: state.mujerEmprendeDbLocal
                                ?.otrosIngresosDescripcion ??
                            'N/A',
                      ),
                      CommentaryWidget(
                        readOnly: true,
                        initialValue:
                            state.mujerEmprendeDbLocal?.tieneTrabajo ?? false
                                ? 'input.yes'.tr()
                                : 'input.no'.tr(),
                        title: 'Tiene Trabajo?',
                      ),
                      CommentaryWidget(
                        readOnly: true,
                        title: 'Cuales',
                        initialValue: state.mujerEmprendeDbLocal
                                ?.trabajoNegocioDescripcion ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        title: 'forms.entorno_familiar.person_origin'.tr(),
                        initialValue: state.mujerEmprendeDbLocal
                                ?.objOrigenCatalogoValorId ??
                            'N/A',
                      ),
                      CommentaryWidget(
                        readOnly: true,
                        title: 'Número de personas a cargo:*',
                        initialValue: state.mujerEmprendeDbLocal?.personasCargo
                                .toString() ??
                            '0',
                      ),
                      CommentaryWidget(
                        readOnly: true,
                        title: '¿Que edades tienen sus hijos?',
                        initialValue:
                            state.mujerEmprendeDbLocal?.edadHijos ?? '0',
                      ),
                      CommentaryWidget(
                        readOnly: true,
                        title: 'Número de hijos:*',
                        initialValue: state.mujerEmprendeDbLocal?.numeroHijos
                                .toString() ??
                            'N/A',
                      ),
                      CommentaryWidget(
                        readOnly: true,
                        initialValue:
                            state.mujerEmprendeDbLocal?.tipoEstudioHijos ??
                                'N/A',
                        title: '¿Qué tipo de estudios reciben sus hijos?',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        title:
                            'Cuéntenos, ¿Qué la motivó a emprender su negocio?*',
                        initialValue:
                            state.mujerEmprendeDbLocal?.motivoEmprender ??
                                'N/A',
                      ),
                      CommentaryWidget(
                        readOnly: true,
                        title:
                            'Coméntenos, ¿ Cómo conoció el proyecto de Mujer Emprende en MiCrédito?',
                        initialValue:
                            state.mujerEmprendeDbLocal?.conocioMujerEmprende ??
                                'N/A',
                      ),
                      CommentaryWidget(
                        readOnly: true,
                        title:
                            '¿Qué la impulsó a optar a este tipo de crédito?*',
                        initialValue:
                            state.mujerEmprendeDbLocal?.impulsoOptar ?? 'N/A',
                      ),
                      CommentaryWidget(
                        readOnly: true,
                        title: '¿Para qué solicitó este préstamo?* Explique',
                        initialValue:
                            state.mujerEmprendeDbLocal?.motivoPrestamo ?? 'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        title:
                            '¿Quién o quiénes le estarían apoyando en su emprendimiento?*',
                        initialValue:
                            state.mujerEmprendeDbLocal?.quienApoya ?? 'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        title:
                            '¿De qué manera este financiamiento va impactar en su negocio ?*',
                        initialValue:
                            state.mujerEmprendeDbLocal?.comoImpactariaNegocio ??
                                'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        title:
                            '¿Cómo cree usted que este crédito va a mejorar su calidad de vida?*',
                        initialValue:
                            state.mujerEmprendeDbLocal?.comoMejoraCalidadVida ??
                                'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        readOnly: true,
                        title:
                            'Otros datos relevantes e interesantes del cliente',
                        initialValue:
                            state.mujerEmprendeDbLocal?.otrosDatosCliente ??
                                'N/A',
                      ),
                      const Gap(20),
                      ButtonActionsWidget(
                        disabled: state.status == Status.inProgress ||
                            response.status == Status.inProgress,
                        onPreviousPressed: () {
                          context.pop();
                        },
                        onNextPressed: () {
                          context.read<MujerEmprendeCubit>().sendOfflineAnswers(
                                mujerEmprendeModel: MujerEmprendeModel(
                                  tipoSolicitud: state.mujerEmprendeDbLocal
                                          ?.tipoSolicitud ??
                                      '',
                                  tiempoActividad: state.mujerEmprendeDbLocal
                                          ?.tiempoActividad ??
                                      0,
                                  tieneTrabajo: state
                                          .mujerEmprendeDbLocal?.tieneTrabajo ??
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
                                  numeroHijos:
                                      state.mujerEmprendeDbLocal?.numeroHijos ??
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
                                  impulsoOptar: state
                                          .mujerEmprendeDbLocal?.impulsoOptar ??
                                      '',
                                  motivoPrestamo: state.mujerEmprendeDbLocal
                                          ?.motivoPrestamo ??
                                      '',
                                  quienApoya:
                                      state.mujerEmprendeDbLocal?.quienApoya ??
                                          '',
                                  comoImpactariaNegocio: state
                                          .mujerEmprendeDbLocal
                                          ?.comoImpactariaNegocio ??
                                      '',
                                  comoMejoraCalidadVida: state
                                          .mujerEmprendeDbLocal
                                          ?.comoMejoraCalidadVida ??
                                      '',
                                  otrosDatosCliente: state.mujerEmprendeDbLocal
                                          ?.otrosDatosCliente ??
                                      '',
                                ),
                              );
                        },
                        previousTitle: 'button.previous'.tr(),
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

class RecurrenteMujerEmprendeOffline extends StatefulWidget {
  final int solicitudId;
  const RecurrenteMujerEmprendeOffline({
    super.key,
    required this.solicitudId,
  });

  @override
  State<RecurrenteMujerEmprendeOffline> createState() =>
      _RecurrenteMujerEmprendeOfflineState();
}

class _RecurrenteMujerEmprendeOfflineState
    extends State<RecurrenteMujerEmprendeOffline> {
  @override
  void initState() {
    initFunctions();
    super.initState();
  }

  initFunctions() async {
    final solicitudesProvider =
        context.read<SolicitudesPendientesLocalDbCubit>();
    await solicitudesProvider.getRecurrentMujerEmprende(widget.solicitudId);
    await solicitudesProvider.getImagesModel(widget.solicitudId);
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
              context.read<UploadUserFileCubit>().uploadUserFilesOffline(
                    numero: context.read<KivaRouteCubit>().state.tipoSolicitud,
                    tipoSolicitud:
                        context.read<KivaRouteCubit>().state.tipoSolicitud,
                    imagen1: state.imageModel?.imagen1 ?? 'NO PATH',
                    imagen2: state.imageModel?.imagen2 ?? 'NO PATH',
                    imagen3: state.imageModel?.imagen3 ?? 'NO PATH',
                    fotoCedula: state.imageModel?.imagen4 ?? 'NO PATH',
                    fotoFirma: state.imageModel?.imagenFirma ?? 'NO PATH',
                    imagenAsesor: state.imageModel?.imagenAsesor ?? 'NO PATH',
                    solicitudId: widget.solicitudId,
                    formularioKiva:
                        context.read<KivaRouteCubit>().state.currentRoute,
                  );
              context
                  .read<SolicitudesPendientesLocalDbCubit>()
                  .removeWhenFormIsUpload(
                    widget.solicitudId,
                    context.read<KivaRouteCubit>().state.currentRoute,
                  );

              await customPopUp(
                context: context,
                dismissOnTouchOutside: false,
                size: MediaQuery.sizeOf(context),
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
                      const Gap(10),
                      CommentaryWidget(
                        initialValue:
                            state.recurrenteMujerEmprende?.otrosIngresos ??
                                    false
                                ? 'input.yes'.tr()
                                : 'input.no'.tr(),
                        title: '¿Tiene otros ingresos?¿Cuales?*',
                      ),
                      CommentaryWidget(
                        title: 'Cuales?',
                        initialValue: state.recurrenteMujerEmprende
                                ?.otrosIngresosDescripcion ??
                            'N/A',
                      ),
                      CommentaryWidget(
                        title: '¿Tiene Trabajo? Cual?',
                        initialValue:
                            state.recurrenteMujerEmprende?.tieneTrabajo ?? false
                                ? 'input.yes'.tr()
                                : 'input.no'.tr(),
                      ),
                      CommentaryWidget(
                        title: 'Cuales?',
                        initialValue: state.recurrenteMujerEmprende
                                ?.tieneTrabajoDescripcion ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: 'Número de personas a cargo:*',
                        initialValue: state
                                .recurrenteMujerEmprende?.personasCargo
                                .toString() ??
                            '0',
                        textInputType: TextInputType.number,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: 'Número de hijos:*',
                        initialValue: state.recurrenteMujerEmprende?.numeroHijos
                                .toString() ??
                            '0',
                        textInputType: TextInputType.number,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿Que edades tienen sus hijos?',
                        initialValue:
                            state.recurrenteMujerEmprende?.edadHijos ?? 'N/A',
                      ),
                      CommentaryWidget(
                        title: '¿Qué tipo de estudios reciben sus hijos?',
                        initialValue:
                            state.recurrenteMujerEmprende?.edadHijos ?? 'N/A',
                      ),
                      CommentaryWidget(
                        initialValue:
                            state.recurrenteMujerEmprende?.coincideRespuesta ??
                                    false
                                ? 'input.yes'.tr()
                                : 'input.no'.tr(),
                        title:
                            '¿Coincide la respuesta del cliente con el formato anterior?',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        initialValue: state.recurrenteMujerEmprende
                                ?.explicacionInversion ??
                            'N/A',
                        title:
                            '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿De qué manera le ayudó este préstamo Kiva?*',
                        initialValue:
                            state.recurrenteMujerEmprende?.comoAyudo ?? 'N/A',
                      ),
                      CommentaryWidget(
                        initialValue:
                            state.recurrenteMujerEmprende?.motivoPrestamo ??
                                'N/A',
                        title:
                            '¿En qué piensa invertir este nuevo préstamo de Mujer Emprende?* Explique',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        initialValue:
                            state.recurrenteMujerEmprende?.apoyanNegocio ??
                                    false
                                ? 'input.yes'.tr()
                                : 'input.no'.tr(),
                        title: '¿Hay alguien que le apoye en su negocio?'.tr(),
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        initialValue:
                            state.recurrenteMujerEmprende?.cuantosApoyan ??
                                'N/A',
                        title:
                            'De ser positivo, favor responder cuántas personas'
                                .tr(),
                      ),
                      const Gap(20),
                      CommentaryWidget(
                          initialValue:
                              state.recurrenteMujerEmprende?.mejoraraEntorno ??
                                      false
                                  ? 'input.yes'.tr()
                                  : 'input.no'.tr(),
                          title:
                              '¿Considera usted que este nuevo préstamo fortalezca su negocio, mejore sus condiciones de vida y entorno familiar?'),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿Porqué?*',
                        initialValue: state.recurrenteMujerEmprende
                                ?.mejoraraEntornoExplicacion ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: 'A futuro ¿Cuál sería su siguiente paso?',
                        initialValue:
                            state.recurrenteMujerEmprende?.siguientePaso ??
                                'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                          initialValue:
                              state.recurrenteMujerEmprende?.alcanzaraMeta ??
                                      false
                                  ? 'input.yes'.tr()
                                  : 'input.no'.tr(),
                          title:
                              '¿Cree usted que una vez finalizado el pago de este préstamo de Mujer Emprende alcanzó su meta?'),
                      CommentaryWidget(
                        title: '¿Por qué?*',
                        initialValue: state.recurrenteMujerEmprende
                                ?.explicacionAlcanzaraMeta ??
                            'N/A',
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
                              .read<RecurrenteMujerEmprendeCubit>()
                              .sendOfflineAnswers(
                                recurrenteMujerEmprende:
                                    RecurrenteMujerEmprendeModel(
                                  tipoSolicitud: state.recurrenteMujerEmprende
                                          ?.tipoSolicitud ??
                                      '',
                                  tiempoActividad: state.recurrenteMujerEmprende
                                          ?.tiempoActividad ??
                                      0,
                                  database:
                                      state.recurrenteMujerEmprende?.database ??
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
                                  edadHijos: state
                                          .recurrenteMujerEmprende?.edadHijos ??
                                      '',
                                  tipoEstudioHijos: state
                                          .recurrenteMujerEmprende
                                          ?.tipoEstudioHijos ??
                                      '',
                                  motivoPrestamo: state.recurrenteMujerEmprende
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
                                  comoAyudo: state
                                          .recurrenteMujerEmprende?.comoAyudo ??
                                      '',
                                  apoyanNegocio: state.recurrenteMujerEmprende
                                          ?.apoyanNegocio ??
                                      false,
                                  cuantosApoyan: state.recurrenteMujerEmprende
                                          ?.cuantosApoyan ??
                                      '',
                                  mejoraraEntorno: state.recurrenteMujerEmprende
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

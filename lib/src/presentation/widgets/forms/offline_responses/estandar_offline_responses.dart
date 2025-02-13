import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/forms/estandar/estandar_model.dart';
import 'package:core_financiero_app/src/datasource/forms/estandar/recurrente_estandar_model.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/estandar/estandar_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_estandar/recurrente_estandart_cubit.dart';
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

class EstandarOfflineForm extends StatefulWidget {
  final String typeProduct;
  final int solicitudId;

  const EstandarOfflineForm({
    super.key,
    required this.typeProduct,
    required this.solicitudId,
  });

  @override
  State<EstandarOfflineForm> createState() => _EstandarOfflineFormState();
}

class _EstandarOfflineFormState extends State<EstandarOfflineForm> {
  @override
  void initState() {
    super.initState();
    initFunctions();
  }

  initFunctions() async {
    final solicitudesProvider =
        context.read<SolicitudesPendientesLocalDbCubit>();
    await solicitudesProvider.getImagesModel(widget.solicitudId);
    await solicitudesProvider.getRecurrentEstandar(widget.solicitudId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              context.read<UploadUserFileCubit>().uploadUserFilesOffline(
                    numero: context.read<KivaRouteCubit>().state.tipoSolicitud,
                    tipoSolicitud:
                        context.read<KivaRouteCubit>().state.tipoSolicitud,
                    imagen1: resp.imageModel?.imagen1 ?? 'NO PATH',
                    imagen2: resp.imageModel?.imagen2 ?? 'NO PATH',
                    imagen3: resp.imageModel?.imagen3 ?? 'NO PATH',
                    fotoCedula: resp.imageModel?.imagen4 ?? 'NO PATH',
                    fotoFirma: resp.imageModel?.imagenFirma ?? 'NO PATH',
                    imagenAsesor: resp.imageModel?.imagenAsesor ?? 'NO PATH',
                    solicitudId: widget.solicitudId,
                    formularioKiva:
                        context.read<KivaRouteCubit>().state.currentRoute,
                  );

              if (!context.mounted) return;
              context
                  .read<SolicitudesPendientesLocalDbCubit>()
                  .removeWhenFormIsUpload(
                    widget.solicitudId,
                    widget.typeProduct,
                  );
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
            return switch (resp.status) {
              Status.inProgress => const LoadingWidget(),
              Status.done => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommentaryWidget(
                        title: '¿Tiene otros ingresos?¿Cuales?*',
                        initialValue: resp
                            .recurrenteEstandarDbLocal?.otrosIngresos
                            .toString(),
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿Cuales?*',
                        initialValue: resp.recurrenteEstandarDbLocal
                                ?.otrosIngresosDescripcion ??
                            'N/A',
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: 'Número de personas a cargo:*',
                        readOnly: true,
                        textInputType: TextInputType.number,
                        initialValue: resp
                                .recurrenteEstandarDbLocal?.personasCargo
                                .toString() ??
                            '0',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: 'Número de hijos:*',
                        readOnly: true,
                        initialValue: resp
                                .recurrenteEstandarDbLocal?.numeroHijos
                                .toString() ??
                            '0',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿Que edades tienen sus hijos?',
                        readOnly: true,
                        initialValue: resp.recurrenteEstandarDbLocal?.edadHijos
                                .toString() ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿Qué tipo de estudios reciben sus hijos?',
                        readOnly: true,
                        initialValue: resp
                                .recurrenteEstandarDbLocal?.tipoEstudioHijos
                                .toString() ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title:
                            '¿Coincide la respuesta del cliente con el formato anterior?',
                        readOnly: true,
                        initialValue: resp
                                .recurrenteEstandarDbLocal?.coincideRespuesta
                                .toString() ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title:
                            'Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                        readOnly: true,
                        initialValue: resp
                                .recurrenteEstandarDbLocal?.explicacionInversion
                                .toString() ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿Hay alguien que le apoye en su negocio?',
                        readOnly: true,
                        initialValue: resp
                                .recurrenteEstandarDbLocal?.apoyanNegocio
                                .toString() ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title:
                            'De ser positivo, favor responder cuántas personas',
                        readOnly: true,
                        initialValue: resp
                                .recurrenteEstandarDbLocal?.cuantosApoyan
                                .toString() ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title:
                            '¿Cómo este crédito ha constribuido a mejorar su calidad de vida y empoderarse de su negocio? Explique.',
                        readOnly: true,
                        initialValue: resp
                                .recurrenteEstandarDbLocal?.comoMejoraEntorno
                                .toString() ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title:
                            '¿En qué piensa invertir este nuevo préstamo? Explique',
                        readOnly: true,
                        initialValue: resp
                                .recurrenteEstandarDbLocal?.motivoPrestamo
                                .toString() ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title:
                            '¿Considera usted que este nuevo préstamo continúe fortaleciendo su negocio y generando mayores ganancias que beneficien a su familia? Explique ',
                        readOnly: true,
                        initialValue: resp
                                .recurrenteEstandarDbLocal?.comoFortalece
                                .toString() ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: 'A futuro ¿Cuál seria su siguiente paso?*',
                        readOnly: true,
                        initialValue: resp
                                .recurrenteEstandarDbLocal?.siguientePaso
                                .toString() ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title:
                            'Una vez finalizado el pago de este préstamo ¿ Podría ser una persona auto suficiente?',
                        readOnly: true,
                        initialValue: resp.recurrenteEstandarDbLocal
                                ?.personaAutoSuficiente
                                .toString() ??
                            'N/A',
                      ),
                      const Gap(20),
                      ButtonActionsWidget(
                        disabled: resp.status == Status.inProgress ||
                            response.status == Status.inProgress,
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
                                tiempoActividad: resp.recurrenteEstandarDbLocal
                                        ?.tiempoActividad ??
                                    0,
                                tieneTrabajo: resp.recurrenteEstandarDbLocal
                                        ?.tieneTrabajo ??
                                    false,
                                trabajoNegocioDescripcion: resp
                                        .recurrenteEstandarDbLocal
                                        ?.trabajoDescripcion ??
                                    '',
                                database:
                                    resp.recurrenteEstandarDbLocal?.database ??
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
                                edadHijos:
                                    resp.recurrenteEstandarDbLocal?.edadHijos ??
                                        '',
                                tipoEstudioHijos: resp.recurrenteEstandarDbLocal
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
                      ),
                    ],
                  ),
                ),
              _ => const Text('wwww')
            };
          },
        );
      },
    );
  }
}

class EstandarForm extends StatefulWidget {
  final int solicitudId;
  const EstandarForm({
    super.key,
    required this.solicitudId,
  });

  @override
  State<EstandarForm> createState() => _EstandarFormState();
}

class _EstandarFormState extends State<EstandarForm> {
  @override
  void initState() {
    initFunctions();
    super.initState();
  }

  initFunctions() async {
    final solicitudesProvider =
        context.read<SolicitudesPendientesLocalDbCubit>();
    await solicitudesProvider.getImagesModel(widget.solicitudId);
    await solicitudesProvider.getEstandar(widget.solicitudId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

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
                        title: '¿Tiene otros ingresos?¿Cuales?*',
                        initialValue:
                            state.estandarDbLocal?.otrosIngresos ?? false
                                ? 'input.yes'.tr()
                                : 'input.no'.tr(),
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: 'Cuales?',
                        initialValue:
                            state.estandarDbLocal?.otrosIngresosDescripcion ??
                                'N/A',
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: 'forms.entorno_familiar.person_origin'.tr(),
                        initialValue:
                            state.estandarDbLocal?.objOrigenCatalogoValorId ??
                                'N/A',
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: 'Número de personas a cargo:*',
                        initialValue:
                            state.estandarDbLocal?.personasCargo.toString() ??
                                'N/A',
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: 'Número de hijos:*',
                        initialValue:
                            state.estandarDbLocal?.numeroHijos.toString() ??
                                'N/A',
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿Que edades tienen sus hijos?',
                        initialValue:
                            state.estandarDbLocal?.edadHijos.toString() ??
                                'N/A',
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿Qué tipo de estudios reciben sus hijos?',
                        initialValue: state.estandarDbLocal?.tipoEstudioHijos
                                .toString() ??
                            'N/A',
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿Qué tipo de estudios reciben sus hijos?',
                        initialValue: state.estandarDbLocal?.tipoEstudioHijos
                                .toString() ??
                            'N/A',
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿Cuenténos cómo inició su negocio?*',
                        initialValue:
                            state.estandarDbLocal?.inicioNegocio.toString() ??
                                'N/A',
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title:
                            '¿Hay alguien que le apoye en su negocio? de ser positivo,?',
                        initialValue:
                            state.estandarDbLocal?.inicioNegocio.toString() ??
                                'N/A',
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title:
                            '¿Hay alguien que le apoye en su negocio? de ser positivo,?',
                        initialValue:
                            state.estandarDbLocal?.apoyanNegocio.toString() ??
                                'N/A',
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: 'Favor responder cuántas personas',
                        initialValue:
                            state.estandarDbLocal?.cuantosApoyan.toString() ??
                                'N/A',
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title:
                            '¿En qué tipo de lugares le gustaría dar a conocer su producto? ¿Por qué?*',
                        initialValue: state.estandarDbLocal?.publicitarNegocio
                                .toString() ??
                            'N/A',
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿Cómo mira su negocio en los proximos años?*',
                        initialValue: state
                                .estandarDbLocal?.negocioProximosAnios
                                .toString() ??
                            'N/A',
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿Para qué solicitó el préstamo? Explique',
                        initialValue:
                            state.estandarDbLocal?.motivoPrestamo.toString() ??
                                'N/A',
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title:
                            '¿Cuáles son sus planes personales para los proximos 5 años?*',
                        initialValue:
                            state.estandarDbLocal?.planesFuturo.toString() ??
                                'N/A',
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title:
                            '¿Cómo este crédito fortalecerá su negocio y mejorará sus condiciones de vida?*',
                        initialValue:
                            state.estandarDbLocal?.comoMejoraVida.toString() ??
                                'N/A',
                        readOnly: true,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title:
                            'Otros datos relevantes e interesantes del cliente',
                        initialValue: state.estandarDbLocal?.otrosDatosCliente
                                .toString() ??
                            'N/A',
                        readOnly: true,
                      ),
                      const Gap(20),
                      ButtonActionsWidget(
                        disabled: state.status == Status.inProgress ||
                            response.status == Status.inProgress,
                        onPreviousPressed: () {
                          context.pop();
                        },
                        onNextPressed: () {
                          context.read<EstandarCubit>().sendOffilneAnswers(
                                estandarModel: EstandarModel(
                                  tipoSolicitud:
                                      state.estandarDbLocal?.tipoSolicitud ??
                                          '',
                                  tiempoActividad:
                                      state.estandarDbLocal?.tiempoActividad ??
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
                                      state.estandarDbLocal?.personasCargo ?? 0,
                                  numeroHijos:
                                      state.estandarDbLocal?.numeroHijos ?? 0,
                                  edadHijos:
                                      state.estandarDbLocal?.edadHijos ?? '',
                                  tipoEstudioHijos:
                                      state.estandarDbLocal?.tipoEstudioHijos ??
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
                                  publicitarNegocio: state
                                          .estandarDbLocal?.publicitarNegocio ??
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
                                      state.estandarDbLocal?.planesFuturo ?? '',
                                  otrosDatosCliente: state
                                          .estandarDbLocal?.otrosDatosCliente ??
                                      '',
                                ),
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

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/forms/agua_y_saneamiento/agua_y_saneamiento_model.dart';
import 'package:core_financiero_app/src/datasource/forms/agua_y_saneamiento/recurrente_agua_y_saneamiento.dart';
import 'package:core_financiero_app/src/presentation/bloc/agua_y_saneamiento/agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_agua_y_saniamiento/recurrente_agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/custom_pop_up.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AguaSaneamientoOffline extends StatefulWidget {
  final int solicitudId;
  const AguaSaneamientoOffline({
    super.key,
    required this.solicitudId,
  });

  @override
  State<AguaSaneamientoOffline> createState() => _AguaSaneamientoOfflineState();
}

class _AguaSaneamientoOfflineState extends State<AguaSaneamientoOffline> {
  @override
  void initState() {
    context
        .read<SolicitudesPendientesLocalDbCubit>()
        .getSaneamientoNueva(widget.solicitudId);
    context
        .read<SolicitudesPendientesLocalDbCubit>()
        .getImagesModel(widget.solicitudId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, state) {
        return BlocConsumer<AguaYSaneamientoCubit, AguaYSaneamientoState>(
          listener: (context, status) async {
            if (status.status == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  showCloseIcon: true,
                  content: Text(status.errorMsg),
                ),
              );
            }
            if (status.status == Status.done) {
              context.read<UploadUserFileCubit>().uploadUserFilesOffline(
                    imagen1: state.imageModel?.imagen1 ?? 'NO PATH',
                    imagen2: state.imageModel?.imagen2 ?? 'NO PATH',
                    imagen3: state.imageModel?.imagen3 ?? 'NO PATH',
                    fotoCedula: state.imageModel?.imagen4 ?? 'NO PATH',
                    fotoFirma: state.imageModel?.imagenFirma ?? 'NO PATH',
                    solicitudId: widget.solicitudId,
                    formularioKiva:
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
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommentaryWidget(
                    readOnly: true,
                    title: '¿Tiene algún trabajo o negocio? ¿Cuál?',
                    initialValue:
                        state.saneamientoDbLocal?.tieneTrabajo ?? false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                  ),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Cual?',
                    initialValue:
                        state.saneamientoDbLocal?.trabajoNegocioDescripcion ??
                            'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Tiempo de la actividad (meses o años)',
                    initialValue:
                        state.saneamientoDbLocal?.tiempoActividad.toString() ??
                            '0',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title: '¿Tiene otros ingresos?¿Cuales?*',
                    initialValue:
                        state.saneamientoDbLocal?.otrosIngresos ?? false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                  ),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Cuales?',
                    initialValue:
                        state.saneamientoDbLocal?.otrosIngresosDescripcion ??
                            'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                      readOnly: true,
                      title: 'forms.entorno_familiar.person_origin'.tr()),
                  const Gap(10),
                  CommentaryWidget(
                      readOnly: true,
                      title: 'Número de personas a cargo:*',
                      initialValue:
                          state.saneamientoDbLocal?.personasCargo ?? ''),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Numero de Hijos',
                    initialValue:
                        state.saneamientoDbLocal?.numeroHijos.toString() ?? '0',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                      readOnly: true,
                      title: 'forms.entorno_familiar.childs_age'.tr(),
                      initialValue:
                          state.saneamientoDbLocal?.edadHijos ?? 'N/A'),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    initialValue:
                        state.saneamientoDbLocal?.tipoEstudioHijos ?? 'N/A',
                    title: '¿Qué tipo de estudios reciben sus hijos?',
                  ),
                  const Gap(15),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'forms.develpment_and_description.aboutCredit'.tr(),
                    initialValue:
                        state.saneamientoDbLocal?.motivoPrestamo ?? 'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title:
                        '¿Porqué considera importante mejorar las condiciones higiénicas en su familia?*'
                            .tr(),
                    initialValue: state.saneamientoDbLocal
                            ?.importanciaMejorarCondiciones ??
                        'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    initialValue:
                        state.saneamientoDbLocal?.cumpliriaPropuesta ?? false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                    title:
                        '¿Cree usted que con este crédito va poder cumplir el proyecto que se ha propuesto? ¿Por qué?',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Porque?',
                    initialValue: state.saneamientoDbLocal
                            ?.explicacionCumpliriaPropuesta ??
                        'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title: '¿Para que solicitó este préstamo? Explique'.tr(),
                    initialValue:
                        state.saneamientoDbLocal?.motivoPrestamo ?? 'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'forms.impacto_social_kiva.how_perform'.tr(),
                    initialValue:
                        state.saneamientoDbLocal?.mejoraCalidadVida ?? 'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title:
                        '¿Cuál sería el siguiente proyecto para enriquecer su calidad de vida ?*'
                            .tr(),
                    initialValue: state
                            .saneamientoDbLocal?.siguienteProyectoCalidadVida ??
                        'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title:
                        '¿Cuáles son sus metas para los próximos años?*'.tr(),
                    initialValue:
                        state.saneamientoDbLocal?.metasProximas ?? 'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title: '¿Otros datos relevantes e interesantes del cliente:'
                        .tr(),
                    initialValue:
                        state.saneamientoDbLocal?.otrosDatosCliente ?? 'N/A',
                  ),
                  const Gap(20),
                  ButtonActionsWidget(
                    disabled: state.status == Status.inProgress ||
                        response.status == Status.inProgress,
                    onPreviousPressed: () {
                      context.pop();
                    },
                    onNextPressed: () {
                      context.read<AguaYSaneamientoCubit>().sendOfflineAnswers(
                            aguaSaneamientoModel: AguaSaneamientoModel(
                              database:
                                  state.saneamientoDbLocal?.database ?? '',
                              objSolicitudNuevamenorId: state.saneamientoDbLocal
                                      ?.objSolicitudNuevamenorId ??
                                  0,
                              tieneTrabajo:
                                  state.saneamientoDbLocal?.tieneTrabajo ??
                                      false,
                              trabajoNegocioDescripcion: state
                                      .saneamientoDbLocal
                                      ?.trabajoNegocioDescripcion ??
                                  '',
                              tiempoActividad:
                                  state.saneamientoDbLocal?.tiempoActividad ??
                                      0,
                              otrosIngresos:
                                  state.saneamientoDbLocal?.otrosIngresos ??
                                      false,
                              otrosIngresosDescripcion: state.saneamientoDbLocal
                                      ?.otrosIngresosDescripcion ??
                                  '',
                              objOrigenCatalogoValorId: state.saneamientoDbLocal
                                      ?.objOrigenCatalogoValorId ??
                                  '',
                              personasCargo:
                                  state.saneamientoDbLocal?.personasCargo ?? '',
                              numeroHijos:
                                  state.saneamientoDbLocal?.numeroHijos ?? 0,
                              edadHijos:
                                  state.saneamientoDbLocal?.edadHijos ?? '',
                              tipoEstudioHijos:
                                  state.saneamientoDbLocal?.tipoEstudioHijos ??
                                      '',
                              motivacionCredito:
                                  state.saneamientoDbLocal?.motivacionCredito ??
                                      '',
                              importanciaMejorarCondiciones: state
                                      .saneamientoDbLocal
                                      ?.importanciaMejorarCondiciones ??
                                  '',
                              cumpliriaPropuesta: state
                                      .saneamientoDbLocal?.cumpliriaPropuesta ??
                                  false,
                              explicacionCumpliriaPropuesta: state
                                      .saneamientoDbLocal
                                      ?.explicacionCumpliriaPropuesta ??
                                  '',
                              motivoPrestamo:
                                  state.saneamientoDbLocal?.motivoPrestamo ??
                                      '',
                              mejoraCalidadVida:
                                  state.saneamientoDbLocal?.mejoraCalidadVida ??
                                      '',
                              siguienteProyectoCalidadVida: state
                                      .saneamientoDbLocal
                                      ?.siguienteProyectoCalidadVida ??
                                  '',
                              metasProximas:
                                  state.saneamientoDbLocal?.metasProximas ?? '',
                              otrosDatosCliente:
                                  state.saneamientoDbLocal?.otrosDatosCliente ??
                                      '',
                            ),
                          );
                    },
                    previousTitle: 'button.previous'.tr(),
                    nextTitle: 'button.next'.tr(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class RecurrenteSaneamientoOffline extends StatefulWidget {
  final int solicitudId;
  const RecurrenteSaneamientoOffline({
    super.key,
    required this.solicitudId,
  });

  @override
  State<RecurrenteSaneamientoOffline> createState() =>
      _RecurrenteSaneamientoOfflineState();
}

class _RecurrenteSaneamientoOfflineState
    extends State<RecurrenteSaneamientoOffline> {
  @override
  void initState() {
    context
        .read<SolicitudesPendientesLocalDbCubit>()
        .getSaneamientoRecurrente(widget.solicitudId);
    context
        .read<SolicitudesPendientesLocalDbCubit>()
        .getImagesModel(widget.solicitudId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, state) {
        return BlocConsumer<AguaYSaneamientoCubit, AguaYSaneamientoState>(
          listener: (context, status) async {
            if (status.status == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  showCloseIcon: true,
                  content: Text(status.errorMsg),
                ),
              );
            }
            if (status.status == Status.done) {
              context.read<UploadUserFileCubit>().uploadUserFilesOffline(
                    imagen1: state.imageModel?.imagen1 ?? 'NO PATH',
                    imagen2: state.imageModel?.imagen2 ?? 'NO PATH',
                    imagen3: state.imageModel?.imagen3 ?? 'NO PATH',
                    fotoCedula: state.imageModel?.imagen4 ?? 'NO PATH',
                    fotoFirma: state.imageModel?.imagenFirma ?? 'NO PATH',
                    solicitudId: widget.solicitudId,
                    formularioKiva:
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
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Número de personas a cargo:*',
                    initialValue:
                        state.recurrenteSaneamientoDbLocal?.personasCargo ??
                            'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title: '¿Tiene algún trabajo o negocio? ¿Cuál?',
                    initialValue:
                        state.recurrenteSaneamientoDbLocal?.tieneTrabajo ??
                                false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                  ),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Cual?',
                    initialValue: state.recurrenteSaneamientoDbLocal
                            ?.trabajoNegocioDescripcion ??
                        'N/A',
                  ),
                  CommentaryWidget(
                    readOnly: true,
                    initialValue: state
                            .recurrenteSaneamientoDbLocal?.tiempoActividad
                            .toString() ??
                        '0',
                    title: 'Tiempo de la actividad (meses o años):*',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    initialValue:
                        state.recurrenteSaneamientoDbLocal?.otrosIngresos ??
                                false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                    title: '¿Tiene otros ingresos?¿Cuales?*',
                  ),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Cuales?',
                    initialValue: state.recurrenteSaneamientoDbLocal
                            ?.otrosIngresosDescripcion ??
                        'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Número de hijos:*',
                    initialValue: state
                            .recurrenteSaneamientoDbLocal?.numeroHijos
                            .toString() ??
                        '0',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title: '¿Que edades tienen sus hijos?',
                    initialValue:
                        state.recurrenteSaneamientoDbLocal?.edadHijos ?? 'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title: '¿Qué tipo de estudios reciben sus hijos?',
                    initialValue:
                        state.recurrenteSaneamientoDbLocal?.tipoEstudioHijos ??
                            'N/A',
                  ),
                  CommentaryWidget(
                    readOnly: true,
                    initialValue:
                        state.recurrenteSaneamientoDbLocal?.coincideRespuesta ??
                                false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                    title:
                        '¿Coincide la respuesta del cliente con el formato anterior?',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    initialValue: state.recurrenteSaneamientoDbLocal
                            ?.explicacionInversion ??
                        'N/A',
                    title:
                        '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title:
                        '¿De qué manera le ayudó este préstamo Kiva a mejorar sus condiciones en la familia?*',
                    initialValue: state.recurrenteSaneamientoDbLocal
                            ?.comoAyudoCondiciones ??
                        'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title:
                        '¿En qué piensa invertir este nuevo préstamo de agua y saneamiento?*'
                            .tr(),
                    initialValue:
                        state.recurrenteSaneamientoDbLocal?.motivoPrestamo ??
                            'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title:
                        '¿Cómo cree usted que este nuevo préstamo mejore sus condiciones de vida y entorno familiar?*'
                            .tr(),
                    initialValue: state.recurrenteSaneamientoDbLocal
                            ?.comoMejoraCondicionesEntorno ??
                        'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title:
                        '¿Quién o quienes le estarían apoyando en esta inversión?*'
                            .tr(),
                    initialValue:
                        state.recurrenteSaneamientoDbLocal?.quienApoya ?? 'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title:
                        'Una vez finalizado el pago de este préstamo: ¿Cuál sería su siguiente paso?*'
                            .tr(),
                    initialValue:
                        state.recurrenteSaneamientoDbLocal?.siguientePaso ??
                            'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title: '¿Tiene algún trabajo o negocio? ¿Cuál?',
                    initialValue:
                        state.recurrenteSaneamientoDbLocal?.tieneTrabajo ??
                                false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                  ),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Por que?',
                    initialValue: state.recurrenteSaneamientoDbLocal
                            ?.trabajoNegocioDescripcion ??
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
                          .read<RecurrenteAguaYSaneamientoCubit>()
                          .sendOfflineAnswers(
                            recurrenteAguaSaniamientoModel:
                                RecurrenteAguaSaneamientoModel(
                              database: state
                                      .recurrenteSaneamientoDbLocal?.database ??
                                  '',
                              tieneTrabajo: state.recurrenteSaneamientoDbLocal
                                      ?.tieneTrabajo ??
                                  false,
                              trabajoNegocioDescripcion: state
                                      .recurrenteSaneamientoDbLocal
                                      ?.trabajoNegocioDescripcion ??
                                  '',
                              tiempoActividad: state
                                      .recurrenteSaneamientoDbLocal
                                      ?.tiempoActividad ??
                                  0,
                              otrosIngresos: state.recurrenteSaneamientoDbLocal
                                      ?.otrosIngresos ??
                                  false,
                              otrosIngresosDescripcion: state
                                      .recurrenteSaneamientoDbLocal
                                      ?.otrosIngresosDescripcion ??
                                  '',
                              personasCargo: state.recurrenteSaneamientoDbLocal
                                      ?.personasCargo ??
                                  '',
                              numeroHijos: state.recurrenteSaneamientoDbLocal
                                      ?.numeroHijos ??
                                  0,
                              edadHijos: state.recurrenteSaneamientoDbLocal
                                      ?.edadHijos ??
                                  '',
                              tipoEstudioHijos: state
                                      .recurrenteSaneamientoDbLocal
                                      ?.tipoEstudioHijos ??
                                  '',
                              otrosDatosCliente: state
                                      .recurrenteSaneamientoDbLocal
                                      ?.otrosDatosCliente ??
                                  '',
                              objSolicitudRecurrenteId: state
                                      .recurrenteSaneamientoDbLocal
                                      ?.objSolicitudRecurrenteId ??
                                  0,
                              coincideRespuesta: state
                                      .recurrenteSaneamientoDbLocal
                                      ?.coincideRespuesta ??
                                  false,
                              explicacionInversion: state
                                      .recurrenteSaneamientoDbLocal
                                      ?.explicacionInversion ??
                                  '',
                              comoAyudoCondiciones: state
                                      .recurrenteSaneamientoDbLocal
                                      ?.comoAyudoCondiciones ??
                                  '',
                              motivoPrestamo: state.recurrenteSaneamientoDbLocal
                                      ?.motivoPrestamo ??
                                  '',
                              comoMejoraCondicionesEntorno: state
                                      .recurrenteSaneamientoDbLocal
                                      ?.comoMejoraCondicionesEntorno ??
                                  '',
                              quienApoya: state.recurrenteSaneamientoDbLocal
                                      ?.quienApoya ??
                                  '',
                              siguientePaso: state.recurrenteSaneamientoDbLocal
                                      ?.siguientePaso ??
                                  '',
                              alcanzaraMeta: state.recurrenteSaneamientoDbLocal
                                      ?.alcanzaraMeta ??
                                  false,
                              explicacionAlcanzaraMeta: state
                                      .recurrenteSaneamientoDbLocal
                                      ?.explicacionAlcanzaraMeta ??
                                  '',
                            ),
                          );
                    },
                    previousTitle: 'button.previous'.tr(),
                    nextTitle: 'button.next'.tr(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

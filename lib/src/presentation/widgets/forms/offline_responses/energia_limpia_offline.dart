import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/forms/energia_limpia/energia_limpia_model.dart';
import 'package:core_financiero_app/src/datasource/forms/energia_limpia/recurrente_energia_limpia.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/energia_limpia/energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
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

class EnergiaLImpiaOffline extends StatefulWidget {
  final int solicitudId;
  const EnergiaLImpiaOffline({
    super.key,
    required this.solicitudId,
  });

  @override
  State<EnergiaLImpiaOffline> createState() => _EnergiaLImpiaOfflineState();
}

class _EnergiaLImpiaOfflineState extends State<EnergiaLImpiaOffline> {
  @override
  void initState() {
    context
        .read<SolicitudesPendientesLocalDbCubit>()
        .getEnergiaLimpia(widget.solicitudId);
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
        return BlocConsumer<EnergiaLimpiaCubit, EnergiaLimpiaState>(
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
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    title: '¿Tiene algún trabajo o negocio? ¿Cuál?',
                    initialValue:
                        state.energiaLimpiaDbLocal?.tieneTrabajo ?? false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                  ),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Cual',
                    initialValue:
                        state.energiaLimpiaDbLocal?.tieneTrabajo ?? false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Tiempo de la actividad:*',
                    initialValue: state.energiaLimpiaDbLocal?.tiempoActividad
                            .toString() ??
                        'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    title: '¿Tiene otros ingresos?¿Cuales?*',
                    initialValue:
                        state.energiaLimpiaDbLocal?.otrosIngresos ?? false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                  ),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Cuales Otros Ingresos?',
                    initialValue:
                        state.energiaLimpiaDbLocal?.otrosIngresosDescripcion ??
                            'N/A',
                  ),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Su comunidad es:',
                    initialValue:
                        state.energiaLimpiaDbLocal?.objTipoComunidadId ?? 'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    title:
                        '¿Usted tiene problemas de energía eléctrica en su comunidad?',
                    initialValue:
                        state.energiaLimpiaDbLocal?.tieneProblemasEnergia ??
                                false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Numero de persona a cargo',
                    initialValue:
                        state.energiaLimpiaDbLocal?.tieneProblemasEnergia ??
                                false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Número de hijos:*',
                    initialValue:
                        state.energiaLimpiaDbLocal?.numeroHijos.toString() ??
                            '0',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    title: '¿Qué edades tienen sus hijos?',
                    initialValue:
                        state.energiaLimpiaDbLocal?.edadHijos ?? 'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    title: '¿Qué tipo de estudios reciben sus hijos?',
                    initialValue:
                        state.energiaLimpiaDbLocal?.tipoEstudioHijos ?? 'N/A',
                  ),
                  CommentaryWidget(
                    readOnly: true,
                    title:
                        '¿Por qué y para qué solicitó el préstamo? Explique.*',
                    initialValue:
                        state.energiaLimpiaDbLocal?.motivoPrestamo ?? 'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    title: '¿Cuáles son sus planes para los próximos años?',
                    initialValue:
                        state.energiaLimpiaDbLocal?.planesFuturo ?? 'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Otros datos relevantes e interesantes del cliente',
                    initialValue:
                        state.energiaLimpiaDbLocal?.otrosDatosCliente ?? 'N/A',
                  ),
                  const Gap(20),
                  ButtonActionsWidget(
                    disabled: state.status == Status.inProgress ||
                        response.status == Status.inProgress,
                    onPreviousPressed: () {
                      context.pop();
                    },
                    onNextPressed: () {
                      context.read<EnergiaLimpiaCubit>().sendOfflineAnswers(
                            energiaLimpia: EnergiaLimpiaModel(
                              problemasEnergiaDescripcion: state
                                      .energiaLimpiaDbLocal
                                      ?.problemasEnergiaDescripcion ??
                                  '',
                              database:
                                  state.energiaLimpiaDbLocal?.database ?? '',
                              solicitudNuevamenorId: state.energiaLimpiaDbLocal
                                      ?.solicitudNuevamenorId ??
                                  0,
                              tieneTrabajo:
                                  state.energiaLimpiaDbLocal?.tieneTrabajo ??
                                      false,
                              trabajoNegocioDescripcion: state
                                      .energiaLimpiaDbLocal
                                      ?.trabajoNegocioDescripcion ??
                                  '',
                              tiempoActividad:
                                  state.energiaLimpiaDbLocal?.tiempoActividad ??
                                      0,
                              otrosIngresos:
                                  state.energiaLimpiaDbLocal?.otrosIngresos ??
                                      false,
                              otrosIngresosDescripcion: state
                                      .energiaLimpiaDbLocal
                                      ?.otrosIngresosDescripcion ??
                                  '',
                              objOrigenCatalogoValorId: state
                                      .energiaLimpiaDbLocal
                                      ?.objOrigenCatalogoValorId ??
                                  '',
                              objTipoComunidadId: state.energiaLimpiaDbLocal
                                      ?.objTipoComunidadId ??
                                  '',
                              tieneProblemasEnergia: state.energiaLimpiaDbLocal
                                      ?.tieneProblemasEnergia ??
                                  false,
                              personasCargo:
                                  state.energiaLimpiaDbLocal?.personasCargo ??
                                      '',
                              numeroHijos:
                                  state.energiaLimpiaDbLocal?.numeroHijos ?? 0,
                              edadHijos:
                                  state.energiaLimpiaDbLocal?.edadHijos ?? '',
                              tipoEstudioHijos: state
                                      .energiaLimpiaDbLocal?.tipoEstudioHijos ??
                                  '',
                              motivoPrestamo:
                                  state.energiaLimpiaDbLocal?.motivoPrestamo ??
                                      '',
                              planesFuturo:
                                  state.energiaLimpiaDbLocal?.planesFuturo ??
                                      '',
                              otrosDatosCliente: state.energiaLimpiaDbLocal
                                      ?.otrosDatosCliente ??
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

class RecurrenteEnergiaLimpiaOffline extends StatefulWidget {
  final int solicitudId;
  const RecurrenteEnergiaLimpiaOffline({
    super.key,
    required this.solicitudId,
  });

  @override
  State<RecurrenteEnergiaLimpiaOffline> createState() =>
      _RecurrenteEnergiaLimpiaOfflineState();
}

class _RecurrenteEnergiaLimpiaOfflineState
    extends State<RecurrenteEnergiaLimpiaOffline> {
  @override
  void initState() {
    context
        .read<SolicitudesPendientesLocalDbCubit>()
        .getEnergiaLimpiaRecurrente(widget.solicitudId);
    context
        .read<SolicitudesPendientesLocalDbCubit>()
        .getImagesModel(widget.solicitudId);
    super.initState();
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
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    title: '¿Tiene algún trabajo o negocio? ¿Cuál?',
                    initialValue:
                        state.recurrenteEnergiaLimpiaDbLocal?.tieneTrabajo ??
                                false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                  ),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Cual?',
                    initialValue: state.recurrenteEnergiaLimpiaDbLocal
                            ?.trabajoNegocioDescripcion ??
                        'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Tiempo de la actividad:',
                    initialValue: state
                            .recurrenteEnergiaLimpiaDbLocal?.tiempoActividad
                            .toString() ??
                        '0',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Tiene otros ingresos?¿Cuales?*',
                    initialValue:
                        state.recurrenteEnergiaLimpiaDbLocal?.otrosIngresos ??
                                false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                  ),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Ingrese los otros ingresos',
                    initialValue: state.recurrenteEnergiaLimpiaDbLocal
                            ?.otrosIngresosDescripcion ??
                        'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Su comunidad es:',
                    initialValue: state.recurrenteEnergiaLimpiaDbLocal
                            ?.objTipoComunidadId ??
                        'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    title:
                        '¿Usted tiene problemas de energía eléctrica en su comunidad?',
                    initialValue: state.recurrenteEnergiaLimpiaDbLocal
                                ?.tieneProblemasEnergia ??
                            false
                        ? 'input.yes'.tr()
                        : 'input.no'.tr(),
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Numero de persona a cargo',
                    initialValue:
                        state.recurrenteEnergiaLimpiaDbLocal?.personasCargo ??
                            'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    title: 'Número de hijos:*',
                    initialValue: state
                            .recurrenteEnergiaLimpiaDbLocal?.numeroHijos
                            .toString() ??
                        '0',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    title: '¿Qué edades tienen sus hijos?',
                    initialValue:
                        state.recurrenteEnergiaLimpiaDbLocal?.edadHijos ??
                            'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    title: '¿Qué tipo de estudios reciben sus hijos?',
                    initialValue: state
                            .recurrenteEnergiaLimpiaDbLocal?.tipoEstudioHijos ??
                        'N/A',
                  ),
                  const CommentaryWidget(
                      readOnly: true,
                      title:
                          '¿Coincide la respuesta del cliente con el formato anterior?'),
                  CommentaryWidget(
                    readOnly: true,
                    title:
                        '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                    initialValue: state.recurrenteEnergiaLimpiaDbLocal
                            ?.explicacionInversion ??
                        'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    title:
                        '¿Cómo era su situación antes de adquirir esta solución energética y cómo es ahora ?',
                    initialValue: state.recurrenteEnergiaLimpiaDbLocal
                            ?.situacionAntesAhora ??
                        'N/A',
                  ),
                  CommentaryWidget(
                    readOnly: true,
                    title:
                        '¿En qué piensa invertir este nuevo crédito de energía limpia?* Explique',
                    initialValue:
                        state.recurrenteEnergiaLimpiaDbLocal?.motivoPrestamo ??
                            'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    title:
                        '¿Cómo cree usted que este nuevo préstamo vaya a mejorar su situación y la de su familia?*',
                    initialValue: state.recurrenteEnergiaLimpiaDbLocal
                            ?.comoMejoraSituacion ??
                        'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    title:
                        '¿Quién o quiénes le estarían apoyando en esta nueva inversión?*',
                    initialValue:
                        state.recurrenteEnergiaLimpiaDbLocal?.quienApoya ??
                            'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    title:
                        'Una vez finalizado este préstamo ¿Cuál sería su siguiente meta?',
                    initialValue:
                        state.recurrenteEnergiaLimpiaDbLocal?.siguienteMeta ??
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
                          .read<RecurrenteEnergiaLimpiaCubit>()
                          .sendOfflineAnswers(
                            recurrenteEnergiaLimpia:
                                RecurrenteEnergiaLimpiaModel(
                              database:
                                  state.energiaLimpiaDbLocal?.database ?? '',
                              tieneTrabajo:
                                  state.energiaLimpiaDbLocal?.tieneTrabajo ??
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
                              numeroHijos: state.recurrenteEnergiaLimpiaDbLocal
                                      ?.numeroHijos ??
                                  0,
                              edadHijos: state.recurrenteEnergiaLimpiaDbLocal
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
                              quienApoya: state.recurrenteEnergiaLimpiaDbLocal
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

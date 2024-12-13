import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/forms/micredi_estudio/micredi_estudio_model.dart';
import 'package:core_financiero_app/src/datasource/forms/micredi_estudio/recurrente_micredi_estudio_model.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/micredi_estudio/micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_micredi_estudio/recurrente_micredi_estudio_cubit.dart';
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

class MicrediEstudioForm extends StatefulWidget {
  final int solicitudId;

  const MicrediEstudioForm({
    super.key,
    required this.solicitudId,
  });

  @override
  State<MicrediEstudioForm> createState() => _MicrediEstudioFormState();
}

class _MicrediEstudioFormState extends State<MicrediEstudioForm> {
  @override
  void initState() {
    context
        .read<SolicitudesPendientesLocalDbCubit>()
        .getMiCrediEstudio(widget.solicitudId);
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
        return BlocConsumer<MicrediEstudioCubit, MicrediEstudioState>(
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
                children: [
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Profesión u Oficio:',
                    initialValue:
                        state.miCrediEstudioDbLocal?.tieneTrabajo.toString() ??
                            '',
                    readOnly: true,
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: 'Cual?',
                    initialValue: state
                            .miCrediEstudioDbLocal?.trabajoNegocioDescripcion ??
                        '',
                    readOnly: true,
                  ),
                  const CommentaryWidget(
                    title: '¿Tiene algún trabajo o negocio? ¿Cuál?',
                    readOnly: true,
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Tiempo de la actividad (meses o años)'.tr(),
                    readOnly: true,
                    textInputType: TextInputType.number,
                    initialValue: state.miCrediEstudioDbLocal?.tiempoActividad
                            .toString() ??
                        '0',
                  ),
                  CommentaryWidget(
                    title: '¿Tiene otros ingresos?¿Cuales?*',
                    readOnly: true,
                    initialValue:
                        state.miCrediEstudioDbLocal?.otrosIngresos ?? false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'forms.entorno_familiar.question6'.tr(),
                    readOnly: true,
                    initialValue:
                        state.miCrediEstudioDbLocal?.otrosIngresosDescripcion ??
                            'N/A',
                  ),
                  CommentaryWidget(
                    title: 'forms.entorno_familiar.person_origin'.tr(),
                    readOnly: true,
                    initialValue:
                        state.miCrediEstudioDbLocal?.objOrigenCatalogoValorId ??
                            'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Número de personas a cargo:*'.tr(),
                    readOnly: true,
                    initialValue:
                        state.miCrediEstudioDbLocal?.personasCargo.toString() ??
                            'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Número de hijos:*'.tr(),
                    readOnly: true,
                    initialValue:
                        state.miCrediEstudioDbLocal?.numeroHijos.toString() ??
                            '0',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'forms.entorno_familiar.childs_age'.tr(),
                    readOnly: true,
                    initialValue:
                        state.miCrediEstudioDbLocal?.edadHijos.toString() ??
                            '0',
                  ),
                  CommentaryWidget(
                    title: '¿Qué tipo de estudios reciben sus hijos?',
                    readOnly: true,
                    initialValue: state.miCrediEstudioDbLocal?.tipoEstudioHijos
                            .toString() ??
                        'N/A',
                  ),
                  CommentaryWidget(
                    title: 'Carrera:',
                    readOnly: true,
                    initialValue: state.miCrediEstudioDbLocal?.carrera ?? '',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Universidad a la que pertenece:',
                    readOnly: true,
                    initialValue:
                        state.miCrediEstudioDbLocal?.universidad ?? '',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Años de la carrera:',
                    readOnly: true,
                    initialValue:
                        state.miCrediEstudioDbLocal?.tiempoCarrera.toString() ??
                            '',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: '¿Qué te motivó a elegir esa carrera?',
                    readOnly: true,
                    initialValue:
                        state.miCrediEstudioDbLocal?.motivoCarrera ?? '',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: '¿Sentís que te estás realizando profesionalmente?*',
                    readOnly: true,
                    initialValue: state.miCrediEstudioDbLocal
                                ?.relizandoProfesionalmente ??
                            false
                        ? 'input.yes'.tr()
                        : 'inpit.no'.tr(),
                  ),
                  CommentaryWidget(
                    title: 'Por que?',
                    readOnly: true,
                    initialValue: state.miCrediEstudioDbLocal
                            ?.explicacionRelizandoProfesionalmente ??
                        'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: '¿Quién o quiénes te apoyan en tus estudios?*',
                    readOnly: true,
                    initialValue:
                        state.miCrediEstudioDbLocal?.quienApoya ?? 'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title:
                        '¿En qué trabaja o qué negocio tienen tus padres o tutores?*',
                    readOnly: true,
                    initialValue:
                        state.miCrediEstudioDbLocal?.ocupacionPadres ?? 'N/A',
                  ),
                  CommentaryWidget(
                    title: 'forms.miCredi_estudio.question1'.tr(),
                    readOnly: true,
                    initialValue:
                        state.miCrediEstudioDbLocal?.motivoPrestamo ?? 'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title:
                        '¿De qué manera este financiamiento le ayudará a crecer profesionalemente? Explique'
                            .tr(),
                    readOnly: true,
                    initialValue:
                        state.miCrediEstudioDbLocal?.comoAyudaCrecer ?? 'N/A',
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    initialValue:
                        state.miCrediEstudioDbLocal?.optarOtroEstudio ?? false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                    title: '¿Piensa optar a otro estudio superior?*',
                    readOnly: true,
                  ),
                  CommentaryWidget(
                    title: 'Porque?',
                    initialValue:
                        state.miCrediEstudioDbLocal?.cualEstudio ?? 'N/A',
                    readOnly: true,
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title:
                        '¿Cuáles son sus planes en los próximos 10 años?*'.tr(),
                    initialValue:
                        state.miCrediEstudioDbLocal?.planFuturo ?? 'N/A',
                    readOnly: true,
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: '¿Qué aspira laboralmente?*'.tr(),
                    initialValue:
                        state.miCrediEstudioDbLocal?.aspiraLaboralmente ??
                            'N/A',
                    readOnly: true,
                  ),
                  const Gap(10),
                  CommentaryWidget(
                    title: 'Otros datos relevantes e interesantes del cliente'
                        .tr(),
                    initialValue:
                        state.miCrediEstudioDbLocal?.otrosDatosCliente ?? 'N/A',
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
                      context.read<MicrediEstudioCubit>().sendOfflineAnswers(
                            miCrediEstudioModel: MiCrediEstudioModel(
                              database:
                                  state.miCrediEstudioDbLocal?.database ?? '',
                              objSolicitudNuevamenorId: state
                                      .miCrediEstudioDbLocal
                                      ?.objSolicitudNuevamenorId ??
                                  0,
                              tieneTrabajo:
                                  state.miCrediEstudioDbLocal?.tieneTrabajo ??
                                      false,
                              trabajoNegocioDescripcion: state
                                      .miCrediEstudioDbLocal
                                      ?.trabajoNegocioDescripcion ??
                                  'N/A',
                              tiempoActividad: state
                                      .miCrediEstudioDbLocal?.tiempoActividad ??
                                  0,
                              otrosIngresos:
                                  state.miCrediEstudioDbLocal?.otrosIngresos ??
                                      false,
                              otrosIngresosDescripcion: state
                                      .miCrediEstudioDbLocal
                                      ?.otrosIngresosDescripcion ??
                                  '',
                              objOrigenCatalogoValorId: state
                                      .miCrediEstudioDbLocal
                                      ?.objOrigenCatalogoValorId ??
                                  '',
                              personasCargo:
                                  state.miCrediEstudioDbLocal?.personasCargo ??
                                      0,
                              numeroHijos:
                                  state.miCrediEstudioDbLocal?.numeroHijos ?? 0,
                              edadHijos:
                                  state.miCrediEstudioDbLocal?.edadHijos ?? '',
                              tipoEstudioHijos: state.miCrediEstudioDbLocal
                                      ?.tipoEstudioHijos ??
                                  '',
                              carrera:
                                  state.miCrediEstudioDbLocal?.carrera ?? '',
                              tiempoCarrera:
                                  state.miCrediEstudioDbLocal?.tiempoCarrera ??
                                      0,
                              universidad:
                                  state.miCrediEstudioDbLocal?.universidad ??
                                      '',
                              motivoCarrera:
                                  state.miCrediEstudioDbLocal?.motivoCarrera ??
                                      '',
                              relizandoProfesionalmente: state
                                      .miCrediEstudioDbLocal
                                      ?.relizandoProfesionalmente ??
                                  false,
                              explicacionRelizandoProfesionalmente: state
                                      .miCrediEstudioDbLocal
                                      ?.explicacionRelizandoProfesionalmente ??
                                  '',
                              quienApoya:
                                  state.miCrediEstudioDbLocal?.quienApoya ?? '',
                              ocupacionPadres: state
                                      .miCrediEstudioDbLocal?.ocupacionPadres ??
                                  '',
                              motivoPrestamo:
                                  state.miCrediEstudioDbLocal?.motivoPrestamo ??
                                      '',
                              comoAyudaCrecer: state
                                      .miCrediEstudioDbLocal?.comoAyudaCrecer ??
                                  '',
                              optarOtroEstudio: state.miCrediEstudioDbLocal
                                      ?.optarOtroEstudio ??
                                  false,
                              cualEstudio:
                                  state.miCrediEstudioDbLocal?.cualEstudio ??
                                      '',
                              planFuturo:
                                  state.miCrediEstudioDbLocal?.planFuturo ?? '',
                              aspiraLaboralmente: state.miCrediEstudioDbLocal
                                      ?.aspiraLaboralmente ??
                                  '',
                              otrosDatosCliente: state.miCrediEstudioDbLocal
                                      ?.otrosDatosCliente ??
                                  '',
                            ),
                          );
                    },
                    previousTitle: 'Salir',
                    nextTitle: 'Enviar',
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

class MiCrediEstudioRecurrenteForm extends StatefulWidget {
  final int solicitudId;
  const MiCrediEstudioRecurrenteForm({
    super.key,
    required this.solicitudId,
  });

  @override
  State<MiCrediEstudioRecurrenteForm> createState() =>
      _MiCrediEstudioRecurrenteFormState();
}

class _MiCrediEstudioRecurrenteFormState
    extends State<MiCrediEstudioRecurrenteForm> {
  @override
  void initState() {
    context
        .read<SolicitudesPendientesLocalDbCubit>()
        .getRecurrentMiCrediEstudio(widget.solicitudId);
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
        return BlocConsumer<RecurrenteMicrediEstudioCubit,
            RecurrenteMicrediEstudioState>(
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
                    title: '¿Tiene algún trabajo o negocio? ¿Cuál?',
                    readOnly: true,
                    initialValue:
                        (state.recurrenteMiCrediEstudioDbLocal?.tieneTrabajo ??
                                false)
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Cual?',
                    readOnly: true,
                    initialValue: state.recurrenteMiCrediEstudioDbLocal
                            ?.trabajoNegocioDescripcion ??
                        'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Tiempo de la actividad (meses o años)',
                    readOnly: true,
                    initialValue: state
                            .recurrenteMiCrediEstudioDbLocal?.tiempoActividad
                            .toString() ??
                        '0',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: '¿Tiene otros ingresos?',
                    readOnly: true,
                    initialValue:
                        state.recurrenteMiCrediEstudioDbLocal?.otrosIngresos ??
                                false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: '¿Cuáles?',
                    readOnly: true,
                    initialValue: state.recurrenteMiCrediEstudioDbLocal
                            ?.otrosIngresosDescripcion ??
                        '',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Número de personas a cargo:*',
                    readOnly: true,
                    initialValue: state
                            .recurrenteMiCrediEstudioDbLocal?.personasCargo
                            .toString() ??
                        '0',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Número de hijos:*',
                    readOnly: true,
                    initialValue: state
                            .recurrenteMiCrediEstudioDbLocal?.numeroHijos
                            .toString() ??
                        '0',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: '¿Que edades tienen sus hijos? ',
                    readOnly: true,
                    initialValue: state
                            .recurrenteMiCrediEstudioDbLocal?.edadHijos
                            .toString() ??
                        'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: '¿Qué tipo de estudios reciben sus hijos?',
                    readOnly: true,
                    initialValue: state
                            .recurrenteMiCrediEstudioDbLocal?.tipoEstudioHijos
                            .toString() ??
                        'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Carrera:',
                    readOnly: true,
                    initialValue: state.recurrenteMiCrediEstudioDbLocal?.carrera
                            .toString() ??
                        'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Años de la carrera:',
                    readOnly: true,
                    initialValue: state
                            .recurrenteMiCrediEstudioDbLocal?.tiempoCarrera
                            .toString() ??
                        'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    initialValue: state
                            .recurrenteMiCrediEstudioDbLocal?.universidad
                            .toString() ??
                        'N/A',
                    title: 'Universidad a la que pertenece',
                    readOnly: true,
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    initialValue: state
                            .recurrenteMiCrediEstudioDbLocal?.quienApoya
                            .toString() ??
                        'N/A',
                    title:
                        '¿Quién o quiénes le estarían apoyando en esta nueva etapa?*',
                    readOnly: true,
                  ),
                  CommentaryWidget(
                    title:
                        '¿Coincide la respuesta del cliente con el formato anterior?',
                    readOnly: true,
                    initialValue: state.recurrenteMiCrediEstudioDbLocal
                                ?.coincideRespuesta ??
                            false
                        ? 'input.yes'.tr()
                        : 'input.no'.tr(),
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title:
                        '* Si la respuesta es no, explique en que invirtió y porqué hizo esa nueva inversión.',
                    initialValue: state.recurrenteMiCrediEstudioDbLocal
                            ?.explicacionInversion ??
                        'N/A',
                    readOnly: true,
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title:
                        '¿De qué manera ayudó este préstamo Kiva en su vida profesional?*',
                    initialValue: state.recurrenteMiCrediEstudioDbLocal
                            ?.comoAyudoProfesionalmente ??
                        'N/A',
                    readOnly: true,
                  ),
                  CommentaryWidget(
                    initialValue:
                        state.recurrenteMiCrediEstudioDbLocal?.motivoPrestamo ??
                            'N/A',
                    title:
                        '¿En qué piensa invertir este nuevo préstamo de MiCrediestudio?* Explique',
                    readOnly: true,
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    initialValue:
                        state.recurrenteMiCrediEstudioDbLocal?.motivoPrestamo ??
                            'N/A',
                    readOnly: true,
                    title:
                        '¿Cómo cree usted que este nuevo préstamo le ayude en su crecimiento profesional?*',
                  ),
                  const Gap(20),
                  const CommentaryWidget(
                    readOnly: true,
                    title:
                        '¿Cree usted que una vez finalizado el pago de este préstamo de MiCréditoEstudio alcanzó su meta académica? ¿Por qué?',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    initialValue: state.recurrenteMiCrediEstudioDbLocal
                            ?.explicacionAlcanzaraMeta ??
                        'N/A',
                    title: 'Explica la meta?',
                    readOnly: true,
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    readOnly: true,
                    initialValue:
                        state.recurrenteMiCrediEstudioDbLocal?.siguientePaso ??
                            '',
                    title: '¿Cuál sería su siguiente paso?',
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
                          .read<RecurrenteMicrediEstudioCubit>()
                          .sendOfflineAnswers(
                            recurrenteMicrediEstudioModel:
                                RecurrenteMiCrediEstudioModel(
                              database: state.recurrenteMiCrediEstudioDbLocal
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
                              numeroHijos: state.recurrenteMiCrediEstudioDbLocal
                                      ?.numeroHijos ??
                                  0,
                              edadHijos: state.recurrenteMiCrediEstudioDbLocal
                                      ?.edadHijos ??
                                  '',
                              tipoEstudioHijos: state
                                      .recurrenteMiCrediEstudioDbLocal
                                      ?.tipoEstudioHijos ??
                                  '',
                              carrera: state.recurrenteMiCrediEstudioDbLocal
                                      ?.carrera ??
                                  '',
                              tiempoCarrera: state
                                      .recurrenteMiCrediEstudioDbLocal
                                      ?.tiempoCarrera ??
                                  0,
                              universidad: state.recurrenteMiCrediEstudioDbLocal
                                      ?.universidad ??
                                  '',
                              quienApoya: state.recurrenteMiCrediEstudioDbLocal
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

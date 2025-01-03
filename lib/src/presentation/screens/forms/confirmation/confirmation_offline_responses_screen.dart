import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/forms/migrantes-economicos/migrantes_ecomicos.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/agua_y_saneamiento/agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/energia_limpia/energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/estandar/estandar_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/mejora_vivienda/mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/micredi_estudio/micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/migrantes_economicos/migrantes_economicos_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/mujer_emprende/mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_,mejora_vivienda.dart/recurrente_mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_agua_y_saniamiento/recurrente_agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_estandar/recurrente_estandart_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_estandar_confirmation/recurrente_estandar_confirmation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_micredi_estudio/recurrente_micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_mujer_emprende/recurrente_mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/energia_limpia_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/estandar_offline_responses.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/mejora_vivienda_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/micredi_estudio_responses.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/mujer_emprende_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/saneamiento_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/custom_pop_up.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ConfirmationOfflineResponsesScreen extends StatelessWidget {
  final String typeProduct;
  const ConfirmationOfflineResponsesScreen(
      {super.key, required this.typeProduct});

  @override
  Widget build(BuildContext context) {
    final solicitudId = context.read<KivaRouteCubit>().state.solicitudId;
    final name = context.read<KivaRouteCubit>().state.nombre;
    final isar = context.read<SolicitudesPendientesLocalDbCubit>().state.isar;
    final respository = ResponsesRepositoryImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => RecurrenteEstandartCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => EstandarCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => MicrediEstudioCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteEstandarConfirmationCubit()
            ..getRecurrentResponses(
                isar: isar, solicitudId: int.tryParse(solicitudId) ?? 0),
        ),
        BlocProvider(
          create: (ctx) => MejoraViviendaCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteMejoraViviendaCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteMejoraViviendaCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => AguaYSaneamientoCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteAguaYSaneamientoCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => EnergiaLimpiaCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteEnergiaLimpiaCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => MujerEmprendeCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteMujerEmprendeCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => UploadUserFileCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => RecurrenteMicrediEstudioCubit(respository),
        ),
        BlocProvider(
          create: (ctx) => MigrantesEconomicosCubit(respository),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: _CurrentForm(
          typeProduct: typeProduct,
          solicitudId: solicitudId,
        ),
      ),
    );
  }
}

class _CurrentForm extends StatelessWidget {
  const _CurrentForm({
    required this.typeProduct,
    required this.solicitudId,
  });

  final String typeProduct;
  final String solicitudId;

  @override
  Widget build(BuildContext context) {
    return switch (typeProduct) {
      'ESTANDAR RECURRENTE' => EstandarOfflineForm(
          typeProduct: typeProduct,
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'ESTANDAR NUEVO' => EstandarForm(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'MICREDIESTUDIO NUEVO' => MicrediEstudioForm(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'MICREDIESTUDIO RECURRENTE' => MiCrediEstudioRecurrenteForm(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'VIVIENDA NUEVA' => ViviendaNuevaOfflineResponse(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'VIVIENDA REPRESTAMO' => RecurrenteViviendaOfflineResponse(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'AGUA Y SANEAMIENTO NUEVO' => AguaSaneamientoOffline(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'AGUA Y SANEAMIENTO RECURRENTE' => RecurrenteSaneamientoOffline(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'ASER NUEVO' => EnergiaLImpiaOffline(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'ASER RECURRENTE' => RecurrenteEnergiaLimpiaOffline(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'MUJER EMPRENDE NUEVO' => MujerEmprendeOffline(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'MUJER EMPRENDE RECURRENTE' => RecurrenteMujerEmprendeOffline(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'ESTANDAR COLONES NUEVO MAYOR A MIL' => MigranteEconomicoOffline(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'ESTANDAR COLONES NUEVO MENOR A MIL' => MigranteEconomicoOffline(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      _ => const SizedBox(),
    };
  }
}

class MigranteEconomicoOffline extends StatefulWidget {
  final int solicitudId;
  const MigranteEconomicoOffline({super.key, required this.solicitudId});

  @override
  State<MigranteEconomicoOffline> createState() =>
      _MigranteEconomicoOfflineState();
}

class _MigranteEconomicoOfflineState extends State<MigranteEconomicoOffline> {
  @override
  void initState() {
    initFunctions();
    super.initState();
  }

  initFunctions() async {
    final solicitudesProvider =
        context.read<SolicitudesPendientesLocalDbCubit>();
    await solicitudesProvider.getMigranteEconomico(widget.solicitudId);
    await solicitudesProvider.getImagesModel(widget.solicitudId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, state) {
        return BlocConsumer<MigrantesEconomicosCubit, MigrantesEconomicosState>(
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
                            state.migranteEconomicoDbLocal?.tieneTrabajo ??
                                    false
                                ? 'input.yes'.tr()
                                : 'input.no'.tr(),
                        title: '¿Tiene algún trabajo o negocio? ¿Cuál?',
                      ),
                      const Gap(20),
                      if (state.migranteEconomicoDbLocal?.tieneTrabajo ?? false)
                        CommentaryWidget(
                          title: 'Cual',
                          initialValue: state.migranteEconomicoDbLocal
                                  ?.trabajoNegocioDescripcion ??
                              'N/A',
                        ),
                      const Gap(10),
                      CommentaryWidget(
                        title: 'Tiempo de la actividad:* (MESES)',
                        initialValue: state
                                .migranteEconomicoDbLocal?.tiempoActividad
                                ?.toString() ??
                            '0',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        initialValue:
                            state.migranteEconomicoDbLocal?.otrosIngresos ??
                                    false
                                ? 'input.yes'.tr()
                                : 'input.no'.tr(),
                        title: '¿Tiene otros ingresos?¿Cuales?*',
                      ),
                      if (state.migranteEconomicoDbLocal?.otrosIngresos ??
                          false)
                        CommentaryWidget(
                          title: 'Cuales Otros Ingresos?',
                          initialValue: state.migranteEconomicoDbLocal
                                  ?.otrosIngresosDescripcion ??
                              'N/A',
                        ),
                      const Gap(20),
                      CommentaryWidget(
                        title: 'Número de personas a cargo:*',
                        initialValue: state
                                .migranteEconomicoDbLocal?.personasCargo
                                ?.toString() ??
                            '0',
                        textInputType: TextInputType.number,
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: 'forms.entorno_familiar.person_origin'.tr(),
                        initialValue: state.migranteEconomicoDbLocal
                                ?.objOrigenUbicacionGeograficaId ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿Qué le motivó a dejar su país natal?',
                        initialValue:
                            state.migranteEconomicoDbLocal?.motivoDejarPais ??
                                'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿Cuál es su situación migratoria en éste país?',
                        initialValue: state.migranteEconomicoDbLocal
                                ?.situacionMigratoria ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿En su país de origen a qué se dedicaba?',
                        initialValue: state
                                .migranteEconomicoDbLocal?.dedicabaPaisOrigen ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿Con quién vive en este país?',
                        initialValue:
                            state.migranteEconomicoDbLocal?.vivePaisActual ??
                                'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: 'Número de hijos:*',
                        initialValue: state
                                .migranteEconomicoDbLocal?.numeroHijos
                                ?.toString() ??
                            '0',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿Qué edades tienen sus hijos?',
                        initialValue:
                            state.migranteEconomicoDbLocal?.edadHijos ?? 'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿Qué tipo de estudios reciben sus hijos?',
                        initialValue:
                            state.migranteEconomicoDbLocal?.tipoEstudioHijos ??
                                'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿Envía remesas a su país de origen?',
                        initialValue:
                            state.migranteEconomicoDbLocal?.enviaRemesas ??
                                    false
                                ? 'input.yes'.tr()
                                : 'input.no'.tr(),
                      ),
                      if (state.migranteEconomicoDbLocal?.enviaRemesas ?? false)
                        CommentaryWidget(
                          title: '¿Por qué lo hace?',
                          initialValue: state.migranteEconomicoDbLocal
                                  ?.enviaRemesasExplicacion ??
                              'N/A',
                        ),
                      const Gap(20),
                      CommentaryWidget(
                        initialValue:
                            state.migranteEconomicoDbLocal?.quienApoya ?? 'N/A',
                        title:
                            '¿Quién o quiénes le apoyan para salir adelante?',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title:
                            '¿Le gustaría fortalecer su negocio o ingresos económicos?'
                                .tr(),
                        initialValue: state.migranteEconomicoDbLocal
                                    ?.fortalecerIngresos ??
                                false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                      ),
                      const Gap(20),
                      if (state.migranteEconomicoDbLocal?.fortalecerIngresos ??
                          false)
                        CommentaryWidget(
                          title: '¿Porqué?',
                          initialValue: state.migranteEconomicoDbLocal
                                  ?.fortalecerIngresosExplicacion ??
                              'N/A',
                        ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿Cuáles son las metas a futuro que tiene?',
                        initialValue:
                            state.migranteEconomicoDbLocal?.metasFuturo ??
                                'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title: '¿Para qué solicitó el crédito?'.tr(),
                        initialValue:
                            state.migranteEconomicoDbLocal?.motivoPrestamo ??
                                'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
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
                        CommentaryWidget(
                          title: '¿Por qué?'.tr(),
                          initialValue: state.migranteEconomicoDbLocal
                                  ?.ayudaMejorarCondicionesExplicacion ??
                              'N/A',
                        ),
                      const Gap(20),
                      CommentaryWidget(
                        title:
                            '¿Cuáles son sus propósitos para los próximos años?'
                                .tr(),
                        initialValue: state
                                .migranteEconomicoDbLocal?.propositosProximos ??
                            'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title:
                            '¿Piensa regresar a su país natal algún día?'.tr(),
                        initialValue:
                            state.migranteEconomicoDbLocal?.piensaRegresar ??
                                'N/A',
                      ),
                      const Gap(20),
                      CommentaryWidget(
                        title:
                            'Otros datos relevantes e interesantes del cliente'
                                .tr(),
                        initialValue:
                            state.migranteEconomicoDbLocal?.otrosDatosCliente ??
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
                              .read<MigrantesEconomicosCubit>()
                              .sendOfflineAnswers(
                                migrantesEconomicos: MigrantesEconomicos(
                                  database: LocalStorage().database,
                                  objSolicitudNuevamenorId: int.tryParse(context
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
                                  otrosIngresos: state.migranteEconomicoDbLocal
                                          ?.otrosIngresos ??
                                      false,
                                  otrosIngresosDescripcion: state
                                          .migranteEconomicoDbLocal
                                          ?.otrosIngresosDescripcion ??
                                      '',
                                  personasCargo: state.migranteEconomicoDbLocal
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
                                  vivePaisActual: state.migranteEconomicoDbLocal
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
                                  motivoPrestamo: state.migranteEconomicoDbLocal
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
                                  piensaRegresar: state.migranteEconomicoDbLocal
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

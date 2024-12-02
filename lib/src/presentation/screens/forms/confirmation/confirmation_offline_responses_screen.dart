import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/forms/mujer_emprende/mujer_emprende_model.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/agua_y_saneamiento/agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/energia_limpia/energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/estandar/estandar_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/mejora_vivienda/mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/micredi_estudio/micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/mujer_emprende/mujer_emprende_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_,mejora_vivienda.dart/recurrente_mejora_vivienda_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_agua_y_saniamiento/recurrente_agua_y_saneamiento_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_estandar/recurrente_estandart_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_estandar_confirmation/recurrente_estandar_confirmation_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/energia_limpia_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/estandar_offline_responses.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/mejora_vivienda_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/micredi_estudio_responses.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/saneamiento_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/custom_pop_up.dart';
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
      'MUJER EMPRENDE RECURRENTE' => const Text('Mujer Emprende recurrente'),
      _ => const SizedBox(),
    };
  }
}

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
    context.read<SolicitudesPendientesLocalDbCubit>().getMujerEmprende(
          widget.solicitudId,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, state) {
        return BlocConsumer<MujerEmprendeCubit, MujerEmprendeState>(
          listener: (context, state) async {
            if (state.status == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  showCloseIcon: true,
                  content: Text(state.errorMsg),
                ),
              );
            }
            if (state.status == Status.done) {
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
                  const Gap(10),
                  CommentaryWidget(
                    initialValue:
                        state.mujerEmprendeDbLocal?.otrosIngresos ?? false
                            ? 'input.yes'.tr()
                            : 'input.no'.tr(),
                    title: '¿Tiene otros ingresos?¿Cuales?*',
                  ),
                  CommentaryWidget(
                    title: 'Cuales',
                    initialValue:
                        state.mujerEmprendeDbLocal?.otrosIngresosDescripcion ??
                            'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'forms.entorno_familiar.person_origin'.tr(),
                    initialValue:
                        state.mujerEmprendeDbLocal?.objOrigenCatalogoValorId ??
                            'N/A',
                  ),
                  CommentaryWidget(
                    title: 'Número de personas a cargo:*',
                    initialValue:
                        state.mujerEmprendeDbLocal?.personasCargo.toString() ??
                            '0',
                  ),
                  CommentaryWidget(
                    title: '¿Que edades tienen sus hijos?',
                    initialValue: state.mujerEmprendeDbLocal?.edadHijos ?? '0',
                  ),
                  CommentaryWidget(
                    title: 'Número de hijos:*',
                    initialValue:
                        state.mujerEmprendeDbLocal?.numeroHijos.toString() ??
                            'N/A',
                  ),
                  CommentaryWidget(
                    initialValue:
                        state.mujerEmprendeDbLocal?.tipoEstudioHijos ?? 'N/A',
                    title: '¿Qué tipo de estudios reciben sus hijos?',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Cuéntenos, ¿Qué la motivó a emprender su negocio?*',
                    initialValue:
                        state.mujerEmprendeDbLocal?.motivoEmprender ?? 'N/A',
                  ),
                  CommentaryWidget(
                    title:
                        'Coméntenos, ¿ Cómo conoció el proyecto de Mujer Emprende en MiCrédito?',
                    initialValue:
                        state.mujerEmprendeDbLocal?.conocioMujerEmprende ??
                            'N/A',
                  ),
                  CommentaryWidget(
                    title: '¿Qué la impulsó a optar a este tipo de crédito?*',
                    initialValue:
                        state.mujerEmprendeDbLocal?.impulsoOptar ?? 'N/A',
                  ),
                  CommentaryWidget(
                    title: '¿Para qué solicitó este préstamo?* Explique',
                    initialValue:
                        state.mujerEmprendeDbLocal?.motivoPrestamo ?? 'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title:
                        '¿Quién o quiénes le estarían apoyando en su emprendimiento?*',
                    initialValue:
                        state.mujerEmprendeDbLocal?.quienApoya ?? 'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title:
                        '¿De qué manera este financiamiento va impactar en su negocio ?*',
                    initialValue:
                        state.mujerEmprendeDbLocal?.comoImpactariaNegocio ??
                            'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title:
                        '¿Cómo cree usted que este crédito va a mejorar su calidad de vida?*',
                    initialValue:
                        state.mujerEmprendeDbLocal?.comoMejoraCalidadVida ??
                            'N/A',
                  ),
                  const Gap(20),
                  CommentaryWidget(
                    title: 'Otros datos relevantes e interesantes del cliente',
                    initialValue:
                        state.mujerEmprendeDbLocal?.otrosDatosCliente ?? 'N/A',
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
                              database:
                                  state.mujerEmprendeDbLocal?.database ?? '',
                              objSolicitudNuevamenorId: state
                                      .mujerEmprendeDbLocal
                                      ?.objSolicitudNuevamenorId ??
                                  0,
                              otrosIngresos:
                                  state.mujerEmprendeDbLocal?.otrosIngresos ??
                                      false,
                              otrosIngresosDescripcion: state
                                      .mujerEmprendeDbLocal
                                      ?.otrosIngresosDescripcion ??
                                  '',
                              objOrigenCatalogoValorId: state
                                      .mujerEmprendeDbLocal
                                      ?.objOrigenCatalogoValorId ??
                                  '',
                              personasCargo:
                                  state.mujerEmprendeDbLocal?.personasCargo ??
                                      0,
                              numeroHijos:
                                  state.mujerEmprendeDbLocal?.numeroHijos ?? 0,
                              edadHijos:
                                  state.mujerEmprendeDbLocal?.edadHijos ?? '',
                              tipoEstudioHijos: state
                                      .mujerEmprendeDbLocal?.tipoEstudioHijos ??
                                  '',
                              motivoEmprender:
                                  state.mujerEmprendeDbLocal?.motivoEmprender ??
                                      '',
                              conocioMujerEmprende: state.mujerEmprendeDbLocal
                                      ?.conocioMujerEmprende ??
                                  '',
                              impulsoOptar:
                                  state.mujerEmprendeDbLocal?.impulsoOptar ??
                                      '',
                              motivoPrestamo:
                                  state.mujerEmprendeDbLocal?.motivoPrestamo ??
                                      '',
                              quienApoya:
                                  state.mujerEmprendeDbLocal?.quienApoya ?? '',
                              comoImpactariaNegocio: state.mujerEmprendeDbLocal
                                      ?.comoImpactariaNegocio ??
                                  '',
                              comoMejoraCalidadVida: state.mujerEmprendeDbLocal
                                      ?.comoMejoraCalidadVida ??
                                  '',
                              otrosDatosCliente: state.mujerEmprendeDbLocal
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

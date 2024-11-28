import 'package:core_financiero_app/src/datasource/forms/micredi_estudio/micredi_estudio_model.dart';
import 'package:core_financiero_app/src/domain/repository/kiva/responses/responses_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/estandar/estandar_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva_route/kiva_route_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/micredi_estudio/micredi_estudio_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_estandar/recurrente_estandart_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/forms/saneamiento_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/offline_responses/estandar_offline_responses.dart';
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
    final solicitudId = context.watch<KivaRouteCubit>().state.solicitudId;
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
      ],
      child: Scaffold(
        appBar: AppBar(),
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
      'ESTANDAR NUEVO' => EstandarOfflineForm(
          typeProduct: typeProduct,
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'ESTANDAR RECURRENTE' => EstandarForm(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      'MICREDIESTUDIO NUEVO' => MicrediEstudioForm(
          solicitudId: int.tryParse(solicitudId) ?? 0,
        ),
      _ => const SizedBox(),
    };
  }
}

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudesPendientesLocalDbCubit,
        SolicitudesPendientesLocalDbState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const Gap(20),
              CommentaryWidget(
                title: 'Profesión u Oficio:',
                initialValue:
                    state.miCrediEstudioDbLocal?.tieneTrabajo.toString() ?? '',
              ),
              const Gap(10),
              CommentaryWidget(
                title: 'Cual?',
                initialValue:
                    state.miCrediEstudioDbLocal?.trabajoNegocioDescripcion ??
                        '',
              ),
              const CommentaryWidget(
                title: '¿Tiene algún trabajo o negocio? ¿Cuál?',
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'Tiempo de la actividad (meses o años)'.tr(),
                textInputType: TextInputType.number,
                initialValue:
                    state.miCrediEstudioDbLocal?.tiempoActividad.toString() ??
                        '0',
              ),
              CommentaryWidget(
                title: '¿Tiene otros ingresos?¿Cuales?*',
                initialValue:
                    state.miCrediEstudioDbLocal?.otrosIngresos ?? false
                        ? 'input.yes'.tr()
                        : 'input.no'.tr(),
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'forms.entorno_familiar.question6'.tr(),
                initialValue:
                    state.miCrediEstudioDbLocal?.otrosIngresosDescripcion ??
                        'N/A',
              ),
              CommentaryWidget(
                title: 'forms.entorno_familiar.person_origin'.tr(),
                initialValue:
                    state.miCrediEstudioDbLocal?.objOrigenCatalogoValorId ??
                        'N/A',
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'Número de personas a cargo:*'.tr(),
                initialValue:
                    state.miCrediEstudioDbLocal?.personasCargo ?? 'N/A',
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'Número de hijos:*'.tr(),
                initialValue:
                    state.miCrediEstudioDbLocal?.numeroHijos.toString() ?? '0',
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'forms.entorno_familiar.childs_age'.tr(),
                initialValue:
                    state.miCrediEstudioDbLocal?.edadHijos.toString() ?? '0',
              ),
              CommentaryWidget(
                title: '¿Qué tipo de estudios reciben sus hijos?',
                initialValue:
                    state.miCrediEstudioDbLocal?.tipoEstudioHijos.toString() ??
                        'N/A',
              ),
              CommentaryWidget(
                title: 'Carrera:',
                initialValue: state.miCrediEstudioDbLocal?.carrera ?? '',
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'Universidad a la que pertenece:',
                initialValue: state.miCrediEstudioDbLocal?.universidad ?? '',
              ),
              const Gap(20),
              CommentaryWidget(
                title: 'Años de la carrera:',
                initialValue:
                    state.miCrediEstudioDbLocal?.tiempoCarrera.toString() ?? '',
              ),
              const Gap(20),
              CommentaryWidget(
                title: '¿Qué te motivó a elegir esa carrera?',
                initialValue: state.miCrediEstudioDbLocal?.motivoCarrera ?? '',
              ),
              const Gap(20),
              CommentaryWidget(
                title: '¿Sentís que te estás realizando profesionalmente?*',
                initialValue:
                    state.miCrediEstudioDbLocal?.relizandoProfesionalmente ??
                            false
                        ? 'input.yes'.tr()
                        : 'inpit.no'.tr(),
              ),
              CommentaryWidget(
                title: 'Por que?',
                initialValue: state.miCrediEstudioDbLocal
                        ?.explicacionRelizandoProfesionalmente ??
                    'N/A',
              ),
              const Gap(20),
              CommentaryWidget(
                title: '¿Quién o quiénes te apoyan en tus estudios?*',
                initialValue: state.miCrediEstudioDbLocal?.quienApoya ?? 'N/A',
              ),
              const Gap(20),
              CommentaryWidget(
                title:
                    '¿En qué trabaja o qué negocio tienen tus padres o tutores?*',
                initialValue:
                    state.miCrediEstudioDbLocal?.ocupacionPadres ?? 'N/A',
              ),
              CommentaryWidget(
                title: 'forms.miCredi_estudio.question1'.tr(),
                initialValue:
                    state.miCrediEstudioDbLocal?.motivoPrestamo ?? 'N/A',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'input.input_validator'.tr();
                  }
                  return null;
                },
              ),
              const Gap(10),
              CommentaryWidget(
                title:
                    '¿De qué manera este financiamiento le ayudará a crecer profesionalemente? Explique'
                        .tr(),
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
              ),
              CommentaryWidget(
                title: 'Porque?',
                initialValue: state.miCrediEstudioDbLocal?.cualEstudio ?? 'N/A',
              ),
              const Gap(10),
              CommentaryWidget(
                title: '¿Cuáles son sus planes en los próximos 10 años?*'.tr(),
                initialValue: state.miCrediEstudioDbLocal?.planFuturo ?? 'N/A',
              ),
              const Gap(10),
              CommentaryWidget(
                title: '¿Qué aspira laboralmente?*'.tr(),
                initialValue:
                    state.miCrediEstudioDbLocal?.aspiraLaboralmente ?? 'N/A',
              ),
              const Gap(10),
              CommentaryWidget(
                title: 'Otros datos relevantes e interesantes del cliente'.tr(),
                initialValue:
                    state.miCrediEstudioDbLocal?.otrosDatosCliente ?? 'N/A',
              ),
              const Gap(20),
              ButtonActionsWidget(
                // disabled: state.status == Status.inProgress ||
                // response.status == Status.inProgress,
                onPreviousPressed: () {
                  context.pop();
                },
                onNextPressed: () {
                  context.read<MicrediEstudioCubit>().sendOfflineAnswers(
                        miCrediEstudioModel: MiCrediEstudioModel(
                          database: state.miCrediEstudioDbLocal?.database ?? '',
                          objSolicitudNuevamenorId: state.miCrediEstudioDbLocal
                                  ?.objSolicitudNuevamenorId ??
                              0,
                          tieneTrabajo:
                              state.miCrediEstudioDbLocal?.tieneTrabajo ??
                                  false,
                          trabajoNegocioDescripcion: state.miCrediEstudioDbLocal
                                  ?.trabajoNegocioDescripcion ??
                              'N/A',
                          tiempoActividad:
                              state.miCrediEstudioDbLocal?.tiempoActividad ?? 0,
                          otrosIngresos:
                              state.miCrediEstudioDbLocal?.otrosIngresos ??
                                  false,
                          otrosIngresosDescripcion: state.miCrediEstudioDbLocal
                                  ?.otrosIngresosDescripcion ??
                              '',
                          objOrigenCatalogoValorId: state.miCrediEstudioDbLocal
                                  ?.objOrigenCatalogoValorId ??
                              '',
                          personasCargo:
                              state.miCrediEstudioDbLocal?.personasCargo ?? '',
                          numeroHijos:
                              state.miCrediEstudioDbLocal?.numeroHijos ?? 0,
                          edadHijos:
                              state.miCrediEstudioDbLocal?.edadHijos ?? '',
                          tipoEstudioHijos:
                              state.miCrediEstudioDbLocal?.tipoEstudioHijos ??
                                  '',
                          carrera: state.miCrediEstudioDbLocal?.carrera ?? '',
                          tiempoCarrera:
                              state.miCrediEstudioDbLocal?.tiempoCarrera ?? 0,
                          universidad:
                              state.miCrediEstudioDbLocal?.universidad ?? '',
                          motivoCarrera:
                              state.miCrediEstudioDbLocal?.motivoCarrera ?? '',
                          relizandoProfesionalmente: state.miCrediEstudioDbLocal
                                  ?.relizandoProfesionalmente ??
                              false,
                          explicacionRelizandoProfesionalmente: state
                                  .miCrediEstudioDbLocal
                                  ?.explicacionRelizandoProfesionalmente ??
                              '',
                          quienApoya:
                              state.miCrediEstudioDbLocal?.quienApoya ?? '',
                          ocupacionPadres:
                              state.miCrediEstudioDbLocal?.ocupacionPadres ??
                                  '',
                          motivoPrestamo:
                              state.miCrediEstudioDbLocal?.motivoPrestamo ?? '',
                          comoAyudaCrecer:
                              state.miCrediEstudioDbLocal?.comoAyudaCrecer ??
                                  '',
                          optarOtroEstudio:
                              state.miCrediEstudioDbLocal?.optarOtroEstudio ??
                                  false,
                          cualEstudio:
                              state.miCrediEstudioDbLocal?.cualEstudio ?? '',
                          planFuturo:
                              state.miCrediEstudioDbLocal?.planFuturo ?? '',
                          aspiraLaboralmente:
                              state.miCrediEstudioDbLocal?.aspiraLaboralmente ??
                                  '',
                          otrosDatosCliente:
                              state.miCrediEstudioDbLocal?.otrosDatosCliente ??
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
  }
}

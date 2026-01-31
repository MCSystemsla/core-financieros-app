// ignore_for_file: deprecated_member_use

import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/grupales/grupo_activo_response.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/grupos_activos/grupos_activos_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/asignacion_solicitud/asignacion_solicitud_grupal_hn_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/autorizacion/autorizacion_solicitud_grupal_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/selectable_card/selectable_card_item.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/no_data/empty_list_widget.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CrearGrupoCreditoGrupalScreen extends StatelessWidget {
  const CrearGrupoCreditoGrupalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => GruposActivosCubit(
            SolicitudesCreditoHnRepositoryImpl(),
          )..getGruposActivos(),
        ),
      ],
      child: Scaffold(
        floatingActionButton: const _FabCrearGrupo(),
        appBar: AppBar(
          title: const Text('Solicitudes Grupales'),
        ),
        body: BlocBuilder<GruposActivosCubit, GruposActivosState>(
          builder: (context, state) {
            return switch (state.status) {
              Status.inProgress => const LoadingWidget(),
              Status.error => OnErrorWidget(
                  errorMsg: state.errorMsg,
                  onPressed: () =>
                      context.read<GruposActivosCubit>().getGruposActivos(),
                ),
              Status.done => _ListData(
                  grupoActivoData: state.gruposActivos,
                ),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}

class _ListData extends StatelessWidget {
  final List<GrupoActivoData> grupoActivoData;

  const _ListData({required this.grupoActivoData});

  @override
  Widget build(BuildContext context) {
    if (grupoActivoData.isEmpty) {
      return const EmptyListWidget(message: 'No hay grupos activos');
    }
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: grupoActivoData.length,
      itemBuilder: (BuildContext context, int index) {
        return SelectableCardItem(
          color: const Color(0xFF1565C0),
          icon: Icons.group,
          title: grupoActivoData[index].nombreCompleto,
          subtitle: 'Codigo: ${grupoActivoData[index].codigo}',
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (ctx) => _ModalSheetGrupales(
                grupoActivoData: grupoActivoData[index],
              ),
            );
          },
        );
      },
    );
  }
}

class CreateGrupoCreditoGrupalContainerForm extends StatefulWidget {
  final Function(String nombre) onGrupoCreditoCreated;
  const CreateGrupoCreditoGrupalContainerForm({
    super.key,
    required this.onGrupoCreditoCreated,
  });

  @override
  State<CreateGrupoCreditoGrupalContainerForm> createState() =>
      _CreateGrupoCreditoGrupalContainerFormState();
}

class _CreateGrupoCreditoGrupalContainerFormState
    extends State<CreateGrupoCreditoGrupalContainerForm> {
  String? nombre;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.40,
        minChildSize: 0.30,
        maxChildSize: 0.70,
        expand: false,
        builder: (context, _) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: SingleChildScrollView(
              controller: ScrollController(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Gap(15),
                    Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const Gap(20),
                    OutlineTextfieldWidget(
                      title: 'Nombre del grupo',
                      icon: const Icon(Icons.group),
                      textInputType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      onChange: (value) {
                        nombre = value;
                      },
                    ),
                    const Gap(20),
                    BlocConsumer<GruposActivosCubit, GruposActivosState>(
                      listenWhen: (previous, current) =>
                          previous.createStatus != current.createStatus,
                      listener: (context, state) {
                        if (state.createStatus == Status.error) {
                          CustomAlertDialog(
                            context: context,
                            title: state.errorMsg,
                            onDone: () => context.pop(),
                          ).showDialog(
                            context,
                            dialogType: DialogType.error,
                          );
                        }
                        if (state.createStatus == Status.done) {
                          CustomAlertDialog(
                            context: context,
                            title: 'Grupo creado exitosamente!!',
                            onDone: () {
                              context.pop();
                              context.pop();
                              context
                                  .read<GruposActivosCubit>()
                                  .getGruposActivos();
                            },
                          ).showDialog(
                            context,
                            dialogType: DialogType.success,
                          );
                        }
                      },
                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          child: CustomElevatedButton(
                            enabled: state.createStatus != Status.inProgress,
                            text: state.createStatus == Status.inProgress
                                ? 'Cargando...'
                                : 'Crear Grupo',
                            color: AppColors.greenLatern.withOpacity(0.4),
                            onPressed: () {
                              if (!formKey.currentState!.validate()) return;
                              widget.onGrupoCreditoCreated(nombre!);
                            },
                          ),
                        );
                      },
                    ),
                    const Gap(20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FabCrearGrupo extends StatelessWidget {
  const _FabCrearGrupo();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        final cubit = context.read<GruposActivosCubit>();

        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (modalContext) => BlocProvider.value(
            value: cubit,
            child: CreateGrupoCreditoGrupalContainerForm(
              onGrupoCreditoCreated: (nombre) {
                cubit.createGrupoCredito(nombre: nombre);
              },
            ),
          ),
        );
      },
    );
  }
}

class _ModalSheetGrupales extends StatelessWidget {
  final GrupoActivoData grupoActivoData;
  const _ModalSheetGrupales({
    required this.grupoActivoData,
  });
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.41,
      minChildSize: 0.2,
      maxChildSize: 0.5,
      expand: false,
      builder: (_, controller) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xfff9fafb),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(28),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 25,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 42,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const Gap(18),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                children: [
                  SelectableCardItem(
                    icon: Icons.group_add_rounded,
                    color: const Color(0xFF2E7D32),
                    title: 'Asignacion de Solicitud Grupal',
                    subtitle: 'Asignar solicitud a grupo',
                    onTap: () => {
                      context.pushTransparentRoute(
                        AsignacionSolicitudGrupalHnScreen(
                          grupoActivoData: grupoActivoData,
                        ),
                      ),
                    },
                  ),
                  SelectableCardItem(
                    icon: Icons.verified_user,
                    color: Colors.indigo,
                    title: 'Autorizar Solicitud Grupal',
                    subtitle: 'Autorizar solicitud grupal',
                    onTap: () => {
                      context.pushTransparentRoute(
                        AutorizacionSolicitudGrupalScreen(
                          grupoActivoData: grupoActivoData,
                        ),
                      ),
                    },
                  ),
                ],
              ),
            ],
          ),
        ).fadeIn();
      },
    );
  }
}

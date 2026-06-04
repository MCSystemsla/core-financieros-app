import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/calculo_cuota/calculo_cuota_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/ni/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/navbar/navbar.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/update_solicitud/asalariado/actualizar_solicitud_asalariado_container.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/update_solicitud/nuevamenor/actualizar_solicitud_nueva_menor_container.dart';
import 'package:core_financiero_app/src/utils/extensions/type_form/type_form_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../bloc/solicitudes/hn/cubit/grupos_activos/grupos_activos_cubit.dart';
import '../../../../bloc/solicitudes/hn/cubit/update_solicitud_nueva_menor/update_solicitud_nueva_menor_cubit.dart';

class ActualizacionSolicitudFormScreenHn extends StatelessWidget {
  final String tipoSolicitud;
  final int idSolicitud;
  final bool isSolicitudGrupal;
  const ActualizacionSolicitudFormScreenHn({
    super.key,
    required this.tipoSolicitud,
    required this.idSolicitud,
    required this.isSolicitudGrupal,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => UpdateSolicitudNuevaMenorCubit(
            SolicitudesCreditoHnRepositoryImpl(),
          )..getSolicitudDataById(
              tipoSolicitud: tipoSolicitud,
              idSolicitud: idSolicitud,
            ),
        ),
        BlocProvider(
          create: (ctx) => GruposActivosCubit(
            SolicitudesCreditoHnRepositoryImpl(),
          )..getGruposActivos(),
        ),
        BlocProvider(
          create: (ctx) => CalculoCuotaCubit(),
        ),
      ],
      child: Scaffold(
        floatingActionButton: _UpdateSolicitudButton(
          idSolicitud: idSolicitud,
          tipoSolicitud: tipoSolicitud,
        ),
        body: BlocBuilder<UpdateSolicitudNuevaMenorCubit,
            UpdateSolicitudNuevaMenorState>(
          builder: (context, state) {
            return switch (state.status) {
              Status.inProgress => const LoadingWidget(),
              Status.error => Text(state.errorMsg),
              Status.done => _ActualizarSolicitudByTypeForm(
                  typeForm: tipoSolicitud.toTypeForm(),
                  isSolicitudGrupal: isSolicitudGrupal,
                ),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}

class _ActualizarSolicitudByTypeForm extends StatelessWidget {
  final TypeForm typeForm;
  final bool isSolicitudGrupal;
  const _ActualizarSolicitudByTypeForm({
    required this.typeForm,
    required this.isSolicitudGrupal,
  });

  @override
  Widget build(BuildContext context) {
    return switch (typeForm) {
      TypeForm.nueva => ActualizarSolicitudNuevaMenorContainer(
          isSolicitudGrupal: isSolicitudGrupal,
        ),
      TypeForm.asalariado => const ActualizarSolicitudAsalariadoContainer(),
      TypeForm.represtamo => const Text('Represtamo'),
    };
  }
}

class ActualizarSolicitudReprestamoContainer extends StatelessWidget {
  const ActualizarSolicitudReprestamoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Column(
      children: [
        const Navbar(
          title: 'Actualizar Solicitud Represtamo',
        ),
        Expanded(
          child: SafeArea(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: const [
                Text('Aún no se puede actualizar un solicitud de Represtamo'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _UpdateSolicitudButton extends StatelessWidget {
  final int idSolicitud;
  final String tipoSolicitud;
  const _UpdateSolicitudButton({
    required this.idSolicitud,
    required this.tipoSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateSolicitudNuevaMenorCubit,
        UpdateSolicitudNuevaMenorState>(
      listenWhen: (previous, current) =>
          previous.updateStatus != current.updateStatus,
      listener: (context, state) {
        if (state.updateStatus == Status.done) {
          CustomAlertDialog(
            context: context,
            title: 'Solicitud actualizada exitosamente',
            onDone: () => context.pop(),
          ).showDialog(context, dialogType: DialogType.success);
        }
        if (state.updateStatus == Status.error) {
          CustomAlertDialog(
            context: context,
            title: state.errorMsg,
            onDone: () => context.pop(),
          ).showDialog(context, dialogType: DialogType.error);
        }
      },
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: state.updateStatus == Status.inProgress
              ? null
              : () {
                  context
                      .read<UpdateSolicitudNuevaMenorCubit>()
                      .updateSolicitud(
                        idSolicitud: idSolicitud,
                        tipoSolicitud: tipoSolicitud.toTypeForm(),
                      );
                },
          child: state.updateStatus == Status.inProgress
              ? const CircularProgressIndicator()
              : const Icon(Icons.save),
        );
      },
    );
  }
}

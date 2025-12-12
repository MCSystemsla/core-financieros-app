import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/cerrar_analisis/cerrar_analisis_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitudes_by_estado_hn/solicitudes_by_estado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/snackbar/closing_analisis_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CerrarAnalisisListener extends StatelessWidget {
  const CerrarAnalisisListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CerrarAnalisisCubit, CerrarAnalisisState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);

        if (state.status == Status.inProgress) {
          messenger.showSnackBar(
            closingAnalisisSnackBar(
              currentNumeroSolicitud: state.currentNumeroSolicitud,
            ),
          );
        }

        if (state.status == Status.done) {
          messenger.clearSnackBars();
          CustomAlertDialog(
            context: context,
            title: 'Análisis cerrado exitosamente',
            onDone: () {
              context.pop();
              context.read<SolicitudesByEstadoHnCubit>().getSolicitudesByEstado(
                    isAsignadaToAsesorCredito: true,
                    estadoCredito: EstadoCredito.asignada,
                  );
            },
          ).showDialog(
            context,
            dialogType: DialogType.success,
          );
        }

        if (state.status == Status.error) {
          messenger.clearSnackBars();
          CustomAlertDialog(
            context: context,
            title: state.errorMsg,
            onDone: () => context.pop(),
          ).showDialog(
            context,
            dialogType: DialogType.error,
          );
        }
      },
      builder: (_, __) => const SizedBox.shrink(),
    );
  }
}

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/ni/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/ni/cubit/enviar_cedula_solicitud_ni/enviar_cedula_solicitud_ni_cubit.dart';
import 'package:core_financiero_app/src/utils/extensions/loading/loading_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Botón "Reenviar fotos cédula" para una solicitud NI ya creada en el
/// servidor. Sube otra vez las fotos de la cédula guardadas en el teléfono al
/// expediente digital. No se muestra si la solicitud no tiene número.
class ReenviarFotosCedulaNiButton extends StatelessWidget {
  const ReenviarFotosCedulaNiButton({
    super.key,
    required this.numeroSolicitud,
    required this.cedula,
    required this.tipoSolicitud,
  });

  final String? numeroSolicitud;
  final String? cedula;

  /// Tipo con el que se guardó la cédula en `ObjectBoxService`:
  /// `NUEVA_MENOR`, `ASALARIADO` o `REPRESTAMO`.
  final String tipoSolicitud;

  @override
  Widget build(BuildContext context) {
    final numero = numeroSolicitud ?? '';
    final cedulaCliente = cedula ?? '';
    if (numero.isEmpty || cedulaCliente.isEmpty) {
      return const SizedBox.shrink();
    }

    return BlocProvider(
      create: (_) => EnviarCedulaSolicitudNiCubit(
        SolicitudCreditoRepositoryImpl(),
      ),
      child: _ReenviarFotosCedulaNiView(
        numeroSolicitud: numero,
        cedula: cedulaCliente,
        tipoSolicitud: tipoSolicitud,
      ),
    );
  }
}

class _ReenviarFotosCedulaNiView extends StatelessWidget {
  const _ReenviarFotosCedulaNiView({
    required this.numeroSolicitud,
    required this.cedula,
    required this.tipoSolicitud,
  });

  final String numeroSolicitud;
  final String cedula;
  final String tipoSolicitud;

  @override
  Widget build(BuildContext context) {
    return BlocListener<EnviarCedulaSolicitudNiCubit,
        EnviarCedulaSolicitudNiState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        switch (state.status) {
          case Status.inProgress:
            context.showLoading(message: 'Enviando fotos de la cédula...');
          case Status.done:
            context.hideLoading();
            showV2CustomSnackbar(
              context,
              title: 'Las fotos de la cédula fueron enviadas exitosamente',
              type: SnackbarType.success,
            );
          case Status.error:
            context.hideLoading();
            showV2CustomSnackbar(
              context,
              title: state.errorMsg,
              type: SnackbarType.error,
            );
          default:
            break;
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
        child: SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: RedesignColors.ink,
              backgroundColor: RedesignColors.surface,
              side: const BorderSide(color: RedesignColors.border),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.upload_file_outlined),
            label: Text('Reenviar fotos cédula · No. $numeroSolicitud'),
            onPressed: () {
              final imagenes = global<ObjectBoxService>().getCedula(
                cedula: cedula,
                tipoSolicitud: tipoSolicitud,
              );
              context.read<EnviarCedulaSolicitudNiCubit>().enviarCedulaSolicitud(
                    numeroSolicitud: numeroSolicitud,
                    cedulaCliente: cedula,
                    imagenFrontal: imagenes?.imageFrontCedula,
                    imagenTrasera: imagenes?.imageBackCedula,
                  );
            },
          ),
        ),
      ),
    );
  }
}

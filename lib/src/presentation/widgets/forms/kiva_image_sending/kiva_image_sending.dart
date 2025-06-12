import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/upload_user_file/upload_user_file_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/downsloading_catalogos_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class KivaImageSending extends StatefulWidget {
  final VoidCallback onRetry;
  final String solicitudId;
  const KivaImageSending({
    super.key,
    required this.onRetry,
    required this.solicitudId,
  });

  @override
  State<KivaImageSending> createState() => _KivaImageSendingState();
}

class _KivaImageSendingState extends State<KivaImageSending> {
  @override
  void initState() {
    super.initState();
    widget.onRetry();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: BlocConsumer<UploadUserFileCubit, UploadUserFileState>(
          listener: (context, state) {
            if (state.status == Status.done) {
              context
                  .read<SolicitudesPendientesLocalDbCubit>()
                  .updateIsImagesSendedOnSolicitud(
                    solicitudId: widget.solicitudId,
                  );
            }
          },
          builder: (context, state) {
            return switch (state.status) {
              Status.inProgress => const DownloadCatalogoLoading(
                  lottieAsset: ImageAsset.enviarSolicitudOfflines,
                  text: 'Enviando Imagenes...',
                ),
              Status.done => Padding(
                  padding: const EdgeInsets.all(10),
                  child: DownloadCatalogoLoading(
                    isSucess: true,
                    lottieAsset: ImageAsset.nuevaMenorSuccess,
                    text: 'Imagenes enviadas exitosamente!!',
                    repeat: false,
                    isUploadingForms: false,
                    onDownloadComplete: () {
                      context.pushReplacement('/');
                    },
                  ),
                ),
              Status.error => OnErrorWidget(
                  needToGoBack: false,
                  errorMsg: 'Error al enviar imagenes, intente nuevamente',
                  onPressed: () {
                    if (state.imageRetryAttempts >= 3) {
                      CustomAlertDialog(
                        context: context,
                        title: 'Limite de intentos excedido, intente mas tarde',
                        onDone: () => context.pushReplacement('/'),
                      ).showDialog(context);
                      return;
                    }
                    widget.onRetry();
                  },
                ),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}

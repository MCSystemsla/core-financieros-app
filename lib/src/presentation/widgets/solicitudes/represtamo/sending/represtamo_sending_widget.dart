import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_represtamo/solicitud_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/downsloading_catalogos_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReprestamoSendingWidget extends StatefulWidget {
  final int solicitudId;

  const ReprestamoSendingWidget({
    super.key,
    required this.solicitudId,
  });

  @override
  State<ReprestamoSendingWidget> createState() =>
      _ReprestamoSendingWidgetState();
}

class _ReprestamoSendingWidgetState extends State<ReprestamoSendingWidget> {
  @override
  void initState() {
    context.read<SolicitudReprestamoCubit>().createSolicitudReprestamo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dbProvider = global<ObjectBoxService>();
    return BlocConsumer<SolicitudReprestamoCubit, SolicitudReprestamoState>(
      listener: (context, state) {
        if (state.status == Status.done) {
          dbProvider.removeSolicitudWhenisUploaded(
            solicitudId: widget.solicitudId,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: switch (state.status) {
            Status.inProgress => const DownloadCatalogoLoading(
                lottieAsset: ImageAsset.nuevaMenorUploading,
                text: 'Enviando solicitud a servidor...',
              ),
            Status.done => Padding(
                padding: const EdgeInsets.all(10),
                child: DownloadCatalogoLoading(
                  isSucess: true,
                  lottieAsset: ImageAsset.nuevaMenorSuccess,
                  text:
                      'Solicitud enviada exitosamente!!\n\n ${state.successMsg}',
                  repeat: false,
                  isUploadingForms: true,
                ),
              ),
            Status.error => OnErrorWidget(
                needToGoBack: true,
                errorMsg: state.errorMsg.capitalizeAll,
                onPressed: () {
                  context
                      .read<SolicitudReprestamoCubit>()
                      .createSolicitudReprestamo();
                },
              ),
            _ => const SizedBox(),
          },
        );
      },
    );
  }
}

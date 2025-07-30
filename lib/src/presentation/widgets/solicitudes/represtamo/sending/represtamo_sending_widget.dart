import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_represtamo/solicitud_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/exit_confirmation_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/downsloading_catalogos_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
  final localDbProvider = global<ObjectBoxService>();

  @override
  void initState() {
    super.initState();
    final imagesCedula = localDbProvider.getCedula(
      cedula: context.read<SolicitudReprestamoCubit>().state.cedula,
      tipoSolicitud: 'REPRESTAMO',
    );
    context.read<SolicitudReprestamoCubit>().saveCedula(
          cedulaFrontPath: imagesCedula?.imageFrontCedula,
          cedulaBackPath: imagesCedula?.imageBackCedula,
        );

    context.read<SolicitudReprestamoCubit>().createSolicitudReprestamo();
  }

  @override
  Widget build(BuildContext context) {
    final dbProvider = global<ObjectBoxService>();
    return BlocConsumer<SolicitudReprestamoCubit, SolicitudReprestamoState>(
      listener: (context, state) {
        if (state.status == Status.done) {
          context.read<SolicitudReprestamoCubit>().sendCedulaImages(
                numeroSolicitud: state.numeroSolicitud,
              );
          dbProvider.removeSolicitudReprestamoWhenisUploaded(
            solicitudId: widget.solicitudId,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                ExitConfirmationDialog(
                  context: context,
                  title: '¿Estás seguro de que quieres salir?',
                  onYes: () {
                    context.pushReplacement('/');
                  },
                ).showDialog(context);
              },
              icon: const Icon(Icons.close),
            ),
          ),
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

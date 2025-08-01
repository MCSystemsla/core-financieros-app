import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/exit_confirmation_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/downsloading_catalogos_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SendingFormWidget extends StatefulWidget {
  final int solicitudId;
  const SendingFormWidget({super.key, required this.solicitudId});

  @override
  State<SendingFormWidget> createState() => _SendingFormWidgetState();
}

class _SendingFormWidgetState extends State<SendingFormWidget> {
  @override
  void initState() {
    context.read<SolicitudNuevaMenorCubit>().createSolicitudNuevaMenor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dbProvider = global<ObjectBoxService>();
    return BlocConsumer<SolicitudNuevaMenorCubit, SolicitudNuevaMenorState>(
      listener: (context, state) {
        if (state.status == Status.done) {
          dbProvider.removeSolicitudWhenisUploaded(
            solicitudId: widget.solicitudId,
          );
          context.read<SolicitudNuevaMenorCubit>().sendCedulaImages(
                numeroSolicitud: state.numeroSolicitud,
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
                      'Solicitud enviada exitosamente!!\n\n${state.onSuccessMsg}',
                  repeat: false,
                  isUploadingForms: true,
                ),
              ),
            Status.error => OnErrorWidget(
                needToGoBack: true,
                errorMsg: state.errorMsg,
                onPressed: () {
                  context
                      .read<SolicitudNuevaMenorCubit>()
                      .createSolicitudNuevaMenor();
                },
              ),
            _ => const SizedBox(),
          },
        );
      },
    );
  }
}

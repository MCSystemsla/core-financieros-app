import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_nueva_menor_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/exit_confirmation_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/downsloading_catalogos_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SendingFormWidgetHN extends StatefulWidget {
  const SendingFormWidgetHN({super.key});

  @override
  State<SendingFormWidgetHN> createState() => _SendingFormWidgetHNState();
}

class _SendingFormWidgetHNState extends State<SendingFormWidgetHN> {
  @override
  void initState() {
    super.initState();
    context.read<SolicitudNuevaMenorHnCubit>().createSolicitudNuevaMenor();
  }

  @override
  Widget build(BuildContext context) {
    // final dbProvider = global<ObjectBoxService>();
    return BlocConsumer<SolicitudNuevaMenorHnCubit, SolicitudNuevaMenorHnState>(
      listener: (context, state) {
        if (state.status == Status.done) {
          // dbProvider.removeSolicitudWhenisUploaded(
          //   solicitudId: widget.solicitudId,
          // );
          context.read<SolicitudNuevaMenorHnCubit>().sendCedulaImages(
                numeroSolicitud: state.numeroSolicitud,
              );
          // context
          //     .read<SolicitudNuevaMenorCubit>()
          //     .onFieldChanged(() => state.copyWith(
          //           hasVerified: true,
          //         ));
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
            Status.done => const Padding(
                padding: EdgeInsets.all(10),
                child: DownloadCatalogoLoading(
                  isSucess: true,
                  lottieAsset: ImageAsset.nuevaMenorSuccess,
                  text: 'Solicitud nueva enviada exitosamente!!\n\n',
                  repeat: false,
                  isUploadingForms: true,
                ),
              ),
            Status.error => OnErrorWidget(
                needToGoBack: true,
                errorMsg: state.errorMsg,
                onPressed: () {
                  context
                      .read<SolicitudNuevaMenorHnCubit>()
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

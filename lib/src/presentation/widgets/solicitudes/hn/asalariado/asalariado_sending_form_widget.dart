import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_aslariado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/exit_confirmation_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/downsloading_catalogos_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AsalariadoSendingFormWidget extends StatefulWidget {
  final bool isUserSelectUpdateImage;
  final bool tieneFotoCedula;
  const AsalariadoSendingFormWidget({
    super.key,
    this.isUserSelectUpdateImage = false,
    this.tieneFotoCedula = false,
  });

  @override
  State<AsalariadoSendingFormWidget> createState() =>
      _AsalariadoSendingFormWidgetState();
}

class _AsalariadoSendingFormWidgetState
    extends State<AsalariadoSendingFormWidget> {
  @override
  void initState() {
    super.initState();
    context.read<SolicitudAslariadoHnCubit>().createSolicitudAsalariado();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SolicitudAslariadoHnCubit, SolicitudAslariadoHnState>(
      listener: (context, state) {
        if (state.status == Status.done) {
          if (widget.isUserSelectUpdateImage || !widget.tieneFotoCedula) {
            context.read<SolicitudAslariadoHnCubit>().sendCedulaImages(
                  numeroSolicitud: state.numeroSolicitud,
                );
          }
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
                  text: 'Solicitud asalariado enviada exitosamente!!\n\n',
                  repeat: false,
                  isUploadingForms: true,
                ),
              ),
            Status.error => OnErrorWidget(
                needToGoBack: true,
                errorMsg: state.errorMsg,
                onPressed: () {
                  context
                      .read<SolicitudAslariadoHnCubit>()
                      .createSolicitudAsalariado();
                },
              ),
            _ => const SizedBox(),
          },
        );
      },
    );
  }
}

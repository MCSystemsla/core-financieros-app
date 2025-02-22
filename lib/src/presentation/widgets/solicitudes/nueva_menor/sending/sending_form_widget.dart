import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/downsloading_catalogos_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendingFormWidget extends StatefulWidget {
  const SendingFormWidget({super.key});

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
    return BlocBuilder<SolicitudNuevaMenorCubit, SolicitudNuevaMenorState>(
      builder: (context, state) {
        return Scaffold(
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
                  text: 'Solicitud enviada exitosamente!!',
                  repeat: false,
                  isUploadingForms: true,
                ),
              ),
            Status.error => OnErrorWidget(
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

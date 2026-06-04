import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_represtamo/analisis_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/exit_confirmation_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/downsloading_catalogos_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendingAnalisisReprestamoHn extends StatefulWidget {
  const SendingAnalisisReprestamoHn({super.key});

  @override
  State<SendingAnalisisReprestamoHn> createState() =>
      _SendingAnalisisReprestamoHnState();
}

class _SendingAnalisisReprestamoHnState
    extends State<SendingAnalisisReprestamoHn> {
  @override
  void initState() {
    super.initState();
    context.read<AnalisisReprestamoCubit>().createAnalisisReprestamo();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnalisisReprestamoCubit, AnalisisReprestamoState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                ExitConfirmationDialog(
                  context: context,
                  title: '¿Estás seguro de que quieres salir?',
                  onYes: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AnalisisInterceptorByFlavor(),
                      ),
                    );
                  },
                ).showDialog(context);
              },
              icon: const Icon(Icons.close),
            ),
          ),
          body: switch (state.status) {
            Status.inProgress => const DownloadCatalogoLoading(
                lottieAsset: ImageAsset.nuevaMenorUploading,
                text: 'Enviando analisis a servidor...',
              ),
            Status.done => Padding(
                padding: const EdgeInsets.all(10),
                child: DownloadCatalogoLoading(
                  isSucess: true,
                  lottieAsset: ImageAsset.nuevaMenorSuccess,
                  text: 'Analisis Represtamo enviada exitosamente!!\n\n',
                  repeat: false,
                  isUploadingForms: true,
                  onDownloadComplete: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AnalisisInterceptorByFlavor(),
                      ),
                    );
                  },
                ),
              ),
            Status.error => OnErrorWidget(
                needToGoBack: true,
                errorMsg: state.errorMsg,
                onPressed: () {
                  context
                      .read<AnalisisReprestamoCubit>()
                      .createAnalisisReprestamo();
                },
              ),
            _ => const SizedBox(),
          },
        );
      },
    );
  }
}

import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/exit_confirmation_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/downsloading_catalogos_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalisisMayorMilSendingForm extends StatefulWidget {
  final int numeroSolicitud;
  const AnalisisMayorMilSendingForm({
    super.key,
    required this.numeroSolicitud,
  });

  @override
  State<AnalisisMayorMilSendingForm> createState() =>
      _AnalisisMayorMilSendingFormState();
}

class _AnalisisMayorMilSendingFormState
    extends State<AnalisisMayorMilSendingForm> {
  @override
  void initState() {
    super.initState();
    context
        .read<AnalisisNuevaMayorMilHnCubit>()
        .createAnalisisNuevaMayorMil(numeroSolicitud: widget.numeroSolicitud);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnalisisNuevaMayorMilHnCubit,
        AnalisisNuevaMayorMilHnState>(
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
                  text: 'Analisis Nueva enviada exitosamente!!\n\n',
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
                      .read<AnalisisNuevaMayorMilHnCubit>()
                      .createAnalisisNuevaMayorMil(
                          numeroSolicitud: widget.numeroSolicitud);
                },
              ),
            _ => const SizedBox(),
          },
        );
      },
    );
  }
}

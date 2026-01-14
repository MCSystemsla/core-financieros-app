import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/comite/comite_aprobacion/comite_aprobacion_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/exit_confirmation_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/downsloading_catalogos_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ComiteSendingAprobacionWidget extends StatefulWidget {
  final String monto;
  const ComiteSendingAprobacionWidget({super.key, required this.monto});

  @override
  State<ComiteSendingAprobacionWidget> createState() =>
      _ComiteSendingAprobacionWidgetState();
}

class _ComiteSendingAprobacionWidgetState
    extends State<ComiteSendingAprobacionWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ComiteAprobacionCubit>().comiteAprobacion(
          monto: widget.monto,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComiteAprobacionCubit, ComiteAprobacionState>(
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
                text: 'Enviando aprobación a servidor...',
              ),
            Status.done => const Padding(
                padding: EdgeInsets.all(10),
                child: DownloadCatalogoLoading(
                  isSucess: true,
                  lottieAsset: ImageAsset.nuevaMenorSuccess,
                  text: 'Acta de comite aprobada exitosamente!!\n\n',
                  repeat: false,
                  isUploadingForms: true,
                ),
              ),
            Status.error => OnErrorWidget(
                needToGoBack: true,
                errorMsg: state.errorMsg,
                onPressed: () {
                  context.read<ComiteAprobacionCubit>().comiteAprobacion(
                        monto: widget.monto,
                      );
                },
              ),
            _ => const SizedBox(),
          },
        );
      },
    );
  }
}

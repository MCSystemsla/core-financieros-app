import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/comite/comite_aprobacion/comite_aprobacion_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/comite/hn/comite_screen_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/exit_confirmation_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/downsloading_catalogos_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ComiteSendingAprobacionWidget extends StatefulWidget {
  final String monto;
  final double porcentajeComision;
  final double montoSeguro;
  final double tasaInteresCorriente;
  final double tasaInteresMoratorio;
  final double montoSinComision;
  final double seguoMemorialMensual;
  final double porcentajeSaldoDeudorAprobado;
  final double montoTelemedicinaAprobada;
  final double seguroMapfre;
  const ComiteSendingAprobacionWidget({
    super.key,
    required this.monto,
    required this.porcentajeComision,
    required this.montoSeguro,
    required this.tasaInteresCorriente,
    required this.tasaInteresMoratorio,
    required this.montoSinComision,
    required this.seguoMemorialMensual,
    required this.porcentajeSaldoDeudorAprobado,
    required this.montoTelemedicinaAprobada,
    required this.seguroMapfre,
  });

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
          montoSeguro: widget.montoSeguro,
          porcentajeComision: widget.porcentajeComision,
          porcentajeSaldoDeudorAprobado: widget.porcentajeSaldoDeudorAprobado,
          montoSinComision: widget.montoSinComision,
          seguoMemorialMensual: widget.seguoMemorialMensual,
          seguroMapfre: widget.seguroMapfre,
          tasaInteresCorriente: widget.tasaInteresCorriente,
          tasaInteresMoratorio: widget.tasaInteresMoratorio,
          montoTelemedicinaAprobada: widget.montoTelemedicinaAprobada,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComiteAprobacionCubit, ComiteAprobacionState>(
      buildWhen: (previous, current) => previous.status != current.status,
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
            Status.done => Padding(
                padding: const EdgeInsets.all(10),
                child: DownloadCatalogoLoading(
                  isSucess: true,
                  lottieAsset: ImageAsset.nuevaMenorSuccess,
                  text: state.respMsg,
                  repeat: false,
                  isUploadingForms: true,
                  onDownloadComplete: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const ComiteScreenHn(),
                    ),
                  ),
                ),
              ),
            Status.error => OnErrorWidget(
                needToGoBack: true,
                errorMsg: state.errorMsg,
                onPressed: () {
                  context.read<ComiteAprobacionCubit>().comiteAprobacion(
                        monto: widget.monto,
                        montoSeguro: widget.montoSeguro,
                        porcentajeComision: widget.porcentajeComision,
                        porcentajeSaldoDeudorAprobado:
                            widget.porcentajeSaldoDeudorAprobado,
                        montoSinComision: widget.montoSinComision,
                        seguoMemorialMensual: widget.seguoMemorialMensual,
                        seguroMapfre: widget.seguroMapfre,
                        tasaInteresCorriente: widget.tasaInteresCorriente,
                        tasaInteresMoratorio: widget.tasaInteresMoratorio,
                        montoTelemedicinaAprobada:
                            widget.montoTelemedicinaAprobada,
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

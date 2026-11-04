import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/comite/comite_aprobacion/comite_aprobacion_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/exit_confirmation_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/comite/comite_approved_success_transaction_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/receipt_card/receipt_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/downsloading_catalogos_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ComiteResumeReceiptAprobacionWidget extends StatefulWidget {
  final List<Item> servicios;
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
  final DateTime fechaPrimerPago;
  final int plazoCredito;
  final double totalServicios;
  final int actaId;

  const ComiteResumeReceiptAprobacionWidget({
    super.key,
    required this.servicios,
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
    required this.fechaPrimerPago,
    required this.plazoCredito,
    required this.totalServicios,
    required this.actaId,
  });

  @override
  State<ComiteResumeReceiptAprobacionWidget> createState() =>
      _ComiteResumeReceiptAprobacionWidgetState();
}

class _ComiteResumeReceiptAprobacionWidgetState
    extends State<ComiteResumeReceiptAprobacionWidget> {
  /// Evita abrir dos pantallas de envío (y mandar dos POST) con toques rápidos.
  bool _navegando = false;

  /// Monto aprobado por el comité +/- servicios, según `ComisionFinanciada`.
  double _montoFinal(ComiteAprobacionState aprobacion) =>
      aprobacion.comisionFinanciada
          ? aprobacion.monto + widget.totalServicios
          : aprobacion.monto - widget.totalServicios;

  @override
  Widget build(BuildContext context) {
    final aprobacion = context.read<ComiteAprobacionCubit>().state;

    return PopScope(
      canPop: false,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(25),
              _buildTransactionCard(aprobacion),
              const Gap(20),
              _buildApproveButton(context, aprobacion),
              const Gap(20),
              _buildCancelButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionCard(ComiteAprobacionState aprobacion) {
    return TransactionReviewCard(
      servicios: widget.servicios,
      producto: aprobacion.productoCodigo,
      monto: _montoFinal(aprobacion),
      plazo: aprobacion.plazo,
      primerPago: widget.fechaPrimerPago,
      montoConServicios: _montoFinal(aprobacion),
      observaciones: aprobacion.observacion,
      tipoCredito: aprobacion.tipoCreditoNombre,
      montoSinComision: aprobacion.monto,
      mostrarMontoSinComision: aprobacion.comisionFinanciada,
      tasaInteresCorriente: widget.tasaInteresCorriente,
      tasaInteresMoratorio: widget.tasaInteresMoratorio,
    );
  }

  Widget _buildApproveButton(
    BuildContext context,
    ComiteAprobacionState stateAprobacion,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: CustomElevatedButton(
          icon: const Icon(Icons.check_circle_outline, color: Colors.white),
          text: 'Aprobar Acta',
          color: Colors.indigo,
          onPressed: () => _navigateToSending(context, stateAprobacion),
        ),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: CustomElevatedButton(
          text: 'Cancelar',
          color: Colors.red,
          onPressed: () {
            context.pop();
            context.pop();
          },
        ),
      ),
    );
  }

  Future<void> _navigateToSending(
    BuildContext context,
    ComiteAprobacionState stateAprobacion,
  ) async {
    if (_navegando) return;
    _navegando = true;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<ComiteAprobacionCubit>(),
          child: ComiteSendingAprobacionWidget(
            monto: _montoFinal(stateAprobacion).toString(),
            montoSinComision: stateAprobacion.monto,
            montoTelemedicinaAprobada:
                stateAprobacion.montoTelemedicinaAprobada.toDouble(),
            seguroMapfre: widget.seguroMapfre,
            tasaInteresCorriente: widget.tasaInteresCorriente,
            tasaInteresMoratorio: widget.tasaInteresMoratorio,
            montoSeguro: widget.montoSeguro,
            porcentajeComision: widget.porcentajeComision,
            porcentajeSaldoDeudorAprobado: widget.porcentajeSaldoDeudorAprobado,
            seguoMemorialMensual: widget.seguoMemorialMensual,
          ),
        ),
      ),
    );
    // Si el envío falló y el usuario volvió al resumen, puede reintentar.
    if (mounted) _navegando = false;
  }
}

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
            Status.done => ComiteApprovedSuccessTransactionCard(
                monto: double.tryParse(widget.monto) ?? 0,
                mensajeExito: state.respMsg,
                responsables: state.responsables,
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

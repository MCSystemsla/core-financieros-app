import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_garantia_obtener_detalle/analisis_garantia_obtener_detalle_dpf_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/modern_loading_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/loading/loading_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../bloc/analisis/hn/analisis_garantia_actualizar_dpf/analisis_garantia_actualizar_dpf_cubit.dart';

class ActualizarDetalleDPF extends StatelessWidget {
  final int objAnalisisGarantiaId;
  final int articuloCodigo;
  final String tipoPersonaCodigo;
  const ActualizarDetalleDPF({
    super.key,
    required this.objAnalisisGarantiaId,
    required this.articuloCodigo,
    required this.tipoPersonaCodigo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalisisGarantiaObtenerDetalleDpfCubit,
        AnalisisGarantiaObtenerDetalleDpfState>(
      builder: (context, state) {
        return switch (state.status) {
          Status.inProgress => const ModernLoadingWidget(),
          Status.error => OnErrorWidget(
              errorMsg: state.errorMsg,
              onPressed: () => context
                  .read<AnalisisGarantiaObtenerDetalleDpfCubit>()
                  .obtenerGarantiaDetalleDPF(
                    objAnalisisGarantiaID: objAnalisisGarantiaId,
                  ),
            ),
          Status.done => _DpfForm(
              objAnalisisGarantiaId: objAnalisisGarantiaId,
              articuloCodigo: articuloCodigo,
              tipoPersonaCodigo: tipoPersonaCodigo,
              detalle: state,
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}

class _DpfForm extends StatefulWidget {
  final int objAnalisisGarantiaId;
  final int articuloCodigo;
  final String tipoPersonaCodigo;
  final AnalisisGarantiaObtenerDetalleDpfState detalle;
  const _DpfForm({
    required this.objAnalisisGarantiaId,
    required this.articuloCodigo,
    required this.tipoPersonaCodigo,
    required this.detalle,
  });

  @override
  State<_DpfForm> createState() => _DpfFormState();
}

class _DpfFormState extends State<_DpfForm> {
  final formKey = GlobalKey<FormState>();

  int? objCuentaDpfId;
  double? monto;
  String? observaciones;

  @override
  void initState() {
    super.initState();
    final detalle = widget.detalle;
    objCuentaDpfId = detalle.dpfId == 0 ? null : detalle.dpfId;
    monto = detalle.valorComercial.toDouble();
    observaciones = detalle.observaciones;
  }

  @override
  Widget build(BuildContext context) {
    final detalle = widget.detalle;
    return Form(
      key: formKey,
      child: FadeIn(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 20),
                  child: Text(
                    'Actualiza los datos requeridos',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black87),
                      children: [
                        const TextSpan(
                          text: 'N. Cuenta: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: detalle.numeroCuenta),
                      ],
                    ),
                  ),
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Monto',
                  initialValue: detalle.valorComercial.toCurrencyString(),
                  icon: Icon(
                    Icons.wallet,
                    color: AppColors.getPrimaryColor(),
                  ),
                  textInputType: TextInputType.number,
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    CurrencyInputFormatter(mantissaLength: 0),
                  ],
                  onChange: (value) {
                    final newValue = toNumericString(value, allowPeriod: true);
                    monto = double.tryParse(newValue) ?? 0;
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Observaciones',
                  initialValue: detalle.observaciones,
                  icon: Icon(
                    Icons.wallet,
                    color: AppColors.getPrimaryColor(),
                  ),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    observaciones = value;
                  },
                ),
                const Gap(20),
                BlocConsumer<AnalisisGarantiaActualizarDpfCubit,
                    AnalisisGarantiaActualizarDpfState>(
                  listenWhen: (prev, curr) => prev.status != curr.status,
                  listener: (ctx, state) {
                    if (state.status == Status.inProgress) {
                      context.showLoading(
                          message: 'Actualizando Detalle garantia');
                    }
                    if (state.status == Status.done) {
                      context.hideLoading();
                      formKey.currentState?.reset();
                      showV2CustomSnackbar(
                        context,
                        title: 'Garantia actualizada exitosamente',
                        type: SnackbarType.success,
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AnalisisInterceptorByFlavor(),
                        ),
                      );
                    }
                    if (state.status == Status.error) {
                      context.hideLoading();
                      CustomAlertDialog(
                        context: context,
                        title: state.errorMsg,
                        onDone: () => {
                          context.pop(),
                        },
                      ).showDialog(
                        context,
                        dialogType: DialogType.warning,
                      );
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: CustomElevatedButton(
                        enabled: state.status != Status.inProgress,
                        text: state.status == Status.inProgress
                            ? 'Actualizando...'
                            : 'Actualizar',
                        // ignore: deprecated_member_use
                        color: AppColors.greenLatern.withOpacity(0.4),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          context
                              .read<AnalisisGarantiaActualizarDpfCubit>()
                              .actualizarGarantiaDetalleDPF(
                                objAnalisisGarantiaID:
                                    widget.objAnalisisGarantiaId,
                                monto: monto!,
                                observaciones: observaciones!,
                              );
                        },
                      ),
                    );
                  },
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/snackbar/custom_snackbar.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/analisis_interceptor_by_flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/loading/loading_extension.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../bloc/analisis/hn/analisis_create_asignacion_garantia_dpf/analisis_create_asignacion_garantia_dpf_cubit.dart';
import '../../../../../../bloc/analisis/hn/analisis_dpfs/analisis_dpfs_cubit.dart';

class CrearDetalleDPF extends StatefulWidget {
  final int objAnalisisGarantiaId;
  final int articuloCodigo;
  const CrearDetalleDPF({
    super.key,
    required this.objAnalisisGarantiaId,
    required this.articuloCodigo,
  });

  @override
  State<CrearDetalleDPF> createState() => _CrearDetalleDPFState();
}

class _CrearDetalleDPFState extends State<CrearDetalleDPF> {
  String? evaluadorCodigo;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisCreateAsignacionGarantiaDpfCubit>();
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
                    'Ingresa los datos requeridos',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                BlocBuilder<AnalisisDpfsCubit, AnalisisDpfsState>(
                  builder: (context, state) {
                    return switch (state.status) {
                      Status.inProgress => const LoadingWidget(),
                      Status.error => Text('Error : ${state.errorMsg}'),
                      Status.done => SheetSearchDropdown(
                          title: 'DPFs',
                          isRequired: true,
                          validator: (value) => ClassValidator.validateRequired(
                              value?.value.toString()),
                          onChanged: (v) {
                            cubit.onFieldChanged(
                              () => cubit.state.copyWith(
                                objCuentaDpfid: v?.value,
                              ),
                            );
                          },
                          hintText: state.data.isEmpty
                              ? 'No hay Dpfs registrado.'
                              : 'Selecciona un Dpf',
                          enabled: state.data.isNotEmpty,
                          items: state.data
                              .map((e) => Item(
                                    name: 'N. Cuenta: ${e.numeroCuenta}',
                                    value: e.dpfId,
                                  ))
                              .toList(),
                        ),
                      _ => const SizedBox(),
                    };
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Monto Inicial',
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
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                          montoInicial: double.tryParse(newValue) ?? 0),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Valor Comercial',
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
                    final newValue = toNumericString(value);
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                          valorComercial: double.tryParse(newValue) ?? 0),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Comentario',
                  icon: Icon(
                    Icons.wallet,
                    color: AppColors.getPrimaryColor(),
                  ),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(comentario: value),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Observaciones',
                  icon: Icon(
                    Icons.wallet,
                    color: AppColors.getPrimaryColor(),
                  ),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(observaciones: value),
                    );
                  },
                ),
                const Gap(20),
                BlocConsumer<AnalisisCreateAsignacionGarantiaDpfCubit,
                    AnalisisCreateAsignacionGarantiaDpfState>(
                  listenWhen: (prev, curr) => prev.status != curr.status,
                  listener: (ctx, state) {
                    if (state.status == Status.inProgress) {
                      context.showLoading(message: 'Creando Detalle garantia');
                    }
                    if (state.status == Status.done) {
                      context.hideLoading();
                      formKey.currentState?.reset();

                      showV2CustomSnackbar(
                        context,
                        title: state.responseMesg,
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
                            ? 'Creando...'
                            : 'Crear',
                        // ignore: deprecated_member_use
                        color: AppColors.greenLatern.withOpacity(0.4),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          context
                              .read<AnalisisCreateAsignacionGarantiaDpfCubit>()
                              .createAsignacionGarantiaDpf(
                                objAnalisisGarantiaId:
                                    widget.objAnalisisGarantiaId,
                                articuloCodigo: widget.articuloCodigo,
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

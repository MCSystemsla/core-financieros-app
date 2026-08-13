import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_create_asignacion_garantia_dpf/analisis_create_asignacion_garantia_dpf_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_dpfs/analisis_dpfs_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';

class ActualizarDetalleDPF extends StatefulWidget {
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
  State<ActualizarDetalleDPF> createState() => _ActualizarDetalleDPFState();
}

class _ActualizarDetalleDPFState extends State<ActualizarDetalleDPF> {
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
                    'Actualiza los datos requeridos',
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'Actualizar',
                    // ignore: deprecated_member_use
                    color: AppColors.greenLatern.withOpacity(0.4),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      // TODO: wire this up to the update endpoint for the DPF
                      // asignacion once it exists on AnalisisRepositoryHn. The
                      // edited values are already accumulated in
                      // AnalisisCreateAsignacionGarantiaDpfCubit's state.
                    },
                  ),
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

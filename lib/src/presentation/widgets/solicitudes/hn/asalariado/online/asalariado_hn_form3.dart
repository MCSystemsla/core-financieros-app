// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_aslariado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:gap/gap.dart';

class AsalariadoHnForm3 extends StatefulWidget {
  final PageController controller;
  const AsalariadoHnForm3({
    super.key,
    required this.controller,
  });

  @override
  State<AsalariadoHnForm3> createState() => _AsalariadoHnForm3State();
}

class _AsalariadoHnForm3State extends State<AsalariadoHnForm3> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SolicitudAslariadoHnCubit>();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const MiCreditoProgress(
              currentStep: 3,
              steps: 7,
            ),
            const Gap(30),
            Column(
              children: [
                SearchDropdownWidget(
                  hintText: 'Profesión',
                  title: 'objprofesionID',
                  codigo: 'PROFESION',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        profesionCodigo: item.value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                SearchDropdownWidget(
                  hintText: 'Ocupación',
                  title: 'objOcupacionID',
                  codigo: 'OCUPACION',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        ocupacionCodigo: item.value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Cargo',
                  icon: Icon(Icons.badge, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Cargo',
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        cargo: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Nombre del Trabajo',
                  icon:
                      Icon(Icons.business, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'NombreTrabajo',
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nombreTrabajo: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Dirección del Trabajo',
                  icon: Icon(Icons.location_on,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  title: 'DireccionTrabajo',
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        direccionTrabajo: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Barrio del Trabajo',
                  icon: Icon(Icons.location_city,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'BarrioTrabajo',
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        barrioTrabajo: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Teléfono del Trabajo',
                  icon: Icon(Icons.phone, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.phone,
                  textCapitalization: TextCapitalization.none,
                  title: 'TelefonoTrabajo',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        telefonoTrabajo: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Tiempo de Laborar',
                  icon: Icon(Icons.access_time,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'Tiempo de Laborar',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tiempoLaborar: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Lugar de Trabajo Anterior',
                  icon: Icon(Icons.work_history,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'LugarTrabajoAnterior',
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        lugarTrabajoAnterior: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Salario Neto',
                  icon: Icon(Icons.attach_money,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'SalarioNetoCordoba',
                  inputFormatters: [
                    CurrencyInputFormatter(),
                  ],
                  onChange: (value) {
                    final newValue = value.replaceAll(',', '');
                    final salarioNeto = int.tryParse(newValue) ?? 0;
                    final total = cubit.state.salarioNetoCordoba + salarioNeto;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        salarioNetoCordoba: salarioNeto,
                        totalIngresoMes: total,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Otros Ingresos',
                  icon:
                      Icon(Icons.payments, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'OtrosIngresosCordoba',
                  inputFormatters: [
                    CurrencyInputFormatter(),
                  ],
                  onChange: (value) {
                    final newValue = value.replaceAll(',', '');

                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        otrosIngresosCordoba: int.tryParse(newValue) ?? 0,
                        totalIngresoMes: cubit.state.totalIngresoMes +
                            (int.tryParse(newValue) ?? 0),
                      ),
                    );
                    log('otrosIngresosCordoba: $newValue | totalIngresoMes:   ${cubit.state.totalIngresoMes}');
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Fuente de Otros Ingresos',
                  icon: Icon(Icons.source, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  title: 'FuenteOtrosIngresos',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        fuenteOtrosIngresos: value,
                      ),
                    );
                  },
                ),
                // const Gap(30),
                // BlocBuilder<SolicitudAslariadoHnCubit,
                //     SolicitudAslariadoHnState>(
                //   builder: (context, state) {
                //     return OutlineTextfieldWidget(
                //       key: ValueKey(state.totalIngresoMes),
                //       textEditingController: TextEditingController(
                //         text: state.totalIngresoMes.toCurrencyString(),
                //       ),
                //       readOnly: true,
                //       icon: Icon(Icons.account_balance_wallet,
                //           color: AppColors.getPrimaryColor()),
                //       textInputType: TextInputType.number,
                //       textCapitalization: TextCapitalization.none,
                //       title: 'TotalIngresoMes',
                //     );
                //   },
                // ),
                const Gap(30),
                SearchDropdownWidget(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  hintText: 'Nivel Aproximado de Ingresos',
                  title: 'ObjNivelAproximadoDeIngresosID',
                  codigo: 'NIVELAPROXIMADOINGRESOS',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nivelAproximadoDeIngresosCodigo: item.value,
                      ),
                    );
                  },
                ),
              ],
            ),
            const Gap(30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Siguiente',
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  widget.controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
              ),
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomOutLineButton(
                onPressed: () {
                  widget.controller.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                text: 'Cancelar',
                textColor: AppColors.red,
                color: AppColors.red,
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

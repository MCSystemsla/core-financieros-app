// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_aslariado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:gap/gap.dart';

class AsalariadoHnForm4 extends StatefulWidget {
  final PageController controller;
  const AsalariadoHnForm4({
    super.key,
    required this.controller,
  });

  @override
  State<AsalariadoHnForm4> createState() => _AsalariadoHnForm4State();
}

class _AsalariadoHnForm4State extends State<AsalariadoHnForm4> {
  final formKey = GlobalKey<FormState>();
  bool trabajaConyuge = false;
  Item? estadoCivil;
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
              currentStep: 4,
              steps: 7,
            ),
            const Gap(30),
            Column(
              children: [
                SearchDropdownWidget(
                  codigo: 'ESTADOCIVIL',
                  title: 'Estado Civil',
                  flavor: global<FlavorCubit>().state.flavor,
                  isRequired: true,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      estadoCivil = item;
                    });
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        estadoCivilCodigo: item.value,
                      ),
                    );
                  },
                  hintText: 'input.select_option'.tr(),
                  enabled: true,
                ),
                if (estadoCivil?.value == 'UNI' ||
                    estadoCivil?.value == 'CAS') ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Nombre del Cónyuge',
                    icon:
                        Icon(Icons.person, color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    title: 'NombreConyugue',
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nombreConyugue: value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  SearchDropdownWidget(
                    codigo: 'PROFESION',
                    flavor: global<FlavorCubit>().state.flavor,
                    hintText: 'Profesión del Cónyuge',
                    title: 'ProfesionConyugue',
                    onChanged: (value) {
                      if (value == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          profesionConyugue: value.value,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  SheetSearchDropdown(
                    title: 'Trabaja Conyugue?',
                    hintText: 'input.select.option'.tr(),
                    isRequired: true,
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      setState(() {
                        trabajaConyuge = item.value == 'input.yes'.tr();
                      });
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          trabajaConyugue: item.value,
                        ),
                      );
                    },
                    enabled: true,
                    items: [
                      Item(name: 'input.yes'.tr(), value: 'input.yes'.tr()),
                      Item(name: 'input.no'.tr(), value: 'input.no'.tr()),
                    ],
                  ),
                  if (trabajaConyuge) ...[
                    const Gap(30),
                    OutlineTextfieldWidget(
                      hintText: 'Trabajo del Cónyuge',
                      icon: Icon(Icons.business,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      title: 'TrabajoConyugue',
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            trabajoConyugue: value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      hintText: 'Dirección del Trabajo del Cónyuge',
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      icon: Icon(Icons.location_on,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      title: 'DireccionTrabajoConyugue',
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            direccionTrabajoConyugue: value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      hintText: 'Teléfono del Trabajo del Cónyuge',
                      icon:
                          Icon(Icons.phone, color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.phone,
                      textCapitalization: TextCapitalization.none,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      title: 'TelefonoTrabajoConyugue',
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            telefonoTrabajoConyugue: value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      hintText: 'Tiempo de Laborar del Cónyuge',
                      icon: Icon(Icons.access_time,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.number,
                      textCapitalization: TextCapitalization.none,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      title: 'TiempoLaborarConyugue',
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            tiempoLaborarConyugue: value,
                          ),
                        );
                      },
                    ),
                    const Gap(30),
                    OutlineTextfieldWidget(
                      hintText: 'Sueldo Mensual del Cónyuge',
                      icon: Icon(Icons.attach_money,
                          color: AppColors.getPrimaryColor()),
                      textInputType: TextInputType.number,
                      textCapitalization: TextCapitalization.none,
                      title: 'SueldoMesConyugue',
                      inputFormatters: [
                        CurrencyInputFormatter(),
                      ],
                      onChange: (value) {
                        final newValue = value.replaceAll(',', '');
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            sueldoMesConyugue: int.tryParse(newValue) ?? 0,
                          ),
                        );
                      },
                    ),
                  ],
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Otros Ingresos del Cónyuge',
                    icon: Icon(Icons.payments,
                        color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.number,
                    textCapitalization: TextCapitalization.none,
                    title: 'OtrosIngresosConyugue',
                    inputFormatters: [
                      CurrencyInputFormatter(),
                    ],
                    onChange: (value) {
                      final newValue = value.replaceAll(',', '');
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          otrosIngresosConyugue: int.tryParse(newValue) ?? 0,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  OutlineTextfieldWidget(
                    hintText: 'Fuente de Otros Ingresos del Cónyuge',
                    icon:
                        Icon(Icons.source, color: AppColors.getPrimaryColor()),
                    textInputType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    title: 'FuenteOtrosIngresosConyugue',
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          fuenteOtrosIngresosConyugue: value,
                        ),
                      );
                    },
                  ),
                  // const Gap(30),
                  // OutlineTextfieldWidget(
                  //   hintText: 'Total Ingreso Mensual del Cónyuge',
                  //   icon: Icon(Icons.account_balance_wallet,
                  //       color: AppColors.getPrimaryColor()),
                  //   textInputType: TextInputType.number,
                  //   textCapitalization: TextCapitalization.none,
                  //   title: 'TotalIngresoMesConyugue',
                  //   inputFormatters: [
                  //     CurrencyInputFormatter(),
                  //   ],
                  //   onChange: (value) {
                  //     final newValue = value.replaceAll(',', '');
                  //     cubit.onFieldChanged(
                  //       () => cubit.state.copyWith(
                  //         totalIngresoMesConyugue: int.tryParse(newValue) ?? 0,
                  //       ),
                  //     );
                  //   },
                  // ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    hintText: 'Nacionalidad del Cónyuge',
                    title: 'NacionalidadConyugue',
                    codigo: 'PAIS',
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nacionalidadConyugue: item.valor,
                        ),
                      );
                    },
                  ),
                ],
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Personas a Cargo',
                  icon: Icon(Icons.group, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  title: 'personasACargo',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        personasACargo: int.tryParse(value) ?? 0,
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

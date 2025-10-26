// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/hn/cubit/solicitud_nueva_menor_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/inputs/country_input.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NuevaMenorOfflineHn3 extends StatefulWidget {
  final PageController controller;
  const NuevaMenorOfflineHn3({super.key, required this.controller});

  @override
  State<NuevaMenorOfflineHn3> createState() => _NuevaMenorOfflineHn3State();
}

class _NuevaMenorOfflineHn3State extends State<NuevaMenorOfflineHn3> {
  final formKey = GlobalKey<FormState>();
  String? depWhereClause;
  String? munWhereClause;
  String? aldeaWhereClause;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SolicitudNuevaMenorHnCubit>();
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
                OutlineTextfieldWidget(
                  isRequired: true,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(50),
                  ],
                  validator: (value) => ClassValidator.validateRequired(value),
                  hintText: 'Ingresa Nombre Negocio',
                  icon:
                      Icon(Icons.business, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Nombre Negocio',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        nombreNegocio: value,
                      ),
                    );
                  },
                ),
                if (cubit.state.paisCasaCodigo == 'HN') ...[
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    where: cubit.state.paisCasaCodigo,
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    hintText: 'Ingresa Departamento Negocio',
                    title: 'Departamento Negocio',
                    codigo: 'DEP',
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      setState(() {
                        depWhereClause = item.valor;
                      });
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          departamentoNegocioCodigo: item.valor,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    where: depWhereClause,
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      setState(() {
                        munWhereClause = item.valor;
                      });
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          municipioNegocioCodigo: item.valor,
                        ),
                      );
                    },
                    codigo: 'MUN',
                    hintText: 'Ingresa Municipio Negocio',
                    title: 'Municipio Negocio',
                  ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    where: munWhereClause,
                    codigo: 'ALD',
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    hintText: 'Ingresa Aldea Negocio',
                    onChanged: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          aldeaNegocioCodigo: value?.valor,
                        ),
                      );
                    },
                    title: 'Aldea Negocio',
                  ),
                ],
                const Gap(30),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(50),
                  ],
                  hintText: 'Ingresa Caserio Negocio',
                  title: 'Caserio Negocio',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        caserioNegocio: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  isRequired: true,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(50),
                  ],
                  validator: (value) => ClassValidator.validateRequired(value),
                  hintText: 'Ingresa Dirección Negocio',
                  icon: Icon(Icons.location_on,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.streetAddress,
                  textCapitalization: TextCapitalization.words,
                  title: 'Dirección Negocio',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        direccionNegocio: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  isRequired: true,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(40),
                  ],
                  validator: (value) => ClassValidator.validateRequired(value),
                  hintText: 'Ingresa Barrio Negocio',
                  icon:
                      Icon(Icons.apartment, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Barrio Negocio',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        barrioNegocio: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  isRequired: true,
                  validator: (value) => ClassValidator.validateRequired(value),
                  hintText: 'Ingresa Tiempo de Funcionamiento',
                  icon: Icon(Icons.access_time,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  title: 'Tiempo de Funcionamiento de Negocio',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        tiempoFuncionamientoNegocio: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                SearchDropdownWidget(
                  isRequired: true,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  codigo: 'SECTORECONOMICO',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        sectorCodigo: item.value,
                      ),
                    );
                  },
                  hintText: 'Ingresa Sector',
                  title: 'Sector',
                ),
                const Gap(30),
                SearchDropdownWidget(
                  isRequired: true,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  codigo: 'TIPOVIVIENDA',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        condicionNegocioCodigo: item.value,
                      ),
                    );
                  },
                  hintText: 'Ingresa Condición Negocio',
                  title: 'Condicion Negocio',
                ),
                const Gap(30),
                CountryInput(
                  maxLength: 15,
                  countryCodeInput: CountryCodeInput.hn,
                  isRequired: true,
                  validator: (value) => ClassValidator.validateRequired(value),
                  hintText: 'Ingresa Teléfono Negocio',
                  icon: Icon(Icons.phone, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.phone,
                  textCapitalization: TextCapitalization.none,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  title: 'Telefono Negocio',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        telefonoNegocio: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                CountryInput(
                  countryCodeInput: CountryCodeInput.hn,
                  isRequired: true,
                  maxLength: 15,
                  hintText: 'Ingresa Celular Negocio',
                  icon: Icon(Icons.smartphone,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.phone,
                  textCapitalization: TextCapitalization.none,
                  title: 'Celular Negocio',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        celularNegocio: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  isRequired: true,
                  validator: (value) => ClassValidator.validateRequired(value),
                  hintText: 'Ingresa Puesto Negocio',
                  icon: Icon(Icons.storefront,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Puesto Negocio',
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(100),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        puestoNegocio: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Horario Trabajo',
                  icon: Icon(Icons.work, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Horario de Trabajo',
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(50),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        horarioTrabajo: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  hintText: 'Ingresa Horario Visita',
                  icon:
                      Icon(Icons.schedule, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(50),
                  ],
                  title: 'Horario de Visita',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        horarioVisita: value,
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

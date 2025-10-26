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
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/progress/micredito_progress.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NuevaMenorOfflineHn2 extends StatefulWidget {
  final PageController controller;
  const NuevaMenorOfflineHn2({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorOfflineHn2> createState() => _NuevaMenorOfflineHn2State();
}

class _NuevaMenorOfflineHn2State extends State<NuevaMenorOfflineHn2> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String? depWhereClause;
    String? munWhereClause;
    String? aldeaWhereClause;

    final cubit = context.read<SolicitudNuevaMenorHnCubit>();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const MiCreditoProgress(
              currentStep: 2,
              steps: 7,
            ),
            const Gap(30),
            Column(
              children: [
                CatalogoValorNacionalidad(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  hintText: 'Ingresa País Casa',
                  title: 'País Casa de cliente',
                  codigo: 'PAIS',
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    setState(() {
                      depWhereClause = item.valor;
                    });
                    if (item.valor != 'HN') {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          departamentoCasaCodigo: item.valor,
                          municipioCasaCodigo: item.valor,
                          aldeaCasaCodigo: item.valor,
                          departamentoNegocioCodigo: item.valor,
                          municipioNegocioCodigo: item.valor,
                          aldeaNegocioCodigo: item.valor,
                          departamentoDestinoCodigo: item.valor,
                          municipioDestinoCodigo: item.valor,
                          aldeaDestinoCodigo: item.valor,
                        ),
                      );
                    }

                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        paisCasaCodigo: item.valor,
                      ),
                    );
                  },
                ),
                if (cubit.state.paisCasaCodigo == 'HN') ...[
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    hintText: 'Ingresa Departamento Casa',
                    title: 'Departamento Casa de cliente',
                    codigo: 'DEP',
                    where: depWhereClause,
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      setState(() {
                        munWhereClause = item.valor;
                      });

                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          departamentoCasaCodigo: item.valor,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    where: munWhereClause,
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    hintText: 'Ingresa Municipio Casa',
                    title: 'Municipio Casa de cliente',
                    codigo: 'MUN',
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      setState(() {
                        aldeaWhereClause = item.valor;
                      });
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          municipioCasaCodigo: item.valor,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    where: aldeaWhereClause,
                    enabled: true,
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    hintText: 'Ingresa Aldea Casa',
                    title: 'Ingresa Aldea Casa de cliente',
                    onChanged: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          aldeaCasaCodigo: value?.valor,
                        ),
                      );
                    },
                    codigo: 'ALD',
                  ),
                ],
                const Gap(30),
                OutlineTextfieldWidget(
                  isRequired: true,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(50),
                  ],
                  validator: (value) => ClassValidator.validateRequired(value),
                  hintText: 'Ingresa Dirección Casa',
                  icon: Icon(Icons.home, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.streetAddress,
                  textCapitalization: TextCapitalization.words,
                  title: 'Dirección Casa de cliente',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        direccionCasa: value,
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
                  hintText: 'Ingresa Barrio Casa',
                  title: 'Barrio Casa de cliente',
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        barrioCasa: value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                SearchDropdownWidget(
                  isRequired: true,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  hintText: 'Ingresa Condición Casa',
                  title: 'Condicion Casa',
                  codigo: 'TIPOVIVIENDA',
                  flavor: global<FlavorCubit>().state.flavor,
                  onChanged: (item) {
                    if (item == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        condicionCasaCodigo: item.value,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  isRequired: true,
                  validator: (value) => ClassValidator.validateRequired(value),
                  hintText: 'Ingresa Años Residir Casa',
                  icon: Icon(Icons.calendar_today,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  title: 'Años Residir Casa',
                  onChange: (value) {
                    final newValue = value.replaceAll(',', '');
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        anosResidirCasa: int.tryParse(newValue) ?? 0,
                      ),
                    );
                  },
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  isRequired: true,
                  validator: (value) => ClassValidator.validateRequired(value),
                  hintText: 'Ingresa Personas a cargo',
                  icon: Icon(Icons.group, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  title: 'Personas a cargo',
                  onChange: (value) {
                    final newValue = value.replaceAll(',', '');
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        personasACargo: int.tryParse(newValue) ?? 0,
                      ),
                    );
                  },
                ),
                const Gap(30),
                SheetSearchDropdown(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  hintText: 'Ingresa Ubicación',
                  title: 'Ingresa Ubicacion',
                  enabled: true,
                  isRequired: true,
                  items: const [
                    Item(name: 'Urbano', value: 'URB'),
                    Item(name: 'Rural', value: 'RUR'),
                  ],
                  onChanged: (value) {
                    if (value == null || !mounted) return;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        ubicacion: value.value,
                        ubicacionCodigo: value.value,
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
                text: 'Anterior',
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

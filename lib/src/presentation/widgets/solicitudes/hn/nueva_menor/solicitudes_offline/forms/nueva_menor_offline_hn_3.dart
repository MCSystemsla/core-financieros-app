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

class _NuevaMenorOfflineHn3State extends State<NuevaMenorOfflineHn3>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  String? depWhereClause;
  String? munWhereClause;
  String? aldeaWhereClause;
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                  initialValue: cubit.state.nombreNegocio,
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
                  title: 'Nombre del negocio',
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
                    selectedItem: ItemNacionalidad(
                      id: 0,
                      valor: cubit.state.departamentoNegocioCodigo,
                      nombre: cubit.state.departamentoNegocioCodigoNombre,
                      relacion: '',
                    ),
                    where: cubit.state.paisCasaCodigo,
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    hintText: 'Ingresa Departamento Negocio',
                    title: 'Departamento donde Opera el Negocio',
                    codigo: 'DEP',
                    onChanged: (item) {
                      if (item == null || !mounted) return;
                      setState(() {
                        depWhereClause = item.valor;
                      });
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          departamentoNegocioCodigo: item.valor,
                          departamentoNegocioCodigoNombre: item.nombre,
                        ),
                      );
                    },
                  ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    selectedItem: ItemNacionalidad(
                      id: 0,
                      valor: cubit.state.municipioNegocioCodigo,
                      nombre: cubit.state.municipioNegocioCodigoNombre,
                      relacion: '',
                    ),
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
                          municipioNegocioCodigoNombre: item.nombre,
                        ),
                      );
                    },
                    codigo: 'MUN',
                    hintText: 'Ingresa Municipio Negocio',
                    title: 'Municipio donde Opera el Negocio',
                  ),
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    selectedItem: ItemNacionalidad(
                      id: 0,
                      valor: cubit.state.aldeaNegocioCodigo,
                      nombre: cubit.state.aldeaNegocioCodigoNombre,
                      relacion: '',
                    ),
                    where: munWhereClause,
                    codigo: 'ALD',
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    hintText: 'Ingresa Aldea Negocio',
                    onChanged: (value) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          aldeaNegocioCodigo: value?.valor,
                          aldeaNegocioCodigoNombre: value?.nombre,
                        ),
                      );
                    },
                    title: 'Aldea del Negocio',
                  ),
                ],
                const Gap(30),
                OutlineTextfieldWidget(
                  initialValue: cubit.state.caserioNegocio,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(50),
                  ],
                  hintText: 'Ingresa Caserio Negocio',
                  title: 'Caserío del Negocio',
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
                  initialValue: cubit.state.direccionNegocio,
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
                  title: 'Dirección Comercial Completa del negocio',
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
                  initialValue: cubit.state.barrioNegocio,
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
                  title: 'Barrio o Colonia del Negocio',
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
                  initialValue: cubit.state.tiempoFuncionamientoNegocio,
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
                  title: 'Años de Operación del Negocio',
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
                  selectedItem: Item(
                    name: cubit.state.sectorCodigoNombre,
                    value: cubit.state.sectorCodigo,
                  ),
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
                        sectorCodigoNombre: item.name,
                      ),
                    );
                  },
                  hintText: 'Ingresa Sector',
                  title: 'Sector Económico del Negocio',
                ),
                const Gap(30),
                SearchDropdownWidget(
                  selectedItem: Item(
                    name: cubit.state.condicionNegocioCodigoNombre,
                    value: cubit.state.condicionNegocioCodigo,
                  ),
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
                        condicionNegocioCodigoNombre: item.name,
                      ),
                    );
                  },
                  hintText: 'Ingresa Condición Negocio',
                  title: 'Condición del negocio',
                ),
                const Gap(30),
                CountryInput(
                  initialValue: cubit.state.telefonoNegocio,
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
                  title: 'Teléfono del Negocio',
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
                  initialValue: cubit.state.celularNegocio,
                  countryCodeInput: CountryCodeInput.hn,
                  isRequired: true,
                  maxLength: 15,
                  hintText: 'Ingresa Celular Negocio',
                  icon: Icon(Icons.smartphone,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.phone,
                  textCapitalization: TextCapitalization.none,
                  title: 'Celular del Negocio',
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
                  initialValue: cubit.state.puestoNegocio,
                  isRequired: true,
                  validator: (value) => ClassValidator.validateRequired(value),
                  hintText: 'Ingresa Puesto Negocio',
                  icon: Icon(Icons.storefront,
                      color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Puesto o Cargo dentro del Negocio',
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
                  initialValue: cubit.state.horarioTrabajo,
                  hintText: 'Ingresa Horario Trabajo',
                  icon: Icon(Icons.work, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  title: 'Horario de Atención',
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
                  initialValue: cubit.state.horarioVisita,
                  hintText: 'Ingresa Horario Visita',
                  icon:
                      Icon(Icons.schedule, color: AppColors.getPrimaryColor()),
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    LengthLimitingTextInputFormatter(50),
                  ],
                  title: 'Horario de Visita al Negocio',
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

  @override
  bool get wantKeepAlive => true;
}

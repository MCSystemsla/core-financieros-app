// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/config/helpers/format/format_field.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AsalariadoForm3View extends StatefulWidget {
  final PageController controller;
  const AsalariadoForm3View({super.key, required this.controller});

  @override
  State<AsalariadoForm3View> createState() => _AsalariadoForm3ViewState();
}

class _AsalariadoForm3ViewState extends State<AsalariadoForm3View> {
  @override
  Widget build(BuildContext context) {
    return _FormContent(
      controller: widget.controller,
    );
  }
}

class _FormContent extends StatefulWidget {
  final PageController controller;
  const _FormContent({required this.controller});

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  Item? paisCasa;
  Item? depCasa;
  Item? munCasa;
  Item? condicionCasa;
  String? nombreDuenoCasa;
  String? pagoAlquiler;
  String? anosResidir;
  String? direccionDomicilio;
  String? barrio;
  Item? sector;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolicitudAsalariadoCubit, SolicitudAsalariadoState>(
      builder: (context, state) {
        final cubit = context.read<SolicitudAsalariadoCubit>();
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Gap(30),
                CatalogoValorNacionalidad(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  codigo: 'PAIS',
                  title: 'País de residencia',
                  onChanged: (item) {
                    paisCasa =
                        Item(name: item?.nombre ?? '', value: item?.valor);
                    depCasa = Item(name: item!.nombre, value: item.valor);

                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objPaisCasaId: paisCasa?.value,
                        objPaisCasaIdVer: paisCasa?.name,
                      ),
                    );
                    setState(() {});
                  },
                  hintText: 'input.select_option'.tr(),
                ),
                if (paisCasa?.value != null) ...[
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    where: depCasa?.value,
                    codigo: 'DEP',
                    title: 'Departamento de residencia',
                    hintText: 'input.select_option'.tr(),
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    onChanged: (item) {
                      depCasa =
                          Item(name: item?.nombre ?? '', value: item?.valor);
                      munCasa =
                          Item(name: item?.nombre ?? '', value: item?.valor);
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          objDepartamentoCasaId: depCasa?.value,
                          objDepartamentoCasaIdVer: depCasa?.name,
                        ),
                      );
                      setState(() {});
                    },
                  ),
                ],
                if (depCasa?.value != null) ...[
                  const Gap(30),
                  CatalogoValorNacionalidad(
                    where: munCasa?.value,
                    codigo: 'MUN',
                    title: 'Municipio de residencia',
                    hintText: 'input.select_option'.tr(),
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.valor),
                    onChanged: (item) {
                      munCasa =
                          Item(name: item?.nombre ?? '', value: item?.valor);

                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          objMunicipioCasaId: paisCasa?.value,
                          objMunicipioCasaIdVer: paisCasa?.name,
                        ),
                      );
                      setState(() {});
                    },
                  ),
                ],
                const Gap(30),
                SearchDropdownWidget(
                  codigo: 'TIPOVIVIENDA',
                  title: 'Condición Casa',
                  hintText: 'input.select_option'.tr(),
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  onChanged: (item) {
                    condicionCasa = item;

                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objCondicionCasaId: condicionCasa?.value,
                        objCondicionCasaIdVer: condicionCasa?.name,
                      ),
                    );
                    setState(() {});
                  },
                ),
                if (condicionCasa?.value == 'ALQ') ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    key: const Key('pago_alquiler'),
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      CurrencyInputFormatter(),
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
                    ],
                    onChange: (value) {
                      pagoAlquiler = value.replaceAll(',', '');

                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          pagoAlquiler: int.tryParse(pagoAlquiler ?? '0'),
                        ),
                      );
                    },
                    title: 'Pago de alquiler',
                    icon: const Icon(Icons.money),
                  ),
                ],
                if (condicionCasa?.value != 'ALQ') ...[
                  const Gap(30),
                  OutlineTextfieldWidget(
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    key: const Key('nombre_dueno_casa'),
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    onChange: (value) {
                      nombreDuenoCasa = value;

                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          duenoVivienda: nombreDuenoCasa,
                        ),
                      );
                    },
                    title: 'Nombre del dueño de la casa',
                    icon: const Icon(Icons.person),
                  ),
                ],
                const Gap(30),
                OutlineTextfieldWidget(
                  key: const Key('anos_residir'),
                  validator: (value) => ClassValidator.validateRequired(value),
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  onChange: (value) {
                    anosResidir = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        anosResidirCasa: int.tryParse(anosResidir ?? '0'),
                      ),
                    );
                  },
                  title: 'Años de residencia',
                  icon: const Icon(Icons.house),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  key: const Key('direccion_domicilio'),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: (value) => ClassValidator.validateRequired(value),
                  onChange: (value) {
                    direccionDomicilio = value;

                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        direccionCasa: direccionDomicilio,
                      ),
                    );
                  },
                  title: 'Dirección Domicilio',
                  icon: const Icon(Icons.house),
                ),
                const Gap(30),
                OutlineTextfieldWidget(
                  key: const Key('barrio'),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: (value) => ClassValidator.validateRequired(value),
                  onChange: (value) {
                    barrio = value;

                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        barrioCasa: barrio,
                      ),
                    );
                  },
                  title: 'Barrio de domicilio',
                  icon: const Icon(Icons.house),
                ),
                const Gap(20),
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
                const Gap(10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomOutLineButton(
                    onPressed: () {
                      widget.controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    text: 'Atras',
                    textColor: AppColors.red,
                    color: AppColors.red,
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_fiadores/analisis_fiadores_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/fiadores/registrados/fiador_registrado_items.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AnalisisFiadoresDatosPersonales extends StatefulWidget {
  const AnalisisFiadoresDatosPersonales({
    super.key,
    required this.pageController,
    this.readOnly = false,
  });

  final PageController pageController;

  /// Fiador ya registrado (SPEC 10): muestra los valores del cubit sin dejar
  /// cambiarlos, y "Siguiente" no valida.
  final bool readOnly;

  @override
  State<AnalisisFiadoresDatosPersonales> createState() =>
      _AnalisisFiadoresDatosPersonalesState();
}

class _AnalisisFiadoresDatosPersonalesState
    extends State<AnalisisFiadoresDatosPersonales>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<AnalisisFiadoresCubit>();
    final ro = widget.readOnly;

    return BlocBuilder<AnalisisFiadoresCubit, AnalisisFiadoresState>(
      builder: (context, state) {
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Container(
                  margin: const EdgeInsets.all(18),
                  child: Text(
                    'Datos Personales',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                CatalogoValorNacionalidad(
                  codigo: 'PAIS',
                  hintText: 'input.select_option'.tr(),
                  title: 'País:',
                  enabled: !ro,
                  selectedItem: ro
                      ? cubit.nacionalidadRegistrada('Pais', state.paisCodigo)
                      : null,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        paisCodigo: value?.valor,
                      ),
                    );
                  },
                ),
                const Gap(20),
                CatalogoValorNacionalidad(
                  codigo: 'DEP',
                  hintText: 'input.select_option'.tr(),
                  title: 'Departamento:',
                  enabled: !ro,
                  selectedItem: ro
                      ? cubit.nacionalidadRegistrada('Departamento', state.departamentoCodigo)
                      : null,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  where: state.paisCodigo,
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        departamentoCodigo: value?.valor,
                      ),
                    );
                  },
                ),
                const Gap(20),
                CatalogoValorNacionalidad(
                  codigo: 'MUN',
                  hintText: 'input.select_option'.tr(),
                  title: 'Municipio:',
                  enabled: !ro,
                  selectedItem: ro
                      ? cubit.nacionalidadRegistrada('Municipio', state.municipioCodigo)
                      : null,
                  where: state.departamentoCodigo,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        municipioCodigo: value?.valor,
                      ),
                    );
                  },
                ),
                const Gap(20),
                CatalogoValorNacionalidad(
                  codigo: 'ALD',
                  where: state.municipioCodigo,
                  hintText: 'input.select_option'.tr(),
                  title: 'Aldea:',
                  enabled: !ro,
                  selectedItem: ro
                      ? cubit.nacionalidadRegistrada('Aldea', state.aldeaCodigo)
                      : null,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        aldeaCodigo: value?.valor,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Caserío',
                  initialValue: ro ? state.caserioCasa : null,
                  readOnly: ro,
                  icon: const Icon(Icons.person),
                  // validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        caserioCasa: value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Barrio',
                  initialValue: ro ? state.barrioCasa : null,
                  readOnly: ro,
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.person),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        barrioCasa: value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Direccion y Referencia',
                  initialValue: ro ? state.direccion : null,
                  readOnly: ro,
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.person),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        direccion: value,
                      ),
                    );
                  },
                ),
                CatalogoValorNacionalidad(
                  codigo: 'PAIS',
                  hintText: 'input.select_option'.tr(),
                  title: 'Nacionalidad:',
                  enabled: !ro,
                  selectedItem: ro
                      ? cubit.nacionalidadRegistrada('Nacionalidad1', state.nacionalidad1Codigo)
                      : null,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        nacionalidad1Codigo: value?.valor,
                      ),
                    );
                  },
                ),
                CatalogoValorNacionalidad(
                  codigo: 'PAIS',
                  hintText: 'input.select_option'.tr(),
                  title: 'Nacionalidad 2:',
                  enabled: !ro,
                  selectedItem: ro
                      ? cubit.nacionalidadRegistrada('Nacionalidad2', state.nacionalidad2Codigo)
                      : null,
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        nacionalidad2Codigo: value?.valor,
                      ),
                    );
                  },
                ),
                CatalogoValorNacionalidad(
                  codigo: 'PAIS',
                  hintText: 'input.select_option'.tr(),
                  title: 'Nacionalidad 3:',
                  enabled: !ro,
                  selectedItem: ro
                      ? cubit.nacionalidadRegistrada('Nacionalidad3', state.nacionalidad3Codigo)
                      : null,
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        nacionalidad3Codigo: value?.valor,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Teléfono',
                  initialValue: ro ? state.telefono : null,
                  readOnly: ro,
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.person),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        telefono: value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Celular',
                  initialValue: ro ? state.celular : null,
                  readOnly: ro,
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.person),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        celular: value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateEmail(value),
                  title: 'Correo Electrónico',
                  initialValue: ro ? state.email : null,
                  readOnly: ro,
                  icon: const Icon(Icons.person),
                  textInputType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        email: value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  codigo: 'ESCOLARIDAD',
                  title: 'Escolaridad',
                  enabled: !ro,
                  selectedItem: ro
                      ? cubit.itemRegistrado('Escolaridad', state.escolaridadCodigo)
                      : null,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        escolaridadCodigo: value?.value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  codigo: 'PROFESION',
                  title: 'Profesion',
                  enabled: !ro,
                  selectedItem: ro
                      ? cubit.itemRegistrado('Profesion', state.profesionCodigo)
                      : null,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        profesionCodigo: value?.value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  codigo: 'OCUPACION',
                  title: 'Ocupación',
                  enabled: !ro,
                  selectedItem: ro
                      ? cubit.itemRegistrado('Ocupacion', state.ocupacionCodigo)
                      : null,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        ocupacionCodigo: value?.value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Numero de dependientes',
                  initialValue: ro ? state.cantidadDependientes.toString() : null,
                  readOnly: ro,
                  icon: const Icon(Icons.person),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  textInputType: TextInputType.number,
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        cantidadDependientes: int.tryParse(value),
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Numero de hijos',
                  initialValue: ro ? state.cantidadHijos.toString() : null,
                  readOnly: ro,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  textInputType: TextInputType.number,
                  icon: const Icon(Icons.person),
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        cantidadHijos: int.tryParse(value),
                      ),
                    );
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  codigo: 'TIPOPERSONACNBS',
                  title: 'Tipo persona CNBS',
                  enabled: !ro,
                  selectedItem: ro
                      ? cubit.itemRegistrado('TipoPersonaCNBS', state.tipoPersonaCnbsCodigo)
                      : null,
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        tipoPersonaCnbsCodigo: value?.value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  codigo: 'ESTATUSCLIENTE',
                  title: 'Estatus',
                  enabled: !ro,
                  selectedItem: ro
                      ? cubit.itemRegistrado('Estatus', state.estatusCodigo)
                      : null,
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        estatusCodigo: value?.value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  codigo: 'TIPOCLIENTE',
                  title: 'Tipo de cliente',
                  enabled: !ro,
                  selectedItem: ro
                      ? cubit.itemRegistrado('TipoCliente', state.tipoClienteCodigo)
                      : null,
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        tipoClienteCodigo: value?.value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomElevatedButton(
                    onPressed: () {
                      if (!ro && !formKey.currentState!.validate()) return;

                      widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    text: 'Siguiente',
                    color: Colors.green,
                  ),
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomOutLineButton(
                    onPressed: () {
                      widget.pageController.previousPage(
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
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

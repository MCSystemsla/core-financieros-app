import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_fiadores/analisis_fiadores_cubit.dart';
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
  });

  final PageController pageController;

  @override
  State<AnalisisFiadoresDatosPersonales> createState() =>
      _AnalisisFiadoresDatosPersonalesState();
}

class _AnalisisFiadoresDatosPersonalesState
    extends State<AnalisisFiadoresDatosPersonales>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<AnalisisFiadoresCubit>();
    return BlocBuilder<AnalisisFiadoresCubit, AnalisisFiadoresState>(
      builder: (context, state) {
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
                where: state.paisCodigo,
                onChanged: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
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
                where: state.departamentoCodigo,
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
                onChanged: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
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
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
                onChanged: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      aldeaCodigo: value?.valor,
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Caserío',
                icon: const Icon(Icons.person),
                validator: (value) => ClassValidator.validateRequired(value),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      caserioCasa: value,
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Barrio',
                validator: (value) => ClassValidator.validateRequired(value),
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      barrioCasa: value,
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Direccion y Referencia',
                validator: (value) => ClassValidator.validateRequired(value),
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      direccion: value,
                    ),
                  );
                },
              ),
              CatalogoValorNacionalidad(
                codigo: 'PAIS',
                hintText: 'input.select_option'.tr(),
                title: 'Nacionalidad:',
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
                onChanged: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      nacionalidad1Codigo: value?.valor,
                    ),
                  );
                },
              ),
              CatalogoValorNacionalidad(
                codigo: 'PAIS',
                hintText: 'input.select_option'.tr(),
                title: 'Nacionalidad 2:',
                onChanged: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      nacionalidad2Codigo: value?.valor,
                    ),
                  );
                },
              ),
              CatalogoValorNacionalidad(
                codigo: 'PAIS',
                hintText: 'input.select_option'.tr(),
                title: 'Nacionalidad 3:',
                onChanged: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      nacionalidad3Codigo: value?.valor,
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Teléfono',
                validator: (value) => ClassValidator.validateRequired(value),
                icon: const Icon(Icons.person),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      telefono: value,
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Celular',
                validator: (value) => ClassValidator.validateRequired(value),
                icon: const Icon(Icons.person),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      celular: value,
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                validator: (value) => ClassValidator.validateEmail(value),
                title: 'Correo Electrónico',
                icon: const Icon(Icons.person),
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      email: value,
                    ),
                  );
                },
              ),
              const Gap(20),
              SearchDropdownWidget(
                codigo: 'ESCOLARIDAD',
                title: 'Escolaridad',
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
                validator: (value) =>
                    ClassValidator.validateRequired(value?.value),
                onChanged: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      ocupacionCodigo: value?.value,
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Numero de dependientes',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                textInputType: TextInputType.number,
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      cantidadDependientes: int.tryParse(value),
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Numero de hijos',
                validator: (value) => ClassValidator.validateRequired(value),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                textInputType: TextInputType.number,
                icon: const Icon(Icons.person),
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      cantidadHijos: int.tryParse(value),
                    ),
                  );
                },
              ),
              const Gap(20),
              SearchDropdownWidget(
                codigo: 'TIPOPERSONACNBS',
                title: 'Tipo persona CNBS',
                onChanged: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      tipoPersonaCnbsCodigo: value?.value,
                    ),
                  );
                },
              ),
              const Gap(20),
              SearchDropdownWidget(
                codigo: 'ESTATUSCLIENTE',
                title: 'Estatus',
                onChanged: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
                      estatusCodigo: value?.value,
                    ),
                  );
                },
              ),
              const Gap(20),
              SearchDropdownWidget(
                codigo: 'TIPOCLIENTE',
                title: 'Tipo de cliente',
                validator: (value) =>
                    ClassValidator.validateRequired(value?.value),
                onChanged: (value) {
                  cubit.onFieldChanged(
                    () => cubit.state.copyWith(
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
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

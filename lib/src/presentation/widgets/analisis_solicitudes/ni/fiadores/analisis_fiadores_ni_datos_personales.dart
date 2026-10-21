import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/ni/analisis_fiadores/analisis_fiadores_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/fiadores/fiador_ni_form_layout.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AnalisisFiadoresNiDatosPersonales extends StatefulWidget {
  final PageController pageController;
  const AnalisisFiadoresNiDatosPersonales({
    super.key,
    required this.pageController,
  });

  @override
  State<AnalisisFiadoresNiDatosPersonales> createState() =>
      _AnalisisFiadoresNiDatosPersonalesState();
}

class _AnalisisFiadoresNiDatosPersonalesState
    extends State<AnalisisFiadoresNiDatosPersonales>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<AnalisisFiadoresNiCubit>();
    return BlocBuilder<AnalisisFiadoresNiCubit, AnalisisFiadoresNiState>(
      builder: (context, state) {
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(16),
                FiadorNiSectionCard(
                  label: 'DOMICILIO',
                  children: [
                    CatalogoValorNacionalidad(
                      codigo: 'PAIS',
                      hintText: 'input.select_option'.tr(),
                      title: 'País:',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.valor),
                      onChanged: (value) {
                        // Un país nuevo invalida departamento y municipio.
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            paisCodigo: value?.valor,
                            departamentoCodigo: '',
                            municipioCodigo: '',
                          ),
                        );
                      },
                    ),
                    if (state.paisCodigo.isNotEmpty)
                      CatalogoValorNacionalidad(
                        // La key recrea el dropdown (sin selección) al
                        // cambiar el padre.
                        key: ValueKey('dep-${state.paisCodigo}'),
                        codigo: 'DEP',
                        where: state.paisCodigo,
                        hintText: 'input.select_option'.tr(),
                        title: 'Departamento:',
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.valor),
                        onChanged: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              departamentoCodigo: value?.valor,
                              municipioCodigo: '',
                            ),
                          );
                        },
                      ),
                    if (state.departamentoCodigo.isNotEmpty)
                      CatalogoValorNacionalidad(
                        key: ValueKey('mun-${state.departamentoCodigo}'),
                        codigo: 'MUN',
                        where: state.departamentoCodigo,
                        hintText: 'input.select_option'.tr(),
                        title: 'Municipio:',
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
                    OutlineTextfieldWidget(
                      initialValue: state.barrioCasa,
                      title: 'Barrio:',
                      icon: const Icon(Icons.location_city_outlined),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(barrioCasa: value),
                        );
                      },
                    ),
                    OutlineTextfieldWidget(
                      initialValue: state.direccion,
                      title: 'Dirección y referencia:',
                      icon: const Icon(Icons.home_outlined),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(direccion: value),
                        );
                      },
                    ),
                  ],
                ),
                FiadorNiSectionCard(
                  label: 'CONTACTO',
                  children: [
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
                    OutlineTextfieldWidget(
                      initialValue: state.telefono,
                      title: 'Teléfono:',
                      icon: const Icon(Icons.phone_outlined),
                      textInputType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(telefono: value),
                        );
                      },
                    ),
                    OutlineTextfieldWidget(
                      initialValue: state.celular,
                      title: 'Celular:',
                      icon: const Icon(Icons.smartphone_outlined),
                      textInputType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(celular: value),
                        );
                      },
                    ),
                    OutlineTextfieldWidget(
                      initialValue: state.email,
                      title: 'Correo electrónico:',
                      icon: const Icon(Icons.mail_outline),
                      textInputType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) => ClassValidator.validateEmail(value),
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(email: value),
                        );
                      },
                    ),
                  ],
                ),
                FiadorNiSectionCard(
                  label: 'PERFIL',
                  children: [
                    SearchDropdownWidget(
                      codigo: 'ESCOLARIDAD',
                      title: 'Escolaridad:',
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
                    SearchDropdownWidget(
                      codigo: 'PROFESION',
                      title: 'Profesión:',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      onChanged: (value) {
                        // El body lleva el código y también el nombre.
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            profesionCodigo: value?.value,
                            profesion: value?.name,
                          ),
                        );
                      },
                    ),
                    SearchDropdownWidget(
                      codigo: 'OCUPACION',
                      title: 'Ocupación:',
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
                    OutlineTextfieldWidget(
                      initialValue: state.cantidadDependientes == 0
                          ? null
                          : state.cantidadDependientes.toString(),
                      title: 'Número de dependientes:',
                      icon: const Icon(Icons.family_restroom_outlined),
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            cantidadDependientes: int.tryParse(value) ?? 0,
                          ),
                        );
                      },
                    ),
                    OutlineTextfieldWidget(
                      initialValue: state.cantidadHijos == 0
                          ? null
                          : state.cantidadHijos.toString(),
                      title: 'Número de hijos:',
                      icon: const Icon(Icons.child_care_outlined),
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            cantidadHijos: int.tryParse(value) ?? 0,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                FiadorNiSectionCard(
                  label: 'CLASIFICACIÓN',
                  children: [
                    SearchDropdownWidget(
                      codigo: 'TIPOPERSONACNBS',
                      title: 'Tipo de persona:',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      onChanged: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            tipoPersonaCNBSCodigo: value?.value,
                          ),
                        );
                      },
                    ),
                    SearchDropdownWidget(
                      codigo: 'ESTATUSCLIENTE',
                      title: 'Estatus:',
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.value),
                      onChanged: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            estatusCodigo: value?.value,
                          ),
                        );
                      },
                    ),
                    SearchDropdownWidget(
                      codigo: 'TIPOCLIENTE',
                      title: 'Tipo de cliente:',
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
                  ],
                ),
                FiadorNiStepButtons(
                  onSecondary: () => widget.pageController.previousPage(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                  ),
                  onPrimary: () {
                    if (!formKey.currentState!.validate()) return;
                    widget.pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
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

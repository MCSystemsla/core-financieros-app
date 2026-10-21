import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/ni/analisis_fiadores/analisis_fiadores_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/fiadores/fiador_ni_form_layout.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AnalisisFiadoresNiDatosDeActividad extends StatefulWidget {
  final PageController pageController;
  const AnalisisFiadoresNiDatosDeActividad({
    super.key,
    required this.pageController,
  });

  @override
  State<AnalisisFiadoresNiDatosDeActividad> createState() =>
      _AnalisisFiadoresNiDatosDeActividadState();
}

class _AnalisisFiadoresNiDatosDeActividadState
    extends State<AnalisisFiadoresNiDatosDeActividad>
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
                  label: 'TIPO DE ACTIVIDAD',
                  children: [
                    // Asalariado y empresario son excluyentes, igual que en HN.
                    // Al apagar asalariado se limpian sus datos para no enviar
                    // campos que ya no se ven.
                    CustomSwitch(
                      title: '¿Es asalariado?',
                      subtitle: 'El fiador es asalariado',
                      value: state.esAsalariado,
                      onChanged: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            esAsalariado: value,
                            esEmpresario: value ? false : null,
                            empresa: value ? null : '',
                            cargo: value ? null : '',
                            tiempoLaborar: value ? null : '',
                            direccionTrabajo: value ? null : '',
                            telefonoTrabajo: value ? null : '',
                            lugarTrabajoAnterior: value ? null : '',
                          ),
                        );
                      },
                    ),
                    CustomSwitch(
                      title: '¿Es empresario?',
                      subtitle: 'El fiador es empresario',
                      value: state.esEmpresario,
                      onChanged: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            esEmpresario: value,
                            esAsalariado: value ? false : null,
                            empresa: value ? '' : null,
                            cargo: value ? '' : null,
                            tiempoLaborar: value ? '' : null,
                            direccionTrabajo: value ? '' : null,
                            telefonoTrabajo: value ? '' : null,
                            lugarTrabajoAnterior: value ? '' : null,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                if (state.esAsalariado)
                  FiadorNiSectionCard(
                    label: 'DATOS LABORALES',
                    children: [
                      OutlineTextfieldWidget(
                        initialValue: state.empresa,
                        title: 'Empresa en que labora:',
                        icon: const Icon(Icons.business_outlined),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(empresa: value),
                          );
                        },
                      ),
                      OutlineTextfieldWidget(
                        initialValue: state.cargo,
                        title: 'Cargo:',
                        icon: const Icon(Icons.work_outline),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(cargo: value),
                          );
                        },
                      ),
                      OutlineTextfieldWidget(
                        initialValue: state.tiempoLaborar,
                        title: 'Tiempo de laborar:',
                        icon: const Icon(Icons.schedule_outlined),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(tiempoLaborar: value),
                          );
                        },
                      ),
                      OutlineTextfieldWidget(
                        initialValue: state.direccionTrabajo,
                        title: 'Dirección y referencia del trabajo:',
                        icon: const Icon(Icons.place_outlined),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(direccionTrabajo: value),
                          );
                        },
                      ),
                      OutlineTextfieldWidget(
                        initialValue: state.lugarTrabajoAnterior,
                        title: 'Lugar de trabajo anterior:',
                        icon: const Icon(Icons.history_outlined),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              lugarTrabajoAnterior: value,
                            ),
                          );
                        },
                      ),
                      OutlineTextfieldWidget(
                        initialValue: state.telefonoTrabajo,
                        title: 'Teléfono del trabajo:',
                        icon: const Icon(Icons.phone_outlined),
                        textInputType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(telefonoTrabajo: value),
                          );
                        },
                      ),
                    ],
                  ),
                FiadorNiSectionCard(
                  label: 'UBICACIÓN DE LA OCUPACIÓN',
                  children: [
                    CatalogoValorNacionalidad(
                      codigo: 'PAIS',
                      title: 'País:',
                      hintText: 'input.select_option'.tr(),
                      validator: (value) =>
                          ClassValidator.validateRequired(value?.valor),
                      onChanged: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            paisOcupacionCodigo: value?.valor,
                            departamentoOcupacionCodigo: '',
                            municipioOcupacionCodigo: '',
                          ),
                        );
                      },
                    ),
                    if (state.paisOcupacionCodigo.isNotEmpty)
                      CatalogoValorNacionalidad(
                        key: ValueKey('dep-ocup-${state.paisOcupacionCodigo}'),
                        codigo: 'DEP',
                        where: state.paisOcupacionCodigo,
                        title: 'Departamento:',
                        hintText: 'input.select_option'.tr(),
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.valor),
                        onChanged: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              departamentoOcupacionCodigo: value?.valor,
                              municipioOcupacionCodigo: '',
                            ),
                          );
                        },
                      ),
                    if (state.departamentoOcupacionCodigo.isNotEmpty)
                      CatalogoValorNacionalidad(
                        key: ValueKey(
                          'mun-ocup-${state.departamentoOcupacionCodigo}',
                        ),
                        codigo: 'MUN',
                        where: state.departamentoOcupacionCodigo,
                        title: 'Municipio:',
                        hintText: 'input.select_option'.tr(),
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.valor),
                        onChanged: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              municipioOcupacionCodigo: value?.valor,
                            ),
                          );
                        },
                      ),
                    OutlineTextfieldWidget(
                      initialValue: state.barrioTrabajo,
                      title: 'Barrio:',
                      icon: const Icon(Icons.location_city_outlined),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      validator: (value) =>
                          ClassValidator.validateRequired(value),
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(barrioTrabajo: value),
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

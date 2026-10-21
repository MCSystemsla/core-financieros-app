import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/ni/analisis_fiadores/analisis_fiadores_ni_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/ni/fiadores/fiador_ni_form_layout.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

/// Paso 3: columna derecha de la pestaña "Datos personales" del sistema de
/// escritorio de NI (asalariado, empresario y lugar de trabajo).
class AnalisisFiadoresNiDatosLaborales extends StatefulWidget {
  final PageController pageController;
  const AnalisisFiadoresNiDatosLaborales({
    super.key,
    required this.pageController,
  });

  @override
  State<AnalisisFiadoresNiDatosLaborales> createState() =>
      _AnalisisFiadoresNiDatosLaboralesState();
}

class _AnalisisFiadoresNiDatosLaboralesState
    extends State<AnalisisFiadoresNiDatosLaborales>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<AnalisisFiadoresNiCubit>();
    return BlocBuilder<AnalisisFiadoresNiCubit, AnalisisFiadoresNiState>(
      builder: (context, state) {
        // El lugar de trabajo solo es obligatorio si el fiador trabaja.
        final trabaja = state.esAsalariado || state.esEmpresario;
        String? requiredSiTrabaja(dynamic value) =>
            trabaja ? ClassValidator.validateRequired(value) : null;

        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(16),
                FiadorNiSectionCard(
                  label: 'ASALARIADO',
                  children: [
                    // Al apagarlo se limpian sus datos para no enviar campos
                    // que ya no se ven.
                    CustomSwitch(
                      title: '¿Es asalariado?',
                      subtitle: 'El fiador es asalariado',
                      value: state.esAsalariado,
                      onChanged: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            esAsalariado: value,
                            empresa: value ? null : '',
                            cargo: value ? null : '',
                            tiempoLaborar: value ? null : '',
                          ),
                        );
                      },
                    ),
                    if (state.esAsalariado) ...[
                      OutlineTextfieldWidget(
                        initialValue: state.empresa,
                        title: 'Empresa que labora:',
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
                        title: 'Tiempo laborar:',
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
                    ],
                  ],
                ),
                FiadorNiSectionCard(
                  label: 'EMPRESARIO',
                  children: [
                    CustomSwitch(
                      title: '¿Es empresario?',
                      subtitle: 'El fiador es empresario',
                      value: state.esEmpresario,
                      onChanged: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            esEmpresario: value,
                            actividadCodigo: value ? null : '',
                            tiempoActividad: value ? null : '',
                          ),
                        );
                      },
                    ),
                    if (state.esEmpresario) ...[
                      SearchDropdownWidget(
                        codigo: 'ACTIVIDADECONOMICA',
                        title: 'Actividad:',
                        validator: (value) =>
                            ClassValidator.validateRequired(value?.value),
                        onChanged: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              actividadCodigo: value?.value,
                            ),
                          );
                        },
                      ),
                      OutlineTextfieldWidget(
                        initialValue: state.tiempoActividad,
                        title: 'Tiempo actividad:',
                        icon: const Icon(Icons.schedule_outlined),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
                        validator: (value) =>
                            ClassValidator.validateRequired(value),
                        onChange: (value) {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(tiempoActividad: value),
                          );
                        },
                      ),
                    ],
                  ],
                ),
                FiadorNiSectionCard(
                  label: 'LUGAR DE TRABAJO',
                  children: [
                    OutlineTextfieldWidget(
                      initialValue: state.direccionTrabajo,
                      title: 'Dirección trabajo:',
                      icon: const Icon(Icons.place_outlined),
                      inputFormatters: [
                        UpperCaseTextFormatter(),
                      ],
                      validator: requiredSiTrabaja,
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(direccionTrabajo: value),
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
                      validator: requiredSiTrabaja,
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(barrioTrabajo: value),
                        );
                      },
                    ),
                    OutlineTextfieldWidget(
                      initialValue: state.telefonoTrabajo,
                      title: 'Teléfono trabajo:',
                      icon: const Icon(Icons.phone_outlined),
                      textInputType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: requiredSiTrabaja,
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(telefonoTrabajo: value),
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
                      onChange: (value) {
                        cubit.onFieldChanged(
                          () => cubit.state.copyWith(
                            lugarTrabajoAnterior: value,
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

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_fiadores/analisis_fiadores_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/time_picker/time_picker_bottom_sheet.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AnalisisDatosDeActividad extends StatefulWidget {
  const AnalisisDatosDeActividad({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<AnalisisDatosDeActividad> createState() =>
      _AnalisisDatosDeActividadState();
}

class _AnalisisDatosDeActividadState extends State<AnalisisDatosDeActividad>
    with AutomaticKeepAliveClientMixin {
  bool esAsalariado = false;
  bool esEmpresario = false;

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
                  'Informacion del trabajo o negocio',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              CustomSwitch(
                title: 'Es Asalariado?',
                subtitle: 'El fiador es Asalariado?',
                value: esAsalariado,
                onChanged: (value) {
                  setState(() {
                    esAsalariado = value;
                    esEmpresario = false;
                  });
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      esAsalariado: value,
                      esEmpresario: false,
                    ),
                  );
                },
              ),
              if (esAsalariado) ...[
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Empresa que labora',
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.person),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        empresa: value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Cargo',
                  icon: const Icon(Icons.person),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        cargo: value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Tiempo Laborar',
                  validator: (value) => ClassValidator.validateRequired(value),
                  icon: const Icon(Icons.person),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  textInputType: TextInputType.number,
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        tiempoLaborar: value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Lugar de trabajo anterior',
                  icon: const Icon(Icons.person),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: (value) => ClassValidator.validateRequired(value),
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        lugarTrabajoAnterior: value,
                      ),
                    );
                  },
                ),
              ],
              const Gap(20),
              CustomSwitch(
                title: 'Es Empresario?',
                subtitle: 'El fiador es Empresario?',
                value: esEmpresario,
                onChanged: (value) {
                  setState(() {
                    esEmpresario = value;
                    esAsalariado = false;
                  });
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      esEmpresario: value,
                      esAsalariado: false,
                    ),
                  );
                },
              ),
              if (esEmpresario) ...[
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Nombre del negocio',
                  icon: const Icon(Icons.person),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        nombreNegocio: value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Anos de funcionamiento',
                  icon: const Icon(Icons.person),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  textInputType: TextInputType.number,
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        tiempoNegocio: int.tryParse(value) ?? 0,
                      ),
                    );
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  codigo: 'NIVELAPROXIMADOINGRESOS',
                  title: 'Nivel de aproximado en ingresos',
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        nivelAproximadoIngresosCodigo: value?.value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Puesto que desempeña',
                  icon: const Icon(Icons.person),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        puesto: value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                SearchDropdownWidget(
                  codigo: 'TIPOVIVIENDA',
                  title: 'Condición local del negocio',
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  onChanged: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        condicionLocalCodigo: value?.value,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Horario de visita',
                  hintText: state.horarioVisita,
                  icon: const Icon(Icons.watch_later_sharp),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  readOnly: true,
                  onTap: () => {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (_) => TimePickerBottomSheet(
                        initial: DateTime.now(),
                        use24hFormat: false,
                        onSelected: (time) {
                          cubit.onFieldChanged(
                            () => state.copyWith(
                              horarioVisita: time,
                            ),
                          );
                        },
                      ),
                    ),
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Horario de trabajo',
                  hintText: state.horarioTrabajo,
                  icon: const Icon(Icons.watch_later_sharp),
                  readOnly: true,
                  onTap: () => {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (_) => TimePickerBottomSheet(
                        initial: DateTime.now(),
                        use24hFormat: false,
                        onSelected: (time) {
                          cubit.onFieldChanged(
                            () => state.copyWith(
                              horarioTrabajo: time,
                            ),
                          );
                        },
                      ),
                    ),
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  title: 'Anos de experiencia',
                  icon: const Icon(Icons.person),
                  validator: (value) => ClassValidator.validateRequired(value),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  textInputType: TextInputType.number,
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        tiempoActividad: value,
                      ),
                    );
                  },
                ),
              ],
              const Gap(20),
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Informacion de contacto y direccion del trabajo/negocio',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const Gap(20),
              CatalogoValorNacionalidad(
                codigo: 'PAIS',
                title: 'Pais',
                hintText: 'input.select_option'.tr(),
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
                onChanged: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      paisOcupacionCodigo: value?.valor,
                    ),
                  );
                },
              ),
              const Gap(20),
              CatalogoValorNacionalidad(
                codigo: 'DEP',
                title: 'Departamento',
                hintText: 'input.select_option'.tr(),
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
                where: state.paisOcupacionCodigo,
                onChanged: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      departamentoOcupacionCodigo: value?.valor,
                    ),
                  );
                },
              ),
              const Gap(20),
              CatalogoValorNacionalidad(
                codigo: 'MUN',
                title: 'Municipio',
                hintText: 'input.select_option'.tr(),
                where: state.departamentoOcupacionCodigo,
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
                onChanged: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      municipioOcupacionCodigo: value?.valor,
                    ),
                  );
                },
              ),
              const Gap(20),
              CatalogoValorNacionalidad(
                codigo: 'ALD',
                title: 'Aldea',
                where: state.municipioOcupacionCodigo,
                hintText: 'input.select_option'.tr(),
                validator: (value) =>
                    ClassValidator.validateRequired(value?.valor),
                onChanged: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      aldeaOcupacionCodigo: value?.valor,
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Caserio',
                hintText: 'input.select_option'.tr(),
                icon: const Icon(Icons.person),
                validator: (value) => ClassValidator.validateRequired(value),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      caserioOcupacion: value,
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
                    () => state.copyWith(
                      barrioTrabajo: value,
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Direccion y referencia',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      direccionTrabajo: value,
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Telefono',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                textInputType: TextInputType.phone,
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      telefonoTrabajo: value,
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                title: 'Celular',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                textInputType: TextInputType.phone,
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      celularOcupacion: value,
                    ),
                  );
                },
              ),
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

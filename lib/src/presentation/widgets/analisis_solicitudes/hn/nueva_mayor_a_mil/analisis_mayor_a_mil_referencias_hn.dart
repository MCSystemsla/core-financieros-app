import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';

class AnalisisMayorAMilReferenciasHN extends StatelessWidget {
  const AnalisisMayorAMilReferenciasHN({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisNuevaMayorMilHnCubit>();
    return BlocBuilder<AnalisisNuevaMayorMilHnCubit,
        AnalisisNuevaMayorMilHnState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Referencia 1',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.nombreReferencia1,
                title: 'Nombres y apellidos',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(nombreReferencia1: value),
                  );
                },
              ),
              const Gap(20),
              SearchDropdownWidget(
                selectedItem: Item(
                  name: state.parentescoReferenciaCodigo1,
                  value: state.parentescoReferenciaCodigo1,
                ),
                codigo: 'PARENTESCO',
                title: 'Tipo Parentesco',
                onChanged: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      parentescoReferenciaCodigo1: value?.value,
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.direccionReferencia1,
                title: 'Direccion',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(direccionReferencia1: value),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.lugarTrabajoReferencia1,
                title: 'Centro laboral',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(lugarTrabajoReferencia1: value),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.cedulaReferencia1,
                title: 'Numero de cédula',
                icon: const Icon(Icons.person),
                textInputType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(cedulaReferencia1: value),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.telefonoReferencia1,
                title: 'Telefono Referencia',
                icon: const Icon(Icons.person),
                textInputType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(telefonoReferencia1: value),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.resultadoVerificacion1,
                title: 'Resultado Verificacion',
                icon: const Icon(Icons.person),
                textInputType: TextInputType.number,
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(resultadoVerificacion1: value),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.aniosConocerReferido1.toString(),
                title: 'Años de conocer referido',
                icon: const Icon(Icons.person),
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        aniosConocerReferido1: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Referencia 2',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.nombreReferencia2,
                title: 'Nombres y apellidos:',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(nombreReferencia2: value),
                  );
                },
              ),
              const Gap(20),
              SearchDropdownWidget(
                selectedItem: Item(
                  name: state.parentescoReferenciaCodigo2,
                  value: state.parentescoReferenciaCodigo2,
                ),
                codigo: 'PARENTESCO',
                title: 'Tipo Parentesco',
                onChanged: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      parentescoReferenciaCodigo2: value?.value,
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.direccionReferencia2,
                title: 'Direccion:',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(direccionReferencia2: value),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.lugarTrabajoReferencia2,
                title: 'Centro laboral:',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(lugarTrabajoReferencia2: value),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.cedulaReferencia2,
                title: 'Numero de cédula:',
                textInputType: TextInputType.number,
                icon: const Icon(Icons.person),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(cedulaReferencia2: value),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.telefonoReferencia2,
                title: 'Telefono Referencia 2:',
                textInputType: TextInputType.number,
                icon: const Icon(Icons.person),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(telefonoReferencia2: value),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.aniosConocerReferido2.toString(),
                title: 'Años de conocer referido 2:',
                textInputType: TextInputType.number,
                icon: const Icon(Icons.person),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        aniosConocerReferido2: double.tryParse(newValue) ?? 0),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.resultadoVerificacion2,
                title: 'Resultado Verificacion',
                icon: const Icon(Icons.person),
                textInputType: TextInputType.number,
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(resultadoVerificacion2: value),
                  );
                },
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CustomElevatedButton(
                      onPressed: () {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      text: 'Siguiente',
                      color: Colors.green,
                    ),
                    const Gap(10),
                    CustomElevatedButton(
                      onPressed: () {
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      text: 'Anterior',
                      color: Colors.red,
                    ),
                    const Gap(20),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

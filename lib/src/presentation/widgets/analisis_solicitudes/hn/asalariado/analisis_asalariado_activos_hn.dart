import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_asalariado/analisis_asalariado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

class AnalisisAsalariadoActivosHN extends StatelessWidget {
  const AnalisisAsalariadoActivosHN({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisAsalariadoHnCubit>();
    return BlocBuilder<AnalisisAsalariadoHnCubit, AnalisisAsalariadoHnState>(
      builder: (context, state) {
        final totalActivosCalc = state.activo +
            state.cuentasXCobrar +
            state.valoresAcciones +
            state.menajeHogar +
            state.vehiculo +
            state.maquinaria +
            state.bienesInmuebles;

        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Estado Patrimonial',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Activos:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.activo
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Caja y banco:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      activo: double.tryParse(newValue),
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.cuentasXCobrar
                    .toCurrencyString(
                      mantissaLength: 0,
                    )
                    .toNullIfEmptyOrZero(),
                title: 'Cuentas por cobrar:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      cuentasXCobrar: double.tryParse(newValue),
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.valoresAcciones
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Valores y acciones:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () =>
                        state.copyWith(valoresAcciones: int.tryParse(newValue)),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.menajeHogar
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Menaje del hogar:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      menajeHogar: double.tryParse(newValue),
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.vehiculo
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Vehiculo:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      vehiculo: int.tryParse(newValue),
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.maquinaria
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Maquinaria:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      maquinaria: double.tryParse(newValue),
                    ),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.bienesInmuebles
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Bienes inmuebles:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () =>
                        state.copyWith(bienesInmuebles: int.tryParse(newValue)),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                hintText: totalActivosCalc.toCurrencyString(mantissaLength: 0),
                readOnly: true,
                title: 'Total activos:',
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  CurrencyInputFormatter(
                    mantissaLength: 0,
                  ),
                ],
                onChange: (value) {
                  final newValue = toNumericString(value);
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      totalActivo: double.tryParse(newValue),
                    ),
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

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_asalariado/analisis_asalariado_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:gap/gap.dart';

class AnalisisAsalariadoEstadoResultadoHn extends StatelessWidget {
  final PageController pageController;
  const AnalisisAsalariadoEstadoResultadoHn({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisAsalariadoHnCubit>();
    final incobrablesxCobrar = global<SolicitudesHnBoxService>()
        .getParametroByName(nombre: 'INCOBRABLESDECXCOBRAR');
    return BlocBuilder<AnalisisAsalariadoHnCubit, AnalisisAsalariadoHnState>(
      builder: (context, state) {
        final totalIngresosCalc =
            state.ingresoNetoSalario + state.otrosIngresos;

        final imprevistosCalc = (state.alimentacion +
                state.educacion +
                state.serviciosBasicos +
                state.aseoLimpieza +
                state.vestimentaCalzado +
                state.transporteCombustibleMtto) *
            double.parse(incobrablesxCobrar?.valor ?? '0');

        final totalEgresosCalc = (state.alimentacion +
            state.educacion +
            state.serviciosBasicos +
            state.aseoLimpieza +
            state.vestimentaCalzado +
            state.transporteCombustibleMtto +
            imprevistosCalc +
            state.otrosEgresos +
            state.amortizacionesDeudas);
        final disponiblesCalc = totalIngresosCalc - totalEgresosCalc;

        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Estado de Resultado:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Ingresos:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.ingresoNetoSalario
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Ingreso(s) neto(s) por salario:',
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
                        ingresoNetoSalario: double.tryParse(newValue)),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.otrosIngresos
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Otros Ingresos (debidamente comprobados):',
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
                        otrosIngresos: double.tryParse(newValue)),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                hintText: totalIngresosCalc.toCurrencyString(mantissaLength: 0),
                readOnly: true,
                title: 'Total Ingresos:',
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
                        totalIngresos: double.tryParse(newValue)),
                  );
                },
              ),
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Egresos:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.alimentacion
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Alimentacion:',
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
                    () => state.copyWith(alimentacion: int.tryParse(newValue)),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.educacion
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Educacion:',
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
                    () => state.copyWith(educacion: int.tryParse(newValue)),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.serviciosBasicos
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Servicios basicos (Agua, luz, teléfono, etc.):',
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
                        serviciosBasicos: int.tryParse(newValue)),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.aseoLimpieza
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Aseo limpieza:',
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
                    () => state.copyWith(aseoLimpieza: int.tryParse(newValue)),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.vestimentaCalzado
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Vestimenta y calzado:',
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
                        vestimentaCalzado: int.tryParse(newValue)),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.transporteCombustibleMtto
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Transporte / Combustible / Mantenimiento Vehiculo:',
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
                        transporteCombustibleMtto: int.tryParse(newValue)),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                hintText: imprevistosCalc.toCurrencyString(
                  mantissaLength: 0,
                ),
                readOnly: true,
                title: 'Imprevistos:',
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
                    () => state.copyWith(imprevistos: int.tryParse(newValue)),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.amortizacionesDeudas
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Amortizaciones de deudas pendientes:',
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
                        amortizacionesDeudas: int.tryParse(newValue)),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                initialValue: state.otrosEgresos
                    .toCurrencyString(mantissaLength: 0)
                    .toNullIfEmptyOrZero(),
                title: 'Otros Egresos:',
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
                    () => state.copyWith(otrosEgresos: int.tryParse(newValue)),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                hintText: totalEgresosCalc.toCurrencyString(
                  mantissaLength: 0,
                ),
                readOnly: true,
                title: 'Total Egresos:',
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
                    () => state.copyWith(totalEgresos: int.tryParse(newValue)),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                hintText: disponiblesCalc.toCurrencyString(
                  mantissaLength: 0,
                ),
                readOnly: true,
                title: 'Disponibilidad (Ingresos Egresos):',
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
                    () => state.copyWith(disponible: double.tryParse(newValue)),
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

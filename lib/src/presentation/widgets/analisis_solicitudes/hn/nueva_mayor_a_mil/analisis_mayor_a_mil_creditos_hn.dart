import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/nueva_mayor_a_mil/tables/table_ingresos_familiares_fuera_negocio_hn_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_card_list_hn.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';

import '../../../../bloc/analisis/hn/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_hn_cubit.dart';

class AnalisisMayorAMilCreditosHN extends StatefulWidget {
  const AnalisisMayorAMilCreditosHN({
    super.key,
    required this.pageController,
    required this.numeroSolicitud,
  });

  final PageController pageController;
  final int numeroSolicitud;

  @override
  State<AnalisisMayorAMilCreditosHN> createState() =>
      _AnalisisMayorAMilCreditosHNState();
}

class _AnalisisMayorAMilCreditosHNState
    extends State<AnalisisMayorAMilCreditosHN> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<AnalisisNuevaMayorMilHnCubit>();
    cubit.loadNegocioFamiliarFueraNegocioFromLocalDb(
      numeroSolicitud: widget.numeroSolicitud,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisNuevaMayorMilHnCubit>();
    return BlocBuilder<AnalisisNuevaMayorMilHnCubit,
        AnalisisNuevaMayorMilHnState>(
      builder: (context, state) {
        final totalIngresosFueraNegocio = state.ingeresosFamilaresFueraNegocio
            .fold(0, (sum, e) => sum + e.ingresosFamiliaresFueraNegocio);
        final totalIngresosAnual =
            state.cicloVentaMensual.ciclo.fold(0, (sum, e) => sum + e.venta);
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Detalle del crédito',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              OutlineTextfieldWidget(
                textAlign: TextAlign.end,
                hintText: totalIngresosAnual.toCurrencyString(
                  mantissaLength: 0,
                ),
                title: 'Ingreso anual y/o volumen de venta',
                readOnly: true,
                icon: const Icon(Icons.document_scanner),
                textInputType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                        ingresoAnual: double.tryParse(value) ?? 0),
                  );
                },
              ),
              const Gap(20),
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Nombre de sus principales clientes',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.cliente1.toNullIfEmptyOrZero(),
                title: 'Cliente 1',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(cliente1: value),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.cliente2,
                title: 'Cliente 2',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(cliente2: value),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.cliente3.toNullIfEmptyOrZero(),
                title: 'Cliente 3',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(cliente3: value),
                  );
                },
              ),
              const Gap(20),
              Container(
                margin: const EdgeInsets.all(18),
                child: Text(
                  'Nombre de sus proveedores',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.proveedor1,
                title: 'Proveedor 1',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(proveedor1: value),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.proveedor2,
                title: 'Proveedor 2',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(proveedor2: value),
                  );
                },
              ),
              const Gap(20),
              OutlineTextfieldWidget(
                initialValue: state.proveedor3,
                title: 'Proveedor 3',
                icon: const Icon(Icons.person),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                onChange: (value) {
                  cubit.onFieldChanged(
                    () => state.copyWith(proveedor3: value),
                  );
                },
              ),
              AnalisisCardListHn(
                title: 'Ingresos Familiares Fuera del negocio',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<AnalisisNuevaMayorMilHnCubit>(),
                        child:
                            const TableIngresosFamiliaresFueraNegocioHnWidget(),
                      ),
                    ),
                  );
                },
                items: [
                  AnalisisCardItem(
                    icon: Icons.sell,
                    label: 'Total Ingresos',
                    value: totalIngresosFueraNegocio.toCurrencyString(
                      leadingSymbol: 'L.',
                      mantissaLength: 0,
                    ),
                    color: Colors.indigo,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CustomElevatedButton(
                      onPressed: () {
                        widget.pageController.nextPage(
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
                        widget.pageController.previousPage(
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

import 'package:core_financiero_app/src/datasource/analisis/nuevamenor/analisis_nueva_menor.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/analisis_solicitud_nueva_menor/analisis_solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/expandable/expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';

class AnalisisFormSolicitud extends StatefulWidget {
  final PageController pageController;
  final AnalisisSolicitudNuevaMenorResponse solicitud;
  const AnalisisFormSolicitud({
    super.key,
    required this.pageController,
    required this.solicitud,
  });

  @override
  State<AnalisisFormSolicitud> createState() => _AnalisisFormSolicitudState();
}

class _AnalisisFormSolicitudState extends State<AnalisisFormSolicitud> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTitleCustom(
              title: Text(
                'Balance General Expresado en cordobas',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: [
                ExpansionTitleCustom(
                  childrenPadding: const EdgeInsets.symmetric(vertical: 15),
                  title: const Text('Activos'),
                  finalStep: false,
                  children: [
                    _ActivosWidgetsForm(
                      solicitud: widget.solicitud,
                    ),
                  ],
                ),
                ExpansionTitleCustom(
                  childrenPadding: const EdgeInsets.symmetric(vertical: 15),
                  title: const Text('Pasivos'),
                  finalStep: false,
                  children: [
                    _PasivosAnalisisWidgetsForm(
                      solicitud: widget.solicitud,
                    ),
                  ],
                ),
              ],
            ),
            const Gap(20),
            ExpansionTitleCustom(
              childrenPadding: const EdgeInsets.symmetric(vertical: 15),
              title: Text(
                'Estado de resultado expresado en cordobas',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: const [
                _EstadoResultado(),
              ],
            ),
            const Gap(30),
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
          ],
        ),
      ),
    );
  }
}

class _EstadoResultado extends StatelessWidget {
  const _EstadoResultado();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisSolicitudNuevaMenorCubit>().state;
    final onFieldChanged = context.read<AnalisisSolicitudNuevaMenorCubit>();
    return Column(
      children: [
        OutlineTextfieldWidget(
          initialValue: cubit.ventasContado.toCurrencyString(),
          title: 'Ventas de contado:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(ventasContado: newValue);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.recuperaciones.toCurrencyString(),
          title: 'Recuperaciones:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(
                recuperaciones: newValue,
              );
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.totalIngresos.toCurrencyString(),
          title: 'Total ingresos:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(
                totalIngresos: newValue,
              );
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.costoVenta.toCurrencyString(),
          title: 'Costo de Ventas:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(
                costoVenta: newValue,
              );
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.gastosOperativos.toCurrencyString(),
          title: 'Gastos operativos:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(
                gastosOperativos: newValue,
              );
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.margenBrutoNegocio.toCurrencyString(),
          title: 'Margen bruto del negocio:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(
                margenBrutoNegocio: newValue,
              );
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.otrosIngresos.toCurrencyString(),
          title: 'Otros ingresos:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(
                otrosIngresos: newValue,
              );
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.gastosUnidadFamiliar.toCurrencyString(),
          title: 'Gasto unidad familiar:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(
                gastosUnidadFamiliar: newValue,
              );
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.disponidadFamiliar.toCurrencyString(),
          title: 'Disponibilidad U.Familiar:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(
                disponidadFamiliar: newValue,
              );
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.dpp.toCurrencyString(),
          title: 'D.P.P: (${cubit.dppPorcentaje}%)',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = double.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(
                dpp: newValue,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PasivosAnalisisWidgetsForm extends StatelessWidget {
  final AnalisisSolicitudNuevaMenorResponse solicitud;

  const _PasivosAnalisisWidgetsForm({required this.solicitud});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisSolicitudNuevaMenorCubit>().state;
    final onFieldChanged = context.read<AnalisisSolicitudNuevaMenorCubit>();
    final totalPasivoAndCapitalCubit =
        context.watch<AnalisisSolicitudNuevaMenorCubit>();

    return Column(
      children: [
        OutlineTextfieldWidget(
          initialValue: cubit.proveedores.toString(),
          title: 'Proveedores:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(proveedores: newValue);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.cuentasXPagar.toCurrencyString(),
          title: 'Cuentas por pagar:',
          icon: const Icon(Icons.account_balance_wallet),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(cuentasXPagar: newValue);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.otrasDeudas.toCurrencyString(),
          title: 'Otras deudas:',
          icon: const Icon(Icons.pending),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(otrasDeudas: newValue);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.totalPasivo.toCurrencyString(),
          title: 'Total pasivos:',
          icon: const Icon(Icons.monetization_on),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(totalPasivo: newValue);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.capital.toCurrencyString(),
          title: 'Capital:',
          icon: const Icon(Icons.money),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(capital: newValue);
            },
          ),
        ),
        OutlineTextfieldWidget(
          readOnly: true,
          hintText: (totalPasivoAndCapitalCubit.state.totalPasivo +
                  totalPasivoAndCapitalCubit.state.capital)
              .toCurrencyString(),
          title: 'Pasivos + Capital:',
          icon: const Icon(Icons.call_to_action_outlined),
        ),
      ],
    );
  }
}

class _ActivosWidgetsForm extends StatefulWidget {
  final AnalisisSolicitudNuevaMenorResponse solicitud;

  const _ActivosWidgetsForm({required this.solicitud});

  @override
  State<_ActivosWidgetsForm> createState() => _ActivosWidgetsFormState();
}

class _ActivosWidgetsFormState extends State<_ActivosWidgetsForm>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisSolicitudNuevaMenorCubit>().state;
    final onFieldChanged = context.read<AnalisisSolicitudNuevaMenorCubit>();
    super.build(context);
    return Column(
      key: const Key('Activos'),
      children: [
        OutlineTextfieldWidget(
          initialValue: cubit.caja.toCurrencyString(),
          key: const Key('Caja'),
          title: 'Caja:',
          icon: const Icon(Icons.account_balance_wallet),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(caja: newValue);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.banco.toCurrencyString(),
          title: 'Banco:',
          icon: const Icon(Icons.account_balance),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(banco: newValue);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.cuentasXCobrar.toCurrencyString(),
          title: 'Cuentas por cobrar:',
          icon: const Icon(Icons.monetization_on),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(cuentasXCobrar: newValue);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.inventario.toCurrencyString(),
          title: 'Inventario:',
          icon: const Icon(Icons.inventory),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(inventario: newValue);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.otrosActivos.toCurrencyString(),
          title: 'Otros Activos:',
          icon: const Icon(Icons.monetization_on),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(otrosActivos: newValue);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.totalAc.toCurrencyString(),
          title: 'Total activos circulantes:',
          icon: const Icon(Icons.money),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(totalAc: newValue);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.activoFijo.toCurrencyString(),
          title: 'Activos fijo:',
          icon: const Icon(Icons.access_time),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(activoFijo: newValue);
            },
          ),
        ),
        OutlineTextfieldWidget(
          readOnly: true,
          initialValue: cubit.totalActivo.toCurrencyString(),
          title: 'Total Activo:',
          icon: const Icon(Icons.call_to_action_outlined),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(totalActivo: newValue);
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

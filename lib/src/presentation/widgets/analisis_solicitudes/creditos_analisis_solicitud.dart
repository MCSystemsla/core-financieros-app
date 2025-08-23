import 'package:core_financiero_app/src/presentation/bloc/analisis/analisis_solicitud_nueva_menor/analisis_solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/expandable/expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

class CreditosAnalisisSolicitud extends StatelessWidget {
  const CreditosAnalisisSolicitud({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTitleCustom(
              childrenPadding: const EdgeInsets.symmetric(vertical: 15),
              title: Text(
                'Detalle del Credito',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: const [
                _DetalleCredito(),
              ],
            ),
            const Gap(20),
            ExpansionTitleCustom(
              childrenPadding: const EdgeInsets.symmetric(vertical: 15),
              title: Text(
                'Nombre de sus principales clientes',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: const [
                _NombrePrincipalesClientes(),
              ],
            ),
            const Gap(20),
            ExpansionTitleCustom(
              childrenPadding: const EdgeInsets.symmetric(vertical: 15),
              title: Text(
                'Nombre de sus proveedores',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: const [
                _NombreDeProveedores(),
              ],
            ),
            const Gap(30),
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
            const Gap(15),
            CustomElevatedButton(
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              text: 'Atras',
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class _NombreDeProveedores extends StatelessWidget {
  const _NombreDeProveedores();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisSolicitudNuevaMenorCubit>().state;
    final onFieldChanged = context.read<AnalisisSolicitudNuevaMenorCubit>();
    return Column(
      children: [
        OutlineTextfieldWidget(
          initialValue: cubit.proveedor1,
          title: 'Proveedor 1',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state.copyWith(proveedor1: value);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.proveedor2,
          title: 'Proveedor 2',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state.copyWith(proveedor2: value);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.proveedor3,
          title: 'Proveedor 3',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state.copyWith(proveedor3: value);
            },
          ),
        ),
      ],
    );
  }
}

class _NombrePrincipalesClientes extends StatelessWidget {
  const _NombrePrincipalesClientes();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisSolicitudNuevaMenorCubit>().state;
    final onFieldChanged = context.read<AnalisisSolicitudNuevaMenorCubit>();
    return Column(
      children: [
        OutlineTextfieldWidget(
          initialValue: cubit.cliente1,
          title: 'Cliente 1',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state.copyWith(cliente1: value);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.cliente2,
          title: 'Cliente 2',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state.copyWith(cliente2: value);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.cliente3,
          title: 'Cliente 3',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state.copyWith(cliente3: value);
            },
          ),
        ),
      ],
    );
  }
}

class _DetalleCredito extends StatelessWidget {
  const _DetalleCredito();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisSolicitudNuevaMenorCubit>().state;
    final onFieldChanged = context.read<AnalisisSolicitudNuevaMenorCubit>();
    return Column(
      children: [
        OutlineTextfieldWidget(
          initialValue: cubit.ingresoAnual.toCurrencyString(),
          title: 'Ingreso anual y/o volumen de venta:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
              return onFieldChanged.state.copyWith(ingresoAnual: newValue);
            },
          ),
        ),
      ],
    );
  }
}

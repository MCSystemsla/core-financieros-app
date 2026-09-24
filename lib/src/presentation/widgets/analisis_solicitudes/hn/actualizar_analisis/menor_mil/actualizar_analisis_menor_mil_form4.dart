import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

import '../../../../../bloc/analisis/hn/actualizar_analisis_menor_mil/actualizar_analisis_menor_mil_cubit.dart';

class ActualizarAnalisisMenorMilForm4 extends StatelessWidget {
  final PageController pageController;
  const ActualizarAnalisisMenorMilForm4({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Container(
              margin: const EdgeInsets.all(18),
              child: Text(
                'Creditos',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            _DetalleCredito(),
            const Gap(10),
            _PrincipalesClientes(),
            const Gap(10),
            _NombreProveedores(),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;

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
                ],
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

class _NombreProveedores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ActualizarAnalisisMenorMilCubit>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Nombre de sus proveedores',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            initialValue: cubit.state.proveedor1,
            title: 'Proveedor 1',
            icon: const Icon(Icons.add_box),
            inputFormatters: [UpperCaseTextFormatter()],
            onChange: (value) => cubit.onFieldChanged(
              () => cubit.state.copyWith(proveedor1: value),
            ),
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            initialValue: cubit.state.proveedor2,
            title: 'Proveedor 2',
            icon: const Icon(Icons.add_box),
            inputFormatters: [UpperCaseTextFormatter()],
            onChange: (value) => cubit.onFieldChanged(
              () => cubit.state.copyWith(proveedor2: value),
            ),
          ),
          OutlineTextfieldWidget(
            initialValue: cubit.state.proveedor3,
            title: 'Proveedor 3',
            icon: const Icon(Icons.add_box),
            inputFormatters: [UpperCaseTextFormatter()],
            onChange: (value) => cubit.onFieldChanged(
              () => cubit.state.copyWith(proveedor3: value),
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}

class _PrincipalesClientes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ActualizarAnalisisMenorMilCubit>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Nombre de sus principales clientes',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            initialValue: cubit.state.cliente1,
            title: 'Cliente 1',
            icon: const Icon(Icons.add_box),
            inputFormatters: [UpperCaseTextFormatter()],
            onChange: (value) => cubit.onFieldChanged(
              () => cubit.state.copyWith(cliente1: value),
            ),
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            initialValue: cubit.state.cliente2,
            title: 'Cliente 2',
            icon: const Icon(Icons.add_box),
            inputFormatters: [UpperCaseTextFormatter()],
            onChange: (value) => cubit.onFieldChanged(
              () => cubit.state.copyWith(cliente2: value),
            ),
          ),
          OutlineTextfieldWidget(
            initialValue: cubit.state.cliente3,
            title: 'Cliente 3',
            icon: const Icon(Icons.add_box),
            inputFormatters: [UpperCaseTextFormatter()],
            onChange: (value) => cubit.onFieldChanged(
              () => cubit.state.copyWith(cliente3: value),
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}

class _DetalleCredito extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ActualizarAnalisisMenorMilCubit>().state;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Detalle del crédito',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            hintText: state.ingresoAnual.toCurrencyString(),
            title: 'Ingreso anual y/o volumen de venta',
            readOnly: true,
            icon: const Icon(Icons.add_box),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}

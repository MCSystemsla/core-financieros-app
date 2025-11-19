// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/ni/analisis_card_ventas_day.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class TableComprarPorSemanaHnWidget extends StatelessWidget {
  const TableComprarPorSemanaHnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ciclo de compras semanales'),
      ),
      body: BlocBuilder<AnalisisNuevaMayorMilHnCubit,
          AnalisisNuevaMayorMilHnState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const Gap(20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.cicloDeComprasSemanales.cicloCompra.length,
                  itemBuilder: (context, index) {
                    final e = state.cicloDeComprasSemanales.cicloCompra[index];
                    return AnalisisCardVentasDay(
                      subtitle: e.semanaDelMes,
                      title: e.valorizacion,
                      description: e.cantidadCompra.toCurrencyString(),
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (ctx) => _CompraSemanalHN(
                            cubit: context.read<AnalisisNuevaMayorMilHnCubit>(),
                            numeroSolicitud: state.numeroSolicitud,
                            semana: e.semanaDelMes,
                          ),
                        );
                      },
                    );
                  },
                ),
                const Gap(20),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CompraSemanalHN extends StatefulWidget {
  final AnalisisNuevaMayorMilHnCubit cubit;
  final String semana;
  final int numeroSolicitud;
  const _CompraSemanalHN({
    required this.cubit,
    required this.numeroSolicitud,
    required this.semana,
  });

  @override
  State<_CompraSemanalHN> createState() => _CompraSemanalHNState();
}

class _CompraSemanalHNState extends State<_CompraSemanalHN> {
  final formKey = GlobalKey<FormState>();
  String? valorizacion;
  int? cantidad;
  int? totalCompra;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.44,
      maxChildSize: 0.7,
      builder: (context, scrollController) {
        return AnimatedPadding(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: Form(
              key: formKey,
              child: ListView(
                controller: scrollController,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  const Gap(15),
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const Gap(20),
                  SheetSearchDropdown(
                    enabled: true,
                    items: const [
                      Item(name: 'Buena', value: 'B'),
                      Item(name: 'Normal', value: 'N'),
                      Item(name: 'Mala', value: 'M'),
                    ],
                    hintText: 'Selecciona una opcion',
                    isRequired: true,
                    title: 'Valorizacion',
                    validator: (value) =>
                        ClassValidator.validateRequired(value?.value),
                    onChanged: (value) {
                      if (value == null || !mounted) return;
                      valorizacion = value.value;
                    },
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    title: 'Cantidad de compra',
                    icon: const Icon(Icons.wallet),
                    textInputType: TextInputType.number,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChange: (value) {
                      String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                      cantidad = int.tryParse(newValue) ?? 0;
                    },
                  ),
                  const Gap(20),
                  OutlineTextfieldWidget(
                    title: 'Total compra mensual semanal',
                    icon: const Icon(Icons.wallet),
                    textInputType: TextInputType.number,
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9,\.]')),
                      CurrencyInputFormatter(
                        mantissaLength: 0,
                      ),
                    ],
                    onChange: (value) {
                      String newValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                      totalCompra = int.tryParse(newValue) ?? 0;
                    },
                  ),
                  const Gap(20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: CustomElevatedButton(
                      enabled: true,
                      text: 'Crear',
                      color: AppColors.greenLatern.withOpacity(0.4),
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        widget.cubit.updateCompraSemana(
                          semanaDelMes: widget.semana,
                          cantidadCompra: cantidad!,
                          venta: totalCompra!,
                          valorizacion: valorizacion!,
                          numeroSolicitud: widget.numeroSolicitud,
                        );
                        context.pop();
                      },
                    ),
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

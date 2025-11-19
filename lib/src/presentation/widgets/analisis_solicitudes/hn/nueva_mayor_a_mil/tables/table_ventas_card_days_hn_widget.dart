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

class TableVentasCardDaysHnWidget extends StatelessWidget {
  const TableVentasCardDaysHnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ciclo de ventas diarios'),
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
                  itemCount: state.cicloVentaDiaria.cicloVentas.length,
                  itemBuilder: (context, index) {
                    final e = state.cicloVentaDiaria.cicloVentas[index];
                    return AnalisisCardVentasDay(
                      subtitle: e.dia,
                      title: e.valorizacion,
                      description: e.venta.toCurrencyString(),
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (ctx) => _CreateValorizacionMesHN(
                            cubit: context.read<AnalisisNuevaMayorMilHnCubit>(),
                            numeroSolicitud: state.numeroSolicitud,
                            dia: e.dia,
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

class _CreateValorizacionMesHN extends StatefulWidget {
  final AnalisisNuevaMayorMilHnCubit cubit;
  final String dia;
  final int numeroSolicitud;
  const _CreateValorizacionMesHN({
    required this.cubit,
    required this.numeroSolicitud,
    required this.dia,
  });

  @override
  State<_CreateValorizacionMesHN> createState() =>
      _CreateValorizacionMesHNState();
}

class _CreateValorizacionMesHNState extends State<_CreateValorizacionMesHN> {
  final formKey = GlobalKey<FormState>();
  int? venta;
  String? valorizacion;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.44,
      maxChildSize: 0.7,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              controller: scrollController,
              child: Column(
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
                    title: 'Venta',
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
                      venta = int.tryParse(newValue) ?? 0;
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
                        widget.cubit.updateDayByName(
                          dia: widget.dia,
                          venta: venta!,
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

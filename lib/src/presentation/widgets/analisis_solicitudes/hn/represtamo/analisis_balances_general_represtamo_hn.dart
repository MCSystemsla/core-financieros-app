import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_card_list_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/cuenta_por_cobrar_card_hn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';

class AnalisisBalanceGeneralReprestamoHN extends StatelessWidget {
  const AnalisisBalanceGeneralReprestamoHN({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Balance General Expresado en Lempira',
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
            title: 'Caja:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Reservas:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Cuentas ahorro:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Total:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          CuentaPorCobrarCardHn(
            totalAbonoPorCobrar: 0,
            totalCuentasPorCobrar: 0,
            onTap: () {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Adelanto a proveedores:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Incobrables:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Total:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          AnalisisCardListHn(
            title: 'Inventario',
            onTap: () {},
            items: [
              AnalisisCardItem(
                icon: Icons.inventory,
                label: 'Total Inventario',
                value: 2221.toCurrencyString(
                  leadingSymbol: 'L.',
                  mantissaLength: 0,
                ),
                color: Colors.indigo,
              ),
              AnalisisCardItem(
                icon: Icons.percent,
                label: 'Costo de ventas promedio',
                value: '21 %',
                color: Colors.blueGrey,
              ),
            ],
          ),
          const Gap(20),
          AnalisisCardListHn(
            title: 'Activos Fijos',
            onTap: () {},
            items: [
              AnalisisCardItem(
                icon: Icons.inventory,
                label: 'Total Activos Fijos',
                value: 2221.toCurrencyString(
                  leadingSymbol: 'L.',
                  mantissaLength: 0,
                ),
                color: Colors.indigo,
              ),
              AnalisisCardItem(
                icon: Icons.inventory,
                label: 'Total Activos',
                value: 2221.toCurrencyString(
                  leadingSymbol: 'L.',
                  mantissaLength: 0,
                ),
                color: Colors.indigo,
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Pasivos:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Proveedores:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Adelanto de clientes:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Total proveedores adelantos, otros:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Creditos inst Financiamiento:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Prestamos de amigos:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Total inst finac, amigos y otros:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Total pasivos:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Patrimonio:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Pasivos + patrimonio:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
              ),
            ],
            onChange: (value) {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomElevatedButton(
              onPressed: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              text: 'Siguiente',
              color: Colors.green,
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}

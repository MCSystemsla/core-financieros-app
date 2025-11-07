import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_card_list_hn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';

class AnalisisMayorAMilBalanceGeneralHN extends StatelessWidget {
  const AnalisisMayorAMilBalanceGeneralHN({
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
          OutlineTextfieldWidget(
            title: 'Caja:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Reservas:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Reservas:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Cuentas de ahorro:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Total activos disponibles:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Total clientes:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Adelanto a proveedores:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Incobrables:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Total cuentas por cobrar:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Total inventario:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Total activos corrientes:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              CurrencyInputFormatter(
                mantissaLength: 0,
                leadingSymbol: 'L',
              )
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
          AnalisisCardListHn(
            title: 'Activos fijos',
            onTap: () {},
            items: [
              AnalisisCardItem(
                icon: Icons.sell_rounded,
                label: 'Total Activos fijos',
                value: '25000'.toCurrencyString(),
                color: Colors.indigo,
              ),
              AnalisisCardItem(
                icon: Icons.money,
                label: 'Total Activos',
                value: '35000'.toCurrencyString(),
                color: Colors.blueGrey,
              ),
            ],
          ),
          const Gap(20),
          AnalisisCardListHn(
            title: 'Proveedores, adelantos de clientes, impuestos y otros',
            maxLines: 4,
            onTap: () {},
            items: [
              AnalisisCardItem(
                icon: Icons.business,
                label: 'Total proveedores, adelantos y otros',
                value: '25000'.toCurrencyString(),
                color: Colors.indigo,
              ),
            ],
          ),
          const Gap(20),
          AnalisisCardListHn(
            title: 'Otros creditos, Bancos, ONG, amigos, otros.',
            maxLines: 3,
            onTap: () {},
            items: [
              AnalisisCardItem(
                icon: Icons.mode_standby_sharp,
                label: 'Total inst. financ, amigos y otros',
                value: '25000'.toCurrencyString(),
                color: Colors.indigo,
              ),
              AnalisisCardItem(
                icon: Icons.sell,
                label: 'Total pasivos',
                value: '25000'.toCurrencyString(),
                color: Colors.blueGrey,
              ),
              AnalisisCardItem(
                icon: Icons.business,
                label: 'Patrimonio',
                value: '25000'.toCurrencyString(),
                color: Colors.brown,
              ),
              AnalisisCardItem(
                icon: Icons.calculate,
                label: 'Pasivos + Patrimonio',
                value: '25000'.toCurrencyString(),
                color: Colors.green,
              ),
            ],
          ),
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
  }
}

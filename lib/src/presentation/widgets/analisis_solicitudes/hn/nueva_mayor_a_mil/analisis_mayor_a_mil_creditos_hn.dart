import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_card_list_hn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';

class AnalisisMayorAMilCreditosHN extends StatelessWidget {
  const AnalisisMayorAMilCreditosHN({
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
              'Detalle del crédito',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            title: 'Ingreso anual y/o volumen de venta',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          AnalisisCardListHn(
            title: 'Nombre de sus principales clientes',
            onTap: () {},
            items: [
              AnalisisCardItem(
                icon: Icons.person,
                label: 'Cliente 1',
                value: 'Leche Leyde',
                color: Colors.indigo,
              ),
              AnalisisCardItem(
                icon: Icons.person,
                label: 'Cliente 2',
                value: 'Leche Sula',
                color: Colors.blueGrey,
              ),
              AnalisisCardItem(
                icon: Icons.person,
                label: 'Cliente 3',
                value: 'Pollo campero  ssssss dddsswwqqq que lo que mi gente',
                color: Colors.deepPurple,
              ),
            ],
          ),
          AnalisisCardListHn(
            title: 'Nombre de sus proveedores',
            onTap: () {},
            items: [
              AnalisisCardItem(
                icon: Icons.person,
                label: 'Proveedor 1',
                value: 'Mario Zelaya',
                color: Colors.indigo,
              ),
              AnalisisCardItem(
                icon: Icons.person,
                label: 'Proveedor 2',
                value: 'Daniel caffati',
                color: Colors.blueGrey,
              ),
              AnalisisCardItem(
                icon: Icons.person,
                label: 'Proveedor 3',
                value: 'Eduardo maldonado',
                color: Colors.deepPurple,
              ),
            ],
          ),
          AnalisisCardListHn(
            title: 'Ingresos Familiares Fuera del negocio',
            onTap: () {},
            items: [
              AnalisisCardItem(
                icon: Icons.sell,
                label: 'Total Ingresos',
                value: 1500.toCurrencyString(),
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

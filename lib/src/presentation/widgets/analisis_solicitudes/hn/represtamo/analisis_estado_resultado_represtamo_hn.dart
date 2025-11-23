import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:gap/gap.dart';

class AnalisisEstadoResultadoReprestamoHN extends StatelessWidget {
  final PageController pageController;
  const AnalisisEstadoResultadoReprestamoHN({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ====== HEADER ======
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Estados de Resultados',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),

          // ====== INGRESOS ======
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Ingresos',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Ventas de contado L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Recuperaciones L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Total ingresos L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          // ====== COSTO DE VENTAS ======
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Costo de ventas/producción',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Costo de ventas/producción L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          // ====== COSTOS OPERATIVOS ======
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Costos operativos',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Gastos de alimentación personal L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Subcontratos/Otros serv. de personal L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Alquiler de local/depósitos L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Agua/Electricidad/Teléfono L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Combustible/Lubricantes L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Transporte/Carga L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Pago de cuotas de créditos L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Impuestos/tributos/licencia L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Otros L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Total costos operativos L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Resultado líquido del negocio L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          // ====== CONSUMO FAMILIAR ======
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Consumo familiar mensual',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Alimentación L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Educación L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Agua, Electricidad, Telefono, Gas y Kerosén L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Alquiler L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Aseo y limpieza L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Vestimenta y calzado L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Transporte L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Otros gastos / imprevistos (reserva) L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Pago de créditos privados L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Total consumo familiar L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Ingresos fuera del negocio L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Saldo disponible de la unidad familiar L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),

          const Gap(20),
          OutlineTextfieldWidget(
            textAlign: TextAlign.end,
            title: 'Destino de los excedentes hasta la fecha L:',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [CurrencyInputFormatter(mantissaLength: 0)],
            onChange: (value) {},
          ),
          const Gap(20),
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

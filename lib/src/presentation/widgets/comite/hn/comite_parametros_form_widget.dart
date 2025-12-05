import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ComiteParametrosForm extends StatelessWidget {
  const ComiteParametrosForm({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Container(
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
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 20),
              child: Text(
                'Parametros',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const Gap(12),
            CustomSwitch(
              title: 'Es Reestructuracion',
              subtitle: 'Comite reestructurado?',
              value: false,
              onChanged: (v) {},
            ),
            const Divider(),
            const Gap(12),
            CustomSwitch(
              title: 'Al vencimiento',
              subtitle: 'Esta al vencimiento?',
              value: false,
              onChanged: (v) {},
            ),
            const Divider(),
            const Gap(12),
            CustomSwitch(
              title: 'Cuota Nivelada',
              subtitle: 'La cuota esta nivelada?',
              value: false,
              onChanged: (v) {},
            ),
            const Divider(),
            const Gap(12),
            CustomSwitch(
              title: 'Mantener tasa interés de crédito anterior',
              subtitle: 'Mantendra tasa interés de crédito anterior?',
              value: false,
              onChanged: (v) {},
            ),
            const Gap(12),
            CustomSwitch(
              title: 'Financiar comision y seguros',
              subtitle: 'Financiara la comision y seguros?',
              value: false,
              onChanged: (v) {},
            ),
            const Gap(12),
          ],
        ),
      ),
    );
  }
}

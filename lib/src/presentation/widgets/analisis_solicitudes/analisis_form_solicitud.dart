import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/expandable/expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnalisisFormSolicitud extends StatefulWidget {
  final PageController pageController;
  const AnalisisFormSolicitud({
    super.key,
    required this.pageController,
  });

  @override
  State<AnalisisFormSolicitud> createState() => _AnalisisFormSolicitudState();
}

class _AnalisisFormSolicitudState extends State<AnalisisFormSolicitud>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              children: const [
                ExpansionTitleCustom(
                  childrenPadding: EdgeInsets.symmetric(vertical: 15),
                  title: Text('Activos'),
                  finalStep: false,
                  children: [
                    _ActivosWidgetsForm(),
                  ],
                ),
                ExpansionTitleCustom(
                  childrenPadding: EdgeInsets.symmetric(vertical: 15),
                  title: Text('Pasivos'),
                  finalStep: false,
                  children: [
                    _PasivosAnalisisWidgetsForm(),
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
                Column(
                  children: [
                    OutlineTextfieldWidget(
                      title: 'Ventas de contado:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Recuperaciones:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Total ingresos:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Costo de Ventas:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Gastos operativos:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Margen bruto del negocio:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Otros ingresos:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Gasto unidad familiar:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'Disponibilidad U.Familiar:',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                    OutlineTextfieldWidget(
                      title: 'D.P.P: (80%)',
                      icon: Icon(Icons.person_3_sharp),
                    ),
                  ],
                ),
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

  @override
  bool get wantKeepAlive => true;
}

class _PasivosAnalisisWidgetsForm extends StatelessWidget {
  const _PasivosAnalisisWidgetsForm();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        OutlineTextfieldWidget(
          title: 'Proveedores:',
          icon: Icon(Icons.person_3_sharp),
        ),
        OutlineTextfieldWidget(
          title: 'Cuentas por pagar:',
          icon: Icon(Icons.account_balance_wallet),
        ),
        OutlineTextfieldWidget(
          title: 'Otras deudas:',
          icon: Icon(Icons.pending),
        ),
        OutlineTextfieldWidget(
          title: 'Total pasivos:',
          icon: Icon(Icons.monetization_on),
        ),
        OutlineTextfieldWidget(
          title: 'Capital:',
          icon: Icon(Icons.money),
        ),
        OutlineTextfieldWidget(
          title: 'Pasivos + Capital:',
          icon: Icon(Icons.call_to_action_outlined),
        ),
      ],
    );
  }
}

class _ActivosWidgetsForm extends StatefulWidget {
  const _ActivosWidgetsForm();

  @override
  State<_ActivosWidgetsForm> createState() => _ActivosWidgetsFormState();
}

class _ActivosWidgetsFormState extends State<_ActivosWidgetsForm>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Column(
      key: Key('Activos'),
      children: [
        OutlineTextfieldWidget(
          key: Key('Caja'),
          title: 'Caja:',
          icon: Icon(Icons.account_balance_wallet),
        ),
        OutlineTextfieldWidget(
          title: 'Banco:',
          icon: Icon(Icons.account_balance),
        ),
        OutlineTextfieldWidget(
          title: 'Cuentas por cobrar:',
          icon: Icon(Icons.monetization_on),
        ),
        OutlineTextfieldWidget(
          title: 'Inventario:',
          icon: Icon(Icons.inventory),
        ),
        OutlineTextfieldWidget(
          title: 'Otros Activos:',
          icon: Icon(Icons.monetization_on),
        ),
        OutlineTextfieldWidget(
          title: 'Total activos circulantes:',
          icon: Icon(Icons.money),
        ),
        OutlineTextfieldWidget(
          title: 'Activos fijo:',
          icon: Icon(Icons.access_time),
        ),
        OutlineTextfieldWidget(
          title: 'Total Activo:',
          icon: Icon(Icons.call_to_action_outlined),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

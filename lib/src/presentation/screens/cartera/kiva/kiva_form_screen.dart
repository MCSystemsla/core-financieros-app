import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class KivaFormScreen extends StatelessWidget {
  const KivaFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cartera.title'.tr()),
      ),
      body: ListView.separated(
        itemCount: formsKiva.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Gap(10);
        },
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title:
                Text('${formsKiva[index].numero} - ${formsKiva[index].nombre}'),
            // onTap: () => context.push('/no-internet/form/micredito-estudio'),
            // onTap: () => context.push('/no-internet/form/saneamiento'),
            // onTap: () => context.push('/no-internet/form/mejora-de-vivienda'),
            // onTap: () => context.push('/no-internet/form/seguimiento'),
            onTap: () =>
                context.push('/no-internet/form/${formsKiva[index].route}'),
            subtitle: Text(DateTime.now().formatDate()),
            trailing: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '17,500 USD',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
                Gap(5),
                Text('Estado'),
              ],
            ),
            leading: const CircleAvatar(
              child: Icon(Icons.wallet),
            ),
          );
        },
      ),
    );
  }
}

class FormsKivaData {
  final String estado;
  final String moneda;
  final String monto;
  final String nombre;
  final int numero;
  final String route;

  FormsKivaData({
    required this.estado,
    required this.moneda,
    required this.monto,
    required this.nombre,
    required this.numero,
    required this.route,
  });
}

final formsKiva = [
  FormsKivaData(
    estado: 'Estado',
    moneda: 'USD',
    monto: '12,000',
    nombre: 'Edwin leonardo ruiz',
    numero: 12212,
    route: 'micredito-estudio',
  ),
  FormsKivaData(
    estado: 'Estado',
    moneda: 'USD',
    monto: '12,000',
    nombre: 'Edwin leonardo ruiz',
    numero: 12212,
    route: 'saneamiento',
  ),
  FormsKivaData(
    estado: 'Estado',
    moneda: 'USD',
    monto: '12,000',
    nombre: 'Edwin leonardo ruiz',
    numero: 12212,
    route: 'mejora-de-vivienda',
  ),
  FormsKivaData(
    estado: 'Estado',
    moneda: 'USD',
    monto: '12,000',
    nombre: 'Edwin leonardo ruiz',
    numero: 12212,
    route: 'seguimiento',
  ),
];

import 'package:core_financiero_app/src/presentation/widgets/solicitudes/solicitud_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SelectSolicitudScreen extends StatelessWidget {
  const SelectSolicitudScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'Seleccionar un tipo de Credito',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 19,
                    ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'Por favor, elige una de las siguientes opciones:',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
              ),
            ),
            const Gap(20),
            Row(
              children: [
                const Gap(10),
                Expanded(
                  child: SolicitudCard(
                    onPressed: () {
                      context.push('/solicitudes/solicitud-credito');
                    },
                    svgPath: 'assets/images/credit3.svg',
                    title: 'Nueva Menor',
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: SolicitudCard(
                    onPressed: () {},
                    svgPath: 'assets/images/credit4.svg',
                    title: 'Asalariado',
                  ),
                ),
                const Gap(10),
              ],
            ),
            const Gap(20),
            const Row(
              children: [
                Gap(10),
                Expanded(
                  child: SolicitudCard(
                    svgPath: 'assets/images/credit2.svg',
                    title: 'Represtamo',
                  ),
                ),
                Gap(10),
                Expanded(
                  child: SolicitudCard(
                    svgPath: 'assets/images/credit2.svg',
                    title: '',
                  ),
                ),
                Gap(10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

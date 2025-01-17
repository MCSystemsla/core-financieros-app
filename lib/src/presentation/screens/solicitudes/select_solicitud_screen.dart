import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

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
            const Row(
              children: [
                Gap(10),
                Expanded(
                  child: SolicitudCard(
                    svgPath: 'assets/images/credit3.svg',
                    title: 'Nueva Menor',
                  ),
                ),
                Gap(10),
                Expanded(
                  child: SolicitudCard(
                    svgPath: 'assets/images/credit4.svg',
                    title: 'Asalariado',
                  ),
                ),
                Gap(10),
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

class SolicitudCard extends StatelessWidget {
  final String title;
  final String svgPath;
  const SolicitudCard({
    super.key,
    required this.title,
    required this.svgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgPath,
            height: 60,
          ),
          const Gap(30),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
          )
        ],
      ),
    );
  }
}

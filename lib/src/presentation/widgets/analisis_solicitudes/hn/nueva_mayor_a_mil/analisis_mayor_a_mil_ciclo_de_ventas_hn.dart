import 'dart:developer';

import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_hn_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/ventas_card_days_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/ventas_months_card_hn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AnalisisMayorAMilCicloDeVentasHN extends StatelessWidget {
  const AnalisisMayorAMilCicloDeVentasHN({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisNuevaMayorMilHnCubit>().state.uuid;
    final numero =
        context.read<AnalisisNuevaMayorMilHnCubit>().state.numeroSolicitud;
    log(cubit.toString());
    log(numero.toString());
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          VentasMonthsCardHn(
            mesesBuenos: 5000,
            mesesNormales: 3500,
            mesesMalos: 2500,
            onTap: () {},
          ),
          VentasCardDaysHn(
            diasBuenos: 2500,
            diasNormales: 1000,
            diasMalos: 500,
            onTap: () {},
          ),
          // const ComprasWeekCardHn(
          //   semanasBuenas: 5000,
          //   semanasNormales: 3500,
          //   semanasMalos: 2500,
          // ),
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

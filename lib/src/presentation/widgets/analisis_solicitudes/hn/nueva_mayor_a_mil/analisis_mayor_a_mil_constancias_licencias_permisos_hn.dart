import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../bloc/analisis/hn/analisis_nueva_mayor_mil/analisis_nueva_mayor_mil_hn_cubit.dart';

class AnalisisMayorAMilConstanciasLicenciasPermisosHN extends StatelessWidget {
  const AnalisisMayorAMilConstanciasLicenciasPermisosHN({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisNuevaMayorMilHnCubit>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Permiso de operación',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          OutlineTextfieldWidget(
            initialValue: cubit.state.permisoOperacionNumero,
            title: 'Numero de permiso de operación',
            icon: const Icon(Icons.document_scanner),
            textInputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChange: (value) {
              cubit.onFieldChanged(
                () {
                  return cubit.state.copyWith(
                    permisoOperacionNumero: value,
                  );
                },
              );
            },
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            initialValue: cubit.state.nombreInstitucionLicencia,
            title: 'Nombre de institución',
            icon: const Icon(Icons.business),
            textInputType: TextInputType.number,
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {
              cubit.onFieldChanged(
                () => cubit.state.copyWith(nombreInstitucionLicencia: value),
              );
            },
          ),
          const Gap(20),
          const OutlineTextfieldWidget(
            title: 'Fecha de emision',
            icon: Icon(Icons.calendar_month),
            readOnly: true,
          ),
          const Gap(20),
          const OutlineTextfieldWidget(
            title: 'Fecha de vencimiento',
            icon: Icon(Icons.calendar_month),
            readOnly: true,
          ),
          const Gap(20),
          Container(
            margin: const EdgeInsets.all(18),
            child: Text(
              'Licencia',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Numero de licencia',
            icon: const Icon(Icons.business),
            textInputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Nombre de institución',
            icon: const Icon(Icons.business),
            textInputType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          const Gap(20),
          const OutlineTextfieldWidget(
            title: 'Fecha de emision',
            icon: Icon(Icons.calendar_month),
            readOnly: true,
          ),
          const Gap(20),
          const OutlineTextfieldWidget(
            title: 'Fecha de vencimiento',
            icon: Icon(Icons.calendar_month),
            readOnly: true,
          ),
          const Gap(20),
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
              ],
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}

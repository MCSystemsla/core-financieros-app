import 'package:core_financiero_app/src/datasource/analisis/nuevamenor/analisis_nueva_menor.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/analisis_solicitud_nueva_menor/analisis_solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/expandable/expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ConstanciaYCreditosAnalisis extends StatelessWidget {
  const ConstanciaYCreditosAnalisis({
    super.key,
    required this.pageController,
    required this.solicitud,
  });

  final PageController pageController;
  final AnalisisSolicitudNuevaMenorResponse solicitud;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTitleCustom(
              childrenPadding: const EdgeInsets.symmetric(vertical: 15),
              title: Text(
                'RUC',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: const [
                _Ruc(),
              ],
            ),
            const Gap(20),
            ExpansionTitleCustom(
              childrenPadding: const EdgeInsets.symmetric(vertical: 15),
              title: Text(
                'Matricula',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: const [
                _Matricula(),
              ],
            ),
            const Gap(20),
            ExpansionTitleCustom(
              childrenPadding: const EdgeInsets.symmetric(vertical: 15),
              title: Text(
                'Licencias',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: const [
                _Licencia(),
              ],
            ),
            const Gap(30),
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
            const Gap(15),
            CustomElevatedButton(
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              text: 'Atras',
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class _Licencia extends StatelessWidget {
  const _Licencia();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisSolicitudNuevaMenorCubit>().state;
    final onFieldChanged = context.read<AnalisisSolicitudNuevaMenorCubit>();
    return Column(
      children: [
        OutlineTextfieldWidget(
          initialValue: cubit.numeroLicencia,
          title: 'Licencia:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state.copyWith(numeroLicencia: value);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.nombreInstitucionLicencia,
          title: 'Nombre de institucion:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state
                  .copyWith(nombreInstitucionLicencia: value);
            },
          ),
        ),
        const OutlineTextfieldWidget(
          title: 'Fecha de emision:',
          icon: Icon(Icons.person_3_sharp),
        ),
        const OutlineTextfieldWidget(
          title: 'Fecha de vencimiento:',
          icon: Icon(Icons.person_3_sharp),
        ),
      ],
    );
  }
}

class _Matricula extends StatelessWidget {
  const _Matricula();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisSolicitudNuevaMenorCubit>().state;
    final onFieldChanged = context.read<AnalisisSolicitudNuevaMenorCubit>();
    return Column(
      children: [
        OutlineTextfieldWidget(
          initialValue: cubit.numeroMatricula,
          title: 'Matricula:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state.copyWith(numeroMatricula: value);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.nombreInstitucionMatricula,
          title: 'Nombre de institucion:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state
                  .copyWith(nombreInstitucionMatricula: value);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.fechaEmisionMatricula,
          title: 'Fecha de emision:',
          icon: const Icon(Icons.person_3_sharp),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.fechaVencimientoMatricula,
          title: 'Fecha de vencimiento:',
          icon: const Icon(Icons.person_3_sharp),
        ),
      ],
    );
  }
}

class _Ruc extends StatelessWidget {
  const _Ruc();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisSolicitudNuevaMenorCubit>().state;
    final onFieldChanged = context.read<AnalisisSolicitudNuevaMenorCubit>();
    return Column(
      children: [
        OutlineTextfieldWidget(
          initialValue: cubit.numeroRuc,
          title: 'Numero de RUC:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state.copyWith(numeroRuc: value);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.nombreInstitucionRuc,
          title: 'Nombre de instituto:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state.copyWith(nombreInstitucionRuc: value);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.fechaEmisionRuc,
          title: 'Fecha de emision:',
          icon: const Icon(Icons.person_3_sharp),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.fechaVencimientoRuc,
          title: 'Fecha de vencimiento:',
          icon: const Icon(Icons.person_3_sharp),
        ),
      ],
    );
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/analisis_solicitud_nueva_menor/analisis_solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/expandable/expansion_tile.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ReferenciasAnalisisSolicitud extends StatelessWidget {
  const ReferenciasAnalisisSolicitud({
    super.key,
    required this.pageController,
    required this.numeroSolicitud,
  });

  final PageController pageController;
  final String numeroSolicitud;

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
                'Referencia 1',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: const [
                _Referencia1(),
              ],
            ),
            const Gap(20),
            ExpansionTitleCustom(
              childrenPadding: const EdgeInsets.symmetric(vertical: 15),
              title: Text(
                'Referencia 2',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              finalStep: true,
              children: const [
                _Referencia2(),
              ],
            ),
            const Gap(30),
            BlocConsumer<AnalisisSolicitudNuevaMenorCubit,
                AnalisisSolicitudNuevaMenorState>(
              listener: (context, state) {
                if (state.status == Status.done) {
                  CustomAlertDialog(
                    context: context,
                    title: 'Analisis creado exitosamente!',
                    onDone: () => context.pop(),
                  ).showDialog(context, dialogType: DialogType.success);
                }
                if (state.status == Status.error) {
                  CustomAlertDialog(
                    context: context,
                    title: state.errorMessage,
                    onDone: () => context.pop(),
                  ).showDialog(context, dialogType: DialogType.error);
                }
              },
              builder: (context, state) {
                return CustomElevatedButton(
                  enabled: state.status != Status.inProgress,
                  onPressed: () {
                    context
                        .read<AnalisisSolicitudNuevaMenorCubit>()
                        .createAnalisisSolicitudNuevaMenorCubit(
                          numeroSolicitud: numeroSolicitud,
                          isAnalisisAreCreated: state.id.isNotEmpty,
                        );
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  text: state.status != Status.inProgress
                      ? 'Enviar analisis'
                      : 'Enviando...',
                  color: Colors.green,
                );
              },
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

class _Referencia2 extends StatelessWidget {
  const _Referencia2();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisSolicitudNuevaMenorCubit>().state;
    final onFieldChanged = context.read<AnalisisSolicitudNuevaMenorCubit>();
    return Column(
      children: [
        OutlineTextfieldWidget(
          initialValue: cubit.nombreReferencia2,
          title: 'Nombres y apellidos:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state.copyWith(nombreReferencia2: value);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.objParentescoIdReferencia2.toString(),
          title: 'Tipo de Parentesco:',
          icon: const Icon(Icons.person_3_sharp),
          // onChange: (value) => onFieldChanged.onFieldChanged(
          //   () {
          //     return onFieldChanged.state.copyWith(objParentescoIdReferencia1: value);
          //   },
          // ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.direccionReferencia2,
          title: 'Direccion:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state.copyWith(direccionReferencia2: value);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.lugarTrabajoReferencia2,
          title: 'Centro laboral:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state
                  .copyWith(lugarTrabajoReferencia2: value);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.cedulaReferencia2,
          title: 'Numero de cédula:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state.copyWith(cedulaReferencia2: value);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.telefonoReferencia2,
          title: 'Telefono:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state.copyWith(telefonoReferencia2: value);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.aniosConocerReferido2.toString(),
          title: 'Anos de conocer referido:',
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value) ?? 0;
              return onFieldChanged.state
                  .copyWith(aniosConocerReferido2: newValue);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue:
              DateTime.tryParse(cubit.fechaVerificacion2)?.selectorFormat(),
          title: 'Fecha de verificación:',
          icon: const Icon(Icons.person_3_sharp),
        ),
        // const OutlineTextfieldWidget(
        //   title: 'Fecha',
        //   icon: Icon(Icons.person_3_sharp),
        // ),
      ],
    );
  }
}

class _Referencia1 extends StatelessWidget {
  const _Referencia1();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnalisisSolicitudNuevaMenorCubit>().state;
    final onFieldChanged = context.read<AnalisisSolicitudNuevaMenorCubit>();
    return Column(
      children: [
        OutlineTextfieldWidget(
          initialValue: cubit.nombreReferencia1,
          title: 'Nombres y apellidos:',
          inputFormatters: [
            UpperCaseTextFormatter(),
          ],
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state.copyWith(nombreReferencia1: value);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.objParentescoIdReferencia1.toString(),
          title: 'Tipo de Parentesco:',
          icon: const Icon(Icons.person_3_sharp),
          // onChange: (value) => onFieldChanged.onFieldChanged(
          //   () {
          //     return onFieldChanged.state.copyWith(objParentescoIdReferencia1: value);
          //   },
          // ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.direccionReferencia1,
          title: 'Direccion:',
          inputFormatters: [
            UpperCaseTextFormatter(),
          ],
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state.copyWith(direccionReferencia1: value);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.lugarTrabajoReferencia1,
          title: 'Centro laboral:',
          inputFormatters: [
            UpperCaseTextFormatter(),
          ],
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state
                  .copyWith(lugarTrabajoReferencia1: value);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.cedulaReferencia1,
          title: 'Numero de cédula:',
          inputFormatters: [
            UpperCaseTextFormatter(),
          ],
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state.copyWith(cedulaReferencia1: value);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.telefonoReferencia1,
          title: 'Telefono:',
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              return onFieldChanged.state.copyWith(telefonoReferencia1: value);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue: cubit.aniosConocerReferido1.toString(),
          title: 'Anos de conocer referido:',
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          icon: const Icon(Icons.person_3_sharp),
          onChange: (value) => onFieldChanged.onFieldChanged(
            () {
              final newValue = int.tryParse(value) ?? 0;
              return onFieldChanged.state
                  .copyWith(aniosConocerReferido1: newValue);
            },
          ),
        ),
        OutlineTextfieldWidget(
          initialValue:
              DateTime.tryParse(cubit.fechaVerificacion1)?.selectorFormat(),
          title: 'Fecha de verificación:',
          icon: const Icon(Icons.person_3_sharp),
        ),
        const OutlineTextfieldWidget(
          title: 'Fecha :',
          icon: Icon(Icons.person_3_sharp),
        ),
      ],
    );
  }
}

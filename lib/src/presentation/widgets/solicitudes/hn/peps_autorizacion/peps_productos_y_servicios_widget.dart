import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../bloc/solicitudes/hn/cubit/informacion_peps_hn/informacion_peps_hn_cubit.dart';

class PepsProductosYServiciosUtilizaWidget extends StatelessWidget {
  const PepsProductosYServiciosUtilizaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<InformacionPepsHnCubit>();
    return BlocBuilder<InformacionPepsHnCubit, InformacionPepsHnState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Productos y servicios que espera utilizar:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                        height: 1.3,
                      ),
                ),
              ),
              const Gap(15),
              CustomSwitch(
                value: state.servicioCredito,
                title: 'Créditos',
                subtitle: 'Espera utilizar el servicio de créditos',
                onChanged: (v) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      servicioCredito: v,
                    ),
                  );
                },
              ),
              const Gap(10),
              CustomSwitch(
                value: state.servicioCuentaAhorro,
                title: 'Cuentas de Ahorro',
                subtitle: 'Espera utilizar el servicio de cuentas de ahorro',
                onChanged: (v) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      servicioCuentaAhorro: v,
                    ),
                  );
                },
              ),
              const Gap(10),
              CustomSwitch(
                value: state.servicioDpf,
                title: 'Depósito a plazo fijo',
                subtitle:
                    'Espera utilizar el servicio de depósito a plazo fijo',
                onChanged: (v) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      servicioDpf: v,
                    ),
                  );
                },
              ),
              const Gap(10),
              CustomSwitch(
                value: state.servicioRemesa,
                title: 'Remesas',
                subtitle:
                    'Espera utilizar el servicio de depósito a plazo fijo',
                onChanged: (v) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      servicioRemesa: v,
                    ),
                  );
                },
              ),
              const Gap(10),
              CustomSwitch(
                value: state.servicioOtrosBool,
                title: 'Otros',
                subtitle: 'Otros servicios que espera utilizar',
                onChanged: (v) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      servicioOtrosBool: v,
                    ),
                  );
                },
              ),
              if (state.servicioOtrosBool) ...[
                const Gap(10),
                OutlineTextfieldWidget(
                  title: 'Especifique',
                  icon: const Icon(Icons.account_balance_outlined),
                  textCapitalization: TextCapitalization.none,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: (value) => ClassValidator.validateRequired(value),
                  onChange: (value) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        servicioOtros: value,
                      ),
                    );
                  },
                )
              ],
            ],
          ),
        );
      },
    );
  }
}

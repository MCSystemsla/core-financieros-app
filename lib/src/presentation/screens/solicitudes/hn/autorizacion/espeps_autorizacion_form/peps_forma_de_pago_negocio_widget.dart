import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../bloc/solicitudes/hn/cubit/informacion_peps_hn/informacion_peps_hn_cubit.dart';

class PepsFormaDePagoNegocioWidget extends StatelessWidget {
  const PepsFormaDePagoNegocioWidget({super.key});

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
                  'Forma de pago de sus clientes:',
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
                value: state.pagoEfectivoLempira,
                title: 'Efectivo (Lempira)',
                subtitle: 'Espera utilizar el servicio de créditos',
                onChanged: (v) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      pagoEfectivoLempira: v,
                    ),
                  );
                },
              ),
              const Gap(10),
              CustomSwitch(
                title: 'Efectivo (Dolar)',
                subtitle: 'Espera utilizar el servicio de cuentas de ahorro',
                value: state.pagoEfectivoDolar,
                onChanged: (v) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      pagoEfectivoDolar: v,
                    ),
                  );
                },
              ),
              const Gap(10),
              CustomSwitch(
                title: 'Cheque',
                subtitle:
                    'Espera utilizar el servicio de depósito a plazo fijo',
                value: state.pagoCheque,
                onChanged: (v) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      pagoCheque: v,
                    ),
                  );
                },
              ),
              const Gap(10),
              CustomSwitch(
                title: 'TC/TD',
                subtitle: 'Otros servicios que espera utilizar',
                value: state.pagoTctd,
                onChanged: (v) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      pagoTctd: v,
                    ),
                  );
                },
              ),
              const Gap(10),
              CustomSwitch(
                title: 'Deposito a cuenta',
                subtitle: 'Otros servicios que espera utilizar',
                value: state.pagoDepositoCuenta,
                onChanged: (v) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      pagoDepositoCuenta: v,
                    ),
                  );
                },
              ),
              const Gap(10),
              CustomSwitch(
                title: 'Traslado de fondos a otros bancos',
                subtitle: 'Otros servicios que espera utilizar',
                value: state.pagoOtrosBancos,
                onChanged: (v) {
                  cubit.onFieldChanged(
                    () => state.copyWith(
                      pagoOtrosBancos: v,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

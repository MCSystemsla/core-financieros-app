import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_solicitud_response.dart';
import 'package:core_financiero_app/src/presentation/bloc/comite/comite_aprobacion/comite_aprobacion_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ComiteParametrosForm extends StatefulWidget {
  final ComiteSolicitudData data;
  const ComiteParametrosForm({
    super.key,
    required this.data,
  });

  @override
  State<ComiteParametrosForm> createState() => _ComiteParametrosFormState();
}

class _ComiteParametrosFormState extends State<ComiteParametrosForm> {
  bool alVencimiento = false;
  @override
  initState() {
    super.initState();
    alVencimiento = (widget.data.alVencimiento ?? false);
    final cubit = context.read<ComiteAprobacionCubit>();
    cubit.onFieldChanged(
      () => cubit.state.copyWith(
        alVencimiento: alVencimiento,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ComiteAprobacionCubit>();
    return BlocBuilder<ComiteAprobacionCubit, ComiteAprobacionState>(
      builder: (context, state) {
        return FadeIn(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 20),
                  child: Text(
                    'Parametros',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const Gap(12),
                CustomSwitch(
                  title: 'Es Reestructuración',
                  subtitle: 'Comité reestructurado?',
                  value: false,
                  onChanged: (v) {},
                ),
                const Divider(),
                const Gap(12),
                CustomSwitch(
                  title: 'Al vencimiento',
                  subtitle: 'Esta al vencimiento?',
                  value: alVencimiento,
                  onChanged: (v) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        alVencimiento: v,
                      ),
                    );
                  },
                ),
                const Divider(),
                const Gap(12),
                CustomSwitch(
                  title: 'Cuota Nivelada',
                  subtitle: 'La cuota esta nivelada?',
                  value: false,
                  onChanged: (v) {},
                ),
                const Divider(),
                const Gap(12),
                CustomSwitch(
                  title: 'Mantener tasa interés de crédito anterior',
                  subtitle: 'Mantendrá tasa interés de crédito anterior?',
                  value: false,
                  onChanged: (v) {},
                ),
                const Gap(12),
                CustomSwitch(
                  title: 'Financiar comision y seguros',
                  subtitle: 'Financiara la comision y seguros?',
                  value: false,
                  onChanged: (v) {},
                ),
                const Gap(12),
              ],
            ),
          ),
        );
      },
    );
  }
}

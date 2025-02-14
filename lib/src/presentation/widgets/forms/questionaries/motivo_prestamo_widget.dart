import 'package:core_financiero_app/src/presentation/bloc/kiva/kiva_route/kiva_route_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MotivoPrestamoWidget extends StatelessWidget {
  const MotivoPrestamoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final motivoAnterior = context.read<KivaRouteCubit>().state.motivoAnterior;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Motivo Prestamo',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const Gap(10),
        Text(
          motivoAnterior,
          style: Theme.of(context).textTheme.bodyMedium!,
        ),
      ],
    );
  }
}

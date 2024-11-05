import 'package:core_financiero_app/src/presentation/bloc/motivo_prestamo/motivo_prestamo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MotivoPrestamoWidget extends StatelessWidget {
  const MotivoPrestamoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MotivoPrestamoCubit, MotivoPrestamoState>(
      builder: (context, state) {
        if (state is OnMotivoPrestamoLoading) {
          return const CircularProgressIndicator();
        }
        if (state is OnMotivoPrestamoError) {
          return const Text('Error inesperado');
        }
        if (state is OnMotivoPrestamoSuccess) {
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
                state.motivoPrestamo,
                style: Theme.of(context).textTheme.bodyMedium!,
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

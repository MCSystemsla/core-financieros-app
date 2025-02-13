import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/kiva/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EnergiaLimpiaNuevoPrestamo extends StatefulWidget {
  const EnergiaLimpiaNuevoPrestamo({
    super.key,
  });

  @override
  State<EnergiaLimpiaNuevoPrestamo> createState() =>
      _EnergiaLimpiaNuevoPrestamoState();
}

class _EnergiaLimpiaNuevoPrestamoState
    extends State<EnergiaLimpiaNuevoPrestamo> {
  bool onEditAnswer = false;
  String? newcomoMejoraSituacion;
  @override
  Widget build(BuildContext context) {
    final energiaLimpiaProvider = context.watch<RecurrenteEnergiaLimpiaCubit>();
    return WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 250,
                ),
                child: Text(
                  '¿Cómo cree usted que este nuevo préstamo vaya a mejorar su situación y la de su familia?*',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  onEditAnswer = !onEditAnswer;
                  setState(() {});
                },
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
          const Gap(20),
          Text(
            energiaLimpiaProvider.state.comoMejoraSituacion,
            style: Theme.of(context).textTheme.bodyMedium!,
          ),
          if (onEditAnswer)
            Column(
              children: [
                WhiteCard(
                  padding: const EdgeInsets.all(5),
                  child: CommentaryWidget(
                    title: '',
                    onChange: (value) {
                      newcomoMejoraSituacion = value;
                      setState(() {});
                    },
                    initialValue:
                        energiaLimpiaProvider.state.comoMejoraSituacion,
                  ),
                ),
                const Gap(20),
                CustomElevatedButton(
                  text: 'Guardar',
                  color: AppColors.getPrimaryColor(),
                  onPressed: () {
                    context.read<RecurrenteEnergiaLimpiaCubit>().saveAnswer3(
                          comoMejoraSituacion: newcomoMejoraSituacion,
                        );
                    onEditAnswer = !onEditAnswer;
                    setState(() {});
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}

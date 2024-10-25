import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EnergiaTrabajoDescripcionCualWidget extends StatefulWidget {
  const EnergiaTrabajoDescripcionCualWidget({
    super.key,
  });

  @override
  State<EnergiaTrabajoDescripcionCualWidget> createState() =>
      _EnergiaTrabajoDescripcionCualWidgetState();
}

class _EnergiaTrabajoDescripcionCualWidgetState
    extends State<EnergiaTrabajoDescripcionCualWidget> {
  bool onEditAnswer = false;
  String? trabajoNegocioDescripcion;
  @override
  Widget build(BuildContext context) {
    final energiaLimpiaProvider =
        context.watch<RecurrenteEnergiaLimpiaCubit>().state;

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
                  'Cual?',
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
            energiaLimpiaProvider.trabajoNegocioDescripcion.isEmpty
                ? 'N/A'
                : energiaLimpiaProvider.trabajoNegocioDescripcion,
            style: Theme.of(context).textTheme.bodyMedium!,
          ),
          if (onEditAnswer)
            Column(
              children: [
                CommentaryWidget(
                  title: '',
                  onChange: (value) {
                    trabajoNegocioDescripcion = value;
                    setState(() {});
                  },
                  initialValue: energiaLimpiaProvider.trabajoNegocioDescripcion,
                ),
                const Gap(20),
                CustomElevatedButton(
                  text: 'Guardar',
                  color: AppColors.getPrimaryColor(),
                  onPressed: () {
                    context.read<RecurrenteEnergiaLimpiaCubit>().saveAnswer1(
                          trabajoNegocioDescripcion: trabajoNegocioDescripcion,
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

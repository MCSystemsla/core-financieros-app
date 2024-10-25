import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EnergiaLimpiaCoincideRespuesta extends StatefulWidget {
  const EnergiaLimpiaCoincideRespuesta({
    super.key,
  });

  @override
  State<EnergiaLimpiaCoincideRespuesta> createState() =>
      _EnergiaLimpiaCoincideRespuestaState();
}

class _EnergiaLimpiaCoincideRespuestaState
    extends State<EnergiaLimpiaCoincideRespuesta> {
  bool onEditAnswer = false;
  String? newcoincideRespuesta;
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
                  '¿Coincide la respuesta del cliente con el formato anterior? ',
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
                  // onEditAnswer = !onEditAnswer;
                  // setState(() {});
                },
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
          const Gap(20),
          Text(
            energiaLimpiaProvider.state.coincideRespuesta
                ? 'input.yes'.tr()
                : 'input.no'.tr(),
            style: Theme.of(context).textTheme.bodyMedium!,
          ),
          if (onEditAnswer)
            Column(
              children: [
                WhiteCard(
                  padding: const EdgeInsets.all(5),
                  child: JLuxDropdown(
                    isContainIcon: true,
                    validator: (value) {
                      if (value == null) return 'input.input_validator'.tr();
                      return null;
                    },
                    title: ''.tr(),
                    items: const [],
                    onChanged: (item) {
                      if (item == null) return;
                      newcoincideRespuesta = item;
                      setState(() {});
                    },
                    toStringItem: (item) {
                      return item;
                    },
                    hintText: 'input.select_option'.tr(),
                  ),
                ),
                const Gap(20),
                CustomElevatedButton(
                  text: 'Guardar',
                  color: AppColors.getPrimaryColor(),
                  onPressed: () {
                    context.read<RecurrenteEnergiaLimpiaCubit>().saveAnswer3(
                          coincideRespuesta:
                              newcoincideRespuesta == 'input.yes'.tr(),
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

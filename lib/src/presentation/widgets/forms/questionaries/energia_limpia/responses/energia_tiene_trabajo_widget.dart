import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/bloc/recurrente_energia_limpia/recurrente_energia_limpia_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EnergiaTieneTrabajoWidget extends StatefulWidget {
  const EnergiaTieneTrabajoWidget({
    super.key,
  });

  @override
  State<EnergiaTieneTrabajoWidget> createState() =>
      _EnergiaTieneTrabajoWidgetState();
}

class _EnergiaTieneTrabajoWidgetState extends State<EnergiaTieneTrabajoWidget> {
  String? tieneTrabajos;
  bool onEditAnswer = false;
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
                  '¿Tiene algún trabajo o negocio? ',
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
            energiaLimpiaProvider.tieneTrabajo
                ? 'input.yes'.tr()
                : 'input.no'.tr(),
            style: Theme.of(context).textTheme.bodyMedium!,
          ),
          if (onEditAnswer)
            Column(
              children: [
                JLuxDropdown(
                  isContainIcon: false,
                  title: ''.tr(),
                  items: ['input.yes'.tr(), 'input.no'.tr()],
                  onChanged: (item) {
                    if (item == null) return;
                    tieneTrabajos = item;
                    setState(() {});
                  },
                  toStringItem: (item) {
                    return item;
                  },
                  hintText: 'input.select_option'.tr(),
                ),
                const Gap(20),
                CustomElevatedButton(
                  text: 'Guardar',
                  color: AppColors.getPrimaryColor(),
                  onPressed: () {
                    context.read<RecurrenteEnergiaLimpiaCubit>().saveAnswer1(
                          tieneTrabajo: tieneTrabajos == 'input.yes'.tr(),
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

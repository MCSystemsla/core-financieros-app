import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/autorizacion/espeps_autorizacion_form/espeps_autorizacion_form_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_card_list_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/peps_autorizacion/tables/table_cargos_desempenados_hn_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/peps_autorizacion/tables/table_relation_peps_hn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../bloc/solicitudes/hn/cubit/informacion_peps_hn/informacion_peps_hn_cubit.dart';

class EsPepsAuthorizationPage2 extends StatefulWidget {
  final PageController pageController;
  const EsPepsAuthorizationPage2({
    super.key,
    required this.pageController,
  });

  @override
  State<EsPepsAuthorizationPage2> createState() =>
      _EsPepsAuthorizationPage2State();
}

class _EsPepsAuthorizationPage2State extends State<EsPepsAuthorizationPage2>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<InformacionPepsHnCubit>();
    return BlocBuilder<InformacionPepsHnCubit, InformacionPepsHnState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Text(
                  'Información PEPS',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const Gap(10),
                AnalisisCardListHn(
                  title: 'Últimos cargos desempeñados como funcionario público',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<InformacionPepsHnCubit>(),
                          child: const TableCargosDesempeHnWidget(),
                        ),
                      ),
                    );
                  },
                  items: [
                    AnalisisCardItem(
                      icon: Icons.person,
                      label: 'Cargos desempeñados',
                      value: state.detallePeps.length.toString(),
                      color: Colors.blueGrey,
                    ),
                  ],
                ),
                CustomSwitch(
                  title: '¿Maneja usted recursos públicos o bienes del estado?',
                  subtitle:
                      'Indica si usted maneja recursos públicos o bienes del estado',
                  value: state.manejaBienesPublicos,
                  onChanged: (v) {
                    cubit.onFieldChanged(
                      () => state.copyWith(
                        manejaBienesPublicos: v,
                      ),
                    );
                  },
                ),
                if (state.manejaBienesPublicos) ...[
                  const Gap(5),
                  OutlineTextfieldWidget(
                    title: 'Descripción de recursos',
                    icon: const Icon(Icons.account_balance_outlined),
                    textInputType: TextInputType.number,
                    textCapitalization: TextCapitalization.none,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) =>
                        ClassValidator.validateRequired(value),
                    onChange: (value) {
                      cubit.onFieldChanged(
                        () => state.copyWith(
                          descripcionBienesPublicos: value,
                        ),
                      );
                    },
                  ),
                ],
                AnalisisCardListHn(
                  title: 'Mantiene relación con:',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<InformacionPepsHnCubit>(),
                          child: const TableRelationPepsHnWidget(),
                        ),
                      ),
                    );
                  },
                  items: [
                    AnalisisCardItem(
                      icon: Icons.person,
                      label: 'Ingresa las personas que mantienen la relación',
                      value: state.detallePeps.length.toString(),
                      color: Colors.blueGrey,
                    ),
                  ],
                ),
                const Gap(20),
                esPepsEnviarButton(context, widget.pageController),
                esPepsAtrasButton(context, widget.pageController),
                const Gap(10),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

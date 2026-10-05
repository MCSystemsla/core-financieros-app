import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/autorizacion/espeps_autorizacion_form/espeps_autorizacion_form_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_card_list_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/peps_autorizacion/tables/table_cargos_desempenados_hn_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/peps_autorizacion/tables/table_relation_peps_hn_widget.dart';
import 'package:flutter/material.dart';
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
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<InformacionPepsHnCubit, InformacionPepsHnState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Padding(
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
                    title:
                        'Últimos cargos desempeñados como funcionario público',
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
                        value: state.relacionPeps.length.toString(),
                        color: Colors.blueGrey,
                      ),
                    ],
                  ),
                  const Gap(20),
                  esPepsEnviarButton(context, widget.pageController, formKey),
                  esPepsAtrasButton(context, widget.pageController),
                  const Gap(10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:core_financiero_app/src/datasource/comite/comite_solicitud_response.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/comite/comite_solicitud/comite_solicitud_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_comision_en_desembolso_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_datos_del_credito_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_parametros_form_2.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_seguros_desembolso_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_card_list_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/skeleton_card/skeleton_card.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_parametros_form_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ComiteFormScreen extends StatelessWidget {
  final int numeroSolicitud;
  final String tipoSolicitud;
  const ComiteFormScreen({
    required this.numeroSolicitud,
    required this.tipoSolicitud,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return BlocProvider(
      create: (ctx) => ComiteSolicitudCubit(
        ComiteRepositoryHNImpl(),
      )..getComiteSolicitud(
          numeroSolicitud: numeroSolicitud,
          tipoSolicitud: tipoSolicitud,
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Crear Comité'),
        ),
        body: BlocBuilder<ComiteSolicitudCubit, ComiteSolicitudState>(
          builder: (context, state) {
            return switch (state.status) {
              Status.inProgress => const SkeletonCard(),
              Status.error => OnErrorWidget(
                  errorMsg: state.errorMsg,
                  onPressed: () {
                    context.read<ComiteSolicitudCubit>().getComiteSolicitud(
                          numeroSolicitud: numeroSolicitud,
                          tipoSolicitud: tipoSolicitud,
                        );
                  },
                ),
              Status.done => PageView(
                  controller: pageController,
                  children: [
                    _ComiteGeneralForm(
                      pageController: pageController,
                      data: state.data.data,
                    ),
                    _ComiteOtrosForm(
                      data: state.data.data,
                    ),
                  ],
                ),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}

class _ComiteOtrosForm extends StatefulWidget {
  final ComiteSolicitudData data;

  const _ComiteOtrosForm({required this.data});
  @override
  State<_ComiteOtrosForm> createState() => _ComiteOtrosFormState();
}

class _ComiteOtrosFormState extends State<_ComiteOtrosForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(20),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 20),
              child: Text(
                'Otros',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const ComiteSegurosDesembolsoForm(),
            AnalisisCardListHn(
              title: 'Bienes Adjudicados',
              onTap: () {},
              items: [
                AnalisisCardItem(
                  icon: Icons.production_quantity_limits,
                  label: 'Total bienes adjudicados',
                  value: 2.toString(),
                  color: Colors.purple,
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                // enabled: state.status != Status.inProgress,
                // text: state.status == Status.inProgress
                //     ? 'Creando...'
                //     : 'Crear',
                // ignore: deprecated_member_use
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;
                },
                text: 'Siguiente',
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

class _ComiteGeneralForm extends StatefulWidget {
  final PageController pageController;
  final ComiteSolicitudData data;

  const _ComiteGeneralForm({
    required this.pageController,
    required this.data,
  });
  @override
  State<_ComiteGeneralForm> createState() => _ComiteGeneralFormState();
}

class _ComiteGeneralFormState extends State<_ComiteGeneralForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(20),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 20),
              child: Text(
                'General',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const ComiteParametrosForm(),
            const Gap(12),
            ComiteDatosDelCreditoForm(
              data: widget.data,
            ),
            const Gap(12),
            ComiteComisionEnDesembolsoForm(
              data: widget.data,
            ),
            const Gap(12),
            ComiteParametrosForm2(
              data: widget.data,
            ),
            const Gap(12),
            AnalisisCardListHn(
              title: 'Créditos a cancelar',
              onTap: () {},
              items: [
                AnalisisCardItem(
                  icon: Icons.credit_card,
                  label: 'Total créditos a cancelar',
                  value: 2.toString(),
                  color: Colors.green,
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                // enabled: state.status != Status.inProgress,
                // text: state.status == Status.inProgress
                //     ? 'Creando...'
                //     : 'Crear',
                // ignore: deprecated_member_use
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;
                  widget.pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                text: 'Siguiente',
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

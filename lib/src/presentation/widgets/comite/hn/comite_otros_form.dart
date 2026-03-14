import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_solicitud_response.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_seguros_desembolso_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_card_list_hn.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class _ComiteOtrosForm extends StatefulWidget {
  final ComiteSolicitudData data;
  final PageController pageController;

  const _ComiteOtrosForm({
    required this.data,
    required this.pageController,
  });
  @override
  State<_ComiteOtrosForm> createState() => _ComiteOtrosFormState();
}

class _ComiteOtrosFormState extends State<_ComiteOtrosForm>
    with AutomaticKeepAliveClientMixin {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Form(
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
              ComiteSegurosDesembolsoForm(
                data: widget.data,
              ),
              AnalisisCardListHn(
                title: 'Bienes Adjudicados',
                onTap: () {},
                items: [
                  AnalisisCardItem(
                    icon: Icons.production_quantity_limits,
                    label: 'Total bienes adjudicados',
                    value: 0.toString(),
                    color: Colors.purple,
                  ),
                ],
              ),
              const Gap(20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: CustomElevatedButton(
                  color: AppColors.red,
                  onPressed: () {
                    widget.pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  text: 'Anterior',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

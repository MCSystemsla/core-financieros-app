import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_comision_en_desembolso_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_datos_del_credito_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_card_list_hn.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_parametros_form_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:gap/gap.dart';

class ComiteFormScreen extends StatefulWidget {
  const ComiteFormScreen({super.key});

  @override
  State<ComiteFormScreen> createState() => _ComiteFormScreenState();
}

class _ComiteFormScreenState extends State<ComiteFormScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Comite'),
      ),
      body: Form(
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
                  'Ingresa los datos requeridos',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const ComiteParametrosForm(),
              const Gap(12),
              const ComiteDatosDelCreditoForm(),
              const Gap(12),
              const ComiteComisionEnDesembolsoForm(),
              const Gap(12),
              const ComiteParametrosForm(),
              const Gap(12),
              AnalisisCardListHn(
                title: 'Creditos a cancelar',
                onTap: () {},
                items: [
                  AnalisisCardItem(
                    icon: Icons.credit_card,
                    label: 'Total creditos a cancelar',
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
                  },
                  text: 'Crear',
                ),
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}

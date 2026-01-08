import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form_6.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form1.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form2.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form3.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form_4.dart';
import 'package:core_financiero_app/src/presentation/widgets/supervisiones/credito/supervision_credito_form_5.dart';
import 'package:gap/gap.dart';

class SupervisionesFormCreditoHnScreen extends StatelessWidget {
  const SupervisionesFormCreditoHnScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pagecontroller = PageController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Supervision Credito'),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pagecontroller,
        children: [
          SupervisionCreditoForm1(
            pagecontroller: pagecontroller,
          ),
          SupervisionCreditoForm2(
            pagecontroller: pagecontroller,
          ),
          SupervisionCreditoForm3(
            pagecontroller: pagecontroller,
          ),
          SupervisionCreditoForm4(
            pagecontroller: pagecontroller,
          ),
          SupervisionCreditoForm5(
            pagecontroller: pagecontroller,
          ),
          SupervisionCreditoForm6(
            pagecontroller: pagecontroller,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  Container(
                    margin: const EdgeInsets.all(18),
                    child: Text(
                      'Propuesta',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  const Gap(10),
                  OutlineTextfieldWidget(
                    title: 'Monto',
                    icon: const Icon(Icons.food_bank),
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    onChange: (value) {
                      // cubit.onFieldChanged(
                      //   () => cubit.state.copyWith(),
                      // );
                    },
                  ),
                  const Gap(10),
                  OutlineTextfieldWidget(
                    title: 'Plazo en meses',
                    icon: const Icon(Icons.food_bank),
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    onChange: (value) {
                      // cubit.onFieldChanged(
                      //   () => cubit.state.copyWith(),
                      // );
                    },
                  ),
                  const Gap(10),
                  SearchDropdownWidget(
                    title: 'Producto',
                    codigo: 'PRODUCTO',
                    enabled: true,
                    isRequired: true,
                    onChanged: (v) {
                      if (v == null) return;
                      // cubit.onFieldChanged(
                      //   () => cubit.state.copyWith(),
                      // );
                    },
                    hintText: 'Ingresa Producto',
                  ),
                  const Gap(10),
                  OutlineTextfieldWidget(
                    title: 'Tasa',
                    icon: const Icon(Icons.food_bank),
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    onChange: (value) {
                      // cubit.onFieldChanged(
                      //   () => cubit.state.copyWith(),
                      // );
                    },
                  ),
                  const Gap(25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        CustomElevatedButton(
                          onPressed: () {
                            pagecontroller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          text: 'Siguiente',
                          color: Colors.green,
                        ),
                        const Gap(10),
                        CustomElevatedButton(
                          onPressed: () {
                            pagecontroller.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          text: 'Anterior',
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

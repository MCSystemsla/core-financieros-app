import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_supervisor/tipo_supervisor_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SupervisionCreditoForm4 extends StatelessWidget {
  const SupervisionCreditoForm4({
    super.key,
    required this.pagecontroller,
  });

  final PageController pagecontroller;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                'Buro crediticio',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            SheetSearchDropdown(
              title: 'Controles de Riesgo',
              isRequired: true,
              onChanged: (v) {},
              hintText: 'selecciona una opcion',
              enabled: true,
              items: const [
                Item(
                  name: 'Bueno',
                  value: SupervisionItem1.bueno,
                ),
                Item(
                  name: 'Regular',
                  value: SupervisionItem1.regular,
                ),
                Item(
                  name: 'Malo',
                  value: SupervisionItem1.malo,
                ),
              ],
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
    );
  }
}

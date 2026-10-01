import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SupervisionRiesgoForm1 extends StatelessWidget {
  const SupervisionRiesgoForm1({
    super.key,
    required this.data,
    required this.pagecontroller,
  });

  final SupervisionData data;
  final PageController pagecontroller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RedesignColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: RedesignColors.border),
      ),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Container(
              margin: const EdgeInsets.fromLTRB(18, 0, 18, 8),
              child: const Text(
                'Datos del cliente',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: RedesignColors.ink,
                ),
              ),
            ),
            const Gap(10),
            OutlineTextfieldWidget(
              initialValue: data.fecha.selectorFormat(),
              readOnly: true,
              title: 'Fecha',
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
              initialValue: data.nombrePromotor,
              readOnly: true,
              title: 'Oficial de credito',
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
              initialValue: data.nombreCliente,
              readOnly: true,
              title: 'Cliente',
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
              initialValue: data.sectorComercialNombre,
              readOnly: true,
              title: 'Actividad economica',
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
              initialValue: data.destino,
              readOnly: true,
              title: 'Destino del credito',
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
                    color: RedesignColors.green,
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

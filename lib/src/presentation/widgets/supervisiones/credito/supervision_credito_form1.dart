import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SupervisionCreditoForm1 extends StatelessWidget {
  final PageController pagecontroller;
  final SupervisionData data;

  const SupervisionCreditoForm1({
    super.key,
    required this.pagecontroller,
    required this.data,
  });

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
                'Supervisiones de coordinadores',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
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
              initialValue: data.cedulaCliente,
              readOnly: true,
              title: 'Numero de Cedula',
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
              initialValue: data.direccionCasa,
              readOnly: true,
              title: 'Direccion del Domicilio',
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
              initialValue: data.direccionNegocio,
              readOnly: true,
              title: 'Direccion del negocio',
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

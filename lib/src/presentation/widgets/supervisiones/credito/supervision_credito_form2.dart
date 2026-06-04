import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/datasource/supervisiones/supervisiones_response.dart';
import 'package:core_financiero_app/src/presentation/bloc/supervisiones/supervision_credito/supervision_credito_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_supervisor/tipo_supervisor_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SupervisionCreditoForm2 extends StatefulWidget {
  final PageController pagecontroller;
  final SupervisionData data;

  const SupervisionCreditoForm2({
    super.key,
    required this.pagecontroller,
    required this.data,
  });

  @override
  State<SupervisionCreditoForm2> createState() =>
      _SupervisionCreditoForm2State();
}

class _SupervisionCreditoForm2State extends State<SupervisionCreditoForm2>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final cubit = context.read<SupervisionCreditoCubit>();
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
                'Antecedentes del cliente',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const Gap(10),
            OutlineTextfieldWidget(
              initialValue: widget.data.tiempoActividad.toString(),
              readOnly: true,
              title: 'Tiempo en la actividad',
              icon: const Icon(Icons.food_bank),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {},
            ),
            const Gap(10),
            OutlineTextfieldWidget(
              initialValue: widget.data.tipoVivienda,
              readOnly: true,
              title: 'Tipo de vivienda',
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
            SheetSearchDropdown(
              title: 'Referencias en la comunidad',
              isRequired: false,
              onChanged: (v) {
                if (v == null) return;
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(
                    referenciaComunidadBuena:
                        v.value == SupervisionItem4.buenas,
                    referenciaComunidadMala: v.value == SupervisionItem4.malas,
                  ),
                );
              },
              hintText: 'seleccione una opcion',
              enabled: true,
              items: const [
                Item(
                  name: 'Buenas',
                  value: SupervisionItem4.buenas,
                ),
                Item(
                  name: 'Malas',
                  value: SupervisionItem4.malas,
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
                      widget.pagecontroller.nextPage(
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
                      widget.pagecontroller.previousPage(
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

  @override
  bool get wantKeepAlive => true;
}

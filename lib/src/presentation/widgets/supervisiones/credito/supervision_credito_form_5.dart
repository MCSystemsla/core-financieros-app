import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/presentation/bloc/supervisiones/supervision_credito/supervision_credito_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_supervisor/tipo_supervisor_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SupervisionCreditoForm5 extends StatefulWidget {
  const SupervisionCreditoForm5({
    super.key,
    required this.pagecontroller,
  });

  final PageController pagecontroller;

  @override
  State<SupervisionCreditoForm5> createState() =>
      _SupervisionCreditoForm5State();
}

class _SupervisionCreditoForm5State extends State<SupervisionCreditoForm5>
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
                'Informacion general y analisis',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            SheetSearchDropdown(
              title: 'Cumple razon cuota',
              isRequired: true,
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value.toString()),
              onChanged: (v) {
                if (v == null) return;
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(
                    razonCuota: v.value == SupervisionItem3.si,
                  ),
                );
              },
              hintText: 'selecciona una opcion',
              enabled: true,
              items: const [
                Item(
                  name: 'Si',
                  value: SupervisionItem3.si,
                ),
                Item(
                  name: 'No',
                  value: SupervisionItem3.no,
                ),
              ],
            ),
            SheetSearchDropdown(
              title: 'Cumple con razon endeudamiento futuro',
              isRequired: true,
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value.toString()),
              onChanged: (v) {
                if (v == null) return;
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(
                    razonCuota: v.value == SupervisionItem3.si,
                  ),
                );
              },
              hintText: 'selecciona una opcion',
              enabled: true,
              items: const [
                Item(
                  name: 'Si',
                  value: SupervisionItem3.si,
                ),
                Item(
                  name: 'No',
                  value: SupervisionItem3.no,
                ),
              ],
            ),
            SheetSearchDropdown(
              title: 'Tiene Matriculas y/o licencias y/o fierros vigentes',
              isRequired: true,
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value.toString()),
              onChanged: (v) {
                if (v == null) return;
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(
                    documentos: v.value == SupervisionItem3.si,
                  ),
                );
              },
              hintText: 'selecciona una opcion',
              enabled: true,
              items: const [
                Item(
                  name: 'Si',
                  value: SupervisionItem3.si,
                ),
                Item(
                  name: 'No',
                  value: SupervisionItem3.no,
                ),
              ],
            ),
            SheetSearchDropdown(
              title: 'Cuenta con ingresos fuera del negocio',
              isRequired: true,
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value.toString()),
              onChanged: (v) {
                if (v == null) return;
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(
                    ingresosFueraNegocio: v.value == SupervisionItem3.si,
                  ),
                );
              },
              hintText: 'selecciona una opcion',
              enabled: true,
              items: const [
                Item(
                  name: 'Si',
                  value: SupervisionItem3.si,
                ),
                Item(
                  name: 'No',
                  value: SupervisionItem3.no,
                ),
              ],
            ),
            SheetSearchDropdown(
              title: 'Dictamen legal',
              isRequired: true,
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value.toString()),
              onChanged: (v) {
                if (v == null) return;
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(
                    garantiaDictamenLegal: v.value == SupervisionItem3.si,
                  ),
                );
              },
              hintText: 'selecciona una opcion',
              enabled: true,
              items: const [
                Item(
                  name: 'Si',
                  value: SupervisionItem3.si,
                ),
                Item(
                  name: 'No',
                  value: SupervisionItem3.no,
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

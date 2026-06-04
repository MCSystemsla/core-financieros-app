import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/presentation/bloc/supervisiones/supervision_coordinador/supervision_coordinador_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/supervisiones/supervision_montos/supervision_montos_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_supervisor/tipo_supervisor_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

class SupervisionFormHN3 extends StatefulWidget {
  final PageController pageController;
  final num cuota;
  final num razonEndeudamiento;
  const SupervisionFormHN3({
    super.key,
    required this.pageController,
    required this.cuota,
    required this.razonEndeudamiento,
  });

  @override
  State<SupervisionFormHN3> createState() => _SupervisionFormHN3State();
}

class _SupervisionFormHN3State extends State<SupervisionFormHN3>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final formKey = GlobalKey<FormState>();
    final cubit = context.read<SupervisionCoordinadorCubit>();

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
      child: BlocBuilder<SupervisionMontosCubit, SupervisionMontosState>(
        builder: (context, state) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  Container(
                    margin: const EdgeInsets.all(18),
                    child: Text(
                      'Aspectos cuantitativos',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  const Gap(10),
                  SheetSearchDropdown(
                    validator: (value) => ClassValidator.validateRequired(
                        value?.value.toString()),
                    isRequired: true,
                    hintText: 'input.select_option'.tr(),
                    enabled: true,
                    items: const [
                      Item(name: 'Si', value: SupervisionItem3.si),
                      Item(name: 'No', value: SupervisionItem3.no),
                      Item(name: 'No aplica', value: SupervisionItem3.na),
                    ],
                    title:
                        'Nivel de ventas acordes con analisis asesor\nMonto: ${state.nivelVentas.toCurrencyString()}',
                    onChanged: (v) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          nivelVentasAcordeSi: v?.value == SupervisionItem3.si,
                          nivelVentasAcordeNo: v?.value == SupervisionItem3.no,
                          nivelVentasAcordeNa: v?.value == SupervisionItem3.na,
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  SheetSearchDropdown(
                    validator: (value) => ClassValidator.validateRequired(
                        value?.value.toString()),
                    isRequired: true,
                    hintText: 'input_select_option'.tr(),
                    enabled: true,
                    items: const [
                      Item(name: 'Si', value: SupervisionItem3.si),
                      Item(name: 'No', value: SupervisionItem3.no),
                      Item(name: 'No aplica', value: SupervisionItem3.na),
                    ],
                    title:
                        'Costo de venta adecuado\nMonto: ${state.costoVenta.toCurrencyString()}',
                    onChanged: (v) {
                      cubit.state.copyWith(
                        costoVentaAdecuadoNa: v?.value == SupervisionItem3.na,
                        costoVentaAdecuadoSi: v?.value == SupervisionItem3.si,
                        costoVentaAdecuadoNo: v?.value == SupervisionItem3.no,
                      );
                    },
                  ),
                  const Gap(10),
                  SheetSearchDropdown(
                    validator: (value) => ClassValidator.validateRequired(
                        value?.value.toString()),
                    isRequired: true,
                    hintText: 'input.select_option'.tr(),
                    enabled: true,
                    items: const [
                      Item(name: 'Si', value: SupervisionItem3.si),
                      Item(name: 'No', value: SupervisionItem3.no),
                      Item(name: 'No aplica', value: SupervisionItem3.na),
                    ],
                    title:
                        'Disponible acorde a la realidad del cliente\nMonto: ${state.disponibleCliente.toCurrencyString()}',
                    onChanged: (v) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          realidadClienteNa: v?.value == SupervisionItem3.na,
                          realidadClienteSi: v?.value == SupervisionItem3.si,
                          realidadClienteNo: v?.value == SupervisionItem3.no,
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  SheetSearchDropdown(
                    validator: (value) => ClassValidator.validateRequired(
                        value?.value.toString()),
                    isRequired: true,
                    hintText: 'input.select_option'.tr(),
                    enabled: true,
                    items: const [
                      Item(name: 'Si', value: SupervisionItem3.si),
                      Item(name: 'No', value: SupervisionItem3.no),
                      Item(name: 'No aplica', value: SupervisionItem3.na),
                    ],
                    title:
                        'Razon cuota aplica segun politica de credito\nMonto: ${widget.cuota.toCurrencyString()}',
                    onChanged: (v) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          razonCuotaNa: v?.value == SupervisionItem3.na,
                          razonCuotaNo: v?.value == SupervisionItem3.no,
                          razonCuotaSi: v?.value == SupervisionItem3.si,
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  SheetSearchDropdown(
                    validator: (value) => ClassValidator.validateRequired(
                        value?.value.toString()),
                    isRequired: true,
                    enabled: true,
                    items: const [
                      Item(name: 'Si', value: SupervisionItem3.si),
                      Item(name: 'No', value: SupervisionItem3.no),
                      Item(name: 'No aplica', value: SupervisionItem3.na),
                    ],
                    hintText: 'input.select_option'.tr(),
                    title:
                        'Razon endeudamiento aplica segun politica\nMonto: ${widget.razonEndeudamiento.toCurrencyString()}',
                    onChanged: (v) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          razonEndeudamientoNa: v?.value == SupervisionItem3.na,
                          razonEndeudamientoNo: v?.value == SupervisionItem3.no,
                          razonEndeudamientoSi: v?.value == SupervisionItem3.si,
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  SheetSearchDropdown(
                    validator: (value) => ClassValidator.validateRequired(
                        value?.value.toString()),
                    isRequired: true,
                    hintText: 'input.select_option'.tr(),
                    title: 'Garantia Revisada',
                    enabled: true,
                    items: const [
                      Item(name: 'Si', value: SupervisionItem3.si),
                      Item(name: 'No', value: SupervisionItem3.no),
                      Item(name: 'No aplica', value: SupervisionItem3.na),
                    ],
                    onChanged: (v) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          garantiaRevisadaNa: v?.value == SupervisionItem3.na,
                          garantiaRevisadaSi: v?.value == SupervisionItem3.si,
                          garantiaRevisadaNo: v?.value == SupervisionItem3.no,
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  SheetSearchDropdown(
                    validator: (value) => ClassValidator.validateRequired(
                        value?.value.toString()),
                    isRequired: true,
                    hintText: 'input.select_option'.tr(),
                    title: 'Fiador Revisado',
                    enabled: true,
                    items: const [
                      Item(name: 'Si', value: SupervisionItem3.si),
                      Item(name: 'No', value: SupervisionItem3.no),
                      Item(name: 'No aplica', value: SupervisionItem3.na),
                    ],
                    onChanged: (v) {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          fiadorRevisadoNa: v?.value == SupervisionItem3.na,
                          fiadorRevisadoSi: v?.value == SupervisionItem3.si,
                          fiadorRevisadoNo: v?.value == SupervisionItem3.no,
                        ),
                      );
                    },
                  ),
                  const Gap(25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        CustomElevatedButton(
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;
                            widget.pageController.nextPage(
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
                            widget.pageController.previousPage(
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
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

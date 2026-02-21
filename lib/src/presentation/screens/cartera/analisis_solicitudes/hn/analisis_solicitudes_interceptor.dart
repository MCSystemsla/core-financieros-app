import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_credit_card_hn.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/analisis_solicitud_forms/analisis_asalariado_hn_form.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/analisis_solicitud_forms/analisis_nueva_menor_mil_hn_form.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/analisis_solicitud_forms/analisis_represtamo_hn_form.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/analisis_solicitud_forms/analisis_solicitud_nueva_mayor_a_mil_hn.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/ni/analisis_solicitudes_interceptor.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:gap/gap.dart';

class AnalisisSolicitudesInterceptorHN extends StatelessWidget {
  final AnalisisSolicitudesInterceptorType type;
  final int index;
  final String title;
  final String subtitle;
  final String description;
  final String numeroSolicitud;
  const AnalisisSolicitudesInterceptorHN({
    super.key,
    required this.type,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.numeroSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      AnalisisSolicitudesInterceptorType.nueva => AnalisisNuevaMenorMilHnForm(
          index: index,
          title: title,
          subtitle: subtitle,
          description: description,
          numeroSolicitud: int.parse(numeroSolicitud),
          tipoSolicitud: type,
        ),
      AnalisisSolicitudesInterceptorType.represtamo =>
        AnalisisNuevaMenorMilHnForm(
          index: index,
          title: title,
          subtitle: subtitle,
          description: description,
          numeroSolicitud: int.parse(numeroSolicitud),
          tipoSolicitud: type,
        ),
      AnalisisSolicitudesInterceptorType.nuevaMayorAMil =>
        AnalisisSolicitudNuevaMayorAMilHn(
          title: title,
          subtitle: subtitle,
          description: description,
          index: index,
          numeroSolicitud: int.parse(numeroSolicitud),
        ),
      AnalisisSolicitudesInterceptorType.represtamoMayorAMil =>
        AnalisisReprestamoHnForm(
          description: description,
          index: index,
          numeroSolicitud: int.parse(numeroSolicitud),
          subtitle: subtitle,
          title: title,
        ),
      AnalisisSolicitudesInterceptorType.asalariado => AnalisisAsalariadoHnForm(
          description: description,
          index: index,
          numeroSolicitud: int.parse(numeroSolicitud),
          subtitle: subtitle,
          title: title,
        ),
      AnalisisSolicitudesInterceptorType.grupal => AnalisisGrupaHnForm(
          description: description,
          index: index,
          numeroSolicitud: int.parse(numeroSolicitud),
          subtitle: subtitle,
          title: title,
        ),
    };
  }
}

class AnalisisGrupaHnForm extends StatelessWidget {
  final int index;
  final String title;
  final String subtitle;
  final String description;
  final int numeroSolicitud;
  const AnalisisGrupaHnForm({
    super.key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.numeroSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analisis Grupal'),
      ),
      body: Column(
        children: [
          AnalisisCreditCardHn(
            enabled: false,
            index: index,
            animate: false,
            title: title,
            subtitle: subtitle,
            description: description,
            numeroSolicitud: '',
          ),
          Expanded(
            flex: 3,
            child: SafeArea(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  FadeIn(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 20),
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
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(18),
                                child: Text(
                                  'Estado Patrimonial',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(18),
                                child: Text(
                                  'Activos:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              OutlineTextfieldWidget(
                                textAlign: TextAlign.end,
                                title: 'IngresosNegociosSalarios:',
                                icon: const Icon(Icons.document_scanner),
                                textInputType: TextInputType.number,
                                validator: (value) =>
                                    ClassValidator.validateRequired(value),
                                inputFormatters: [
                                  CurrencyInputFormatter(
                                    mantissaLength: 0,
                                  ),
                                ],
                                onChange: (value) {
                                  // final newValue = toNumericString(value);
                                  // cubit.onFieldChanged(
                                  //   () => state.copyWith(
                                  //     activo: double.tryParse(newValue),
                                  //   ),
                                  // );
                                },
                              ),
                              OutlineTextfieldWidget(
                                textAlign: TextAlign.end,
                                title: 'IngresosRemesas:',
                                icon: const Icon(Icons.document_scanner),
                                textInputType: TextInputType.number,
                                validator: (value) =>
                                    ClassValidator.validateRequired(value),
                                inputFormatters: [
                                  CurrencyInputFormatter(
                                    mantissaLength: 0,
                                  ),
                                ],
                                onChange: (value) {
                                  // final newValue = toNumericString(value);
                                  // cubit.onFieldChanged(
                                  //   () => state.copyWith(
                                  //     activo: double.tryParse(newValue),
                                  //   ),
                                  // );
                                },
                              ),
                              OutlineTextfieldWidget(
                                textAlign: TextAlign.end,
                                title: 'IngresosOtraActividad:',
                                icon: const Icon(Icons.document_scanner),
                                textInputType: TextInputType.number,
                                validator: (value) =>
                                    ClassValidator.validateRequired(value),
                                inputFormatters: [
                                  CurrencyInputFormatter(
                                    mantissaLength: 0,
                                  ),
                                ],
                                onChange: (value) {
                                  // final newValue = toNumericString(value);
                                  // cubit.onFieldChanged(
                                  //   () => state.copyWith(
                                  //     activo: double.tryParse(newValue),
                                  //   ),
                                  // );
                                },
                              ),
                              OutlineTextfieldWidget(
                                textAlign: TextAlign.end,
                                title: 'IngresosConyuge:',
                                icon: const Icon(Icons.document_scanner),
                                textInputType: TextInputType.number,
                                validator: (value) =>
                                    ClassValidator.validateRequired(value),
                                inputFormatters: [
                                  CurrencyInputFormatter(
                                    mantissaLength: 0,
                                  ),
                                ],
                                onChange: (value) {
                                  // final newValue = toNumericString(value);
                                  // cubit.onFieldChanged(
                                  //   () => state.copyWith(
                                  //     activo: double.tryParse(newValue),
                                  //   ),
                                  // );
                                },
                              ),
                              OutlineTextfieldWidget(
                                textAlign: TextAlign.end,
                                title: 'TotalIngresos:',
                                icon: const Icon(Icons.document_scanner),
                                textInputType: TextInputType.number,
                                validator: (value) =>
                                    ClassValidator.validateRequired(value),
                                inputFormatters: [
                                  CurrencyInputFormatter(
                                    mantissaLength: 0,
                                  ),
                                ],
                                onChange: (value) {
                                  // final newValue = toNumericString(value);
                                  // cubit.onFieldChanged(
                                  //   () => state.copyWith(
                                  //     activo: double.tryParse(newValue),
                                  //   ),
                                  // );
                                },
                              ),
                              OutlineTextfieldWidget(
                                textAlign: TextAlign.end,
                                title: 'Compras:',
                                icon: const Icon(Icons.document_scanner),
                                textInputType: TextInputType.number,
                                validator: (value) =>
                                    ClassValidator.validateRequired(value),
                                inputFormatters: [
                                  CurrencyInputFormatter(
                                    mantissaLength: 0,
                                  ),
                                ],
                                onChange: (value) {
                                  // final newValue = toNumericString(value);
                                  // cubit.onFieldChanged(
                                  //   () => state.copyWith(
                                  //     activo: double.tryParse(newValue),
                                  //   ),
                                  // );
                                },
                              ),
                              OutlineTextfieldWidget(
                                textAlign: TextAlign.end,
                                title: 'PagoCuotasOtrasInst:',
                                icon: const Icon(Icons.document_scanner),
                                textInputType: TextInputType.number,
                                validator: (value) =>
                                    ClassValidator.validateRequired(value),
                                inputFormatters: [
                                  CurrencyInputFormatter(
                                    mantissaLength: 0,
                                  ),
                                ],
                                onChange: (value) {
                                  // final newValue = toNumericString(value);
                                  // cubit.onFieldChanged(
                                  //   () => state.copyWith(
                                  //     activo: double.tryParse(newValue),
                                  //   ),
                                  // );
                                },
                              ),
                              OutlineTextfieldWidget(
                                textAlign: TextAlign.end,
                                title: 'GastosFamiliares:',
                                icon: const Icon(Icons.document_scanner),
                                textInputType: TextInputType.number,
                                validator: (value) =>
                                    ClassValidator.validateRequired(value),
                                inputFormatters: [
                                  CurrencyInputFormatter(
                                    mantissaLength: 0,
                                  ),
                                ],
                                onChange: (value) {
                                  // final newValue = toNumericString(value);
                                  // cubit.onFieldChanged(
                                  //   () => state.copyWith(
                                  //     activo: double.tryParse(newValue),
                                  //   ),
                                  // );
                                },
                              ),
                              OutlineTextfieldWidget(
                                textAlign: TextAlign.end,
                                title: 'OtrosGastos:',
                                icon: const Icon(Icons.document_scanner),
                                textInputType: TextInputType.number,
                                validator: (value) =>
                                    ClassValidator.validateRequired(value),
                                inputFormatters: [
                                  CurrencyInputFormatter(
                                    mantissaLength: 0,
                                  ),
                                ],
                                onChange: (value) {
                                  // final newValue = toNumericString(value);
                                  // cubit.onFieldChanged(
                                  //   () => state.copyWith(
                                  //     activo: double.tryParse(newValue),
                                  //   ),
                                  // );
                                },
                              ),
                              OutlineTextfieldWidget(
                                textAlign: TextAlign.end,
                                title: 'TotalGastos:',
                                icon: const Icon(Icons.document_scanner),
                                textInputType: TextInputType.number,
                                validator: (value) =>
                                    ClassValidator.validateRequired(value),
                                inputFormatters: [
                                  CurrencyInputFormatter(
                                    mantissaLength: 0,
                                  ),
                                ],
                                onChange: (value) {
                                  // final newValue = toNumericString(value);
                                  // cubit.onFieldChanged(
                                  //   () => state.copyWith(
                                  //     activo: double.tryParse(newValue),
                                  //   ),
                                  // );
                                },
                              ),
                              OutlineTextfieldWidget(
                                textAlign: TextAlign.end,
                                title: 'FlujoNeto:',
                                icon: const Icon(Icons.document_scanner),
                                textInputType: TextInputType.number,
                                validator: (value) =>
                                    ClassValidator.validateRequired(value),
                                inputFormatters: [
                                  CurrencyInputFormatter(
                                    mantissaLength: 0,
                                  ),
                                ],
                                onChange: (value) {
                                  // final newValue = toNumericString(value);
                                  // cubit.onFieldChanged(
                                  //   () => state.copyWith(
                                  //     activo: double.tryParse(newValue),
                                  //   ),
                                  // );
                                },
                              ),
                              OutlineTextfieldWidget(
                                textAlign: TextAlign.end,
                                title: 'Comentarios:',
                                icon: const Icon(Icons.document_scanner),
                                textInputType: TextInputType.number,
                                validator: (value) =>
                                    ClassValidator.validateRequired(value),
                                inputFormatters: [
                                  CurrencyInputFormatter(
                                    mantissaLength: 0,
                                  ),
                                ],
                                onChange: (value) {
                                  // final newValue = toNumericString(value);
                                  // cubit.onFieldChanged(
                                  //   () => state.copyWith(
                                  //     activo: double.tryParse(newValue),
                                  //   ),
                                  // );
                                },
                              ),
                              OutlineTextfieldWidget(
                                textAlign: TextAlign.end,
                                title: 'CreditoNormal:',
                                icon: const Icon(Icons.document_scanner),
                                textInputType: TextInputType.number,
                                validator: (value) =>
                                    ClassValidator.validateRequired(value),
                                inputFormatters: [
                                  CurrencyInputFormatter(
                                    mantissaLength: 0,
                                  ),
                                ],
                                onChange: (value) {
                                  // final newValue = toNumericString(value);
                                  // cubit.onFieldChanged(
                                  //   () => state.copyWith(
                                  //     activo: double.tryParse(newValue),
                                  //   ),
                                  // );
                                },
                              ),
                              OutlineTextfieldWidget(
                                textAlign: TextAlign.end,
                                title: 'CreditoRefinanciado:',
                                icon: const Icon(Icons.document_scanner),
                                textInputType: TextInputType.number,
                                validator: (value) =>
                                    ClassValidator.validateRequired(value),
                                inputFormatters: [
                                  CurrencyInputFormatter(
                                    mantissaLength: 0,
                                  ),
                                ],
                                onChange: (value) {
                                  // final newValue = toNumericString(value);
                                  // cubit.onFieldChanged(
                                  //   () => state.copyWith(
                                  //     activo: double.tryParse(newValue),
                                  //   ),
                                  // );
                                },
                              ),
                              OutlineTextfieldWidget(
                                textAlign: TextAlign.end,
                                title: 'CreditoReadecuado:',
                                icon: const Icon(Icons.document_scanner),
                                textInputType: TextInputType.number,
                                validator: (value) =>
                                    ClassValidator.validateRequired(value),
                                inputFormatters: [
                                  CurrencyInputFormatter(
                                    mantissaLength: 0,
                                  ),
                                ],
                                onChange: (value) {
                                  // final newValue = toNumericString(value);
                                  // cubit.onFieldChanged(
                                  //   () => state.copyWith(
                                  //     activo: double.tryParse(newValue),
                                  //   ),
                                  // );
                                },
                              ),
                              OutlineTextfieldWidget(
                                textAlign: TextAlign.end,
                                title: 'Recapitalizacion:',
                                icon: const Icon(Icons.document_scanner),
                                textInputType: TextInputType.number,
                                validator: (value) =>
                                    ClassValidator.validateRequired(value),
                                inputFormatters: [
                                  CurrencyInputFormatter(
                                    mantissaLength: 0,
                                  ),
                                ],
                                onChange: (value) {
                                  // final newValue = toNumericString(value);
                                  // cubit.onFieldChanged(
                                  //   () => state.copyWith(
                                  //     activo: double.tryParse(newValue),
                                  //   ),
                                  // );
                                },
                              ),
                              OutlineTextfieldWidget(
                                textAlign: TextAlign.end,
                                title: 'CreditoParalelo:',
                                icon: const Icon(Icons.document_scanner),
                                textInputType: TextInputType.number,
                                validator: (value) =>
                                    ClassValidator.validateRequired(value),
                                inputFormatters: [
                                  CurrencyInputFormatter(
                                    mantissaLength: 0,
                                  ),
                                ],
                                onChange: (value) {
                                  // final newValue = toNumericString(value);
                                  // cubit.onFieldChanged(
                                  //   () => state.copyWith(
                                  //     activo: double.tryParse(newValue),
                                  //   ),
                                  // );
                                },
                              ),
                              const Gap(20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    CustomElevatedButton(
                                      onPressed: () {
                                        if (!formKey.currentState!.validate()) {
                                          return;
                                        }
                                        pageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      text: 'Enviar Analisis',
                                      color: Colors.green,
                                    ),
                                    const Gap(10),
                                    CustomElevatedButton(
                                      onPressed: () {
                                        pageController.previousPage(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      text: 'Anterior',
                                      color: Colors.red,
                                    ),
                                    const Gap(20),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/format/format_field.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/catalogo_frecuencia_pago/catalogo_frecuencia_pago.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/calculo_cuota/calculo_cuota_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/cuota_data_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_frecuencia_pago_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_producto_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/double/double_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/int/int_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NuevaMenorCreditoWidgetView extends StatefulWidget {
  final PageController controller;
  const NuevaMenorCreditoWidgetView({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorCreditoWidgetView> createState() =>
      _NuevaMenorCreditoWidgetViewState();
}

class _NuevaMenorCreditoWidgetViewState
    extends State<NuevaMenorCreditoWidgetView> {
  @override
  Widget build(BuildContext context) {
    return _FormContent(
      controller: widget.controller,
    );
  }
}

class _FormContent extends StatefulWidget {
  final PageController controller;
  const _FormContent({required this.controller});

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  Item? moneda;
  String? monto;
  Item? proposito;
  Item? producto;
  CatalogoFrecuenciaItem? frecuenciaDePago;
  String? plazoSolicitud;
  String? cuota;
  String? observacion;
  DateTime? fechaPrimerPago;
  DateTime? fechaDesembolso;
  double? tasaInteres;
  int? montoMinimo;
  double? montoMaximo;

  final formKey = GlobalKey<FormState>();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaPrimerPago,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaPrimerPago) {
      if (!context.mounted) return;
      if (picked.isBefore(DateTime.now())) {
        CustomAlertDialog(
          onDone: () => context.pop(),
          context: context,
          title: 'La Fecha no puede ser antes a la fecha actual',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }
      if (picked.isAtSameMomentAs(fechaDesembolso ?? DateTime.now())) {
        CustomAlertDialog(
          onDone: () => context.pop(),
          context: context,
          title:
              'La Fecha de primer pago no puede ser igual a la fecha de desembolso',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }
      fechaPrimerPago = picked;
      context.read<SolicitudNuevaMenorCubit>().onFieldChanged(
            () => context.read<SolicitudNuevaMenorCubit>().state.copyWith(
                  fechaPrimerPagoSolicitud:
                      fechaPrimerPago?.toUtc().toIso8601String(),
                ),
          );
      setState(() {});
    }
  }

  Future<void> selectFechaDesembolso(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaDesembolso,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaDesembolso) {
      if (!context.mounted) return;
      if (picked.isBefore(today)) {
        CustomAlertDialog(
          onDone: () => context.pop(),
          context: context,
          title: 'La Fecha no puede ser antes a la fecha actual',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }
      if (picked.isAtSameMomentAs(fechaPrimerPago ?? DateTime.now())) {
        CustomAlertDialog(
          onDone: () => context.pop(),
          context: context,
          title:
              'La Fecha de desembolso no puede ser igual a la fecha de primer pago',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }
      fechaDesembolso = picked;
      context.read<SolicitudNuevaMenorCubit>().onFieldChanged(
            () => context.read<SolicitudNuevaMenorCubit>().state.copyWith(
                  fechaDesembolso: fechaDesembolso?.toUtc().toIso8601String(),
                ),
          );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final calcularCuotaProvider = context.read<CalculoCuotaCubit>();
    return BlocBuilder<SolicitudNuevaMenorCubit, SolicitudNuevaMenorState>(
      builder: (context, state) {
        final cubit = context.read<SolicitudNuevaMenorCubit>();
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Gap(20),
                SearchDropdownWidget(
                  codigo: 'DESTINOCREDITO',
                  title: 'Propósito',
                  validator: (value) =>
                      ClassValidator.validateRequired(proposito?.value),
                  onChanged: (item) {
                    if (item == null) return;
                    proposito = item;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objPropositoId: item.value,
                        objPropositoIdVer: item.name,
                      ),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  icon: Icon(
                    Icons.price_change,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Monto',
                  hintText: 'Ingresa Monto',
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    CurrencyInputFormatter(),
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) => ClassValidator.validateRequired(value),
                  isValid: null,
                  onChange: (value) {
                    monto = value.replaceAll(',', '');
                    cubit.onFieldChanged(
                      () => cubit.state
                          .copyWith(monto: int.tryParse(monto ?? '0')),
                    );
                    setState(() {});
                  },
                ),
                OutlineTextfieldWidget(
                  initialValue: fechaDesembolso?.selectorFormat(),
                  readOnly: true,
                  icon: Icon(
                    Icons.price_change,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Fecha de Desembolso',
                  hintText: fechaDesembolso?.selectorFormat() ??
                      'Ingresar fecha desembolso',
                  validator: (value) => ClassValidator.validateRequired(
                      fechaDesembolso?.selectorFormat()),
                  isValid: null,
                  onTap: () => selectFechaDesembolso(context),
                ),
                const Gap(20),
                CatalogoProductoDropdown(
                  validator: (value) =>
                      ClassValidator.validateRequired(producto?.value),
                  title: 'Producto',
                  onChanged: (item) {
                    if (item == null) return;
                    producto = item;
                    tasaInteres = item.interes;
                    montoMinimo = item.montoMinimo;
                    montoMaximo = item.montoMaximo;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objProductoId: item.value,
                        objProductoIdVer: item.name,
                        prestamoInteres: item.interes,
                        montoMinimo: item.montoMinimo,
                        montoMaximo: item.montoMaximo?.toInt(),
                      ),
                    );
                    setState(() {});
                  },
                ),
                const Gap(20),
                CatalogoFrecuenciaPagoDropdown(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.valor),
                  onChanged: (item) {
                    if (item == null) return;
                    frecuenciaDePago = item;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        objFrecuenciaIdVer: item.nombre,
                        objFrecuenciaId: item.valor,
                        frecuenciaPagoMeses: item.meses,
                      ),
                    );
                  },
                  title: 'Frecuencia de Pago',
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  icon: Icon(
                    Icons.price_change,
                    color: AppColors.getPrimaryColor(),
                  ),
                  validator: (value) => ClassValidator.validateRequired(value),
                  title: 'Plazo Solicitud (meses)',
                  hintText: 'Ingresa Plazo Solicitud (meses)',
                  textInputType: TextInputType.number,
                  isValid: null,
                  onChange: (value) {
                    plazoSolicitud = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                          plazoSolicitud: int.tryParse(plazoSolicitud ?? '0')),
                    );
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  validator: (value) => ClassValidator.validateRequired(
                      fechaPrimerPago?.selectorFormat()),
                  readOnly: true,
                  onTap: () => selectDate(context),
                  icon: Icon(
                    Icons.payment,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Fecha del Primer Pago de la Solicitud',
                  hintText: fechaPrimerPago?.selectorFormat() ??
                      'Ingresar fecha primer pago',
                  isValid: null,
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  maxLength: 50,
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Observación',
                  hintText: 'Ingresa Observación',
                  isValid: null,
                  onChange: (value) {
                    observacion = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(observacion: value),
                    );
                  },
                ),
                const Gap(20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'Siguiente',
                    color: AppColors.greenLatern.withOpacity(0.4),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      if (double.tryParse(monto ?? '0') == 0) {
                        CustomAlertDialog(
                          context: context,
                          title: 'El monto no puede ser 0',
                          onDone: () => context.pop(),
                        ).showDialog(context, dialogType: DialogType.warning);
                        return;
                      }
                      if ((double.tryParse(monto ?? '0') ?? 0) <
                          montoMinimo!.toDouble()) {
                        CustomAlertDialog(
                          context: context,
                          title:
                              'El monto minimo debe ser mayor a ${montoMinimo?.toIntFormat}',
                          onDone: () => context.pop(),
                        ).showDialog(context, dialogType: DialogType.warning);
                        return;
                      }
                      if (double.tryParse(monto ?? '0')! >
                          montoMaximo!.toDouble()) {
                        CustomAlertDialog(
                          context: context,
                          title:
                              'El monto maximo debe ser menor o igual a ${montoMaximo?.toDoubleFormat}',
                          onDone: () => context.pop(),
                        ).showDialog(context, dialogType: DialogType.warning);
                        return;
                      }
                      final plazoSolicitudMount =
                          (int.tryParse(plazoSolicitud ?? '0') ?? 0);
                      final frecuenciaPagoMeses =
                          (double.tryParse(frecuenciaDePago?.meses ?? '0') ??
                              0);
                      if (plazoSolicitudMount < frecuenciaPagoMeses) {
                        CustomAlertDialog(
                          context: context,
                          title:
                              'El plazo solicitud debe ser mayor o igual a la frecuencia de pago',
                          onDone: () => context.pop(),
                        ).showDialog(context, dialogType: DialogType.warning);
                        return;
                      }

                      calcularCuotaProvider.calcularCantidadCuotas(
                        fechaDesembolso: fechaDesembolso!,
                        fechaPrimeraCuota: fechaPrimerPago!,
                        plazoSolicitud: int.parse(plazoSolicitud ?? '0'),
                        frecuenciaPago: frecuenciaDePago?.meses ?? '0',
                        saldoPrincipal: double.parse(monto ?? '0'),
                        tasaInteresMensual: tasaInteres ?? 0,
                      );
                      CuotaDataDialog(
                        context: context,
                        title:
                            'Estimación de la cuota según los datos ingresados\n${calcularCuotaProvider.state.montoPrimeraCuota.toCurrencyFormat} USD',
                        onDone: () {
                          cubit.onFieldChanged(
                            () => cubit.state.copyWith(
                              cuota: calcularCuotaProvider
                                  .state.montoPrimeraCuota
                                  .toInt(),
                            ),
                          );
                          widget.controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                          context.pop();
                        },
                      ).showDialog(context);
                    },
                  ),
                ),
                const Gap(10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomOutLineButton(
                    onPressed: () {
                      widget.controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    text: 'Atras',
                    textColor: AppColors.red,
                    color: AppColors.red,
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        );
      },
    );
  }
}

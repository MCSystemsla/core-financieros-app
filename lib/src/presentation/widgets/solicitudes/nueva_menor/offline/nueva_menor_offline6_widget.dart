// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/calculo_cuota/calculo_cuota_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/cuota_data_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/double/double_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/int/int_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NuevaMenorOffline6Widget extends StatefulWidget {
  final PageController pageController;
  final ResponseLocalDb responseLocalDb;
  const NuevaMenorOffline6Widget(
      {super.key, required this.pageController, required this.responseLocalDb});

  @override
  State<NuevaMenorOffline6Widget> createState() =>
      _NuevaMenorOffline6WidgetState();
}

class _NuevaMenorOffline6WidgetState extends State<NuevaMenorOffline6Widget>
    with AutomaticKeepAliveClientMixin {
  String? moneda;
  String? monedaVer;
  String? monto;
  String? proposito;
  String? propositoVer;
  String? producto;
  String? productoVer;
  String? frecuenciaDePago;
  String? frecuenciaDePagoVer;
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
      firstDate: DateTime(1930),
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
      fechaPrimerPago = picked;
      setState(() {});
    }
  }

  Future<void> selectFechaDesembolso(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaDesembolso,
      firstDate: DateTime(1930),
      lastDate: DateTime(2101),
      locale: Locale(context.read<LangCubit>().state.currentLang.languageCode),
    );
    if (picked != null && picked != fechaDesembolso) {
      if (!context.mounted) return;
      if (picked.isBefore(DateTime.now())) {
        CustomAlertDialog(
          onDone: () => context.pop(),
          context: context,
          title: 'La Fecha no puede ser antes a la fecha actual',
        ).showDialog(context, dialogType: DialogType.warning);
        return;
      }
      fechaDesembolso = picked;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    propositoVer = widget.responseLocalDb.objPropositoIdVer;
    monedaVer = widget.responseLocalDb.objMonedaIdVer;
    productoVer = widget.responseLocalDb.objProductoIdVer;
    frecuenciaDePagoVer = widget.responseLocalDb.objFrecuenciaIdVer;
    moneda = widget.responseLocalDb.objMonedaId;
    monto = widget.responseLocalDb.monto.toString();
    proposito = widget.responseLocalDb.objPropositoId;
    producto = widget.responseLocalDb.objProductoId;
    frecuenciaDePago = widget.responseLocalDb.objFrecuenciaId;
    plazoSolicitud = widget.responseLocalDb.plazoSolicitud.toString();
    fechaPrimerPago = DateTime.tryParse(
        widget.responseLocalDb.fechaPrimerPagoSolicitud ?? '');
    observacion = widget.responseLocalDb.observacion;
    fechaDesembolso =
        DateTime.tryParse(widget.responseLocalDb.fechaDesembolso ?? '');
    tasaInteres = widget.responseLocalDb.prestamoInteres;
    montoMinimo = widget.responseLocalDb.montoMinimo;
    montoMaximo = widget.responseLocalDb.montoMaximo?.toDouble();
  }

  final montoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    log(monto.toString());
    super.build(context);
    final calcularCuotaProvider = context.read<CalculoCuotaCubit>();
    // montoController.value =
    //     TextEditingValue(text: FormatField.formatMonto(monto ?? ''));
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(20),
            SearchDropdownWidget(
              hintText: monedaVer ?? 'input.select_option'.tr(),
              codigo: 'MONEDA',
              onChanged: (item) {
                if (item == null) return;
                moneda = item.value;
                monedaVer = item.name;
              },
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              title: 'Moneda',
              isRequired: true,
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              initialValue: monto,
              // onFieldSubmitted: (value) {
              //   String formattedValue =
              //       FormatField.formatMonto(montoController.text);
              //   montoController.value = TextEditingValue(
              //     text: formattedValue,
              //     selection:
              //         TextSelection.collapsed(offset: formattedValue.length),
              //   );
              // },
              // onTapOutside: (event) {
              //   String formattedValue =
              //       FormatField.formatMonto(montoController.text);
              //   montoController.value = TextEditingValue(
              //     text: formattedValue,
              //     selection:
              //         TextSelection.collapsed(offset: formattedValue.length),
              //   );
              // },
              // textEditingController: montoController,
              icon: Icon(
                Icons.price_change,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Monto',
              hintText: 'Ingresa Monto',
              textInputType: TextInputType.number,
              validator: (value) => ClassValidator.validateRequired(monto),
              isValid: null,
              onChange: (value) {
                monto = value;
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
              title: 'Fecha Desembolso',
              hintText: fechaDesembolso?.selectorFormat() ??
                  'Ingresar fecha desembolso',
              validator: (value) => ClassValidator.validateRequired(
                  fechaDesembolso?.selectorFormat()),
              isValid: null,
              onTap: () => selectFechaDesembolso(context),
            ),
            const Gap(20),
            SearchDropdownWidget(
              hintText: propositoVer ?? 'Selecciona una opcion',
              codigo: 'DESTINOCREDITO',
              title: 'Proposito',
              onChanged: (item) {
                if (item == null) return;
                proposito = item.value;
                propositoVer = item.name;
              },
            ),
            const Gap(20),
            SearchDropdownWidget(
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              hintText: productoVer ?? 'Selecciona una opcion',
              codigo: 'PRODUCTO',
              title: 'Producto',
              onChanged: (item) {
                if (item == null) return;
                producto = item.value;
                productoVer = item.name;
                tasaInteres = item.interes;
                montoMinimo = item.montoMinimo;
                montoMaximo = item.montoMaximo;
              },
            ),
            const Gap(20),
            SearchDropdownWidget(
              hintText: frecuenciaDePagoVer ?? 'input.select_option'.tr(),
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              onChanged: (item) {
                if (item == null) return;
                frecuenciaDePago = item.name;
                frecuenciaDePagoVer = item.name;
              },
              codigo: 'FRECUENCIAPAGO',
              title: 'Frecuencia de Pago',
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              initialValue: plazoSolicitud == '0' ? null : plazoSolicitud,
              icon: Icon(
                Icons.price_change,
                color: AppColors.getPrimaryColor(),
              ),
              validator: (value) => ClassValidator.validateRequired(value),
              title: 'Plazo Solicitud',
              hintText: 'Ingresa Plazo Solicitud',
              textInputType: TextInputType.number,
              isValid: null,
              onChange: (value) {
                plazoSolicitud = value;
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              initialValue: fechaPrimerPago?.selectorFormat(),
              validator: (value) => ClassValidator.validateRequired(
                  fechaPrimerPago?.selectorFormat()),
              readOnly: true,
              onTap: () => selectDate(context),
              icon: Icon(
                Icons.payment,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Fecha de Primer Pago Solicitud',
              hintText: fechaPrimerPago?.selectorFormat() ??
                  'Ingresar fecha primer pago',
              isValid: null,
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              initialValue: observacion,
              icon: Icon(
                Icons.remove_red_eye,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Observacion',
              hintText: 'Ingresa Observacion',
              isValid: null,
              onChange: (value) {
                observacion = value;
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
                  if (double.tryParse(monto ?? '0')! <
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
                  calcularCuotaProvider.calcularCantidadCuotas(
                    fechaDesembolso: fechaDesembolso!,
                    fechaPrimeraCuota: fechaPrimerPago!,
                    plazoSolicitud: int.parse(plazoSolicitud ?? ''),
                    frecuenciaPago: frecuenciaDePagoVer!,
                    saldoPrincipal: double.tryParse(monto ?? '0') ?? 0,
                    tasaInteresMensual: tasaInteres ?? 0,
                  );
                  CuotaDataDialog(
                    context: context,
                    title:
                        'Concuerda el cliente con este monto de cuota? Cuota Final: \n${calcularCuotaProvider.state.montoPrimeraCuota.toCurrencyFormat} $monedaVer',
                    onDone: () {
                      context.read<SolicitudNuevaMenorCubit>().saveAnswers(
                            montoMaximo: montoMaximo?.toInt(),
                            montoMinimo: montoMinimo?.toInt(),
                            fechaDesembolso:
                                fechaDesembolso?.toUtc().toIso8601String(),
                            objFrecuenciaIdVer: frecuenciaDePagoVer,
                            objProductoIdVer: productoVer,
                            objMonedaIdVer: monedaVer,
                            objPropositoIdVer: propositoVer,
                            objMonedaId: moneda,
                            monto: int.tryParse(monto ?? '0'),
                            objPropositoId: proposito,
                            objProductoId: producto,
                            objFrecuenciaId: frecuenciaDePago,
                            plazoSolicitud: int.tryParse(plazoSolicitud ?? '0'),
                            fechaPrimerPagoSolicitud:
                                fechaPrimerPago?.toUtc().toIso8601String(),
                            cuota: calcularCuotaProvider
                                .state.montoPrincipalPrimeraCuota
                                .toInt(),
                            observacion: observacion,
                            prestamoInteres: tasaInteres,
                          );
                      widget.pageController.nextPage(
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
                  widget.pageController.previousPage(
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
  }

  @override
  bool get wantKeepAlive => true;
}

// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/catalogo_frecuencia_pago/catalogo_frecuencia_pago.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_represtamo/solicitud_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_frecuencia_pago_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/int/int_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/format/format_field.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/represtamo_responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/calculo_cuota/calculo_cuota_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/cuota_data_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/double/double_extension.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ReprestamoOfflineForm3 extends StatefulWidget {
  final ReprestamoResponsesLocalDb solicitud;
  final PageController controller;
  const ReprestamoOfflineForm3(
      {super.key, required this.controller, required this.solicitud});

  @override
  State<ReprestamoOfflineForm3> createState() => _ReprestamoOfflineForm3State();
}

class _ReprestamoOfflineForm3State extends State<ReprestamoOfflineForm3>
    with AutomaticKeepAliveClientMixin {
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
      context.read<SolicitudReprestamoCubit>().onFieldChanged(
            () => context.read<SolicitudReprestamoCubit>().state.copyWith(
                  fechaDesembolso: fechaPrimerPago?.toUtc().toIso8601String(),
                ),
          );
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

      context.read<SolicitudReprestamoCubit>().onFieldChanged(
            () => context.read<SolicitudReprestamoCubit>().state.copyWith(
                  fechaDesembolso: fechaDesembolso?.toUtc().toIso8601String(),
                ),
          );

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    final solicitud = widget.solicitud;
    proposito = Item(
        name: solicitud.objPropositoIdVer!, value: solicitud.objPropositoId);
    moneda = const Item(name: 'DOLAR', value: 'DOLAR');
    monto = solicitud.monto.toString();
    fechaDesembolso = solicitud.fechaDesembolso;
    producto = Item(
      name: solicitud.objProductoIdVer!,
      value: solicitud.objProductoId,
      interes: solicitud.prestamoInteres,
      montoMaximo: solicitud.montoMaximo?.toDouble(),
      montoMinimo: solicitud.montoMinimo,
    );
    tasaInteres = solicitud.prestamoInteres;
    frecuenciaDePago = CatalogoFrecuenciaItem(
      nombre: solicitud.objFrecuenciaIdVer!,
      valor: solicitud.objFrecuenciaId!,
      meses: solicitud.frecuenciaPagoMeses!,
    );
    plazoSolicitud = solicitud.plazoSolicitud.toString();
    fechaPrimerPago = solicitud.fechaPrimerPagoSolicitud;
    observacion = solicitud.observacion;

    context.read<SolicitudReprestamoCubit>().onFieldChanged(
          () => context.read<SolicitudReprestamoCubit>().state.copyWith(
                monto: double.parse(monto ?? '0').toInt(),
                tasaInteres: tasaInteres,
                objPropositoId: proposito?.value,
                objPropositoIdVer: proposito?.name,
                objMonedaId: moneda?.value,
                objMonedaIdVer: moneda?.name,
                objProductoId: producto?.value,
                objProductoIdVer: producto?.name,
                objFrecuenciaId: frecuenciaDePago?.valor,
                objFrecuenciaIdVer: frecuenciaDePago?.nombre,
                plazoSolicitud: int.parse(plazoSolicitud ?? '0'),
                frecuenciaPagoMeses: frecuenciaDePago?.meses,
                montoMaximo: montoMaximo?.toInt(),
                montoMinimo: montoMinimo,
                fechaPrimerPagoSolicitud:
                    fechaPrimerPago?.toUtc().toIso8601String(),
                observacion: observacion,
                fechaDesembolso: fechaDesembolso?.toUtc().toIso8601String(),
              ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SolicitudReprestamoCubit>();
    super.build(context);
    final calcularCuotaProvider = context.read<CalculoCuotaCubit>();

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(20),
            SearchDropdownWidget(
              hintText: proposito?.name ?? 'Seleccionar Proposito',
              codigo: 'DESTINOCREDITO',
              title: 'Proposito',
              onChanged: (item) {
                if (item == null) return;
                proposito = item;
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              inputFormatters: [
                CurrencyInputFormatter(),
                FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
                LengthLimitingTextInputFormatter(9),
              ],
              icon: Icon(
                Icons.price_change,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Monto',
              hintText: monto ?? 'Ingresa Monto',
              textInputType: TextInputType.number,
              validator: (value) => ClassValidator.validateRequired(value),
              isValid: null,
              onChange: (value) {
                monto = value.replaceAll(',', '.');
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(
                    monto: int.tryParse(monto ?? '0'),
                  ),
                );
              },
            ),
            const Gap(20),
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
                  fechaPrimerPago?.selectorFormat()),
              isValid: null,
              onTap: () => selectFechaDesembolso(context),
            ),
            const Gap(20),
            SearchDropdownWidget(
              hintText: producto?.name ?? 'Seleccionar Producto',
              codigo: 'PRODUCTO',
              title: 'Producto',
              onChanged: (item) {
                if (item == null) return;
                producto = item;
                tasaInteres = item.interes;
                log(item.interes.toString());
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(
                    objProductoId: producto?.value,
                    objProductoIdVer: producto?.name,
                    tasaInteres: tasaInteres,
                    montoMinimo: producto?.montoMinimo,
                    montoMaximo: producto?.montoMaximo?.toInt(),
                  ),
                );
                setState(() {});
              },
            ),
            const Gap(20),
            CatalogoFrecuenciaPagoDropdown(
              hintText: frecuenciaDePago?.nombre ?? 'input.select_option'.tr(),
              validator: (value) =>
                  ClassValidator.validateRequired(frecuenciaDePago?.nombre),
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
              initialValue: plazoSolicitud,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              icon: Icon(
                Icons.price_change,
                color: AppColors.getPrimaryColor(),
              ),
              validator: (value) => ClassValidator.validateRequired(value),
              title: 'Plazo en meses',
              hintText: 'Ingresa en meses',
              textInputType: TextInputType.number,
              isValid: null,
              onChange: (value) {
                plazoSolicitud = value;
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(
                    plazoSolicitud: int.tryParse(value ?? '0'),
                  ),
                );
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
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              icon: Icon(
                Icons.remove_red_eye,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Observacion',
              hintText: 'Ingresa Observacion',
              isValid: null,
              onChange: (value) {
                observacion = value;
                cubit.onFieldChanged(
                  () => cubit.state.copyWith(
                    observacion: observacion,
                  ),
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
                  if ((double.tryParse(monto ?? '0') ?? 0) >
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
                    plazoSolicitud: int.parse(plazoSolicitud ?? '0'),
                    frecuenciaPago: frecuenciaDePago?.meses ?? '0',
                    saldoPrincipal: double.parse(monto ?? '0'),
                    tasaInteresMensual: tasaInteres ?? 0,
                  );
                  CuotaDataDialog(
                    context: context,
                    title:
                        'Estimación de la Cuota final según los datos ingresados\n${calcularCuotaProvider.state.montoPrimeraCuota.toCurrencyFormat} USD',
                    onDone: () {
                      cubit.onFieldChanged(
                        () => cubit.state.copyWith(
                          cuota: calcularCuotaProvider.state.montoPrimeraCuota
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
  }

  @override
  bool get wantKeepAlive => true;
}

// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/catalogo_frecuencia_pago/catalogo_frecuencia_pago.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/calculo_cuota/calculo_cuota_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/cuota_data_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_frecuencia_pago_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_producto_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/sending/asalariado_sending_form.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/double/double_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/int/int_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:flutter_multi_formatter/formatters/money_input_formatter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AsalariadoForm7View extends StatefulWidget {
  final PageController controller;
  const AsalariadoForm7View({super.key, required this.controller});

  @override
  State<AsalariadoForm7View> createState() => _AsalariadoForm7ViewState();
}

class _AsalariadoForm7ViewState extends State<AsalariadoForm7View> {
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
  String? ubicacion;
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
      context.read<SolicitudAsalariadoCubit>().onFieldChanged(
            () => context.read<SolicitudAsalariadoCubit>().state.copyWith(
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
      context.read<SolicitudAsalariadoCubit>().onFieldChanged(
            () => context.read<SolicitudAsalariadoCubit>().state.copyWith(
                  fechaDesembolso: fechaDesembolso?.toUtc().toIso8601String(),
                ),
          );
      setState(() {});
    }
  }

  final montoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initFunctions();
  }

  initFunctions() async {
    context.read<InternetConnectionCubit>().getInternetStatusConnection();
    context.read<SolicitudAsalariadoCubit>().onFieldChanged(
          () => context.read<SolicitudAsalariadoCubit>().state.copyWith(
                objMonedaId: 'DOLAR',
                objMonedaIdVer: 'DOLAR',
              ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final calcularCuotaProvider = context.read<CalculoCuotaCubit>();
    return BlocBuilder<SolicitudAsalariadoCubit, SolicitudAsalariadoState>(
      builder: (context, state) {
        final cubit = context.read<SolicitudAsalariadoCubit>();
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Gap(20),
                SearchDropdownWidget(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
                  codigo: 'DESTINOCREDITO',
                  title: 'Propósito',
                  hintText: 'input.select_option'.tr(),
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
                  textEditingController: montoController,
                  inputFormatters: [
                    MoneyInputFormatter(
                      leadingSymbol: '',
                      thousandSeparator: ThousandSeparator.Comma,
                      mantissaLength: 0,
                    ),
                  ],
                  icon: Icon(
                    Icons.price_change,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Monto',
                  hintText: 'Ingresa Monto',
                  textInputType: TextInputType.number,
                  validator: (value) => ClassValidator.validateRequired(value),
                  isValid: null,
                  onChange: (value) {
                    monto = value.replaceAll(',', '');
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        monto: double.tryParse(monto ?? '0'),
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
                      fechaDesembolso?.selectorFormat()),
                  isValid: null,
                  onTap: () => selectFechaDesembolso(context),
                ),
                const Gap(20),
                CatalogoProductoDropdown(
                  validator: (value) =>
                      ClassValidator.validateRequired(value?.value),
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
                        tasaInteres: item.interes,
                        montoMinimo: item.montoMinimo,
                        montoMaximo: item.montoMaximo?.toInt(),
                      ),
                    );
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
                        objFrecuenciaId: item.valor,
                        objFrecuenciaIdVer: item.nombre,
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
                    LengthLimitingTextInputFormatter(2),
                  ],
                  icon: Icon(
                    Icons.price_change,
                    color: AppColors.getPrimaryColor(),
                  ),
                  validator: (value) => ClassValidator.validateIntValue(value),
                  title: 'Plazo en meses',
                  hintText: 'Ingresa en meses',
                  textInputType: TextInputType.number,
                  isValid: null,
                  onChange: (value) {
                    plazoSolicitud = value;
                    cubit.onFieldChanged(
                      () => cubit.state.copyWith(
                        plazoSolicitud: int.tryParse(plazoSolicitud ?? '0'),
                      ),
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
                  title: 'Fecha de Primer Pago Solicitud',
                  hintText: fechaPrimerPago?.selectorFormat() ??
                      'Ingresar fecha primer pago',
                  isValid: null,
                ),
                const Gap(20),
                OutlineTextfieldWidget(
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
                  },
                ),
                const Gap(20),
                OutlineTextfieldWidget(
                  icon: Icon(
                    Icons.location_city,
                    color: AppColors.getPrimaryColor(),
                  ),
                  title: 'Ubicación',
                  hintText: 'Ingresa Ubicación',
                  isValid: null,
                  onChange: (value) {
                    ubicacion = value;
                  },
                ),
                const Gap(20),
                BlocBuilder<InternetConnectionCubit, InternetConnectionState>(
                  builder: (context, state) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: CustomElevatedButton(
                        text: 'Siguiente',
                        color: AppColors.greenLatern.withOpacity(0.4),
                        onPressed: () async {
                          if (!formKey.currentState!.validate()) return;
                          if (double.tryParse(monto ?? '0') == 0) {
                            CustomAlertDialog(
                              context: context,
                              title: 'El monto no puede ser 0',
                              onDone: () => context.pop(),
                            ).showDialog(context,
                                dialogType: DialogType.warning);
                            return;
                          }
                          if (double.tryParse(monto ?? '0')! <
                              montoMinimo!.toDouble()) {
                            CustomAlertDialog(
                              context: context,
                              title:
                                  'El monto minimo debe ser mayor a ${montoMinimo?.toIntFormat}',
                              onDone: () => context.pop(),
                            ).showDialog(context,
                                dialogType: DialogType.warning);
                            return;
                          }
                          if (double.tryParse(monto ?? '0')! >
                              montoMaximo!.toDouble()) {
                            CustomAlertDialog(
                              context: context,
                              title:
                                  'El monto maximo debe ser menor o igual a ${montoMaximo?.toDoubleFormat}',
                              onDone: () => context.pop(),
                            ).showDialog(context,
                                dialogType: DialogType.warning);
                            return;
                          }
                          final plazoSolicitudMount =
                              (int.tryParse(plazoSolicitud ?? '0') ?? 0);
                          final frecuenciaPagoMesesMount = (double.tryParse(
                                  frecuenciaDePago?.meses ?? '0') ??
                              0);
                          if (plazoSolicitudMount < frecuenciaPagoMesesMount) {
                            CustomAlertDialog(
                              context: context,
                              title:
                                  'El plazo solicitud debe ser mayor o igual a la frecuencia de pago',
                              onDone: () => context.pop(),
                            ).showDialog(context,
                                dialogType: DialogType.warning);
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
                          await CuotaDataDialog(
                            context: context,
                            title:
                                'Estimación de la cuota según los datos Ingresados\n${calcularCuotaProvider.state.montoPrimeraCuota.toCurrencyFormat} USD',
                            onDone: () {
                              context.pop();
                              cubit.onFieldChanged(
                                () => cubit.state.copyWith(
                                  cuota: calcularCuotaProvider
                                      .state.montoPrimeraCuota,
                                  isDone: true,
                                ),
                              );
                              if (!context.mounted) return;
                              if (state.connectionStatus ==
                                  ConnectionStatus.disconnected) {
                                cubit.onFieldChanged(
                                  () => cubit.state.copyWith(
                                    isOffline: true,
                                    errorMsg:
                                        'No tienes conexion a internet, La solicitud se a guardado de manera local',
                                  ),
                                );
                                CustomAlertDialog(
                                  context: context,
                                  title:
                                      'No tienes conexion a internet, La solicitud se a guardado de manera local',
                                  onDone: () =>
                                      context.pushReplacement('/solicitudes'),
                                ).showDialog(context,
                                    dialogType: DialogType.infoReverse);
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => BlocProvider.value(
                                    value: context
                                        .read<SolicitudAsalariadoCubit>(),
                                    child: AsalariadoSendingForm(
                                      solicitudId: context
                                          .read<SolicitudAsalariadoCubit>()
                                          .state
                                          .idLocalResponse,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).showDialog(context);
                        },
                      ),
                    );
                  },
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

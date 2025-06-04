// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/format/format_field.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/responses/asalariado_responses_local_db.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/lang/lang_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/calculo_cuota/calculo_cuota_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_asalariado/solicitud_asalariado_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/cuota_data_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custom_outline_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/sending/asalariado_sending_form.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/double/double_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/int/int_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AsalariadoOffline7 extends StatefulWidget {
  final PageController controller;
  final AsalariadoResponsesLocalDb? asalariadoResponsesLocalDb;

  const AsalariadoOffline7({
    super.key,
    required this.controller,
    this.asalariadoResponsesLocalDb,
  });

  @override
  State<AsalariadoOffline7> createState() => _AsalariadoOffline7State();
}

class _AsalariadoOffline7State extends State<AsalariadoOffline7>
    with AutomaticKeepAliveClientMixin {
  Item? moneda;
  String? monto;
  Item? proposito;
  Item? producto;
  Item? frecuenciaDePago;
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

  final montoController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final solicitud = widget.asalariadoResponsesLocalDb;
    moneda = Item(
        name: solicitud?.objMonedaIdVer ?? '', value: solicitud?.objMonedaId);
    monto = solicitud?.monto.toString();
    proposito = Item(
      name: solicitud?.objPropositoIdVer ?? '',
      value: solicitud?.objPropositoId,
    );
    producto = Item(
        name: solicitud?.objProductoIdVer ?? '',
        value: solicitud?.objProductoId);
    frecuenciaDePago = Item(
      name: solicitud?.objFrecuenciaIdVer ?? '',
      value: solicitud?.objFrecuenciaId,
    );
    plazoSolicitud = solicitud?.plazoSolicitud.toString();
    cuota = solicitud?.cuota.toString();
    observacion = solicitud?.observacion;
    ubicacion = solicitud?.ubicacion;
    fechaPrimerPago = solicitud?.fechaPrimerPagoSolicitud;
    fechaDesembolso = solicitud?.fechaDesembolso;
    tasaInteres = solicitud?.tasaInteres;
    montoMinimo = solicitud?.montoMinimo;
    montoMaximo = solicitud?.montoMaximo?.toDouble();
    montoController.text = solicitud?.monto.toString() ?? '0';
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isConnected =
        context.read<InternetConnectionCubit>().state.isConnected;
    final calcularCuotaProvider = context.read<CalculoCuotaCubit>();

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Gap(20),
            SearchDropdownWidget(
              hintText: proposito?.name ?? '',
              codigo: 'DESTINOCREDITO',
              title: 'Proposito',
              onChanged: (item) {
                if (item == null) return;
                proposito = item;
              },
            ),
            const Gap(20),
            SearchDropdownWidget(
              hintText: moneda?.name ?? '',
              codigo: 'MONEDA',
              onChanged: (item) {
                if (item == null) return;
                moneda = item;
              },
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              title: 'Moneda',
              isRequired: true,
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              onFieldSubmitted: (value) {
                String formattedValue =
                    FormatField.formatMonto(montoController.text);
                montoController.value = TextEditingValue(
                  text: formattedValue,
                  selection:
                      TextSelection.collapsed(offset: formattedValue.length),
                );
              },
              onTapOutside: (event) {
                String formattedValue =
                    FormatField.formatMonto(montoController.text);
                montoController.value = TextEditingValue(
                  text: formattedValue,
                  selection:
                      TextSelection.collapsed(offset: formattedValue.length),
                );
              },
              textEditingController: montoController,
              icon: Icon(
                Icons.price_change,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Monto',
              hintText: monto ?? 'Ingresa Monto',
              textInputType: TextInputType.number,
              validator: (value) => ClassValidator.validateRequired(monto),
              isValid: null,
              onChange: (value) {
                monto = value;
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
              hintText: producto?.name ?? '',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              codigo: 'PRODUCTO',
              title: 'Producto',
              onChanged: (item) {
                if (item == null) return;
                producto = item;
                tasaInteres = item.interes;
                montoMinimo = item.montoMinimo;
                montoMaximo = item.montoMaximo;
              },
            ),
            const Gap(20),
            SearchDropdownWidget(
              hintText: frecuenciaDePago?.name ?? '',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              onChanged: (item) {
                if (item == null) return;
                frecuenciaDePago = item;
              },
              codigo: 'FRECUENCIAPAGO',
              title: 'Frecuencia de Pago',
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              initialValue: plazoSolicitud,
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
            OutlineTextfieldWidget(
              initialValue: ubicacion,
              icon: Icon(
                Icons.remove_red_eye,
                color: AppColors.getPrimaryColor(),
              ),
              title: 'Ubicacion',
              hintText: 'Ingresa Ubicacion',
              isValid: null,
              onChange: (value) {
                ubicacion = value;
              },
            ),
            const Gap(20),
            Container(
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
                    plazoSolicitud: int.parse(plazoSolicitud ?? '0'),
                    formadePago: frecuenciaDePago?.name ?? '',
                    saldoPrincipal: double.parse(monto ?? '0'),
                    tasaInteresMensual: tasaInteres ?? 0,
                  );
                  await CuotaDataDialog(
                    context: context,
                    title:
                        'Concuerda el cliente con este monto de cuota? Cuota Final: \n${calcularCuotaProvider.state.montoPrimeraCuota.toCurrencyFormat} ${moneda?.name}',
                    onDone: () {
                      context.read<SolicitudAsalariadoCubit>().saveAnswers(
                            ubicacion: ubicacion,
                            isOffline: !isConnected,
                            isDone: !isConnected,
                            tasaInteres: tasaInteres,
                            fechaDesembolso:
                                fechaDesembolso?.toUtc().toIso8601String(),
                            montoMaximo: montoMaximo?.toInt(),
                            montoMinimo: montoMinimo,
                            objMonedaId: moneda?.value,
                            objMonedaIdVer: moneda?.name,
                            monto: double.tryParse(monto ?? '0'),
                            objPropositoId: proposito?.value,
                            objPropositoIdVer: proposito?.name,
                            objProductoId: producto?.value,
                            objProductoIdVer: producto?.name,
                            objFrecuenciaId: frecuenciaDePago?.value,
                            objFrecuenciaIdVer: frecuenciaDePago?.name,
                            plazoSolicitud: int.tryParse(plazoSolicitud ?? '0'),
                            fechaPrimerPagoSolicitud:
                                fechaPrimerPago?.toUtc().toIso8601String(),
                            cuota: calcularCuotaProvider
                                .state.montoPrincipalPrimeraCuota,
                            observacion: observacion,
                          );

                      context.pop();
                      if (!context.mounted) return;
                      if (!isConnected) {
                        context.read<SolicitudAsalariadoCubit>().saveAnswers(
                              errorMsg:
                                  'No tienes conexion a internet, La solicitud se a guardado de manera local',
                            );
                        CustomAlertDialog(
                          context: context,
                          title:
                              'No tienes conexion a internet, La solicitud se a guardado de manera local',
                          onDone: () => context.pushReplacement('/solicitudes'),
                        ).showDialog(context,
                            dialogType: DialogType.infoReverse);
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => BlocProvider.value(
                            value: context.read<SolicitudAsalariadoCubit>(),
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

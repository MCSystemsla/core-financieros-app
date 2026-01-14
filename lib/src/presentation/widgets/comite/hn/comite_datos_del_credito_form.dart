import 'package:core_financiero_app/src/config/helpers/select_date/select_date_helper.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_solicitud_response.dart';
import 'package:core_financiero_app/src/presentation/bloc/comite/comite_aprobacion/comite_aprobacion_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';

class ComiteDatosDelCreditoForm extends StatefulWidget {
  final ComiteSolicitudData data;

  const ComiteDatosDelCreditoForm({
    super.key,
    required this.data,
  });

  @override
  State<ComiteDatosDelCreditoForm> createState() =>
      _ComiteDatosDelCreditoFormState();
}

class _ComiteDatosDelCreditoFormState extends State<ComiteDatosDelCreditoForm> {
  DateTime? fechaVencimiento;
  DateTime? fechaPrimerPago;
  @override
  void initState() {
    super.initState();
    fechaPrimerPago = widget.data.fechaPrimerPagoAprobacion;
    final cubit = context.read<ComiteAprobacionCubit>();
    cubit.onFieldChanged(
      () => cubit.state.copyWith(
        fechaAprobacion: fechaPrimerPago?.toUtc().toIso8601String(),
      ),
    );
  }

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 20),
            child: Text(
              'Datos del credito',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Gap(12),
          SearchDropdownWidget(
            selectedItem: Item(
              name: widget.data.nombreProducto ?? '',
              value: widget.data.nombreProducto,
            ),
            codigo: 'PRODUCTO',
            onChanged: (item) {},
            title: 'Producto',
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            readOnly: true,
            initialValue: widget.data.tasaInteresCorriente
                .toString()
                .toNullIfEmptyOrZero(),
            title: 'Interés Corriente %',
            icon: Icon(
              Icons.percent_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          CustomSwitch(
            title: 'Mantener Tasa interés de crédito anterior',
            subtitle: '',
            value: false,
            onChanged: (v) {},
          ),
          const Divider(),
          OutlineTextfieldWidget(
            readOnly: true,
            initialValue:
                widget.data.plazoSolicitud.toString().toNullIfEmptyOrZero(),
            title: 'Plazo en meses',
            icon: Icon(
              Icons.schedule_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            readOnly: true,
            initialValue: widget.data.montoSinComision?.toCurrencyString(),
            title: 'Monto de aprobación',
            icon: Icon(
              Icons.payments_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            readOnly: true,
            initialValue: DateTime.now().toLocal().selectorFormat(),
            title: 'Fecha de desembolso',
            icon: Icon(
              Icons.event_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            hintText: fechaPrimerPago?.selectorFormat(),
            title: 'Fecha de primer pago',
            onTap: () async {
              final date = await pickDate(context);
              if (date == null) return;
              setState(() {
                fechaPrimerPago = date;
              });
            },
            readOnly: true,
            icon: Icon(
              Icons.calendar_today_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            readOnly: true,
            hintText: fechaVencimiento?.selectorFormat(),
            onTap: () async {
              final date = await pickDate(context);
              if (date == null) return;
              setState(() {
                fechaVencimiento = date;
              });
            },
            title: 'Fecha de vencimiento',
            icon: Icon(
              Icons.event_busy_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
        ],
      ),
    );
  }
}

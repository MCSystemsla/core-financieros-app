import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_solicitud_response.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/switch/custom_switch.dart';
import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ComiteDatosDelCreditoForm extends StatelessWidget {
  final ComiteSolicitudData data;

  const ComiteDatosDelCreditoForm({
    super.key,
    required this.data,
  });

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
          OutlineTextfieldWidget(
            title: 'Producto',
            icon: Icon(
              Icons.category_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            initialValue:
                data.tasaInteresCorriente.toString().toNullIfEmptyOrZero(),
            title: 'Interés Corriente %',
            icon: Icon(
              Icons.percent_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
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
            initialValue: data.plazoSolicitud.toString().toNullIfEmptyOrZero(),
            title: 'Plazo en meses',
            icon: Icon(
              Icons.schedule_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Monto de aprobación',
            icon: Icon(
              Icons.payments_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Fecha de desembolso',
            icon: Icon(
              Icons.event_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            initialValue: data.fechaPrimerPagoAprobacion?.selectorFormat(),
            title: 'Fecha de primer pago',
            icon: Icon(
              Icons.calendar_today_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          OutlineTextfieldWidget(
            title: 'Fecha de vencimiento',
            icon: Icon(
              Icons.event_busy_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
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

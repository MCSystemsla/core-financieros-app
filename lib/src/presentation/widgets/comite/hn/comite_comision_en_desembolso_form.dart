import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_solicitud_response.dart';
import 'package:core_financiero_app/src/presentation/widgets/comite/hn/comite_servicios_acta_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_card_list_hn.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:gap/gap.dart';

class ComiteComisionEnDesembolsoForm extends StatelessWidget {
  final int numeroSolicitud;
  final ComiteSolicitudData data;

  const ComiteComisionEnDesembolsoForm({
    super.key,
    required this.data,
    required this.numeroSolicitud,
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
              'Comisión en desembolso en Lempiras',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            initialValue:
                data.tasaComision?.toCurrencyString().toNullIfEmptyOrZero(),
            title: 'Tasa %',
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
          OutlineTextfieldWidget(
            initialValue:
                data.montoSinComision?.toCurrencyString().toNullIfEmptyOrZero(),
            title: 'Monto',
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
            initialValue: data.monto?.toCurrencyString().toNullIfEmptyOrZero(),
            title: 'Monto de comisión',
            icon: Icon(
              Icons.request_quote_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(20),
          AnalisisCardListHn(
            title: 'Cobros de servicios',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ComiteServiciosActaWidget(
                    comiteId: data.id ?? 0,
                    numeroSolicitud: numeroSolicitud,
                    capitalAdeudado: 0,
                    montoCredito: data.monto?.toDouble() ?? 0,
                    plazoCredito: data.plazoSolicitud ?? 0,
                    primaSegurosDanios: 0,
                    esCreditoHipotecario: false,
                    esDPF: false,
                    esGrupal: false,
                    esMayorA60: false,
                  ),
                ),
              );
            },
            items: [
              AnalisisCardItem(
                icon: Icons.business_center_outlined,
                label: 'Calculo de servicios',
                value: '',
                color: Colors.indigo,
              ),
            ],
          ),
          const Gap(20),
        ],
      ),
    );
  }
}

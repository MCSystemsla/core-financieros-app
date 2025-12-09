import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_solicitud_response.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/utils/extensions/string/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ComiteParametrosForm2 extends StatelessWidget {
  final ComiteSolicitudData data;

  const ComiteParametrosForm2({
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
              'Parametros',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            initialValue: data.monedaCodigo,
            title: 'Moneda de desembolso',
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            initialValue: data.estadoComiteCodigo,
            title: 'Estado',
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            initialValue: data.formaDePagoCodigo,
            title: 'Forma de pago',
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            initialValue: data.periodicidadCodigo,
            title: 'Periodicidad principal',
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            initialValue: data.periodoGracia.toString().toNullIfEmptyOrZero(),
            title: 'Periodicidad interes',
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            initialValue: data.sectorCodigo,
            title: 'Sector',
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            initialValue: data.actividadCodigo,
            title: 'Actividad',
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            initialValue: data.nombrePromotor,
            title: 'Promotor',
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            initialValue: data.fuenteFinanciamientoCodigo,
            title: 'Fuente de financiamiento',
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            initialValue: data.periodoGracia.toString().toNullIfEmptyOrZero(),
            title: 'Periodo de gracia',
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            initialValue: data.tipoCreditoNombre,
            title: 'Tipo de crédito',
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            initialValue: data.tipoProgramaCodigo,
            title: 'Programa',
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppColors.getPrimaryColor(),
            ),
            validator: (value) => ClassValidator.validateRequired(value),
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            onChange: (value) {},
          ),
          const Gap(12),
          OutlineTextfieldWidget(
            initialValue: data.observacion,
            title: 'Observaciones',
            icon: Icon(
              Icons.inventory_2_outlined,
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

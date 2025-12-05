import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ComiteParametrosForm2 extends StatelessWidget {
  const ComiteParametrosForm2({
    super.key,
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

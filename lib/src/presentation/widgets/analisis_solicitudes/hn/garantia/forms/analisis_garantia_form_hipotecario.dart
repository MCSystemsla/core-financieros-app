import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/catalogo/catalogo_valor_nacionalidad.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:gap/gap.dart';

class AnalisisGarantiaFormHipotecario extends StatefulWidget {
  const AnalisisGarantiaFormHipotecario({super.key});

  @override
  State<AnalisisGarantiaFormHipotecario> createState() =>
      _AnalisisGarantiaFormHipotecarioState();
}

class _AnalisisGarantiaFormHipotecarioState
    extends State<AnalisisGarantiaFormHipotecario> {
  String? departamento;
  String? municipio;
  String? aldea;
  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Container(
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
            const Gap(20),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 20),
              child: Text(
                'Ingresa los datos requeridos',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SheetSearchDropdown(
              title: 'Tipo de Garantia',
              isRequired: false,
              onChanged: (v) {},
              hintText: 'input.select_option'.tr(),
              enabled: true,
              items: const [
                Item(name: 'Casa Urbana', value: 'Casa Urbana'),
                Item(name: 'Terreno Urbano', value: 'Terreno Urbano'),
                Item(name: 'Casa Rural', value: 'Casa Rural'),
                Item(name: 'Terreno Rural', value: 'Terreno Rural'),
              ],
            ),
            const Gap(12),
            OutlineTextfieldWidget(
              title: 'Direccion',
              icon: Icon(
                Icons.receipt_long,
                color: AppColors.getPrimaryColor(),
              ),
              textInputType: TextInputType.number,
              validator: (value) => ClassValidator.validateRequired(value),
              inputFormatters: [
                CurrencyInputFormatter(mantissaLength: 0),
              ],
              onChange: (value) {},
            ),
            const Gap(12),
            CatalogoValorNacionalidad(
              hintText: 'input.select_option'.tr(),
              title: 'Departamento',
              onChanged: (v) {
                if (v == null) return;
                setState(() {
                  departamento = v.valor;
                });
              },
              codigo: 'DEP',
              where: 'HN',
            ),
            const Gap(12),
            CatalogoValorNacionalidad(
              hintText: 'input.select_option'.tr(),
              title: 'Municipio',
              onChanged: (v) {
                if (v == null) return;
                setState(() {
                  municipio = v.valor;
                });
              },
              codigo: 'MUN',
              where: departamento,
            ),
            const Gap(12),
            CatalogoValorNacionalidad(
              hintText: 'input.select_option'.tr(),
              title: 'Aldea',
              onChanged: (v) {
                if (v == null) return;
                setState(() {
                  aldea = v.valor;
                });
              },
              codigo: 'ALD',
              where: municipio,
            ),
            const Gap(12),
            OutlineTextfieldWidget(
              title: 'Valor Avaluo',
              icon: Icon(
                Icons.receipt_long,
                color: AppColors.getPrimaryColor(),
              ),
              textInputType: TextInputType.number,
              validator: (value) => ClassValidator.validateRequired(value),
              inputFormatters: [
                CurrencyInputFormatter(mantissaLength: 0),
              ],
              onChange: (value) {},
            ),
            const Gap(12),
            OutlineTextfieldWidget(
              title: 'Valor Comercial',
              icon: Icon(
                Icons.receipt_long,
                color: AppColors.getPrimaryColor(),
              ),
              textInputType: TextInputType.number,
              validator: (value) => ClassValidator.validateRequired(value),
              inputFormatters: [
                CurrencyInputFormatter(mantissaLength: 0),
              ],
              onChange: (value) {},
            ),
            const Gap(12),
            OutlineTextfieldWidget(
              title: 'Evaluador',
              icon: Icon(
                Icons.receipt_long,
                color: AppColors.getPrimaryColor(),
              ),
              textInputType: TextInputType.number,
              validator: (value) => ClassValidator.validateRequired(value),
              inputFormatters: [
                CurrencyInputFormatter(mantissaLength: 0),
              ],
              onChange: (value) {},
            ),
            const Gap(12),
            OutlineTextfieldWidget(
              title: 'No De Escritura',
              icon: Icon(
                Icons.receipt_long,
                color: AppColors.getPrimaryColor(),
              ),
              textInputType: TextInputType.number,
              validator: (value) => ClassValidator.validateRequired(value),
              inputFormatters: [
                CurrencyInputFormatter(mantissaLength: 0),
              ],
              onChange: (value) {},
            ),
            const Gap(12),
            OutlineTextfieldWidget(
              title: 'No. Tomo',
              icon: Icon(
                Icons.receipt_long,
                color: AppColors.getPrimaryColor(),
              ),
              textInputType: TextInputType.number,
              validator: (value) => ClassValidator.validateRequired(value),
              inputFormatters: [
                CurrencyInputFormatter(mantissaLength: 0),
              ],
              onChange: (value) {},
            ),
            const Gap(12),
            OutlineTextfieldWidget(
              title: 'Folio',
              icon: Icon(
                Icons.receipt_long,
                color: AppColors.getPrimaryColor(),
              ),
              textInputType: TextInputType.number,
              validator: (value) => ClassValidator.validateRequired(value),
              inputFormatters: [
                CurrencyInputFormatter(mantissaLength: 0),
              ],
              onChange: (value) {},
            ),
            const Gap(12),
            OutlineTextfieldWidget(
              title: 'Fecha de inscripcion',
              icon: Icon(
                Icons.receipt_long,
                color: AppColors.getPrimaryColor(),
              ),
              textInputType: TextInputType.number,
              validator: (value) => ClassValidator.validateRequired(value),
              inputFormatters: [
                CurrencyInputFormatter(mantissaLength: 0),
              ],
              onChange: (value) {},
            ),
            const Gap(12),
            OutlineTextfieldWidget(
              title: 'Vrs2',
              icon: Icon(
                Icons.receipt_long,
                color: AppColors.getPrimaryColor(),
              ),
              textInputType: TextInputType.number,
              validator: (value) => ClassValidator.validateRequired(value),
              inputFormatters: [
                CurrencyInputFormatter(mantissaLength: 0),
              ],
              onChange: (value) {},
            ),
            const Gap(12),
            OutlineTextfieldWidget(
              title: 'Mts2',
              icon: Icon(
                Icons.receipt_long,
                color: AppColors.getPrimaryColor(),
              ),
              textInputType: TextInputType.number,
              validator: (value) => ClassValidator.validateRequired(value),
              inputFormatters: [
                CurrencyInputFormatter(mantissaLength: 0),
              ],
              onChange: (value) {},
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: CustomElevatedButton(
                // enabled: state.status != Status.inProgress,
                // text: state.status == Status.inProgress
                // ? 'Creando...'
                // : 'Crear',
                text: 'Crear',
                // ignore: deprecated_member_use
                color: AppColors.greenLatern.withOpacity(0.4),
                onPressed: () {
                  // if (!formKey.currentState!.validate()) return;
                },
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

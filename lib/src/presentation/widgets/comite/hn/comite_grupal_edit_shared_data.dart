import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/select_date/select_date_helper.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_frecuencia_pago_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/search_dropdown_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/tipos_credito_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/expandable/custom_expandable.dart';
import 'package:core_financiero_app/src/utils/extensions/catalogo_type/catalogo_type.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ComiteGrupalEditSharedData extends StatelessWidget {
  const ComiteGrupalEditSharedData({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomExpandable(
        title: 'Editar Datos de acta compartida',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 20),
              child: Text(
                'Datos del crédito',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const Gap(12),
            SearchDropdownWidget(
              // selectedItem: Item(
              //   name: productoNombre ?? '',
              //   value: productoCodigo,
              // ),
              codigo: 'PRODUCTO',
              onChanged: (item) {
                if (item == null) return;
                // productoCodigo = item.value;
                // calculosCubit.onFieldChanged(
                //   () => calculosCubit.state.copyWith(
                //     productoCodigo: item.value,
                //   ),
                // );
                // cubit.onFieldChanged(
                //   () => cubit.state.copyWith(
                //     productoCodigo: item.value,
                //   ),
                // );
              },
              title: 'Producto',
            ),
            const Divider(),
            OutlineTextfieldWidget(
              // initialValue: widget.data.plazoSolicitud
              //     .toString()
              //     .toNullIfEmptyOrZero(),
              title: 'Plazo en meses',
              icon: Icon(
                Icons.schedule_outlined,
                color: AppColors.getPrimaryColor(),
              ),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {
                // final newValue = value.replaceAll(',', '');
                // calculosCubit.onFieldChanged(
                //   () => calculosCubit.state.copyWith(
                //     plazoMeses: int.tryParse(newValue) ?? 0,
                //   ),
                // );
                // cubit.onFieldChanged(
                //   () => cubit.state.copyWith(
                //     plazo: int.tryParse(newValue) ?? 0,
                //   ),
                // );
              },
            ),
            const Gap(20),
            OutlineTextfieldWidget(
              // hintText: fechaPrimerPago?.selectorFormat(),
              title: 'Fecha de primer pago',
              // validator: (value) => ClassValidator.validateRequired(
              //     fechaPrimerPago?.selectorFormat()),
              onTap: () async {
                final date = await pickDate(context);
                if (date == null) return;
                // calculosCubit.onFieldChanged(
                //   () => calculosCubit.state.copyWith(
                //     fechaPrimerPago: date.toUtc().toIso8601String(),
                //   ),
                // );

                // setState(() {
                //   fechaPrimerPago = date;
                // });
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
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 20),
              child: Text(
                'Parametros',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const Gap(12),
            SearchDropdownWidget(
              isRequired: true,
              codigo: 'MONEDA',
              enabled: true,
              title: 'Moneda de desembolso',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              onChanged: (item) {
                if (item == null) return;
              },
            ),
            const Gap(12),
            SearchDropdownWidget(
              isRequired: true,
              codigo: CatalogoType.tipoDesembolsos.codigo,
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              enabled: true,
              title: 'Tipo Desembolso',
              onChanged: (item) {
                if (item == null) return;
              },
            ),
            const Gap(12),
            CatalogoFrecuenciaPagoDropdown(
              isRequired: true,
              title: 'Forma de pago',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.valor),
              onChanged: (value) {
                if (value == null) return;
              },
            ),
            const Gap(12),
            CatalogoFrecuenciaPagoDropdown(
              isRequired: true,
              title: 'Periodicidad principal',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.valor),
              onChanged: (value) {
                if (value == null) return;
                // cubit.onFieldChanged(
                //   () => cubit.state.copyWith(
                //     periodicidadPrinicipalCodigo: value.valor,
                //   ),
                // );
              },
            ),
            const Gap(12),
            CatalogoFrecuenciaPagoDropdown(
              isRequired: true,
              onChanged: (item) {
                if (item == null) return;
                // cubit.onFieldChanged(
                //   () => cubit.state.copyWith(
                //     periodicidadInteresCodigo: item.valor,
                //   ),
                // );
              },
              title: 'Periodicidad interes',
              validator: (value) =>
                  ClassValidator.validateRequired(value?.valor),
            ),
            const Gap(12),
            TiposCreditoDropdown(
              // selectedItem: tipoCredito,
              isRequired: true,
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value.toString()),
              onChanged: (item) {
                if (item == null) return;
                // cubit.onFieldChanged(
                //   () => cubit.state.copyWith(
                //     tipoCreditoNombre: item.name,
                //   ),
                // );
              },
            ),
            const Gap(12),
            SearchDropdownWidget(
              isRequired: true,
              // selectedItem: programa,
              codigo: CatalogoType.programa.codigo,
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              title: 'Programa',
              onChanged: (item) {
                if (item == null) return;
                // cubit.onFieldChanged(
                //   () => cubit.state.copyWith(
                //     tipoProgramaCodigo: item.value,
                //   ),
                // );
              },
            ),
            const Gap(12),
            OutlineTextfieldWidget(
              // initialValue: observaciones,
              title: 'Observaciones',
              // validator: (value) => ClassValidator.validateRequired(value),
              icon: Icon(
                Icons.comment,
                color: AppColors.getPrimaryColor(),
              ),
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChange: (value) {
                // cubit.onFieldChanged(
                //   () => cubit.state.copyWith(
                //     observacion: value,
                //   ),
                // );
              },
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.all(15),
              child: CustomElevatedButton(
                color: Colors.indigo,
                text: 'Vincular datos a todos los integrantes',
                onPressed: () {},
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

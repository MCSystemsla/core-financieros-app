// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/catalogo_frecuencia_pago/catalogo_frecuencia_pago.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:gap/gap.dart';

class CatalogoFrecuenciaPagoDropdown extends StatelessWidget {
  final String title;
  final bool isRequired;
  final ItemCallback<CatalogoFrecuenciaItem> onChanged;
  final ValidatorCallback<CatalogoFrecuenciaItem> validator;
  final String hintText;
  final bool enabled;

  const CatalogoFrecuenciaPagoDropdown({
    super.key,
    required this.title,
    this.isRequired = false,
    required this.onChanged,
    this.validator,
    this.hintText = 'Selecciona una opción',
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final FocusNode dropdownFocus = FocusNode();

    final localDbProvider = global<ObjectBoxService>();
    final items = localDbProvider.getCatalogoFrecuenciaPago().map((e) {
      return CatalogoFrecuenciaItem(
        valor: e.valor,
        nombre: e.nombre,
        meses: e.meses,
      );
    }).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(5),
          Text(
            '$title ${isRequired ? '*' : ''}',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const Gap(15),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: DropdownSearch<CatalogoFrecuenciaItem>(
              enabled: enabled,
              validator: validator,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  hintText:
                      hintText.isEmpty ? 'input.select_option'.tr() : hintText,
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              popupProps: PopupProps.menu(
                onDismissed: () {
                  FocusScope.of(context).requestFocus(dropdownFocus);
                },
                showSearchBox: true,
                searchFieldProps: const TextFieldProps(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Buscar',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              items: items,
              itemAsString: (CatalogoFrecuenciaItem? item) =>
                  item?.nombre ?? 'N/A',
              onChanged: onChanged,
              // selectedItem: CatalogoFrecuenciaItem(
              //   valor: '',
              //   nombre: '',
              //   meses: '',
              // ),
            ),
          ),
        ],
      ),
    );
  }
}

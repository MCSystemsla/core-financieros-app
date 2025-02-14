import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SearchDropdownWidget extends StatelessWidget {
  final String codigo;
  final String title;
  final bool isRequired;

  const SearchDropdownWidget({
    super.key,
    required this.codigo,
    required this.title,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();
    final items =
        localDbProvider.findParentescosByNombre(type: codigo).map((e) {
      return Item(
        value: e.valor,
        name: e.nombre,
      );
    }).toList();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: DropdownSearch<Item>(
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        popupProps: const PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              labelText: 'Buscar',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ),
        items: items,
        itemAsString: (Item? item) => item?.name ?? 'N/A',
        onChanged: print,
        selectedItem:
            Item(name: '$title ${isRequired ? '*' : ''}', value: null),
      ),
    );
  }
}

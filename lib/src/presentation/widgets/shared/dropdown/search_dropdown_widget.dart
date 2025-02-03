import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SearchDropdownWidget extends StatelessWidget {
  const SearchDropdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();
    final items = localDbProvider
        .findParentescosByNombre(type: 'RUBROACTIVIDAD')
        .map((e) {
      return Item(
        value: e.valor,
        name: e.nombre,
      );
    }).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: DropdownSearch<Item>(
        popupProps: const PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              labelText: 'Buscar país',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        items: items,
        itemAsString: (Item? item) => item?.name ?? 'N/A',
        onChanged: print,
        selectedItem: const Item(name: 'Seleccionar', value: null),
      ),
    );
  }
}

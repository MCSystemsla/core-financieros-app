// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CatalogoProductoDropdown extends StatefulWidget {
  final String title;
  final bool isRequired;
  final bool isRecurrente;
  final ItemCallback<Item> onChanged;
  final ValidatorCallback<Item> validator;
  final String hintText;
  final bool enabled;
  final Item? selectedItem;

  const CatalogoProductoDropdown({
    super.key,
    required this.title,
    this.isRequired = false,
    required this.onChanged,
    this.validator,
    this.hintText = 'Selecciona una opción',
    this.enabled = true,
    this.isRecurrente = false,
    this.selectedItem,
  });

  @override
  State<CatalogoProductoDropdown> createState() =>
      _CatalogoProductoDropdownState();
}

class _CatalogoProductoDropdownState extends State<CatalogoProductoDropdown> {
  Item? selectedItem;
  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    final uuid = const Uuid().v4();

    final localDbProvider = global<ObjectBoxService>();
    final items = localDbProvider
        .getCatalogoProductos(isRecurrente: widget.isRecurrente)
        .map((e) {
      return Item(
        id: uuid,
        value: e.valor,
        name: e.nombre,
        interes: e.interes ?? 0,
        montoMaximo: e.montoMaximo ?? 0,
        montoMinimo: e.montoMinimo ?? 0,
      );
    }).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: OutlineTextfieldWidget(
        readOnly: true,
        title: widget.title,
        suffixIcon: const Icon(
          Icons.keyboard_arrow_down,
          size: 30,
        ),
        hintText: (selectedItem?.name.isNotEmpty ?? false)
            ? selectedItem!.name
            : widget.hintText,
        validator: (_) {
          // Aquí solo usamos tu validator directamente
          return widget.validator?.call(selectedItem);
        },
        onTap: !widget.enabled
            ? null
            : () {
                DropDownState<Item>(
                  dropDown: DropDown<Item>(
                    searchDelegate: (query, dataItems) {
                      if (query.isEmpty) return dataItems;

                      return dataItems
                          .where((item) => item.data.name
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                          .toList();
                    },
                    enableMultipleSelection: false,
                    bottomSheetTitle: const Text(
                      'Selecciona una opción',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    listItemBuilder: (index, dataItem) {
                      return ListTile(
                        title: Text(
                          dataItem.data.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                      );
                    },
                    data: [
                      ...items.map(
                        (e) {
                          return SelectedListItem<Item>(
                              data: Item(
                            name: e.name,
                            value: e.value,
                            interes: e.interes,
                            montoMaximo: e.montoMaximo,
                            montoMinimo: e.montoMinimo,
                            id: e.id,
                          ));
                        },
                      )
                    ],
                    onSelected: (selectedItems) {
                      for (var item in selectedItems) {
                        setState(() {
                          selectedItem = item.data;
                        });
                        widget.onChanged.call(item.data);
                      }
                    },
                  ),
                ).showModal(context);
              },
      ),
    );
  }
}
// class CatalogoProductoDropdown extends StatelessWidget {
//   final String title;
//   final bool isRequired;
//   final bool isRecurrente;
//   final ItemCallback<Item> onChanged;
//   final ValidatorCallback<Item> validator;
//   final String hintText;
//   final bool enabled;

//   const CatalogoProductoDropdown({
//     super.key,
//     required this.title,
//     this.isRequired = false,
//     required this.onChanged,
//     this.validator,
//     this.hintText = 'Selecciona una opción',
//     this.enabled = true,
//     this.isRecurrente = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final uuid = const Uuid().v4();

//     final FocusNode dropdownFocus = FocusNode();

//     final localDbProvider = global<ObjectBoxService>();
//     final items = localDbProvider
//         .getCatalogoProductos(isRecurrente: isRecurrente)
//         .map((e) {
//       return Item(
//         id: uuid,
//         value: e.valor,
//         name: e.nombre,
//         interes: e.interes ?? 0,
//         montoMaximo: e.montoMaximo ?? 0,
//         montoMinimo: e.montoMinimo ?? 0,
//       );
//     }).toList();
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Gap(5),
//           Text(
//             '$title ${isRequired ? '*' : ''}',
//             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//           ),
//           const Gap(15),
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 8,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: DropdownSearch<Item>(
//               enabled: enabled,
//               validator: validator,
//               dropdownDecoratorProps: DropDownDecoratorProps(
//                 dropdownSearchDecoration: InputDecoration(
//                   hintText:
//                       hintText.isEmpty ? 'input.select_option'.tr() : hintText,
//                   fillColor: Colors.white,
//                   filled: true,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               popupProps: PopupProps.menu(
//                 onDismissed: () {
//                   FocusScope.of(context).requestFocus(dropdownFocus);
//                 },
//                 showSearchBox: true,
//                 searchFieldProps: const TextFieldProps(
//                   autofocus: false,
//                   decoration: InputDecoration(
//                     labelText: 'Buscar',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                     ),
//                   ),
//                 ),
//               ),
//               items: items,
//               itemAsString: (Item? item) => item?.name ?? 'N/A',
//               onChanged: onChanged,
//               selectedItem: Item(
//                   name:
//                       hintText.isEmpty ? 'input.select_option'.tr() : hintText,
//                   value: hintText),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

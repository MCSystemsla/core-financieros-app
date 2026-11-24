// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/catalogo_items.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:drop_down_list/drop_down_list.dart';

class SearchDropdownWidget extends StatefulWidget {
  final String codigo;
  final String title;
  final bool isRequired;
  final ItemCallback<Item> onChanged;
  final ValidatorCallback<Item> validator;
  final String hintText;
  final bool enabled;
  final Item? selectedItem;
  final Flavor flavor;

  const SearchDropdownWidget({
    super.key,
    required this.codigo,
    required this.title,
    this.isRequired = false,
    required this.onChanged,
    this.validator,
    this.hintText = 'Selecciona una opción',
    this.enabled = true,
    this.selectedItem,
    this.flavor = Flavor.nicaragua,
  });

  @override
  State<SearchDropdownWidget> createState() => _SearchDropdownWidgetState();
}

class _SearchDropdownWidgetState extends State<SearchDropdownWidget> {
  Item? selectedItem;
  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    final items = itemsDeCatalogo(widget.codigo);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: OutlineTextfieldWidget(
        readOnly: true,
        title: '${widget.title}*',
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

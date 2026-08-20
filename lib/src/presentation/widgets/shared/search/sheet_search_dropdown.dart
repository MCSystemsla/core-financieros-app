import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';

class SheetSearchDropdown extends StatefulWidget {
  final String title;
  final bool isRequired;
  final ItemCallback<Item> onChanged;
  final ValidatorCallback<Item> validator;
  final String hintText;
  final bool enabled;
  final Item? selectedItem;
  final List<Item> items;
  final bool isLoading;
  const SheetSearchDropdown({
    super.key,
    required this.title,
    required this.isRequired,
    required this.onChanged,
    this.validator,
    required this.hintText,
    required this.enabled,
    this.selectedItem,
    required this.items,
    this.isLoading = false,
  });

  @override
  State<SheetSearchDropdown> createState() => _SheetSearchDropdownState();
}

class _SheetSearchDropdownState extends State<SheetSearchDropdown> {
  Item? selectedItem;
  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: OutlineTextfieldWidget(
        readOnly: true,
        title: widget.title,
        suffixIcon: widget.isLoading
            ? const Padding(
                padding: EdgeInsets.all(12),
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : const Icon(
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
        onTap: !widget.enabled || widget.isLoading
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
                      ...widget.items.map(
                        (e) {
                          return SelectedListItem<Item>(
                              data: Item(
                            name: e.name,
                            value: e.value,
                            interes: e.interes,
                            montoMaximo: e.montoMaximo,
                            montoMinimo: e.montoMinimo,
                            id: e.id,
                            anotherValue: e.anotherValue,
                          ));
                        },
                      )
                    ],
                    onSelected: (selectedItems) {
                      for (var item in selectedItems) {
                        setState(() {
                          selectedItem = item.data;
                          widget.onChanged.call(item.data);
                        });
                      }
                    },
                  ),
                ).showModal(context);
              },
      ),
    );
  }
}

class ActiivdadCNBS {
  final String nombre;
  final String valor;
  final bool esAPNFD;

  ActiivdadCNBS({
    required this.nombre,
    required this.valor,
    required this.esAPNFD,
  });
}

class CatalogoActividadesCNBSDropdown extends StatefulWidget {
  final String title;
  final bool isRequired;
  final ItemCallback<ActiivdadCNBS> onChanged;
  final ValidatorCallback<ActiivdadCNBS> validator;
  final String hintText;
  final bool enabled;
  final ActiivdadCNBS? selectedItem;
  const CatalogoActividadesCNBSDropdown({
    super.key,
    required this.title,
    required this.isRequired,
    required this.onChanged,
    this.validator,
    required this.hintText,
    required this.enabled,
    this.selectedItem,
  });

  @override
  State<CatalogoActividadesCNBSDropdown> createState() =>
      _CatalogoActividadesCNBSDropdownState();
}

class _CatalogoActividadesCNBSDropdownState
    extends State<CatalogoActividadesCNBSDropdown> {
  ActiivdadCNBS? selectedItem;
  final localDbProvider = global<SolicitudesHnBoxService>();

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    final catalogosCnbs = localDbProvider.catalogoActividadCnbsBox.getAll();
    final itemsCatalogos = catalogosCnbs.map((e) {
      return ActiivdadCNBS(
        nombre: e.nombre,
        valor: e.valor,
        esAPNFD: e.isApnfd ?? false,
      );
    }).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: OutlineTextfieldWidget(
        readOnly: true,
        title: '${widget.title} ${widget.isRequired ? '*' : ''}',
        suffixIcon: const Icon(
          Icons.keyboard_arrow_down,
          size: 30,
        ),
        hintText: (selectedItem?.nombre.isNotEmpty ?? false)
            ? selectedItem!.nombre
            : widget.hintText,
        validator: (_) {
          // Aquí solo usamos tu validator directamente
          return widget.validator?.call(selectedItem);
        },
        onTap: !widget.enabled
            ? null
            : () {
                DropDownState<ActiivdadCNBS>(
                  dropDown: DropDown<ActiivdadCNBS>(
                    searchDelegate: (query, dataItems) {
                      if (query.isEmpty) return dataItems;

                      return dataItems
                          .where((item) => item.data.nombre
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
                          dataItem.data.nombre,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                      );
                    },
                    data: [
                      ...itemsCatalogos.map(
                        (e) {
                          return SelectedListItem<ActiivdadCNBS>(
                              data: ActiivdadCNBS(
                            nombre: e.nombre,
                            valor: e.valor,
                            esAPNFD: e.esAPNFD,
                          ));
                        },
                      )
                    ],
                    onSelected: (selectedItems) {
                      for (var item in selectedItems) {
                        setState(() {
                          selectedItem = item.data;
                          widget.onChanged.call(item.data);
                        });
                      }
                    },
                  ),
                ).showModal(context);
              },
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ItemNacionalidad extends Equatable {
  final int id;
  final String valor;
  final String nombre;
  final String relacion;

  const ItemNacionalidad({
    required this.id,
    required this.valor,
    required this.nombre,
    required this.relacion,
  });
  @override
  List<Object?> get props => [
        id,
        valor,
        nombre,
        relacion,
      ];
}

class CatalogoValorNacionalidad extends StatefulWidget {
  final String hintText;
  final String title;
  final ItemCallback<ItemNacionalidad> onChanged;
  final String codigo;
  final String? where;
  final ItemNacionalidad? selectedItem;
  final ValidatorCallback<ItemNacionalidad> validator;
  final bool enabled;
  const CatalogoValorNacionalidad({
    super.key,
    required this.hintText,
    required this.title,
    required this.onChanged,
    required this.codigo,
    this.where,
    this.selectedItem,
    this.validator,
    this.enabled = true,
  });

  @override
  State<CatalogoValorNacionalidad> createState() =>
      _CatalogoValorNacionalidadState();
}

class _CatalogoValorNacionalidadState extends State<CatalogoValorNacionalidad> {
  // late String value;
  late String whereClause;
  ItemNacionalidad? selectedItem;
  @override
  void didUpdateWidget(covariant CatalogoValorNacionalidad oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.where != widget.where) {
      setState(() {
        whereClause = widget.where ?? '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // value = widget.initialValue;
    whereClause = widget.where ?? '';
    selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();
    final items = localDbProvider.getNacionalidadPaises(
      codigo: widget.codigo,
      whereClause: whereClause,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: OutlineTextfieldWidget(
        readOnly: true,
        title: widget.title,
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
                DropDownState<ItemNacionalidad>(
                  dropDown: DropDown<ItemNacionalidad>(
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
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                      );
                    },
                    data: [
                      ...items.map(
                        (e) {
                          return SelectedListItem<ItemNacionalidad>(
                            data: ItemNacionalidad(
                              id: e.id,
                              valor: e.valor,
                              nombre: e.nombre,
                              relacion: e.relacion,
                            ),
                          );
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

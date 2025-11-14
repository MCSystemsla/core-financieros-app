// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/catalogo_frecuencia_pago/catalogo_frecuencia_pago.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/ni/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';

class CatalogoFrecuenciaPagoDropdown extends StatefulWidget {
  final String title;
  final bool isRequired;
  final ItemCallback<CatalogoFrecuenciaItem> onChanged;
  final ValidatorCallback<CatalogoFrecuenciaItem> validator;
  final String hintText;
  final bool enabled;
  final CatalogoFrecuenciaItem? selectedItem;

  const CatalogoFrecuenciaPagoDropdown({
    super.key,
    required this.title,
    this.isRequired = false,
    required this.onChanged,
    this.validator,
    this.hintText = 'Selecciona una opción',
    this.enabled = true,
    this.selectedItem,
  });

  @override
  State<CatalogoFrecuenciaPagoDropdown> createState() =>
      _CatalogoFrecuenciaPagoDropdownState();
}

class _CatalogoFrecuenciaPagoDropdownState
    extends State<CatalogoFrecuenciaPagoDropdown> {
  CatalogoFrecuenciaItem? selectedItem;
  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    final flavor = global<FlavorCubit>().state.flavor;

    final localDbProvider = global<ObjectBoxService>();
    final localDbProviderHn = global<SolicitudesHnBoxService>();
    final items = switch (flavor) {
      Flavor.nicaragua => localDbProvider.getCatalogoFrecuenciaPago().map((e) {
          return CatalogoFrecuenciaItem(
            valor: e.valor,
            nombre: e.nombre,
            meses: e.meses,
          );
        }).toList(),
      Flavor.costaRica => localDbProvider.getCatalogoFrecuenciaPago().map((e) {
          return CatalogoFrecuenciaItem(
            valor: e.valor,
            nombre: e.nombre,
            meses: e.meses,
          );
        }).toList(),
      Flavor.honduras => localDbProviderHn.getCatalogoFrecuenciaPago().map(
          (e) {
            return CatalogoFrecuenciaItem(
              valor: e.valor,
              nombre: e.nombre,
              meses: e.meses,
            );
          },
        ).toList(),
      _ => [],
    };
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
                DropDownState<CatalogoFrecuenciaItem>(
                  dropDown: DropDown<CatalogoFrecuenciaItem>(
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
                          return SelectedListItem<CatalogoFrecuenciaItem>(
                            data: CatalogoFrecuenciaItem(
                              nombre: e.nombre,
                              valor: e.valor,
                              meses: e.meses,
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

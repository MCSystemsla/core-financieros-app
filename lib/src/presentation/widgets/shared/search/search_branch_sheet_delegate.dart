import 'package:core_financiero_app/src/domain/entities/responses/branch_team_response.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';

class SearchBranchSheetDelegate extends StatefulWidget {
  final String title;
  final bool isRequired;
  final ItemCallback<Branch> onChanged;
  final ValidatorCallback<Branch> validator;
  final String hintText;
  final bool enabled;
  final Branch? selectedItem;
  final List<Branch> items;
  final bool isLoading;
  const SearchBranchSheetDelegate({
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
  State<SearchBranchSheetDelegate> createState() =>
      _SearchBranchSheetDelegateState();
}

class _SearchBranchSheetDelegateState extends State<SearchBranchSheetDelegate> {
  Branch? selectedItem;
  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? const Center(
            child: SizedBox.square(
              dimension: 25,
              child: CircularProgressIndicator(),
            ),
          )
        : OutlineTextfieldWidget(
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              size: 30,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            // icon: const Icon(Icons.work),
            readOnly: true,
            title: widget.title,
            hintText: (selectedItem?.nombre.isNotEmpty ?? false)
                ? selectedItem!.nombre
                : widget.hintText,
            validator: (_) {
              return widget.validator?.call(selectedItem);
            },
            onTap: !widget.enabled
                ? null
                : () {
                    DropDownState<Branch>(
                      dropDown: DropDown<Branch>(
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
                          'Selecciona una sucursal',
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
                            trailing:
                                const Icon(Icons.arrow_forward_ios, size: 14),
                          );
                        },
                        data: [
                          ...widget.items.map(
                            (e) {
                              return SelectedListItem<Branch>(
                                  data: Branch(
                                id: e.id,
                                nombre: e.nombre,
                                nombreDb: e.nombreDb,
                              ));
                            },
                          ),
                          // SelectedListItem<Branch>(
                          //     data: Branch(
                          //   id: 39,
                          //   nombre: 'Tegucigalpa',
                          //   nombreDb: 'MC_TEGUCIGALPA_COPIA',
                          // )),
                          // SelectedListItem<Branch>(
                          //     data: Branch(
                          //   id: 45,
                          //   nombre: 'SANTA FE DEV',
                          //   nombreDb: 'MC_SF_DEV',
                          // )),
                          // SelectedListItem<Branch>(
                          //     data: Branch(
                          //   id: 28,
                          //   nombre: 'Choluteca',
                          //   nombreDb: 'MC_CH',
                          // )),
                          // SelectedListItem<Branch>(
                          //     data: Branch(
                          //   id: 21,
                          //   nombre: 'METROPOLIS',
                          //   nombreDb: 'MC_MT',
                          // )),
                          // SelectedListItem<Branch>(
                          //     data: Branch(
                          //   id: 46,
                          //   nombre: 'Santa Fe Paralelo',
                          //   nombreDb: 'MC_SF_TEST',
                          // )),
                          // SelectedListItem<Branch>(
                          //     data: Branch(
                          //   id: 5,
                          //   nombre: 'OFICINA CENTRAL',
                          //   nombreDb: 'MICREDITO_CM',
                          // ))
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
          );
  }
}

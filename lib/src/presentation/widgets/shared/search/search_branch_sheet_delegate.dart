import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/domain/entities/responses/branch_team_response.dart';
import 'package:core_financiero_app/src/presentation/widgets/auth/login/login_field_widgets.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
    _controller.text = selectedItem?.nombre ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LoginFieldLabel(widget.title),
        const Gap(8),
        TextFormField(
          controller: _controller,
          readOnly: true,
          enabled: widget.enabled || widget.isLoading,
          style: const TextStyle(fontSize: 16, color: RedesignColors.ink),
          decoration: loginInputDecoration(
            hintText: widget.hintText,
            icon: Icons.storefront_outlined,
            suffixIcon: widget.isLoading
                ? const Padding(
                    padding: EdgeInsets.all(15),
                    child: SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: loginAccent,
                      ),
                    ),
                  )
                : const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: RedesignColors.chevron,
                  ),
          ),
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
                              _controller.text = item.data.nombre;
                            });
                            widget.onChanged.call(item.data);
                          }
                        },
                      ),
                    ).showModal(context);
                  },
        ),
      ],
    );
  }
}

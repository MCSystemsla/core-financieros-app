import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/domain/entities/responses/branch_team_response.dart';
import 'package:core_financiero_app/src/presentation/widgets/auth/login/login_field_widgets.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/v2_redesign/search_dropdown_v2.dart';
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

  Future<void> _abrir() async {
    FocusScope.of(context).unfocus();
    final actual = selectedItem;

    final resultado = await mostrarSearchDropdownSheet<Branch>(
      context: context,
      titulo: widget.title,
      items: widget.items,
      toStringItem: (branch) => branch.nombre,
      esSeleccionado: actual == null
          ? null
          : (branch) => branch.nombreDb == actual.nombreDb,
      textoSinOpciones: 'No hay sucursales disponibles.',
    );

    final branch = resultado?.item;
    if (branch == null || !mounted) return;
    setState(() {
      selectedItem = branch;
      _controller.text = branch.nombre;
    });
    widget.onChanged(branch);
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
          onTap: !widget.enabled ? null : _abrir,
        ),
      ],
    );
  }
}

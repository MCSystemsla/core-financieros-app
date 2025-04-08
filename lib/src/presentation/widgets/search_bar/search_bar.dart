// ignore_for_file: prefer_final_fields, deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SearchBarCustom extends StatefulWidget {
  final void Function(String?)? onItemSelected;
  final String? initialValue;
  final void Function()? onTap;
  final void Function() onPressed;

  const SearchBarCustom({
    required this.onItemSelected,
    this.initialValue,
    required this.onPressed,
    this.onTap,
    super.key,
  });

  @override
  State<SearchBarCustom> createState() => SearchBarCustomState();
}

class SearchBarCustomState extends State<SearchBarCustom> {
  TextEditingController _controller = TextEditingController();
  late bool _isEmpty;

  @override
  void initState() {
    _controller.text = widget.initialValue ?? '';
    _isEmpty = _controller.text.isEmpty;

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 1,
        color: AppColors.grey.withOpacity(0.5),
      ),
    );

    return GestureDetector(
      onTap: widget.onTap,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        enabled: widget.onTap == null,
        onTap: widget.onTap,
        controller: _controller,
        onChanged: (value) {
          final finalValue = value.isEmpty ? null : value;
          widget.onItemSelected?.call(finalValue);
          setState(() {
            _isEmpty = _controller.text.isEmpty;
          });
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          isDense: true,
          prefixIcon: Container(
            margin: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.search,
              color: AppColors.greyWithOpacityV4,
              size: 20,
            ),
          ),
          suffixIcon: _isEmpty
              ? const SizedBox()
              : IconButton(
                  icon: const Icon(Icons.close),
                  color: AppColors.grey.withOpacity(0.5),
                  onPressed: () {
                    widget.onPressed();
                    _controller.clear();
                    setState(() {
                      _isEmpty = _controller.text.isEmpty;
                    });
                  },
                ),
          hintText: 'Ingresa nombre de Cliente',
          border: border,
          errorBorder: border,
          disabledBorder: border,
          focusedBorder: border,
          enabledBorder: border,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          hintStyle:
              TextStyle(color: AppColors.greyWithOpacityV4, fontSize: 15),
        ),
        autocorrect: false,
      ),
    );
  }
}

class SearchableItem {
  final String id;
  final String name;

  const SearchableItem({required this.id, required this.name});
}

class Filter extends StatelessWidget {
  final List<PopupMenuEntry<dynamic>> itemsPopUp;
  const Filter({super.key, required this.itemsPopUp});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return itemsPopUp;
      },
      child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.getSecondaryColor().withOpacity(0.1),
            border: Border.all(color: AppColors.grey.withOpacity(0.1)),
          ),
          child: Icon(
            Icons.filter_alt_rounded,
            color: AppColors.getSecondaryColor(),
          )),
    );
  }
}

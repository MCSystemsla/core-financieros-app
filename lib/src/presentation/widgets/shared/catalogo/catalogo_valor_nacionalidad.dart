// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
  final ItemNacionalidad? initialValue;
  final ValidatorCallback validator;
  final bool enabled;
  const CatalogoValorNacionalidad({
    super.key,
    required this.hintText,
    required this.title,
    required this.onChanged,
    required this.codigo,
    this.where,
    this.initialValue,
    this.validator,
    this.enabled = true,
  });

  @override
  State<CatalogoValorNacionalidad> createState() =>
      _CatalogoValorNacionalidadState();
}

class _CatalogoValorNacionalidadState extends State<CatalogoValorNacionalidad> {
  late String value;
  late String whereClause;
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
    // value = widget.initialValue;
    whereClause = widget.where ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();
    final items = localDbProvider.getNacionalidadPaises(
      codigo: widget.codigo,
      whereClause: whereClause,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(5),
          Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const Gap(15),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: DropdownSearch<ItemNacionalidad>(
              enabled: widget.enabled,
              validator: widget.validator,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              popupProps: PopupProps.menu(
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    hintText: widget.hintText.isEmpty
                        ? 'input.select_option'.tr()
                        : widget.hintText,
                    labelText: 'Buscar',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              items: items,
              itemAsString: (ItemNacionalidad? item) => item?.nombre ?? 'N/A',
              onChanged: widget.onChanged,
              selectedItem: ItemNacionalidad(
                nombre: widget.hintText.isEmpty
                    ? 'input.select_option'.tr()
                    : widget.hintText,
                valor: widget.hintText.isEmpty
                    ? 'input.select_option'.tr()
                    : widget.hintText,
                relacion: '',
                id: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

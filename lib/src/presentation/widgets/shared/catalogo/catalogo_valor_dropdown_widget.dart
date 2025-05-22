import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CatalogoValorDropdownWidget extends StatefulWidget {
  final String hintText;
  final String title;
  final ItemCallback<CatalogoLocalDb> onChanged;
  final String codigo;
  final String? initialValue;
  final bool? isRequired;
  final ValidatorCallback validator;
  const CatalogoValorDropdownWidget({
    super.key,
    this.initialValue,
    required this.codigo,
    required this.onChanged,
    required this.title,
    this.hintText = 'Selecciona una opción',
    this.isRequired = false,
    this.validator,
  });

  @override
  State<CatalogoValorDropdownWidget> createState() =>
      _CatalogoValorDropdownWidgetState();
}

class _CatalogoValorDropdownWidgetState
    extends State<CatalogoValorDropdownWidget> {
  late String value;

  @override
  void initState() {
    super.initState();
    // value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();

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
          DropdownSearch<CatalogoLocalDb>(
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
                  hintText: widget.hintText,
                  labelText: 'Buscar',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            items: localDbProvider.findParentescosByNombre(type: widget.codigo),
            itemAsString: (CatalogoLocalDb? item) => item?.nombre ?? 'N/A',
            onChanged: widget.onChanged,
            selectedItem: CatalogoLocalDb(
              type: widget.codigo,
              nombre: widget.initialValue ?? 'input.select_option'.tr(),
              valor: widget.initialValue ?? 'input.select_option'.tr(),
            ),
          ),
        ],
      ),
    );
  }
}

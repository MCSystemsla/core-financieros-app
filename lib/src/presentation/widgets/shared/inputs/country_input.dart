import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/commentary_widget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CountryInput extends StatelessWidget {
  final void Function(String)? onFieldSubmitted;
  final void Function(PointerDownEvent)? onTapOutside;
  final int maxLength;
  final bool? haveCounter;
  final String? hintText;
  final TextEditingController? textEditingController;
  final String title;
  final ValidatorCallback validator;
  final OnChangeCallback? onChange;
  final OnChangeCallback<CountryCode>? onCountryCodeChange;
  final String? initialValue;
  final double? marginTop;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;
  final bool? readOnly;
  final bool? isValid; // Cambiado a `bool?` para manejar nulo
  final Icon? icon;
  final bool isRequired;
  final VoidCallback? onTap;
  const CountryInput({
    super.key,
    this.onFieldSubmitted,
    this.onCountryCodeChange,
    this.onTapOutside,
    required this.maxLength,
    this.haveCounter,
    this.hintText,
    this.textEditingController,
    required this.title,
    this.validator,
    this.onChange,
    this.initialValue,
    this.marginTop,
    this.textInputType,
    this.textCapitalization,
    this.readOnly,
    this.isValid,
    this.icon,
    required this.isRequired,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(5),
          Text(
            '$title ${isRequired ? '*' : ''}',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const Gap(15),
          Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isValid == null
                    ? Colors.black // Negro para el estado inicial
                    : isValid!
                        ? AppColors.greenLatern // Verde para válido
                        : AppColors.red, // Rojo para inválido
                width: 1.5,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    contextMenuBuilder: (context, editableTextState) =>
                        const SizedBox(),
                    onFieldSubmitted: onFieldSubmitted,
                    onTapOutside: onTapOutside,
                    onTap: onTap,
                    keyboardType: textInputType,
                    controller: textEditingController,
                    validator: validator,
                    initialValue: initialValue,
                    maxLength: maxLength,
                    maxLines: null,
                    onChanged: onChange,
                    textCapitalization:
                        textCapitalization ?? TextCapitalization.none,
                    readOnly: readOnly ?? false,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: CountryCodePicker(
                        hideSearch: true,
                        dialogSize: const Size.fromHeight(520),
                        headerText: 'Seleccionar Pais',
                        padding: const EdgeInsets.all(2),
                        onChanged: onCountryCodeChange,
                        initialSelection: 'NI',
                        countryFilter: const [
                          'HN',
                          'NI',
                          'PA',
                          'CR',
                        ],
                        showCountryOnly: false,
                        showDropDownButton: true,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                      ),
                      counter: const Offstage(),
                      hintText: hintText,
                      border: InputBorder.none,
                      hintStyle: const TextStyle(
                        color: AppColors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                if (isValid != null) ...[
                  const Gap(10),
                  Icon(
                    isValid!
                        ? Icons.check_circle
                        : Icons.error, // Ícono dinámico
                    color: isValid! ? AppColors.greenLatern : AppColors.red,
                    size: 20,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

typedef ValidatorCallback<T> = String? Function(T? value)?;
typedef OnChangeCallback<T> = Function(T? value)?;

class OutlineTextfieldWidget extends StatelessWidget {
  final int maxLength;
  final bool haveCounter;
  final String? hintText;
  final TextEditingController? textEditingController;
  final String title;
  final ValidatorCallback validator;
  final OnChangeCallback? onChange;
  final String? initialValue;
  final double? marginTop;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;
  final bool? readOnly;
  final bool? isValid; // Cambiado a `bool?` para manejar nulo
  final Icon? icon;
  final bool isRequired;
  final VoidCallback? onTap;
  const OutlineTextfieldWidget({
    super.key,
    this.hintText = 'Ingresa tu texto',
    required this.title,
    this.textEditingController,
    this.validator,
    this.initialValue,
    this.onChange,
    this.marginTop = 10,
    this.textInputType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.readOnly = false,
    this.isValid,
    this.icon, // Permitir nulo como estado inicial
    this.isRequired = false,
    this.onTap,
    this.maxLength = 500,
  }) : haveCounter = false;
  const OutlineTextfieldWidget.withCounter({
    super.key,
    this.hintText = 'Ingresa tu texto',
    required this.title,
    this.textEditingController,
    this.validator,
    this.initialValue,
    this.onChange,
    this.marginTop = 10,
    this.textInputType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.readOnly = false,
    this.isValid,
    this.icon,
    this.isRequired = false,
    this.maxLength = 500,
    this.onTap,
  }) : haveCounter = true;

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
              children: [
                Expanded(
                  child: TextFormField(
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
                      prefixIcon: icon,
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

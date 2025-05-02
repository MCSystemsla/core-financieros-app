import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class InputSimple extends StatefulWidget {
  final String title;
  final String? initialValue;
  final String? hintText;
  final void Function(String)? onChanged;
  final bool activeColor;
  final bool enabled;
  final TextFieldSettings? textFieldSettings;
  final bool isPasswordField;
  final Widget? suffixIcon;

  const InputSimple({
    required this.title,
    this.initialValue,
    this.activeColor = true,
    this.onChanged,
    this.enabled = false,
    this.hintText,
    this.textFieldSettings,
    super.key,
    this.isPasswordField = false,
    this.suffixIcon,
  });

  @override
  State<InputSimple> createState() => InputSimpleState();
}

class InputSimpleState extends State<InputSimple> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        widget.title != ''
            ? Text(
                widget.title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(),
              )
            : const SizedBox(),
        widget.title != '' ? const SizedBox(height: 10) : const SizedBox(),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            enableSuggestions: false,
            obscureText: widget.isPasswordField,
            validator: widget.textFieldSettings?.validator,
            keyboardType: widget.textFieldSettings?.keyboardType,
            textCapitalization: widget.textFieldSettings?.textCapitalization ??
                TextCapitalization.none,
            autocorrect: false,
            initialValue: widget.initialValue,
            enabled: widget.enabled,
            onTapOutside: (event) {
              setState(() {
                FocusScope.of(context).unfocus();
              });
            },
            onChanged: widget.onChanged,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: TextStyle(
              color: AppColors.borderGrey,
            ),
            decoration: InputDecoration(
              suffixIcon: widget.suffixIcon,
              fillColor: widget.activeColor ? AppColors.white : AppColors.grey,
              hintText: widget.hintText,
              // context: context,
              // borderColor: AppColors.darkGrey.withOpacity(.3),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ),
      ],
    );
  }
}

class TextFieldSettings {
  const TextFieldSettings({
    this.keyboardType,
    this.validator,
    this.textCapitalization,
  });
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
}

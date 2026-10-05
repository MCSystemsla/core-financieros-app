import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Campo de contraseña del rediseño 2026 con botón para mostrar/ocultar.
class PasswordFieldWidget extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputAction textInputAction;
  const PasswordFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
  });

  @override
  State<PasswordFieldWidget> createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool isVisible = false;

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: 1.2),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: RedesignColors.inkMuted,
          ),
        ),
        const Gap(6),
        TextFormField(
          controller: widget.controller,
          obscureText: !isVisible,
          enableSuggestions: false,
          autocorrect: false,
          validator: widget.validator,
          onChanged: widget.onChanged,
          textInputAction: widget.textInputAction,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          style: const TextStyle(fontSize: 15, color: RedesignColors.ink),
          decoration: InputDecoration(
            hintText: '••••••••',
            hintStyle: const TextStyle(color: RedesignColors.chevron),
            filled: true,
            fillColor: RedesignColors.background,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            suffixIcon: IconButton(
              icon: Icon(
                isVisible
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20,
                color: RedesignColors.inkMuted,
              ),
              onPressed: () => setState(() => isVisible = !isVisible),
            ),
            border: _border(Colors.transparent),
            enabledBorder: _border(Colors.transparent),
            focusedBorder: _border(RedesignColors.ink),
            errorBorder: _border(RedesignColors.red),
            focusedErrorBorder: _border(RedesignColors.red),
            errorStyle: const TextStyle(color: RedesignColors.red),
          ),
        ),
      ],
    );
  }
}

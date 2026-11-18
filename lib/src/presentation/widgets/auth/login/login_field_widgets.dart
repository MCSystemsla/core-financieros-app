import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

/// Acento del login (focus de los campos y modo offline).
const loginAccent = RedesignColors.teal;

/// Decoración de los campos del login: relleno gris claro, esquinas de 14,
/// ícono de línea a la izquierda y borde verde azulado al enfocar.
InputDecoration loginInputDecoration({
  required String hintText,
  required IconData icon,
  Widget? suffixIcon,
}) {
  OutlineInputBorder border(Color color, [double width = 1]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(color: RedesignColors.inkMuted, fontSize: 16),
    filled: true,
    fillColor: RedesignColors.background,
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
    prefixIcon: Icon(icon, size: 20, color: RedesignColors.inkMuted),
    prefixIconConstraints: const BoxConstraints(minWidth: 46, minHeight: 52),
    suffixIcon: suffixIcon,
    enabledBorder: border(RedesignColors.border),
    disabledBorder: border(RedesignColors.border),
    focusedBorder: border(loginAccent, 1.5),
    errorBorder: border(RedesignColors.red),
    focusedErrorBorder: border(RedesignColors.red, 1.5),
    errorStyle: const TextStyle(color: RedesignColors.red, fontSize: 12),
  );
}

class LoginFieldLabel extends StatelessWidget {
  const LoginFieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: RedesignColors.ink,
      ),
    );
  }
}

/// Campo de texto del login: etiqueta arriba y [loginInputDecoration].
class LoginTextField extends StatelessWidget {
  const LoginTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.textInputAction,
  });

  final String label;
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LoginFieldLabel(label),
        const Gap(8),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          inputFormatters: inputFormatters,
          textInputAction: textInputAction,
          cursorColor: loginAccent,
          style: const TextStyle(fontSize: 16, color: RedesignColors.ink),
          decoration: loginInputDecoration(
            hintText: hintText,
            icon: icon,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

/// Botón principal del login. Muestra un spinner mientras [isLoading].
class LoginSubmitButton extends StatelessWidget {
  const LoginSubmitButton({
    super.key,
    required this.text,
    required this.loadingText,
    required this.isLoading,
    required this.onPressed,
  });

  final String text;
  final String loadingText;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      letterSpacing: .2,
      color: Colors.white,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: RedesignColors.ink.withValues(alpha: .35),
            blurRadius: 20,
            spreadRadius: -8,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: SizedBox(
        height: 54,
        width: double.infinity,
        child: FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: RedesignColors.ink,
            disabledBackgroundColor: const Color(0xff3A403C),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: isLoading
                ? [
                    const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                        backgroundColor: Colors.white24,
                      ),
                    ),
                    const Gap(12),
                    Text(loadingText, style: textStyle),
                  ]
                : [
                    Text(text, style: textStyle),
                    const Gap(10),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}

/// Fila "Entrar en modo offline" con las iniciales del usuario guardado.
class LoginOfflineTile extends StatelessWidget {
  const LoginOfflineTile({
    super.key,
    required this.dividerText,
    required this.title,
    required this.subtitle,
    required this.userName,
    required this.onTap,
  });

  final String dividerText;
  final String title;
  final String subtitle;
  final String userName;
  final VoidCallback onTap;

  String get _initials {
    final clean = userName.trim().toUpperCase();
    if (clean.isEmpty) return '?';
    return clean.length < 2 ? clean : clean.substring(0, 2);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: RedesignColors.border)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                dividerText,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: RedesignColors.inkMuted,
                ),
              ),
            ),
            const Expanded(child: Divider(color: RedesignColors.border)),
          ],
        ),
        const Gap(12),
        Material(
          color: RedesignColors.tealTint,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: RedesignColors.border),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: RedesignColors.teal,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _initials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: RedesignColors.ink,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: RedesignColors.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: RedesignColors.teal,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Círculos translúcidos sobre el degradado del login (solo decoración).
class LoginBackgroundDecoration extends StatelessWidget {
  const LoginBackgroundDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -150,
            right: -120,
            child: _circle(
              340,
              color: Colors.white.withValues(alpha: .35),
            ),
          ),
          Positioned(
            top: 120,
            left: -170,
            child: _circle(
              260,
              border: Border.all(
                color: Colors.white.withValues(alpha: .55),
                width: 1.5,
              ),
            ),
          ),
          Positioned(
            bottom: -260,
            right: -160,
            child: _circle(
              420,
              color: RedesignColors.green.withValues(alpha: .12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circle(double size, {Color? color, BoxBorder? border}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: border,
      ),
    );
  }
}

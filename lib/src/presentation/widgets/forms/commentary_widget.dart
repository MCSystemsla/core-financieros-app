import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/redesign_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/kiva_redesign/kiva_form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

typedef ValidatorCallback<T> = String? Function(T? value)?;
typedef OnChangeCallback<T> = Function(T? value)?;

/// Pregunta de texto libre de los formularios Kiva (rediseño 2026): la
/// pregunta arriba y el campo debajo, dentro de una [KivaPreguntaCard].
/// Escribe en mayúsculas y admite hasta 500 caracteres.
class CommentaryWidget extends StatelessWidget {
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
  final List<TextInputFormatter>? inputFormatters;
  const CommentaryWidget({
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
    this.inputFormatters,
  }) : haveCounter = false;
  const CommentaryWidget.withCounter({
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
    this.inputFormatters,
  }) : haveCounter = true;

  @override
  Widget build(BuildContext context) {
    final soloLectura = readOnly ?? false;

    return KivaPreguntaCard(
      marginTop: marginTop,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KivaPreguntaTitulo(title),
          const Gap(10),
          TextFormField(
            inputFormatters: [
              UpperCaseTextFormatter(),
              ...?inputFormatters,
            ],
            keyboardType: textInputType,
            controller: textEditingController,
            validator: validator,
            initialValue: initialValue,
            maxLength: 500,
            minLines: 1,
            maxLines: null,
            onChanged: onChange,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            readOnly: soloLectura,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            cursorColor: RedesignColors.teal,
            style: TextStyle(
              fontSize: 15,
              height: 1.35,
              fontWeight: soloLectura ? FontWeight.w600 : FontWeight.w500,
              color: soloLectura ? RedesignColors.inkMuted : RedesignColors.ink,
            ),
            decoration: kivaInputDecoration(
              hintText: hintText,
              readOnly: soloLectura,
              showCounter: haveCounter,
            ),
          ),
        ],
      ),
    );
  }
}

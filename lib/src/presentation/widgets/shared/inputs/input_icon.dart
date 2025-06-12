import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputIcon extends StatefulWidget {
  final String item;
  final String? suffixIcon;
  final String? hintText;
  final String? errorText;
  final FocusNode? focusNode;
  final String? Function(String?) validator;
  final bool? obscureText;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Function()? onTapIcon;

  final bool? hasError;
  const InputIcon({
    required this.validator,
    this.controller,
    this.focusNode,
    required this.item,
    this.inputFormatters,
    this.errorText,
    this.onTapIcon,
    this.obscureText,
    this.onChanged,
    this.hintText,
    this.suffixIcon,
    this.hasError,
    super.key,
  });

  @override
  State<InputIcon> createState() => _InputIconState();
}

class _InputIconState extends State<InputIcon> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            const Icon(Icons.email),
            const SizedBox(width: 12),
            Text(
              widget.item,
              // style: context.getBodyLarge(
              //   TextStyle(
              //     color: context.primaryColor(),
              //     fontWeight: FontWeight.bold,
              //     fontSize: getFontSize(context, TextType.bodyMedium),
              //   ),
              // ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          autocorrect: false,
          focusNode: widget.focusNode,
          obscureText: widget.obscureText ?? false,
          obscuringCharacter: '*',
          inputFormatters: widget.inputFormatters,
          controller: widget.controller,
          onTapOutside: (event) {
            setState(() {
              FocusScope.of(context).unfocus();
            });
          },
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: TextStyle(
            color: AppColors.greyWithOpacityV4,
          ),
          decoration: InputDecoration(
            fillColor: Colors.white,
            errorText: widget.errorText,
            // borderColor: AppColors.boxGrey,
            hintText: widget.hintText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ).copyWith(
            suffixIconConstraints: const BoxConstraints(
              maxHeight: 20,
              maxWidth: 33,
            ),
            hintStyle: TextStyle(
              color: AppColors.greyWithOpacityV4,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.blueIndigo,
              ),
            ),
            suffixIcon: widget.suffixIcon != null
                ? InkWell(
                    onTap: widget.onTapIcon,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.percent,
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}

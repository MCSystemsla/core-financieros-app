import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

typedef ValidatorCallback<T> = String? Function(T? value)?;
typedef OnChangeCallback<T> = Function(T? value)?;

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
  }) : haveCounter = true;

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      marginTop: marginTop,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(5),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const Gap(15),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.greyWithOpacityV4,
                width: 1,
              ),
            ),
            child: TextFormField(
              keyboardType: textInputType,
              controller: textEditingController,
              validator: validator,
              initialValue: initialValue,
              maxLength: 500,
              maxLines: null,
              onChanged: onChange,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              style: TextStyle(
                color: AppColors.greyWithOpacityV4,
                fontSize: 16,
              ),
              decoration: !haveCounter
                  ? InputDecoration(
                      counter: const Offstage(),
                      hintText: hintText,
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 2,
                      ),
                    )
                  : InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 2,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

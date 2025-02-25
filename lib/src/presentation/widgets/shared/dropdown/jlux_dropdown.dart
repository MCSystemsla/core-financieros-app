import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

typedef ItemCallback<T> = void Function(T? item);
typedef StringCallback<T> = String Function(T item);
typedef ValidatorCallback<T> = String? Function(T? value)?;

class Item<T> extends Equatable {
  final String name;
  final T value;
  final double? interes;

  const Item({
    required this.name,
    required this.value,
    this.interes,
  });

  @override
  List<Object?> get props => [name, value, interes];
}

class JLuxDropdown<T> extends StatelessWidget {
  const JLuxDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.onChanged,
    required this.toStringItem,
    required this.hintText,
    this.initialValue,
    this.validator,
    this.isEnabled = true,
    this.isLoading = false,
    this.isContainIcon = true,
    this.dropdownColor = Colors.transparent,
  });
  final String title;
  final String hintText;
  final T? initialValue;
  final ItemCallback<T> onChanged;
  final StringCallback<T> toStringItem;
  final ValidatorCallback<T> validator;
  final bool isEnabled;
  final bool isLoading;
  final bool isContainIcon;

  final List<T> items;
  final Color dropdownColor;

  @override
  Widget build(BuildContext context) {
    final enabled = isEnabled && items.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: !isEnabled ? AppColors.boxGrey : null,
          ),
        ),
        const Gap(10),
        isLoading
            ? const Center(
                child: SizedBox.square(
                  dimension: 25,
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                color: dropdownColor,
                child: DropdownButtonFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  value: initialValue,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: !enabled ? dropdownColor : null,
                  ),
                  selectedItemBuilder: items.isNotEmpty
                      ? (context) {
                          return items.map((item) {
                            return Container(
                              alignment: Alignment.centerLeft,
                              constraints: BoxConstraints(
                                  minWidth: 100,
                                  maxWidth:
                                      MediaQuery.sizeOf(context).width * 0.7),
                              child: FittedBox(
                                child: Text(
                                  toStringItem(item),
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: AppColors.grey,
                                  ),
                                ),
                              ),
                            );
                          }).toList();
                        }
                      : null,
                  items: [
                    for (var item in items)
                      DropdownMenuItem<T>(
                        value: item,
                        child: FittedBox(
                            child: Text(
                          toStringItem(item),
                          style: TextStyle(
                            color: AppColors.getPrimaryColor(),
                          ),
                          maxLines: 2,
                        )),
                      ),
                  ],
                  onChanged: enabled ? onChanged : null,
                  validator: validator,
                  disabledHint: Text(
                    hintText,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.grey,
                    ),
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    fillColor: AppColors.white,
                    // contentPadding:
                    //     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    hintText: hintText,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.grey,
                    ),
                  ),
                  // decoration: StyleTextField.inputDecoration(
                  //   fillColor: enabled
                  //       ? AppColors.white
                  //       : AppColors.borderSide.withOpacity(0.2),
                  //   hintText: hintText,
                  //   context: context,
                  //   borderColor: AppColors.darkGrey.withOpacity(.3),
                  //   contentPadding:
                  //       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  // ).copyWith(
                  //   enabled: enabled,
                  //   hintStyle: context.getBodyMedium(
                  //     TextStyle(
                  //       fontWeight: FontWeight.w600,
                  //       fontSize: 14,
                  //       color: AppColors.textGrey,
                  //     ),
                  //   ),
                  // ),
                  iconSize: 30,
                  iconEnabledColor: AppColors.grey,
                  icon: isContainIcon
                      ? const Icon(
                          Icons.keyboard_arrow_down_rounded,
                        )
                      : const SizedBox(),
                ),
              ),
      ],
    );
  }
}

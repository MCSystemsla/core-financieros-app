import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ExpansionTitleCustom extends StatefulWidget {
  final String? step;
  final Widget title;
  final bool finalStep;
  final List<Widget> children;
  final bool isVerifier;
  final void Function(bool value)? onExpansionChanged;
  final bool? isExpanded;
  const ExpansionTitleCustom({
    super.key,
    this.step,
    required this.title,
    required this.children,
    required this.finalStep,
    this.isExpanded,
    this.onExpansionChanged,
    this.isVerifier = false,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ExpansionTitleCustomState createState() => _ExpansionTitleCustomState();
}

class _ExpansionTitleCustomState extends State<ExpansionTitleCustom> {
  bool isExpanded = false;

  @override
  void initState() {
    isExpanded = widget.isExpanded ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Stack(
        children: [
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ExpansionTile(
                initiallyExpanded: isExpanded,
                childrenPadding: EdgeInsets.zero,
                collapsedBackgroundColor: AppColors.white,
                backgroundColor: AppColors.white,
                onExpansionChanged: (bool expanded) {
                  setState(() {
                    isExpanded = expanded;
                  });
                  widget.onExpansionChanged?.call(expanded);
                },
                tilePadding: const EdgeInsets.symmetric(horizontal: 10),
                trailing: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up_sharp
                      : Icons.keyboard_arrow_down_sharp,
                  size: 30,
                  color: AppColors.greyWithOpacityV4,
                ),
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      widget.step != null
                          ? Text(
                              widget.step!,
                              // style: context.getBodyMedium(
                              //   TextStyle(
                              //     fontSize:
                              //         getFontSize(context, TextType.bodySmall),
                              //   ),
                              // ),
                            )
                          : const SizedBox(),
                      const Gap(10),
                      Expanded(
                        child: widget.title,
                      ),
                    ],
                  ),
                ),
                children: widget.children.map((child) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.greyWithOpacityV4.withOpacity(0.2),
                    child: child,
                  );
                }).toList(),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
            child: Container(
              width: 15,
              height: 58,
              decoration: BoxDecoration(
                color: widget.finalStep
                    ? AppColors.getPrimaryColor()
                    : AppColors.getTerciaryColor(),
                border: Border(
                  left: BorderSide(
                    color: widget.finalStep
                        ? AppColors.getPrimaryColor()
                        : AppColors.getTerciaryColor(),
                    width: widget.finalStep ? 16 : 10,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

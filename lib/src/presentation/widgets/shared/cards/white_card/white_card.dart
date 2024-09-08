import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class WhiteCard extends StatelessWidget {
  final Widget child;
  final double? marginTop;
  final EdgeInsetsGeometry? padding;
  final bool? haveBorders;
  const WhiteCard({
    super.key,
    required this.child,
    this.marginTop,
    this.padding,
    this.haveBorders = false,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .9,
      margin: EdgeInsets.only(top: marginTop ?? 0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: haveBorders!
            ? Border.all(
                width: 0.5,
                color: AppColors.borderGrey,
              )
            : null,
      ),
      child: Padding(
        padding: padding != null
            ? padding!
            : const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
        child: child,
      ),
    );
  }
}

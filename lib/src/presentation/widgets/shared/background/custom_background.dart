import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: const [0.20, 1],
          tileMode: TileMode.repeated,
          colors: <Color>[
            const Color(0xffc2f2d2),
            AppColors.getSecondaryColor(),
          ],
        ),
      ),
      child: child,
    );
  }
}

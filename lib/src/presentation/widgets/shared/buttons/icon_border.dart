import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum _IconType { icon, image }

class IconBorder extends StatelessWidget {
  final Color? color;
  final Size? size;
  final Function()? onTap;

  //Icon
  final IconData? _icon;
  final double? iconSize;

  //Image
  final Size? imageSize;
  final String? _iconPath;

  final _IconType _iconType;

  const IconBorder.fromIcon({
    required this.onTap,
    required IconData? icon,
    this.color,
    this.iconSize,
    this.size,
    super.key,
  })  : _icon = icon,
        _iconType = _IconType.icon,
        _iconPath = null,
        imageSize = null;

  const IconBorder.fromImage({
    required this.onTap,
    required String iconPath,
    this.imageSize,
    this.color,
    this.size,
    super.key,
  })  : _iconPath = iconPath,
        _icon = null,
        iconSize = null,
        _iconType = _IconType.image;

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
        style: IconButton.styleFrom(
          fixedSize: size ?? const Size.square(40),
          padding: const EdgeInsets.all(0),
          side: BorderSide(
            color: color ?? AppColors.getPrimaryColor(),
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onTap,
        icon: switch (_iconType) {
          _IconType.image => Image.asset(
              // fit: BoxFit.fill,
              _iconPath!,
              width: (imageSize?.width ?? 20),
              height: (imageSize?.height ?? 20),
              color: color ?? context.primaryColor(),
            ),
          _IconType.icon => Icon(
              _icon,
              size: iconSize ?? 20,
              color: color ?? context.primaryColor(),
            ),
        });
  }
}

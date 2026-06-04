import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';

extension LogoExtension on Flavor {
  String get toLogoExtension {
    return switch (this) {
      Flavor.honduras => ImageAsset.logoHN,
      Flavor.nicaragua => ImageAsset.logoNi,
      Flavor.costaRica => ImageAsset.logoNi,
      _ => ImageAsset.logoNi,
    };
  }
}

import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(15),
        child: const Center(
          child: Image(image: AssetImage(ImageAsset.logo)),
        ),
      ),
    );
  }
}

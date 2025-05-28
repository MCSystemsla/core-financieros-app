import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/cedula/photos_cedula_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class AddCedulaPhotosScreen extends StatelessWidget {
  final PageController controller;
  const AddCedulaPhotosScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Validacion de Identidad'),
      ),
      body: _ValidationIdentidadCard(
        controller: controller,
      ),
    );
  }
}

class _ValidationIdentidadCard extends StatelessWidget {
  final PageController controller;

  const _ValidationIdentidadCard({required this.controller});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: _CardValidationContent(
            controller: controller,
          ),
        ),
      ),
    );
  }
}

class _CardValidationContent extends StatelessWidget {
  final PageController controller;

  const _CardValidationContent({required this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            ImageAsset.cedulaPhoto,
            height: 180,
          ),
          const Gap(25),
          Text(
            'Validación de identidad',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Gap(16),
          Text(
            'Utilice la cámara de su dispositivo para tomar una foto clara de su documento nacional de identidad.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                ),
          ),
          const Gap(30),
          CustomElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PhotosCedulaScreen(
                    controller: controller,
                  ),
                ),
              );
            },
            text: 'Continuar',
            color: AppColors.getSecondaryColor(),
          ),
        ],
      ),
    );
  }
}

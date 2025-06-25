// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class PhotoTakedWidget extends StatefulWidget {
  final VoidCallback onDelete;
  final VoidCallback onConfirm;
  final String? selectedImage1Path;

  const PhotoTakedWidget({
    super.key,
    required this.onDelete,
    required this.onConfirm,
    this.selectedImage1Path,
  });

  @override
  State<PhotoTakedWidget> createState() => _PhotoTakedWidgetState();
}

class _PhotoTakedWidgetState extends State<PhotoTakedWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      key: ValueKey(widget.selectedImage1Path),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (widget.selectedImage1Path != null)
            IconButton(
              onPressed: widget.onDelete,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
                size: 30,
              ),
            ),
          Column(
            children: [
              if (widget.selectedImage1Path != null)
                Text(
                  'Foto tomada:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              const SizedBox(height: 8),
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 500),
                tween: Tween(begin: 0.8, end: 1.0),
                curve: Curves.easeOutBack,
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: child,
                  );
                },
                child: InkWell(
                  onTap: () {
                    if (widget.selectedImage1Path == null) return;
                    context.pushTransparentRoute(
                      OnImageCaptureTap(
                        imagePath: widget.selectedImage1Path!,
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'selectedImage',
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: widget.selectedImage1Path != null
                            ? Image.file(
                                File(widget.selectedImage1Path!),
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              )
                            : SvgPicture.asset(
                                ImageAsset.imgForm,
                                height: 80,
                              )),
                  ),
                ),
              ),
            ],
          ),
          if (widget.selectedImage1Path != null)
            IconButton.filled(
              onPressed: widget.onConfirm,
              icon: const Icon(
                Icons.check,
                size: 32,
              ),
            ),
        ],
      ),
    );
  }
}

class OnImageCaptureTap extends StatelessWidget {
  final String imagePath;
  const OnImageCaptureTap({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () {
        context.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Foto Tomada'),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Hero(
          tag: 'selectedImage',
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                height: 600,
                File(imagePath),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CameraWidgets extends StatefulWidget {
  final VoidCallback onTakePhoto;
  final CameraController controller;
  final bool isLoading;
  const CameraWidgets({
    super.key,
    required this.onTakePhoto,
    required this.controller,
    required this.isLoading,
  });

  @override
  State<CameraWidgets> createState() => _CameraWidgetsState();
}

class _CameraWidgetsState extends State<CameraWidgets> {
  bool flashMode = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(10),
                backgroundColor: Colors.white.withOpacity(0.85),
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                // controller.setFlashMode(FlashMode.camw);
              },
              child: const Icon(Icons.cameraswitch_rounded, size: 30),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(18),
                backgroundColor: Colors.white.withOpacity(0.85),
                foregroundColor: Colors.black,
              ),
              onPressed: widget.isLoading ? null : widget.onTakePhoto,
              child: const Icon(Icons.camera_alt, size: 32),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(10),
                backgroundColor: Colors.white.withOpacity(0.85),
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                flashMode = !flashMode;
                final flashModeData =
                    flashMode ? FlashMode.always : FlashMode.off;
                setState(() {});
                widget.controller.setFlashMode(flashModeData);
              },
              child: Icon(
                flashMode ? Icons.flash_on : Icons.flash_off,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

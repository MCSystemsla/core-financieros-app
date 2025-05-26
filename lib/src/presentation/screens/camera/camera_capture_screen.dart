// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:camera/camera.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraCaptureScreen extends StatefulWidget {
  final void Function(XFile? image) onImageSelected;
  const CameraCaptureScreen({super.key, required this.onImageSelected});

  @override
  State<CameraCaptureScreen> createState() => _CameraCaptureScreenState();
}

class _CameraCaptureScreenState extends State<CameraCaptureScreen>
    with TickerProviderStateMixin {
  late CameraController _controller;
  bool _isCameraInitialized = false;
  XFile? selectedImage;
  String? selectedImage1Path;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final backCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      backCamera,
      ResolutionPreset.veryHigh,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    await _controller.initialize();

    await _controller.lockCaptureOrientation(DeviceOrientation.portraitUp);

    if (!mounted) return;
    setState(() {
      _isCameraInitialized = true;
    });
  }

  Future<bool> _requestPermissions() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<void> _takePhoto() async {
    if (!mounted || !context.mounted) return;

    final hasPermission = await _requestPermissions();
    if (!context.mounted || !mounted) return;

    if (!hasPermission) {
      CustomAlertDialog(
        context: context,
        title: 'No tienes permisos para usar la camara',
        onDone: () async {
          final isOpened = await openAppSettings();
          if (!context.mounted || !mounted) return;
          if (isOpened) {
            context.pop();
          }
        },
      ).showDialog(context, dialogType: DialogType.error);
      return;
    }

    try {
      final photo = await _controller.takePicture();
      final appDir = await getApplicationDocumentsDirectory();
      final customDir = Directory('${appDir.path}/MyImages');

      if (!await customDir.exists()) {
        await customDir.create(recursive: true);
        log('Directorio creado: ${customDir.path}');
      }

      final localPath =
          '${customDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final imageFile = File(photo.path);
      await imageFile.copy(localPath);

      if (!mounted) return;
      setState(() {
        selectedImage = photo;
        selectedImage1Path = localPath;
      });
    } on PlatformException catch (e) {
      CustomAlertDialog(
        context: context,
        title: 'Error al tomar la foto: ${e.message}',
        onDone: () async {
          final isOpened = await openAppSettings();
          if (!context.mounted || !mounted) return;
          if (isOpened) {
            context.pop();
          }
        },
      ).showDialog(context, dialogType: DialogType.error);
    } catch (e) {
      CustomAlertDialog(
        context: context,
        title: 'Error al tomar la foto: $e',
        onDone: () async {
          final isOpened = await openAppSettings();
          if (!context.mounted || !mounted) return;
          if (isOpened) {
            context.pop();
          }
        },
      ).showDialog(context, dialogType: DialogType.error);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: const Text('Tomar foto'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: CameraPreview(
                _controller,
                child: CameraWidgets(
                  controller: _controller,
                  onTakePhoto: () => _takePhoto(),
                ),
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                child: _PhotoTakedWidget(
                  onDelete: () {
                    setState(() {
                      selectedImage1Path = null;
                    });
                  },
                  onConfirm: () {
                    setState(() {
                      widget.onImageSelected(selectedImage);
                      context.pop();
                    });
                  },
                  selectedImage1Path: selectedImage1Path,
                )
                // : const SizedBox.shrink(),
                ),
          ),
          const Gap(24),
        ],
      ),
    );
  }
}

class _PhotoTakedWidget extends StatefulWidget {
  final VoidCallback onDelete;
  final VoidCallback onConfirm;
  final String? selectedImage1Path;

  const _PhotoTakedWidget({
    required this.onDelete,
    required this.onConfirm,
    this.selectedImage1Path,
  });

  @override
  State<_PhotoTakedWidget> createState() => __PhotoTakedWidgetState();
}

class __PhotoTakedWidgetState extends State<_PhotoTakedWidget> {
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
  const CameraWidgets({
    super.key,
    required this.onTakePhoto,
    required this.controller,
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
              onPressed: widget.onTakePhoto,
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

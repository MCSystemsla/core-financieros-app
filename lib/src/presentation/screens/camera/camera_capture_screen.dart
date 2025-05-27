import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:camera/camera.dart';
import 'package:core_financiero_app/src/config/services/camera/camera_service.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/image_preview_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
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
  bool flashVisible = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
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
      // await _controller.setFocusPoint(const Offset(0.5, 0.5));

      if (!mounted) return;
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      CustomAlertDialog(
        context: context,
        title: 'Error al inicializar la camara: $e',
        onDone: () => context.pop(),
      ).showDialog(context, dialogType: DialogType.error);
    }
  }

  Future<bool> _requestPermissions() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<void> _takePhoto() async {
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
      final (savedPath, photo) =
          await CameraService.takeAndsavePhoto(controller: _controller);
      if (!context.mounted || !mounted) return;
      setState(() {
        selectedImage = photo;
        selectedImage1Path = savedPath;
      });
    } on PlatformException catch (e) {
      CustomAlertDialog(
        context: context,
        title: 'Error al tomar la foto: ${e.message}',
        onDone: () => context.pop(),
      ).showDialog(context, dialogType: DialogType.error);
    } catch (e) {
      CustomAlertDialog(
        context: context,
        title: 'Error al tomar la foto: $e',
        onDone: () => context.pop(),
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
        title: const Text('Tomar foto Kiva'),
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
              child: PhotoTakedWidget(
                onDelete: () {
                  setState(() {
                    selectedImage1Path = null;
                  });
                },
                onConfirm: () {
                  widget.onImageSelected(selectedImage);
                  context.pop();
                },
                selectedImage1Path: selectedImage1Path,
              ),
            ),
          ),
          const Gap(24),
        ],
      ),
    );
  }
}

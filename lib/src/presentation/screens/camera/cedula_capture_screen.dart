import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:camera/camera.dart';
import 'package:core_financiero_app/src/config/services/camera/camera_service.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/image_preview_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cedula/cedula_capture.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/custom_painter/cedula_frame_painter.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

class CedulaCaptureScreen extends StatefulWidget {
  final void Function(String imagePath) onImageTaken;
  final String title;
  const CedulaCaptureScreen({
    super.key,
    required this.title,
    required this.onImageTaken,
  });

  @override
  State<CedulaCaptureScreen> createState() => _CedulaCaptureScreenState();
}

class _CedulaCaptureScreenState extends State<CedulaCaptureScreen> {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  File? selectedImage;
  String? selectedImage1Path;
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
      await _controller?.initialize();
      await _controller?.setFlashMode(FlashMode.off);
      await _controller?.setFocusMode(FocusMode.auto);
      // await _controller.lockCaptureOrientation(DeviceOrientation.portraitUp);

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
      if (!context.mounted || !mounted) return;
      final (croppedPath, croppedFile) =
          await CameraService.takeImageAndSaveWithCropped(
        controller: _controller!,
      );
      setState(() {
        selectedImage = croppedFile;
        selectedImage1Path = croppedPath;
      });
      context.pushTransparentRoute(
        CedulaCaptureView(
          cedulaCapturedImage: croppedFile,
          onImageTaken: widget.onImageTaken,
        ),
      );
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
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final previewSize = _controller?.value.previewSize;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final cameraAspectRatio = isPortrait
        ? (previewSize?.width ?? 0) / (previewSize?.height ?? 0)
        : (previewSize?.height ?? 0) / (previewSize?.width ?? 0);
    if (!_isCameraInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          AspectRatio(
            aspectRatio: cameraAspectRatio,
            child: CameraPreview(
              _controller!,
              child: Positioned.fill(
                child: CustomPaint(
                  painter: CedulaFramePainter(),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: CameraWidgets(
              onTakePhoto: () => _takePhoto(),
              controller: _controller!,
            ),
          ),
          const CloseCaptureCedulaWidget(),
          CaptureCedulaTitle(
            title: widget.title,
          ),
          const CaptureCedulaDescription(),
        ],
      ),
    );
  }
}

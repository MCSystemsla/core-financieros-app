// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CedulaFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // La geometría del recuadro (80% x 25%, centrado) debe mantenerse
    // alineada con el recorte de CameraService.takeImageAndSaveWithCropped.
    double frameWidth = size.width * 0.8;
    double frameHeight = size.height * 0.25;

    double left = (size.width - frameWidth) / 2;
    double top = (size.height - frameHeight) / 2;
    Rect frameRect = Rect.fromLTWH(left, top, frameWidth, frameHeight);

    const radius = 16.0;
    final frameRRect =
        RRect.fromRectAndRadius(frameRect, const Radius.circular(radius));

    // Oscurece todo lo que queda fuera del recuadro
    final cutout = Path.combine(
      PathOperation.difference,
      Path()..addRect(Offset.zero & size),
      Path()..addRRect(frameRRect),
    );
    canvas.drawPath(
      cutout,
      Paint()
        ..color = Colors.black.withOpacity(0.55)
        ..style = PaintingStyle.fill,
    );

    // Borde fino del recuadro
    canvas.drawRRect(
      frameRRect,
      Paint()
        ..color = Colors.white.withOpacity(0.35)
        ..strokeWidth = 1.2
        ..style = PaintingStyle.stroke,
    );

    // Esquinas redondeadas
    final cornerPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    const cornerLength = 28.0;
    final right = left + frameWidth;
    final bottom = top + frameHeight;

    // top-left
    canvas.drawPath(
      Path()
        ..moveTo(left, top + cornerLength)
        ..lineTo(left, top + radius)
        ..arcToPoint(Offset(left + radius, top),
            radius: const Radius.circular(radius))
        ..lineTo(left + cornerLength, top),
      cornerPaint,
    );
    // top-right
    canvas.drawPath(
      Path()
        ..moveTo(right - cornerLength, top)
        ..lineTo(right - radius, top)
        ..arcToPoint(Offset(right, top + radius),
            radius: const Radius.circular(radius))
        ..lineTo(right, top + cornerLength),
      cornerPaint,
    );
    // bottom-right
    canvas.drawPath(
      Path()
        ..moveTo(right, bottom - cornerLength)
        ..lineTo(right, bottom - radius)
        ..arcToPoint(Offset(right - radius, bottom),
            radius: const Radius.circular(radius))
        ..lineTo(right - cornerLength, bottom),
      cornerPaint,
    );
    // bottom-left
    canvas.drawPath(
      Path()
        ..moveTo(left + cornerLength, bottom)
        ..lineTo(left + radius, bottom)
        ..arcToPoint(Offset(left, bottom - radius),
            radius: const Radius.circular(radius))
        ..lineTo(left, bottom - cornerLength),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

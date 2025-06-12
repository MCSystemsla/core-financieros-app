// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CedulaFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = AppColors.getPrimaryColor()
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    double frameWidth = size.width * 0.8;
    double frameHeight = size.height * 0.25;

    double left = (size.width - frameWidth) / 2;
    double top = (size.height - frameHeight) / 2;
    Rect frameRect = Rect.fromLTWH(left, top, frameWidth, frameHeight);

    // Crea el path de recorte
    final cutout = Path.combine(
      PathOperation.difference,
      Path()..addRect(Offset.zero & size),
      Path()..addRect(frameRect),
    );

    // Pinta el área fuera del recorte de rojo
    canvas.saveLayer(Offset.zero & size, Paint());
    canvas.drawPath(
      cutout,
      Paint()
        ..color = Colors.black.withOpacity(0.2)
        ..blendMode = BlendMode.srcOut
        ..style = PaintingStyle.fill,
    );
    canvas.restore();

    // Líneas en las esquinas
    double cornerLength = 20;

    // Esquinas
    canvas.drawLine(Offset(left, top), Offset(left + cornerLength, top),
        borderPaint); // top-left H
    canvas.drawLine(Offset(left, top), Offset(left, top + cornerLength),
        borderPaint); // top-left V

    canvas.drawLine(
        Offset(left + frameWidth, top),
        Offset(left + frameWidth - cornerLength, top),
        borderPaint); // top-right H
    canvas.drawLine(
        Offset(left + frameWidth, top),
        Offset(left + frameWidth, top + cornerLength),
        borderPaint); // top-right V

    canvas.drawLine(
        Offset(left, top + frameHeight),
        Offset(left + cornerLength, top + frameHeight),
        borderPaint); // bottom-left H
    canvas.drawLine(
        Offset(left, top + frameHeight),
        Offset(left, top + frameHeight - cornerLength),
        borderPaint); // bottom-left V

    canvas.drawLine(
        Offset(left + frameWidth, top + frameHeight),
        Offset(left + frameWidth - cornerLength, top + frameHeight),
        borderPaint); // bottom-right H
    canvas.drawLine(
        Offset(left + frameWidth, top + frameHeight),
        Offset(left + frameWidth, top + frameHeight - cornerLength),
        borderPaint); // bottom-right V
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

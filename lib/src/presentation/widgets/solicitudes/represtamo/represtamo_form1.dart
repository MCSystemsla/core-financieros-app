import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/views/represtamo_form_content_view1.dart';
import 'package:flutter/material.dart';

class ReprestamoForm1 extends StatefulWidget {
  final PageController controller;
  final UserByCedulaSolicitud userByCedulaSolicitud;
  const ReprestamoForm1({
    super.key,
    required this.controller,
    required this.userByCedulaSolicitud,
  });

  @override
  State<ReprestamoForm1> createState() => _ReprestamoForm1State();
}

class _ReprestamoForm1State extends State<ReprestamoForm1> {
  @override
  Widget build(BuildContext context) {
    return ReprestamoFormContentView1(
      controller: widget.controller,
      userByCedulaSolicitud: widget.userByCedulaSolicitud,
    );
  }
}

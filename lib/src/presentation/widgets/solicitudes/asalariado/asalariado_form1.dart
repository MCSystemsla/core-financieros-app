import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/asalariado_form.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/views/asalariado_form1_view.dart';

class AsalariadoForm1 extends StatefulWidget {
  final PageController controller;
  final UserByCedulaSolicitud? userByCedulaSolicitud;
  const AsalariadoForm1({
    super.key,
    required this.controller,
    this.userByCedulaSolicitud,
  });

  @override
  State<AsalariadoForm1> createState() => _AsalariadoForm1State();
}

class _AsalariadoForm1State extends State<AsalariadoForm1>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AsalariadoForm1View(
      controller: widget.controller,
      userByCedulaSolicitud: widget.userByCedulaSolicitud,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

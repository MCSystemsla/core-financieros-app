import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/views/asalariado_form4_view.dart';

class AsalariadoForm4 extends StatefulWidget {
  final PageController controller;
  const AsalariadoForm4({super.key, required this.controller});

  @override
  State<AsalariadoForm4> createState() => _AsalariadoForm4State();
}

class _AsalariadoForm4State extends State<AsalariadoForm4>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AsalariadoForm4View(
      controller: widget.controller,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

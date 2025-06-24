import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/views/asalariado_form2_view.dart';

class AsalariadoForm2 extends StatefulWidget {
  final PageController controller;
  const AsalariadoForm2({super.key, required this.controller});

  @override
  State<AsalariadoForm2> createState() => _AsalariadoForm2State();
}

class _AsalariadoForm2State extends State<AsalariadoForm2>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AsalariadoForm2View(
      controller: widget.controller,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

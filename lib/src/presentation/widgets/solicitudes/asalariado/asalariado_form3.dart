import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/views/asalariado_form3_view.dart';

class AsalariadoForm3 extends StatefulWidget {
  final PageController controller;
  const AsalariadoForm3({super.key, required this.controller});

  @override
  State<AsalariadoForm3> createState() => _AsalariadoForm3State();
}

class _AsalariadoForm3State extends State<AsalariadoForm3>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AsalariadoForm3View(
      controller: widget.controller,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

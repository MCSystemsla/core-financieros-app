import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/views/asalariado_form7_view.dart';

class AsalariadoForm7 extends StatefulWidget {
  final PageController controller;
  const AsalariadoForm7({super.key, required this.controller});

  @override
  State<AsalariadoForm7> createState() => _AsalariadoForm7State();
}

class _AsalariadoForm7State extends State<AsalariadoForm7>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AsalariadoForm7View(controller: widget.controller);
  }

  @override
  bool get wantKeepAlive => true;
}

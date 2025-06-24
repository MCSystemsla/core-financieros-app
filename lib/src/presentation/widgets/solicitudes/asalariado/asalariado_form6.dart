import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/views/asalariado_form6_view.dart';

class AsalariadoForm6 extends StatefulWidget {
  final PageController controller;
  const AsalariadoForm6({super.key, required this.controller});

  @override
  State<AsalariadoForm6> createState() => _AsalariadoForm6State();
}

class _AsalariadoForm6State extends State<AsalariadoForm6>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AsalariadoForm6View(
      controller: widget.controller,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

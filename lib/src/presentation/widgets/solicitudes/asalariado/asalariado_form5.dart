import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/views/asalariado_form5_view.dart';

class AsalariadoForm5 extends StatefulWidget {
  final PageController controller;
  const AsalariadoForm5({super.key, required this.controller});

  @override
  State<AsalariadoForm5> createState() => _AsalariadoForm5State();
}

class _AsalariadoForm5State extends State<AsalariadoForm5>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AsalariadoForm5View(
      controller: widget.controller,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

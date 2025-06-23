import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/views/nueva_menor_espeps_widget_view.dart';

class NuevaMenorEsPepsWidget extends StatefulWidget {
  const NuevaMenorEsPepsWidget({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<NuevaMenorEsPepsWidget> createState() => _NuevaMenorEsPepsWidgetState();
}

class _NuevaMenorEsPepsWidgetState extends State<NuevaMenorEsPepsWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NuevaMenorEspepsWidgetView(
      controller: widget.pageController,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

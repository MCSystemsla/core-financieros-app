import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/views/nueva_menor_working_widget_view.dart';

class NuevaMenorMontoWidget extends StatefulWidget {
  const NuevaMenorMontoWidget({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<NuevaMenorMontoWidget> createState() => _NuevaMenorMontoWidgetState();
}

class _NuevaMenorMontoWidgetState extends State<NuevaMenorMontoWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NuevaMenorMontoWidgetView(
      controller: widget.pageController,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

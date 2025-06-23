import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/views/nueva_menor_credito_widget_view.dart';

class NuevaMenorCreditoWidget extends StatefulWidget {
  const NuevaMenorCreditoWidget({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<NuevaMenorCreditoWidget> createState() =>
      _NuevaMenorCreditoWidgetState();
}

class _NuevaMenorCreditoWidgetState extends State<NuevaMenorCreditoWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NuevaMenorCreditoWidgetView(
      controller: widget.pageController,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

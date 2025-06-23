import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/views/nueva_menor_business_data_widget_view.dart';

class NuevaMenorBusinessDataWidget extends StatefulWidget {
  const NuevaMenorBusinessDataWidget({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<NuevaMenorBusinessDataWidget> createState() =>
      _NuevaMenorBusinessDataWidgetState();
}

class _NuevaMenorBusinessDataWidgetState
    extends State<NuevaMenorBusinessDataWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NuevaMenorBusinessDataWidgetView(
      controller: widget.pageController,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

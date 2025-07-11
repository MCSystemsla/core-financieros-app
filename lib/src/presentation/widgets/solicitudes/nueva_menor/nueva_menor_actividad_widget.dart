import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/views/nueva_menor_actividad_widget_view.dart';

class NuevaMenorBeneficiarioWidget extends StatefulWidget {
  const NuevaMenorBeneficiarioWidget({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<NuevaMenorBeneficiarioWidget> createState() =>
      _NuevaMenorBeneficiarioWidgetState();
}

class _NuevaMenorBeneficiarioWidgetState
    extends State<NuevaMenorBeneficiarioWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NuevaMenorActividadWidgetView(
      pageController: widget.pageController,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

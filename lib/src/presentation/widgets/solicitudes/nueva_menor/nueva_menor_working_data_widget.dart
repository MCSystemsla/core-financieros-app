import 'package:core_financiero_app/src/presentation/bloc/geolocation/geolocation_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/views/nueva_menor_working_data_widget_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NuevaMenorWorkingDataWidget extends StatefulWidget {
  final PageController controller;
  const NuevaMenorWorkingDataWidget({
    super.key,
    required this.controller,
  });

  @override
  State<NuevaMenorWorkingDataWidget> createState() =>
      _NuevaMenorWorkingDataWidgetState();
}

class _NuevaMenorWorkingDataWidgetState
    extends State<NuevaMenorWorkingDataWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GeolocationCubit>().getCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NuevaMenorWorkingDataWidgetView(
      controller: widget.controller,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:core_financiero_app/src/presentation/bloc/solicitudes/user_by_cedula/user_by_cedula_cubit.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/asalariado/views/asalariado_form1_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsalariadoForm1 extends StatefulWidget {
  final PageController controller;
  const AsalariadoForm1({
    super.key,
    required this.controller,
  });

  @override
  State<AsalariadoForm1> createState() => _AsalariadoForm1State();
}

class _AsalariadoForm1State extends State<AsalariadoForm1>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<UserByCedulaCubit, UserByCedulaState>(
      builder: (context, state) {
        return switch (state) {
          OnUserByCedulaSuccess() => AsalariadoForm1View(
              controller: widget.controller,
              userByCedulaSolicitud: state.userByCedula,
            ),
          OnUserByCedulaError() => AsalariadoForm1View(
              controller: widget.controller,
              userByCedulaSolicitud: state.userByCedula,
            ),
          _ => const SizedBox(),
        };
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

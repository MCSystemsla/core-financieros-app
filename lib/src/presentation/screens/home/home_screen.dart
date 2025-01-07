import 'package:core_financiero_app/src/presentation/bloc/solicitudes_pendientes_local_db/solicitudes_pendientes_local_db_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/home/home_banner_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/home/home_items_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    initFunctions();
    super.initState();
  }

  void initFunctions() async {
    await context.read<SolicitudesPendientesLocalDbCubit>().getActionsAsList();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          HomeBannerWidget(),
          Expanded(
            child: HomeItemsWidget(),
          ),
        ],
      ),
    );
  }
}

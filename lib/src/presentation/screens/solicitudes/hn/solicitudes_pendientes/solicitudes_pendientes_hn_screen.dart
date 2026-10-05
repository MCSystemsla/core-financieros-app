import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/asalariado/solicitudes_offline/solicitudes_asalariado_pendientes_items.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitud_asalariado_hn_db_local.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/nuevamenor/local_db/solicitud_nueva_menor_hn_local_db.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/nueva_menor/solicitudes_offline/solicitudes_pendientes_nueva.dart';

class SolicitudesPendientesScreenHN extends StatefulWidget {
  const SolicitudesPendientesScreenHN({super.key});

  @override
  State<SolicitudesPendientesScreenHN> createState() =>
      _SolicitudesPendientesScreenHNState();
}

class _SolicitudesPendientesScreenHNState
    extends State<SolicitudesPendientesScreenHN> {
  List<SolicitudNuevaMenorHnLocalDb> solicitudesNuevasOffline = [];
  List<SolicitudAsalariadoHnDbLocal> solicitudesAsalariadoOffline = [];

  @override
  void initState() {
    super.initState();
    final localDbProvider = global<SolicitudesHnBoxService>();
    localDbProvider.deleteRowsByDeterminateTime();
    solicitudesNuevasOffline = localDbProvider.getSolicitudesNueva();
    solicitudesAsalariadoOffline = localDbProvider.getSolicitudesAsalariado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes en proceso offline'),
      ),
      body: SolicitudesCreditoView(
        solicitudesAsalariado: solicitudesAsalariadoOffline,
        solicitudesOffline: solicitudesNuevasOffline,
      ),
    );
  }
}

class SolicitudesCreditoView extends StatelessWidget {
  final List<SolicitudNuevaMenorHnLocalDb> solicitudesOffline;
  final List<SolicitudAsalariadoHnDbLocal> solicitudesAsalariado;

  const SolicitudesCreditoView({
    super.key,
    required this.solicitudesOffline,
    required this.solicitudesAsalariado,
  });

  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    return PageView(
      controller: controller,
      children: [
        SolicitudesPendientesItemsNuevaHN(
          solicitudesOfflinePending: solicitudesOffline
              .where(
                (element) => element.isDone == false,
              )
              .toList(),
          solicitudesOfflineDone: solicitudesOffline
              .where(
                (element) => element.isDone == true,
              )
              .toList(),
          controller: controller,
        ),
        SolicitudesAsalariadoPendientesItemsHN(
          controller: controller,
          solicitudesAsalariadoInProgress: solicitudesAsalariado
              .where(
                (element) => element.isDone == false,
              )
              .toList(),
          solicitudesAsalariadoDone: solicitudesAsalariado
              .where(
                (element) => element.isDone == true,
              )
              .toList(),
        ),
      ],
    );
  }
}

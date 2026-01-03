import 'package:core_financiero_app/src/config/helpers/catalogo_sync/catalogo_sync.dart';
import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

extension NavigationSyncExt on BuildContext {
  void pushWithSyncCheck({
    required Widget destination,
    required ConnectionStatus connectionStatus,
  }) {
    if (!mounted) return;

    if (CatalogoSync.needToSync() &&
        connectionStatus == ConnectionStatus.connected) {
      CustomAlertDialog(
        onDone: () => Navigator.of(this).pop(),
        context: this,
        title: 'Es necesario sincronizar los catálogos para avanzar',
      ).showDialog(this);
      return;
    }

    Navigator.of(this).push(
      MaterialPageRoute(builder: (_) => destination),
    );
  }
}

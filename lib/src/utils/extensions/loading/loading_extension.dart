import 'package:core_financiero_app/src/presentation/widgets/shared/dialogs/loading_dialog.dart';
import 'package:flutter/material.dart';

extension LoadingDialogExtension on BuildContext {
  void showLoading({String message = 'Procesando...'}) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (_) => LoadingDialog(message: message),
    );
  }

  void hideLoading() {
    if (Navigator.of(this).canPop()) {
      Navigator.of(this).pop();
    }
  }
}

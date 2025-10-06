import 'package:flutter/material.dart';

class DownloadCatalogosDialogHn extends StatefulWidget {
  final VoidCallback? onDownloadComplete;

  const DownloadCatalogosDialogHn({super.key, this.onDownloadComplete});

  @override
  State<DownloadCatalogosDialogHn> createState() =>
      _DownloadCatalogosDialogHnState();
}

class _DownloadCatalogosDialogHnState extends State<DownloadCatalogosDialogHn> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text(
        'Vista para descargar catalogos hn',
      ),
    );
  }
}

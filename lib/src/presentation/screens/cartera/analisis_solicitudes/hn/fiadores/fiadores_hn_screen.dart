import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/fiadores/fiadores_hn_form_screen.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/fiadores/fiadores_search_by_document_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/selectable_card/selectable_card_item.dart';
import 'package:flutter/material.dart';

class FiadoresHnScreen extends StatelessWidget {
  final int numeroSolicitud;
  const FiadoresHnScreen({super.key, required this.numeroSolicitud});

  @override
  Widget build(BuildContext context) {
    List<SelectableCardItem> items = [
      SelectableCardItem(
        color: AppColors.getPrimaryColor(),
        icon: Icons.person_pin_sharp,
        title: 'Conyugue',
        subtitle: 'Crear Fiador conyugue',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => FiadoresSearchByDocumentScreen(
                typeForm: FiadoresHnFormType.conyugue,
                numeroSolicitud: numeroSolicitud,
              ),
            ),
          );
        },
      ),
      SelectableCardItem(
        color: const Color(0xFF1E88E5),
        icon: Icons.verified_user,
        title: 'Aval',
        subtitle: 'Crear Fiador aval',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => FiadoresSearchByDocumentScreen(
                typeForm: FiadoresHnFormType.aval,
                numeroSolicitud: numeroSolicitud,
              ),
            ),
          );
        },
      ),
      SelectableCardItem(
        color: const Color(0xFF26A69A),
        icon: Icons.group_add,
        title: 'Codeudor',
        subtitle: 'Crear Fiador codeudor',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => FiadoresSearchByDocumentScreen(
                typeForm: FiadoresHnFormType.codeudor,
                numeroSolicitud: numeroSolicitud,
              ),
            ),
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fiadores'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(18),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return items[index];
        },
      ),
    );
  }
}

import 'package:core_financiero_app/src/presentation/widgets/shared/cards/selectable_card/selectable_card_item.dart';
import 'package:flutter/material.dart';

class ClientSignatureListData extends StatelessWidget {
  final VoidCallback onClientPossibleSignatureTap;
  final VoidCallback onClientNoPossibleSignatureTap;
  const ClientSignatureListData({
    super.key,
    required this.onClientPossibleSignatureTap,
    required this.onClientNoPossibleSignatureTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          SelectableCardItem(
            icon: Icons.edit,
            color: Colors.green,
            title: 'El cliente tiene posibilidad de firmar?',
            subtitle: 'Si, el cliente puede firmar el documento',
            onTap: onClientPossibleSignatureTap,
          ),
          SelectableCardItem(
            icon: Icons.edit_off_sharp,
            color: Colors.red,
            title: 'El cliente no tiene posibilidad de firmar?',
            subtitle: 'Si, el cliente no puede firmar el documento',
            onTap: onClientNoPossibleSignatureTap,
          ),
        ],
      ),
    );
  }
}

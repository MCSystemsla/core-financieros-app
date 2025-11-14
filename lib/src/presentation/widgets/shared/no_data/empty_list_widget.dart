import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EmptyListWidget extends StatelessWidget {
  final String message;

  const EmptyListWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox,
            size: 60,
            color: Colors.grey[400],
          ),
          const Gap(16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool enabled;
  const CustomSwitch({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.9,
      child: SwitchListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: enabled ? Colors.black87 : Colors.grey,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.black54),
        ),
        inactiveThumbColor: Colors.grey.shade400,
        inactiveTrackColor: Colors.grey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        value: value,
        onChanged: enabled ? onChanged : null,
      ),
    );
  }
}

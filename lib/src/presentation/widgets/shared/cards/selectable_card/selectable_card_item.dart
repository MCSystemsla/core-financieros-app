// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class SelectableCardItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isLoading;
  final bool userHaveDataAlready;
  final Icon? leading;

  const SelectableCardItem({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isLoading = false,
    this.userHaveDataAlready = false,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, size: 26, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff1F2937),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xff6B7280),
          ),
        ),
        trailing: leading ??
            (isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(),
                  )
                : IsUserHaveDataAlreadyWidget(
                    userHaveDataAlready: userHaveDataAlready,
                  )),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }
}

class IsUserHaveDataAlreadyWidget extends StatelessWidget {
  final bool userHaveDataAlready;
  const IsUserHaveDataAlreadyWidget({
    super.key,
    required this.userHaveDataAlready,
  });

  @override
  Widget build(BuildContext context) {
    return switch (userHaveDataAlready) {
      true => const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 28,
        ),
      false => const SizedBox.shrink(),
    };
  }
}

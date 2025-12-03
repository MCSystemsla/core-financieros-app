import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AnalisisCardItem {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  AnalisisCardItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });
}

class AnalisisCardListHn extends StatelessWidget {
  final VoidCallback onTap;
  final List<AnalisisCardItem> items;
  final String title;
  final int maxLines;
  final bool isLoading;
  const AnalisisCardListHn({
    super.key,
    required this.onTap,
    required this.items,
    required this.title,
    this.isLoading = false,
    this.maxLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const Gap(10),
          InkWell(
            onTap: onTap,
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Gap(10),
                    Container(
                      alignment: Alignment.centerRight,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Crear estadisticas',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          Gap(10),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    if (items.isEmpty) const Text('Ingresa items para ver'),
                    ...items.map(
                      (e) => _buildItem(
                        icon: e.icon,
                        label: e.label,
                        value: e.value,
                        color: e.color,
                        maxLines: maxLines,
                        isLoading: isLoading,
                      ).fadeIn(duration: const Duration(milliseconds: 500)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    int maxLines = 2,
    bool isLoading = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 60),
          child: Text(
            label,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        trailing: isLoading
            ? const SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                ),
              )
            : ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 120),
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
      ),
    );
  }
}

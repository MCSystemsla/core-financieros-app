import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ReceivedCard extends StatelessWidget {
  final int? count;
  final Color color;
  final String title;
  final bool isLoading;

  const ReceivedCard.withCount({
    super.key,
    required this.count,
    required this.color,
    required this.title,
    this.isLoading = false,
  });
  const ReceivedCard({
    super.key,
    required this.color,
    required this.title,
  })  : count = null,
        isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.12,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.white),
              ),
            ),
            const Spacer(),
            if (count != null)
              isLoading
                  ? const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                      ),
                    )
                  : Text(
                      count.toString(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: AppColors.white,
                            fontSize: 40,
                          ),
                    ),
          ],
        ),
      ),
    );
  }
}

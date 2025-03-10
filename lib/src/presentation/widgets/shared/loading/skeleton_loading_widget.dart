import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoadingWidget extends StatelessWidget {
  const SkeletonLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(
      12,
      (index) {
        return ListTile(
          title: Container(
            width: double.infinity,
            height: 16.0,
            color: Colors.grey[300],
          ),
          subtitle: Container(
            width: double.infinity,
            height: 12.0,
            margin: const EdgeInsets.only(top: 4.0),
            color: Colors.grey[300],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40.0,
                height: 12.0,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 5),
              Container(
                width: 40.0,
                height: 12.0,
                color: Colors.grey[300],
              ),
            ],
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.grey[300],
            radius: 20.0,
          ),
        );
      },
    );
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...items,
          ],
        ),
      ),
    );
  }
}

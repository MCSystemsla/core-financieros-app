import 'package:flutter/material.dart';

class SlidePageviewView extends StatelessWidget {
  const SlidePageviewView(
      {super.key, required this.controller, required this.title});
  final String title;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            iconSize: 18,
            onPressed: () {
              controller.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                ),
          ),
        ),
        Expanded(
          child: IconButton(
            iconSize: 18,
            onPressed: () {
              controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CustomPrimaryTextWidget extends StatelessWidget {
  final String text;
  const CustomPrimaryTextWidget({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

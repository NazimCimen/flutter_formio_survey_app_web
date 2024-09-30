import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/core/size/constant_size.dart';

@immutable
final class CustomBoxDecoration {
  const CustomBoxDecoration._();
  static BoxDecoration customBoxDecorationForImage(BuildContext context) {
    return BoxDecoration(
      borderRadius: ConstantSizes.small.borderRadius,
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      border: Border.all(
        color: Theme.of(context).colorScheme.tertiary,
        width: 2,
      ),
    );
  }

  static BoxDecoration customBoxDecoration(BuildContext context) {
    return BoxDecoration(
      border: Border.all(
        color: Theme.of(context).colorScheme.tertiary.withOpacity(0.4),
      ),
      borderRadius: BorderRadius.circular(12),
      color: Theme.of(context).colorScheme.scrim,
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).colorScheme.tertiaryFixed.withOpacity(0.1),
          offset: const Offset(0, 4),
          blurRadius: 2,
          spreadRadius: 2,
        ),
      ],
    );
  }

  static BoxDecoration storeCardDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.onSurface,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
      ),
    );
  }
}

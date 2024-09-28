part of '../view/add_question_view.dart';

class _BottomActionButtons extends StatelessWidget {
  final VoidCallback onPressedCancel;
  final VoidCallback onPressedSave;

  const _BottomActionButtons({
    required this.onPressedCancel,
    required this.onPressedSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: Responsive.isMobile(context)
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: onPressedCancel,
          child: Text(
            'CANCEL',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiaryFixed,
                ),
          ),
        ),
        TextButton(
          onPressed: onPressedSave,
          child: Text(
            'SAVE',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiaryFixed,
                ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_survey_app_web/core/size/padding_extension.dart';

class RegisterButtonWidget extends StatelessWidget {
  final VoidCallback navigateLogin;
  final VoidCallback navigateSignup;

  const RegisterButtonWidget(
      {required this.navigateLogin, required this.navigateSignup, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.cPaddingSmall,
      child: Row(
        children: [
          FeatureButton(
            text: 'Sign up',
            onPressed: navigateSignup,
            isFocused: false,
          ),
          FeatureButton(
            text: 'Log in',
            onPressed: navigateLogin,
            isFocused: true,
          ),
        ],
      ),
    );
  }
}

class FeatureButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isFocused;
  const FeatureButton({
    required this.text,
    required this.onPressed,
    required this.isFocused,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: isFocused
            ? Theme.of(context).colorScheme.tertiaryFixed
            : Colors.transparent,
        fixedSize: isFocused ? const Size(80, 30) : null,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isFocused
                  ? Theme.of(context).scaffoldBackgroundColor
                  : Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );
  }
}

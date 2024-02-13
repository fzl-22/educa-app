import 'package:education_app/src/auth/presentation/widgets/sign_in_screen.dart';
import 'package:flutter/material.dart';


class AuthNavigationButton extends StatelessWidget {
  const AuthNavigationButton({
    required this.normalText,
    required this.highlightedText,
    required this.onPressed,
    super.key,
  });

  final String normalText;
  final String highlightedText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$normalText '),
        AuthTextButton(
          onPressed: onPressed,
          child: Text(highlightedText),
        ),
      ],
    );
  }
}

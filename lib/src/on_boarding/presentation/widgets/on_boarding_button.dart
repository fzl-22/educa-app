import 'package:education_app/core/res/colours.dart';
import 'package:education_app/core/res/fonts.dart';
import 'package:flutter/material.dart';

class OnBoardingButton extends StatelessWidget {
  const OnBoardingButton({
    required this.onPressed,
    required this.child,
    super.key,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colours.primaryColour,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 17,
        ),
        textStyle: const TextStyle(
          fontFamily: Fonts.aeonik,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

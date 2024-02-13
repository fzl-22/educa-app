import 'package:educa_app/core/res/colours.dart';
import 'package:educa_app/core/res/fonts.dart';
import 'package:educa_app/core/res/text_styles.dart';
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
        foregroundColor: Colours.whiteColour,
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 17,
        ),
        textStyle: TextStyles.regular16.copyWith(
          fontFamily: Fonts.aeonik,
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

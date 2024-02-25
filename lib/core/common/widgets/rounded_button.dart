import 'package:educa_app/core/res/colours.dart';
import 'package:educa_app/core/res/text_styles.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.onPressed,
    required this.child,
    this.buttonColour,
    this.labelColour,
    super.key,
  });

  final VoidCallback onPressed;
  final Widget child;
  final Color? buttonColour;
  final Color? labelColour;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColour ?? Colours.primaryColour,
        foregroundColor: labelColour ?? Colors.white,
        minimumSize: const Size(double.maxFinite, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: TextStyles.medium16,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

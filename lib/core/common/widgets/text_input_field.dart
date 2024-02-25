import 'package:educa_app/core/res/text_styles.dart';
import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    required this.controller,
    this.validator,
    this.filled = false,
    this.fillColour,
    this.obscureText = false,
    this.readOnly = false,
    this.suffixIcon,
    this.hintText,
    this.keyboardType,
    this.overrideValidator = false,
    this.hintStyle,
    this.maxLines = 1,
    super.key,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool filled;
  final Color? fillColour;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool overrideValidator;
  final TextStyle? hintStyle;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: overrideValidator
          ? validator
          : (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return validator?.call(value);
            },
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        // overwriting the default padding helps with that puffy look
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        filled: filled,
        fillColor: fillColour,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle ?? TextStyles.regular16,
      ),
    );
  }
}

import 'package:educa_app/core/common/widgets/text_input_field.dart';
import 'package:educa_app/core/res/text_styles.dart';
import 'package:flutter/material.dart';

class EditProfileFormField extends StatelessWidget {
  const EditProfileFormField({
    required this.fieldTitle,
    required this.controller,
    this.readOnly = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.hintText,
    super.key,
  });

  final String fieldTitle;
  final TextEditingController controller;
  final bool readOnly;
  final bool obscureText;
  final int? maxLines;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            fieldTitle,
            style: TextStyles.bold11,
          ),
        ),
        const SizedBox(height: 10),
        TextInputField(
          controller: controller,
          hintText: hintText,
          readOnly: readOnly,
          obscureText: obscureText,
          maxLines: maxLines,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

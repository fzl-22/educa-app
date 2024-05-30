import 'package:educa_app/core/common/widgets/text_input_field.dart';
import 'package:educa_app/core/res/colours.dart';
import 'package:educa_app/core/res/text_styles.dart';
import 'package:flutter/material.dart';

class TitledInputField extends StatelessWidget {
  const TitledInputField({
    required this.controller,
    required this.title,
    this.required = true,
    this.hintText,
    this.hintStyle,
    this.suffixIcon,
    super.key,
  });

  final TextEditingController controller;
  final String title;
  final bool required;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: title,
                style: TextStyles.bold16
                    .copyWith(color: Colours.neutralTextColour),
                children: !required
                    ? null
                    : [
                        TextSpan(
                          text: ' *',
                          style: TextStyles.regular14.copyWith(
                            color: Colours.redColour,
                          ),
                        ),
                      ],
              ),
            ),
            if (suffixIcon != null) suffixIcon!,
          ],
        ),
        const SizedBox(height: 12),
        TextInputField(
          controller: controller,
          hintText: hintText ?? 'Enter $title',
          hintStyle: hintStyle,
          overrideValidator: true,
          validator: (value) {
            if (!required) return null;
            if (value == null || value.isEmpty) {
              return 'This field is required ';
            }
            return null;
          },
        ),
      ],
    );
  }
}

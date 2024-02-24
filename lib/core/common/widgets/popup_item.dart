import 'package:educa_app/core/res/text_styles.dart';
import 'package:flutter/material.dart';

class PopupItem extends StatelessWidget {
  const PopupItem({
    required this.title,
    required this.icon,
    super.key,
  });

  final String title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyles.medium16,
        ),
        icon,
      ],
    );
  }
}

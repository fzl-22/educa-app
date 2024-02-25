import 'package:educa_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class NestedBackButton extends StatelessWidget {
  const NestedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    var isUsedNavigation = false;

    return PopScope(
      canPop: isUsedNavigation,
      onPopInvoked: (didPop) {
        try {
          context.pop();
          isUsedNavigation = false;
        } catch (_) {
          isUsedNavigation = true;
        }
      },
      child: IconButton(
        onPressed: () {
          try {
            context.pop();
          } catch (_) {
            Navigator.of(context).pop();
          }
        },
        icon: Icon(
          context.platform == TargetPlatform.iOS
              ? Icons.arrow_back_ios_new
              : Icons.arrow_back,
        ),
      ),
    );
  }
}

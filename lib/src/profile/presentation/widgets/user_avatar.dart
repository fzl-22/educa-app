import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    required this.image,
    this.child,
    super.key,
  });

  final ImageProvider<Object> image;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: image,
          fit: BoxFit.contain,
        ),
      ),
      child: child,
    );
  }
}

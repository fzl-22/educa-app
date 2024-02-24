import 'package:educa_app/core/common/app/providers/user_provider.dart';
import 'package:educa_app/core/extensions/context_extension.dart';
import 'package:educa_app/core/res/colours.dart';
import 'package:educa_app/core/res/media_res.dart';
import 'package:educa_app/core/res/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Profile Picture ${context.currentUser?.profilePicture}');
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.user;
        final image =
            user?.profilePicture == null || user!.profilePicture!.isEmpty
                ? null
                : user.profilePicture;
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: image != null
                    ? NetworkImage(image)
                    : const AssetImage(MediaRes.user) as ImageProvider,
              ),
              const SizedBox(height: 16),
              Text(
                user?.fullName ?? 'No User',
                textAlign: TextAlign.center,
                style: TextStyles.bold23,
              ),
              if (user?.bio != null && user!.bio!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * .15,
                  ),
                  child: Text(
                    user.bio!,
                    textAlign: TextAlign.center,
                    style: TextStyles.regular11.copyWith(
                      color: Colours.neutralTextColour,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

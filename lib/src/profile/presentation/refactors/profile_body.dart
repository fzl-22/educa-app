import 'package:educa_app/core/common/app/providers/user_provider.dart';
import 'package:educa_app/core/res/colours.dart';
import 'package:educa_app/core/res/media_res.dart';
import 'package:educa_app/src/profile/presentation/widgets/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.user;
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 2 / 1,
          children: [
            UserInfoCard(
              infoThemeColor: Colours.physicsTileColour,
              infoIcon: const Icon(
                IconlyLight.document,
                color: Color(0xFF767DFF),
                size: 24,
              ),
              infoTitle: 'Courses',
              infoValue: user!.enrolledCourseIds.length.toString(),
            ),
            UserInfoCard(
              infoThemeColor: Colours.languageTileColour,
              infoIcon: Image.asset(
                MediaRes.scoreboard,
                height: 24,
                width: 24,
              ),
              infoTitle: 'My Score',
              infoValue: user.points.toString(),
            ),
            UserInfoCard(
              infoThemeColor: Colours.biologyTileColour,
              infoIcon: const Icon(
                IconlyLight.user,
                color: Color(0xFF56AEFF),
                size: 24,
              ),
              infoTitle: 'Followers',
              infoValue: user.followers.length.toString(),
            ),
            UserInfoCard(
              infoThemeColor: Colours.chemistryTileColour,
              infoIcon: const Icon(
                IconlyLight.user,
                color: Color(0xFFFF84AA),
                size: 24,
              ),
              infoTitle: 'Following',
              infoValue: user.following.length.toString(),
            ),
          ],
        );
      },
    );
  }
}

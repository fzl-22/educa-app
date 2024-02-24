import 'package:educa_app/core/common/widgets/gradient_background.dart';
import 'package:educa_app/core/res/media_res.dart';
import 'package:educa_app/src/profile/presentation/refactors/profile_body.dart';
import 'package:educa_app/src/profile/presentation/refactors/profile_header.dart';
import 'package:educa_app/src/profile/presentation/widgets/profile_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const ProfileAppBar(),
      body: GradientBackground(
        image: MediaRes.profileGradientBackground,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: const [
            ProfileHeader(),
            ProfileBody(),
          ],
        ),
      ),
    );
  }
}

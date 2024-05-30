import 'package:educa_app/core/common/app/providers/user_provider.dart';
import 'package:educa_app/core/extensions/context_extension.dart';
import 'package:educa_app/core/injection/injection_container.dart';
import 'package:educa_app/core/res/colours.dart';
import 'package:educa_app/core/res/media_res.dart';
import 'package:educa_app/src/course/presentations/cubit/course_cubit.dart';
import 'package:educa_app/src/course/presentations/widgets/add_course_sheet.dart';
import 'package:educa_app/src/profile/presentation/widgets/admin_button.dart';
import 'package:educa_app/src/profile/presentation/widgets/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.user;
        return Column(
          children: [
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 2 / 1,
              physics: const NeverScrollableScrollPhysics(),
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
            ),
            const SizedBox(height: 30),
            if (context.currentUser!.isAdmin) ...[
              AdminButton(
                label: 'Add Course',
                icon: IconlyLight.paper_upload,
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: Colors.white,
                    isScrollControlled: true,
                    showDragHandle: true,
                    elevation: 0,
                    useSafeArea: true,
                    builder: (context) {
                      return BlocProvider(
                        create: (context) => sl<CourseCubit>(),
                        child: const AddCourseSheet(),
                      );
                    },
                  );
                },
              ),
            ],
          ],
        );
      },
    );
  }
}

import 'dart:async';

import 'package:educa_app/core/common/widgets/popup_item.dart';
import 'package:educa_app/core/extensions/context_extension.dart';
import 'package:educa_app/core/injection/injection_container.dart';
import 'package:educa_app/core/res/colours.dart';
import 'package:educa_app/core/res/text_styles.dart';
import 'package:educa_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:educa_app/src/profile/presentation/views/edit_profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Account',
        style: TextStyles.bold23,
      ),
      actions: [
        PopupMenuButton(
          offset: const Offset(0, 50),
          surfaceTintColor: Colours.whiteColour,
          icon: const Icon(Icons.more_horiz_rounded),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          itemBuilder: (_) => [
            PopupMenuItem<void>(
              child: const PopupItem(
                title: 'Edit Profile',
                icon: Icon(
                  IconlyLight.edit,
                  color: Colours.neutralTextColour,
                ),
              ),
              onTap: () => context.push(
                BlocProvider(
                  create: (_) => sl<AuthBloc>(),
                  child: const EditProfileView(),
                ),
              ),
            ),
            PopupMenuItem<void>(
              child: const PopupItem(
                title: 'Notification',
                icon: Icon(
                  IconlyLight.notification,
                  color: Colours.neutralTextColour,
                ),
              ),
              onTap: () {},
            ),
            PopupMenuItem<void>(
              child: const PopupItem(
                title: 'Help',
                icon: Icon(
                  IconlyLight.info_circle,
                  color: Colours.neutralTextColour,
                ),
              ),
              onTap: () {},
            ),
            PopupMenuItem<void>(
              height: 1,
              padding: EdgeInsets.zero,
              child: Divider(
                height: 1,
                color: Colours.greyColour.shade200,
                indent: 16,
                endIndent: 16,
              ),
            ),
            PopupMenuItem<void>(
              child: const PopupItem(
                title: 'Logout',
                icon: Icon(
                  IconlyLight.logout,
                  color: Colours.redColour,
                ),
              ),
              onTap: () async {
                final navigator = Navigator.of(context);
                await sl<FirebaseAuth>().signOut();
                unawaited(
                  navigator.pushNamedAndRemoveUntil(
                    '/',
                    (route) => false,
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

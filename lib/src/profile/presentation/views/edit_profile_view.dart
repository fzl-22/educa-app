import 'dart:convert';
import 'dart:io';

import 'package:educa_app/core/common/widgets/gradient_background.dart';
import 'package:educa_app/core/common/widgets/nested_back_button.dart';
import 'package:educa_app/core/enums/update_user.dart';
import 'package:educa_app/core/extensions/context_extension.dart';
import 'package:educa_app/core/res/colours.dart';
import 'package:educa_app/core/res/media_res.dart';
import 'package:educa_app/core/res/text_styles.dart';
import 'package:educa_app/core/utils/core_utils.dart';
import 'package:educa_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:educa_app/src/profile/presentation/widgets/edit_profile_form.dart';
import 'package:educa_app/src/profile/presentation/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();
  final passwordController = TextEditingController();
  final oldPasswordController = TextEditingController();

  File? pickedImage;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    setState(() {
      pickedImage = File(image.path);
    });
  }

  bool get nameChanged =>
      context.currentUser?.fullName.trim() != fullNameController.text.trim();

  bool get emailChanged => emailController.text.trim().isNotEmpty;

  bool get bioChanged =>
      context.currentUser?.bio?.trim() != bioController.text.trim();

  bool get passwordChanged => passwordController.text.trim().isNotEmpty;

  bool get imageChanged => pickedImage != null;

  bool get nothingChanged =>
      !nameChanged &&
      !emailChanged &&
      !bioChanged &&
      !passwordChanged &&
      !imageChanged;

  @override
  void initState() {
    fullNameController.text = context.currentUser!.fullName.trim();
    bioController.text = context.currentUser!.bio?.trim() ?? '';
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    bioController.dispose();
    passwordController.dispose();
    oldPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UserUpdated) {
          CoreUtils.showSnackBar(context, 'Profile updated successfully');
          context.pop();
        } else if (state is AuthError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: const NestedBackButton(),
            title: const Text(
              'Edit Profile',
              style: TextStyles.bold23,
            ),
            actions: [
              StatefulBuilder(
                builder: (context, refresh) {
                  fullNameController.addListener(() => refresh(() {}));
                  emailController.addListener(() => refresh(() {}));
                  bioController.addListener(() => refresh(() {}));
                  passwordController.addListener(() => refresh(() {}));
                  return TextButton(
                    onPressed: () {
                      if (nothingChanged) context.pop();
                      final bloc = context.read<AuthBloc>();

                      if (passwordChanged) {
                        if (oldPasswordController.text.trim().isEmpty) {
                          CoreUtils.showSnackBar(
                            context,
                            'Please enter your own password',
                          );
                          return;
                        }

                        bloc.add(
                          UpdateUserEvent(
                            action: UpdateUserAction.password,
                            userData: jsonEncode({
                              'oldPassword': oldPasswordController.text.trim(),
                              'newPassword': passwordController.text.trim(),
                            }),
                          ),
                        );
                      }

                      if (nameChanged) {
                        bloc.add(
                          UpdateUserEvent(
                            action: UpdateUserAction.displayName,
                            userData: fullNameController.text.trim(),
                          ),
                        );
                      }

                      if (emailChanged) {
                        bloc.add(
                          UpdateUserEvent(
                            action: UpdateUserAction.email,
                            userData: emailController.text.trim(),
                          ),
                        );
                      }

                      if (bioChanged) {
                        bloc.add(
                          UpdateUserEvent(
                            action: UpdateUserAction.bio,
                            userData: bioController.text.trim(),
                          ),
                        );
                      }

                      if (imageChanged) {
                        bloc.add(
                          UpdateUserEvent(
                            action: UpdateUserAction.profilePicture,
                            userData: pickedImage,
                          ),
                        );
                      }
                    },
                    child: state is AuthLoading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Text(
                            'Done',
                            style: TextStyles.medium16.copyWith(
                              color: nothingChanged
                                  ? Colours.greyColour
                                  : Colours.primaryColour,
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
          body: GradientBackground(
            image: MediaRes.profileGradientBackground,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              children: [
                Builder(
                  builder: (context) {
                    final user = context.currentUser!;
                    final userImage = user.profilePicture == null ||
                            user.profilePicture!.isEmpty
                        ? null
                        : user.profilePicture;
                    return Center(
                      child: UserAvatar(
                        image: pickedImage != null
                            ? FileImage(pickedImage!)
                            : userImage != null
                                ? NetworkImage(userImage)
                                : const AssetImage(
                                    MediaRes.user,
                                  ) as ImageProvider,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colours.blackColour.withOpacity(0.5),
                          ),
                          child: IconButton(
                            onPressed: pickImage,
                            icon: Icon(
                              pickedImage != null || user.profilePicture != null
                                  ? IconlyLight.edit
                                  : IconlyLight.camera,
                              color: Colours.whiteColour,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'We recommend an image of at least 400x400',
                    textAlign: TextAlign.center,
                    style: TextStyles.regular14.copyWith(
                      color: const Color(0xFF777E90),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                EditProfileForm(
                  fullNameController: fullNameController,
                  emailController: emailController,
                  bioController: bioController,
                  passwordController: passwordController,
                  oldPasswordController: oldPasswordController,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

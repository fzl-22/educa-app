import 'package:educa_app/core/common/app/providers/user_provider.dart';
import 'package:educa_app/core/common/widgets/gradient_background.dart';
import 'package:educa_app/core/common/widgets/rounded_button.dart';
import 'package:educa_app/core/res/colours.dart';
import 'package:educa_app/core/res/fonts.dart';
import 'package:educa_app/core/res/media_res.dart';
import 'package:educa_app/core/res/text_styles.dart';
import 'package:educa_app/core/services/injection_container.dart';
import 'package:educa_app/core/utils/core_utils.dart';
import 'package:educa_app/src/auth/data/models/user_model.dart';
import 'package:educa_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:educa_app/src/auth/presentation/views/sign_in_screen.dart';
import 'package:educa_app/src/auth/presentation/widgets/auth_navigation_button.dart';
import 'package:educa_app/src/auth/presentation/widgets/sign_up_form.dart';
import 'package:educa_app/src/dashboard/presentation/views/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void register(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    sl<FirebaseAuth>().currentUser?.reload();

    if (!formKey.currentState!.validate()) {
      return;
    }

    context.read<AuthBloc>().add(
          SignUpEvent(
            email: emailController.text.trim(),
            fullName: fullNameController.text.trim(),
            password: passwordController.text.trim(),
          ),
        );
  }

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.whiteColour,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is SignedUp) {
            context.read<AuthBloc>().add(
                  SignInEvent(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  ),
                );
          } else if (state is SignedIn) {
            context.read<UserProvider>().initUser(state.user as LocalUserModel);
            Navigator.pushReplacementNamed(context, Dashboard.routeName);
          }
        },
        builder: (context, state) {
          return GradientBackground(
            image: MediaRes.authGradientBackground,
            child: SafeArea(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
                children: [
                  Text(
                    'Easy to learn, discover more skills',
                    style: TextStyles.bold32.copyWith(
                      fontFamily: Fonts.aeonik,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Sign up for an account',
                    style: TextStyles.regular16,
                  ),
                  const SizedBox(height: 20),
                  SignUpForm(
                    emailController: emailController,
                    fullNameController: fullNameController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                    formKey: formKey,
                  ),
                  const SizedBox(height: 40),
                  RoundedButton(
                    onPressed: () {
                      register(context);
                    },
                    child: state is AuthLoading
                        ? const Center(
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colours.whiteColour,
                              ),
                            ),
                          )
                        : const Text('Sign Up'),
                  ),
                  const SizedBox(height: 20),
                  AuthNavigationButton(
                    normalText: 'Already have an account?',
                    highlightedText: 'Log In',
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        SignInScreen.routeName,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

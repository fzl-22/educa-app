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
import 'package:educa_app/src/auth/presentation/views/sign_up_screen.dart';
import 'package:educa_app/src/auth/presentation/widgets/auth_navigation_button.dart';
import 'package:educa_app/src/auth/presentation/widgets/sign_in_form.dart';
import 'package:educa_app/src/auth/presentation/widgets/sign_in_screen.dart';
import 'package:educa_app/src/dashboard/presentation/views/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const routeName = '/signin';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void login(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    sl<FirebaseAuth>().currentUser?.reload();

    if (!formKey.currentState!.validate()) {
      return;
    }

    context.read<AuthBloc>().add(
          SignInEvent(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          ),
        );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                    'Sign in to your account',
                    style: TextStyles.regular16,
                  ),
                  const SizedBox(height: 20),
                  SignInForm(
                    emailController: emailController,
                    passwordController: passwordController,
                    formKey: formKey,
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AuthTextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/forgot-password',
                        );
                      },
                      child: const Text('Forgot password?'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  RoundedButton(
                    onPressed: () {
                      login(context);
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
                        : const Text('Sign In'),
                  ),
                  const SizedBox(height: 20),
                  AuthNavigationButton(
                    normalText: "Don't have an account?",
                    highlightedText: 'Register',
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        SignUpScreen.routeName,
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

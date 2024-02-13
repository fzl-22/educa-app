import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/res/fonts.dart';
import 'package:education_app/core/res/text_styles.dart';
import 'package:education_app/src/on_boarding/domain/entities/page_content.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:education_app/src/on_boarding/presentation/widgets/on_boarding_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({
    required this.pageContent,
    super.key,
  });

  final PageContent pageContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          pageContent.image,
          height: 0.4 * context.height,
        ),
        SizedBox(
          height: 0.04 * context.height,
        ),
        Padding(
          padding: const EdgeInsets.all(24).copyWith(bottom: 0),
          child: Column(
            children: [
              Text(
                pageContent.title,
                textAlign: TextAlign.center,
                style: TextStyles.bold32.copyWith(
                  fontFamily: Fonts.aeonik,
                ),
              ),
              SizedBox(
                height: 0.03 * context.height,
              ),
              Text(
                pageContent.description,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 0.05 * context.height,
              ),
              OnBoardingButton(
                onPressed: () {
                  context.read<OnBoardingCubit>().cacheFirstTimer();
                  // push user to the appropriate screen
                },
                child: const Text('Get Started'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

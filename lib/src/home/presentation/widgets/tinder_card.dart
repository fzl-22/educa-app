import 'package:educa_app/core/common/app/providers/course_of_the_day_provider.dart';
import 'package:educa_app/core/res/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class TinderCard extends StatelessWidget {
  const TinderCard({
    required this.isFirst,
    this.color,
    super.key,
  });

  final bool isFirst;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 137,
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        gradient: isFirst
            ? const LinearGradient(
                colors: [
                  Color(0xFF8E96FF),
                  Color(0xFFA06AF9),
                ],
              )
            : null,
        color: color,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(0, 5),
            blurRadius: 10,
          ),
        ],
      ),
      child: isFirst
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Builder(
                  builder: (context) {
                    final courseOfTheDay =
                        context.read<CourseOfTheDayProvider>().courseOfTheDay;
                    return Text(
                      '${courseOfTheDay?.title ?? 'Chemistry'} '
                      'final\nexams',
                      textAlign: TextAlign.left,
                      style: TextStyles.bold23.copyWith(
                        color: Colors.white,
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    const Icon(
                      IconlyLight.notification,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '45 minutes',
                      style: TextStyles.regular14.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            )
          : null,
    );

    // return Stack(
    //   children: [
    //
    //   ],
    // );
  }
}

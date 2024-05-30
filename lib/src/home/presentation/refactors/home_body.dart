import 'package:educa_app/core/common/app/providers/course_of_the_day_provider.dart';
import 'package:educa_app/core/common/views/loading_view.dart';
import 'package:educa_app/core/common/widgets/not_found_text.dart';
import 'package:educa_app/core/utils/core_utils.dart';
import 'package:educa_app/src/course/presentations/cubit/course_cubit.dart';
import 'package:educa_app/src/home/presentation/refactors/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  void _getCourses() {
    context.read<CourseCubit>().getCourses();
  }

  @override
  void initState() {
    super.initState();
    _getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseCubit, CourseState>(
      listener: (context, state) {
        if (state is CourseError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is CoursesLoaded && state.courses.isNotEmpty) {
          final courses = state.courses..shuffle();
          final courseOfTheDay = courses.first;
          context.read<CourseOfTheDayProvider>().courseOfTheDay =
              courseOfTheDay;
        }
      },
      builder: (context, state) {
        if (state is LoadingCourses) {
          return const LoadingView();
        } else if (state is CoursesLoaded && state.courses.isEmpty ||
            state is CourseError) {
          return const NotFoundText(
              'No courses found\nPlease contact admin or if you are admin, '
              'add courses');
        } else if (state is CoursesLoaded) {
          final courses = state.courses
            ..sort(
              (a, b) => b.updatedAt.compareTo(a.updatedAt),
            );

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              HomeHeader(),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
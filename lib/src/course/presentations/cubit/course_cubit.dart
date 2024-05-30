import 'package:bloc/bloc.dart';
import 'package:educa_app/src/course/domain/entities/course.dart';
import 'package:educa_app/src/course/domain/usecases/add_course.dart';
import 'package:educa_app/src/course/domain/usecases/get_courses.dart';
import 'package:equatable/equatable.dart';

part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit({
    required GetCourses getCourses,
    required AddCourse addCourse,
  })  : _getCourses = getCourses,
        _addCourse = addCourse,
        super(const CourseInitial());

  final GetCourses _getCourses;
  final AddCourse _addCourse;

  Future<void> getCourses() async {
    emit(const LoadingCourses());

    final result = await _getCourses();

    if (isClosed) return;

    result.fold(
      (failure) => emit(CourseError(message: failure.errorMessage)),
      (courses) => emit(CoursesLoaded(courses: courses)),
    );
  }

  Future<void> addCourse({
    required Course course,
  }) async {
    emit(const AddingCourse());

    final result = await _addCourse(course);

    if (isClosed) return;

    result.fold(
      (failure) => emit(CourseError(message: failure.errorMessage)),
      (_) => emit(const CourseAdded()),
    );
  }
}

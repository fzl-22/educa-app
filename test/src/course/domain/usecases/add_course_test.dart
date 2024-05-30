import 'package:dartz/dartz.dart';
import 'package:educa_app/src/course/domain/entities/course.dart';
import 'package:educa_app/src/course/domain/repos/course_repo.dart';
import 'package:educa_app/src/course/domain/usecases/add_course.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'course_repo.mock.dart';

void main() {
  late CourseRepo repo;
  late AddCourse usecase;

  final tCourse = Course.empty();

  setUp(() {
    repo = MockCourseRepo();
    usecase = AddCourse(repo);
    registerFallbackValue(tCourse);
  });

  test(
    'should call [CourseRepo.addCourse',
    () async {
      // Arrange
      when(() => repo.addCourse(any()))
          .thenAnswer((_) async => const Right(null));

      // Act
      await usecase.call(tCourse);

      // Assert
      verify(() => repo.addCourse(tCourse)).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}

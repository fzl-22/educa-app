import 'package:dartz/dartz.dart';
import 'package:educa_app/core/features/course/domain/entities/course.dart';
import 'package:educa_app/core/features/course/domain/repos/course_repo.dart';
import 'package:educa_app/core/features/course/domain/usecases/get_courses.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'course_repo.mock.dart';

void main() {
  late CourseRepo repo;
  late GetCourses usecase;

  setUp(() {
    repo = MockCourseRepo();
    usecase = GetCourses(repo);
  });

  test(
    'should get courses from the repo',
    () async {
      // Arrange
      when(() => repo.getCourses()).thenAnswer((_) async => const Right([]));

      // Act
      final result = await usecase();

      // Assert
      expect(result, const Right<dynamic, List<Course>>([]));
      verify(() => repo.getCourses()).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}

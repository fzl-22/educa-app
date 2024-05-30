import 'package:dartz/dartz.dart';
import 'package:educa_app/core/errors/exception.dart';
import 'package:educa_app/core/errors/failure.dart';
import 'package:educa_app/src/course/data/datasources/course_remote_data_source.dart';
import 'package:educa_app/src/course/data/models/course_model.dart';
import 'package:educa_app/src/course/data/repos/course_repo_impl.dart';
import 'package:educa_app/src/course/domain/entities/course.dart';
import 'package:educa_app/src/course/domain/repos/course_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCourseRemoteDataSource extends Mock
    implements CourseRemoteDataSource {}

void main() {
  late CourseRemoteDataSource remoteDataSource;
  late CourseRepoImpl repoImpl;

  final tCourse = CourseModel.empty();

  setUp(() {
    remoteDataSource = MockCourseRemoteDataSource();
    repoImpl = CourseRepoImpl(remoteDataSource);
    registerFallbackValue(tCourse);
  });

  const tException = ServerException(
    message: 'Something when wrong',
    statusCode: '500',
  );

  test('should be a subclass of [CourseRepo]', () {
    expect(repoImpl, isA<CourseRepo>());
  });

  group('addCourse', () {
    test(
      'should complete successfully when call to remote data source is '
      'successful',
      () async {
        when(() => remoteDataSource.addCourse(any())).thenAnswer(
          (_) async => Future.value(),
        );

        final result = await repoImpl.addCourse(tCourse);

        expect(result, equals(const Right<dynamic, void>(null)));
        verify(() => remoteDataSource.addCourse(tCourse)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [ServerFailure] when call to remote data '
      'source is unsuccessful',
      () async {
        when(() => remoteDataSource.addCourse(any())).thenThrow(tException);

        final result = await repoImpl.addCourse(tCourse);

        expect(
          result,
          Left<Failure, void>(ServerFailure.fromException(tException)),
        );
        verify(() => remoteDataSource.addCourse(tCourse)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getCourses', () {
    test(
      'should return a [List<Course>] when call to remote data source '
      'is successful',
      () async {
        when(() => remoteDataSource.getCourses())
            .thenAnswer((_) async => [tCourse]);

        final result = await repoImpl.getCourses();

        expect(result, isA<Right<dynamic, List<Course>>>());
        verify(() => remoteDataSource.getCourses()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [ServerFailure] when call to remote data source '
      'is unsuccessful',
      () async {
        when(() => remoteDataSource.getCourses()).thenThrow(tException);

        final result = await repoImpl.getCourses();

        expect(
          result,
          Left<Failure, List<Course>>(ServerFailure.fromException(tException)),
        );
        verify(() => remoteDataSource.getCourses()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}

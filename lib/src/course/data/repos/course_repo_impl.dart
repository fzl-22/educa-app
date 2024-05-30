import 'package:dartz/dartz.dart';
import 'package:educa_app/core/errors/exception.dart';
import 'package:educa_app/core/errors/failure.dart';
import 'package:educa_app/core/utils/typedef.dart';
import 'package:educa_app/src/course/data/datasources/course_remote_data_source.dart';
import 'package:educa_app/src/course/domain/entities/course.dart';
import 'package:educa_app/src/course/domain/repos/course_repo.dart';

class CourseRepoImpl implements CourseRepo {
  const CourseRepoImpl(this._remoteDataSource);

  final CourseRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> addCourse(Course course) async {
    try {
      await _remoteDataSource.addCourse(course);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Course>> getCourses() async {
    try {
      final courses = await _remoteDataSource.getCourses();
      return Right(courses);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}

import 'package:educa_app/core/usecase/usecase.dart';
import 'package:educa_app/core/utils/typedef.dart';
import 'package:educa_app/src/course/domain/entities/course.dart';
import 'package:educa_app/src/course/domain/repos/course_repo.dart';

class GetCourses extends UseCaseWithoutParams<List<Course>> {
  const GetCourses(this._repo);

  final CourseRepo _repo;

  @override
  ResultFuture<List<Course>> call() async {
    return _repo.getCourses();
  }
}

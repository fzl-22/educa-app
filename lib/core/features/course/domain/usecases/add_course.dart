import 'package:educa_app/core/features/course/domain/entities/course.dart';
import 'package:educa_app/core/features/course/domain/repos/course_repo.dart';
import 'package:educa_app/core/usecase/usecase.dart';
import 'package:educa_app/core/utils/typedef.dart';

class AddCourse extends UseCaseWithParams<void, Course> {
  const AddCourse(this._repo);

  final CourseRepo _repo;

  @override
  ResultFuture<void> call(Course params) async {
    return _repo.addCourse(params);
  }
}

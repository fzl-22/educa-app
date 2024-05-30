import 'package:educa_app/src/course/domain/entities/course.dart';
import 'package:flutter/foundation.dart';

class CourseOfTheDayProvider extends ChangeNotifier {
  Course? _courseOfTheDay;

  Course? get courseOfTheDay => _courseOfTheDay;

  set courseOfTheDay(Course? course) {
    _courseOfTheDay ??= course;
    notifyListeners();
  }
}

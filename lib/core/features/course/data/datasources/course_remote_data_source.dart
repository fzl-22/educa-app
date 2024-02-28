import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educa_app/core/features/course/data/models/course_model.dart';
import 'package:educa_app/core/features/course/domain/entities/course.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class CourseRemoteDataSource {
  const CourseRemoteDataSource();

  Future<List<CourseModel>> getCourses();

  Future<void> addCourse(Course course);
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  const CourseRemoteDataSourceImpl({
    required FirebaseAuth authClient,
    required FirebaseStorage cloudStorageClient,
    required FirebaseFirestore dbClient,
  })  : _authClient = authClient,
        _cloudStorageClient = cloudStorageClient,
        _dbClient = dbClient;

  final FirebaseAuth _authClient;
  final FirebaseStorage _cloudStorageClient;
  final FirebaseFirestore _dbClient;

  @override
  Future<void> addCourse(Course course) async {
    // TODO(addCourse): implement addCourse
    throw UnimplementedError();
  }

  @override
  Future<List<CourseModel>> getCourses() async {
    // TODO(getCourses): implement getCourses
    throw UnimplementedError();
  }
}

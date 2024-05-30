import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educa_app/core/errors/exception.dart';
import 'package:educa_app/src/chat/data/models/group_model.dart';
import 'package:educa_app/src/course/data/models/course_model.dart';
import 'package:educa_app/src/course/domain/entities/course.dart';
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
    try {
      final user = _authClient.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      final courseRef = _dbClient.collection('courses').doc();
      final groupRef = _dbClient.collection('groups').doc();

      var courseModel = (course as CourseModel).copyWith(
        id: courseRef.id,
        groupId: groupRef.id,
      );

      if (courseModel.imageIsFile) {
        final imageRef = _cloudStorageClient.ref().child(
              'courses/${courseModel.id}/profile_image/${courseModel.title}-pfp',
            );

        await imageRef.putFile(File(courseModel.image!)).then((value) async {
          final url = await value.ref.getDownloadURL();
          courseModel = courseModel.copyWith(image: url);
        });
      }

      await courseRef.set(courseModel.toMap());

      final group = GroupModel(
        id: groupRef.id,
        name: course.title,
        members: const [],
        courseId: courseRef.id,
        groupImageUrl: courseModel.image,
      );

      return groupRef.set(group.toMap());
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occured',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  @override
  Future<List<CourseModel>> getCourses() async {
    try {
      final user = _authClient.currentUser;
      if (user == null) {
        throw const ServerException(
          message: 'User is not authenticated',
          statusCode: '401',
        );
      }

      return _dbClient.collection('courses').get().then(
            (value) => value.docs
                .map((doc) => CourseModel.fromMap(doc.data()))
                .toList(),
          );
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occured',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }
}

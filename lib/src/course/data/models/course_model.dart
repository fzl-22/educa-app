import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educa_app/core/utils/typedef.dart';
import 'package:educa_app/src/course/domain/entities/course.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.title,
    required super.numberOfExams,
    required super.numberOfMaterials,
    required super.numberOfVideos,
    required super.groupId,
    required super.createdAt,
    required super.updatedAt,
    super.imageIsFile = false,
    super.description,
    super.image,
  });

  factory CourseModel.empty() {
    return CourseModel(
      id: '_empty.id',
      title: '_empty.title',
      numberOfExams: 0,
      numberOfMaterials: 0,
      numberOfVideos: 0,
      groupId: '_empty.groupId',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      description: '_empty.description',
    );
  }

  factory CourseModel.fromMap(DataMap map) {
    return CourseModel(
      id: (map['id'] ?? '') as String,
      title: (map['title'] ?? '') as String,
      numberOfExams: (map['numberOfExams'] ?? 0) as int,
      numberOfMaterials: (map['numberOfMaterials'] ?? 0) as int,
      numberOfVideos: (map['numberOfVideos'] ?? 0) as int,
      groupId: (map['groupId'] ?? '') as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      description: map['description'] as String?,
      image: map['image'] as String?,
    );
  }

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source) as DataMap);

  CourseModel copyWith({
    String? id,
    String? title,
    int? numberOfExams,
    int? numberOfMaterials,
    int? numberOfVideos,
    String? groupId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? imageIsFile,
    String? description,
    String? image,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      numberOfExams: numberOfExams ?? this.numberOfExams,
      numberOfMaterials: numberOfMaterials ?? this.numberOfMaterials,
      numberOfVideos: numberOfVideos ?? this.numberOfVideos,
      groupId: groupId ?? this.groupId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      imageIsFile: imageIsFile ?? this.imageIsFile,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'title': title,
      'numberOfExams': numberOfExams,
      'numberOfMaterials': numberOfMaterials,
      'numberOfVideos': numberOfVideos,
      'groupId': groupId,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'description': description,
      'image': image,
    };
  }

  String toJson() => json.encode(toMap());
}

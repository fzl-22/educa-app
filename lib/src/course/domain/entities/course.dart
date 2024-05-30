import 'package:equatable/equatable.dart';

class Course extends Equatable {
  const Course({
    required this.id,
    required this.title,
    required this.numberOfExams,
    required this.numberOfMaterials,
    required this.numberOfVideos,
    required this.groupId,
    required this.createdAt,
    required this.updatedAt,
    this.imageIsFile = false,
    this.description,
    this.image,
  });

  factory Course.empty() {
    return Course(
      id: '_empty.id',
      title: '_empty.title',
      numberOfExams: 0,
      numberOfMaterials: 0,
      numberOfVideos: 0,
      groupId: '_empty.groupId',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      description: '_empty.description',
      image: '_empty.image',
    );
  }

  final String id;
  final String title;
  final int numberOfExams;
  final int numberOfMaterials;
  final int numberOfVideos;
  final String groupId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool imageIsFile;
  final String? description;
  final String? image;

  @override
  List<String> get props => [id];
}

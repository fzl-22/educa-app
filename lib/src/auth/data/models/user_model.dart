import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.points,
    required super.fullName,
    super.groupIds,
    super.enrolledCourseIds,
    super.following,
    super.followers,
    super.profilePicture,
    super.bio,
  });

  factory LocalUserModel.fromMap(DataMap map) {
    return LocalUserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      points: (map['points'] as num).toInt(),
      fullName: map['fullName'] as String,
      groupIds: (map['groupIds'] as List<dynamic>).cast<String>(),
      enrolledCourseIds:
          (map['enrolledCourseIds'] as List<dynamic>).cast<String>(),
      following: (map['following'] as List<dynamic>).cast<String>(),
      followers: (map['followers'] as List<dynamic>).cast<String>(),
      profilePicture: map['profilPicture'] as String?,
      bio: map['bio'] as String?,
    );
  }

  factory LocalUserModel.empty() {
    return const LocalUserModel(
      uid: '',
      email: '',
      points: 0,
      fullName: '',
    );
  }

  DataMap toMap() {
    return {
      'uid': uid,
      'email': email,
      'points': points,
      'fullName': fullName,
      'groupIds': groupIds,
      'enrolledCourseIds': enrolledCourseIds,
      'following': following,
      'followers': followers,
      'profilePicture': profilePicture,
      'bio': bio,
    };
  }

  LocalUserModel copyWith({
    String? uid,
    String? email,
    int? points,
    String? fullName,
    List<String>? groupIds,
    List<String>? enrolledCourseIds,
    List<String>? following,
    List<String>? followers,
    String? profilePicture,
    String? bio,
  }) {
    return LocalUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      points: points ?? this.points,
      fullName: fullName ?? this.fullName,
      groupIds: groupIds ?? this.groupIds,
      enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
      following: following ?? this.following,
      followers: followers ?? this.followers,
      profilePicture: profilePicture ?? this.profilePicture,
      bio: bio ?? this.bio,
    );
  }
}

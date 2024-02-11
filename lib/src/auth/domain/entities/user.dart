import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    required this.points,
    required this.fullName,
    required this.groupId,
    required this.enrolledCourseId,
    required this.following,
    required this.followers,
    this.profilePicture,
    this.bio,
  });

  factory LocalUser.empty() {
    return const LocalUser(
      uid: '',
      email: '',
      points: 0,
      fullName: '',
      groupId: [],
      enrolledCourseId: [],
      following: [],
      followers: [],
    );
  }

  final String uid;
  final String email;
  final int points;
  final String fullName;
  final List<String> groupId;
  final List<String> enrolledCourseId;
  final List<String> following;
  final List<String> followers;
  final String? profilePicture;
  final String? bio;

  @override
  List<Object?> get props => [uid, email];

  @override
  String toString() {
    return 'LocalUser(uid: $uid, email: $email, fullName: $fullName, '
        'bio: $bio, points: $points)';
  }
}

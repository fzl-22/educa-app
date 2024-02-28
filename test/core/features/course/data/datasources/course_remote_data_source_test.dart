import 'package:educa_app/core/features/course/data/datasources/course_remote_data_source.dart';
import 'package:educa_app/core/features/course/data/models/course_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

void main() {
  late CourseRemoteDataSource remoteDataSource;
  late MockFirebaseAuth authClient;
  late MockFirebaseStorage cloudStorageClient;
  late FakeFirebaseFirestore dbClient;

  setUp(() async {
    final user = MockUser(
      uid: 'uid',
      email: 'email',
      displayName: 'displayName',
    );

    final googleSignIn = MockGoogleSignIn();
    final signInAccount = await googleSignIn.signIn();
    final googleAuth = await signInAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    authClient = MockFirebaseAuth(mockUser: user);
    await authClient.signInWithCredential(credential);

    cloudStorageClient = MockFirebaseStorage();

    dbClient = FakeFirebaseFirestore();

    remoteDataSource = CourseRemoteDataSourceImpl(
      authClient: authClient,
      cloudStorageClient: cloudStorageClient,
      dbClient: dbClient,
    );
  });

  group('addCourse', () {
    test(
      'should add the given course to the dbClient collection',
      () async {
        // arrange
        final tCourse = CourseModel.empty();

        // act
        await remoteDataSource.addCourse(tCourse);

        // assert
        final dbClientData = await dbClient.collection('courses').get();
        expect(dbClientData.docs.length, 1);

        final courseRef = dbClientData.docs.first;
        expect(courseRef.data()['id'], courseRef.id);

        final groupData = await dbClient.collection('groups').get();
        expect(groupData.docs.length, 1);

        final groupRef = groupData.docs.first;
        expect(groupRef.data()['id'], groupRef.id);

        expect(courseRef.data()['groupId'], groupRef.id);
        expect(groupRef.data()['courseId'], courseRef.id);
      },
    );
  });
}

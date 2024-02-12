import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/errors/exception.dart';
import 'package:education_app/core/utils/constants.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<void> forgotPassword(String email);

  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({
    required FirebaseAuth authClient,
    required FirebaseFirestore dbClient,
    required FirebaseStorage cloudStorageClient,
  })  : _authClient = authClient,
        _dbClient = dbClient,
        _cloudStorageClient = cloudStorageClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _dbClient;
  final FirebaseStorage _cloudStorageClient;

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _authClient.sendPasswordResetEmail(
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error ',
        statusCode: e.code,
      );
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;

      if (user == null) {
        throw const ServerException(
          message: 'Please try again later',
          statusCode: 'Unknown error',
        );
      }

      var userData = await _getUserData(user.uid);

      if (userData.exists) {
        return LocalUserModel.fromMap(userData.data()!);
      }

      // upload the user;
      await _setUserData(
        user,
        email,
      );

      userData = await _getUserData(user.uid);

      return LocalUserModel.fromMap(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error ',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      final userCred = await _authClient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCred.user?.updateDisplayName(fullName);
      await userCred.user?.updatePhotoURL(kDefaultAvatar);

      await _setUserData(_authClient.currentUser!, email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      if (action case UpdateUserAction.email) {
        await _authClient.currentUser
            ?.verifyBeforeUpdateEmail(userData as String);
        await _updateUserData({'email': userData});
      } else if (action case UpdateUserAction.displayName) {
        await _authClient.currentUser?.updateDisplayName(userData as String);
        await _updateUserData({'fullName': userData});
      } else if (action case UpdateUserAction.profilePicture) {
        final ref = _cloudStorageClient
            .ref()
            .child('profile_pictures/${_authClient.currentUser?.uid}');
        await ref.putFile(userData as File);
        final url = await ref.getDownloadURL();
        await _authClient.currentUser?.updatePhotoURL(url);
        await _updateUserData({'profilePicture': url});
      } else if (action case UpdateUserAction.password) {
        if (_authClient.currentUser?.email == null) {
          throw const ServerException(
            message: 'User does not exist',
            statusCode: 'Insufficient Permission',
          );
        }
        final newData = jsonDecode(userData as String) as DataMap;
        await _authClient.currentUser?.reauthenticateWithCredential(
          EmailAuthProvider.credential(
            email: _authClient.currentUser!.email!,
            password: newData['oldPassword'] as String,
          ),
        );
        await _authClient.currentUser?.updatePassword(
          newData['newPassword'] as String,
        );
      } else if (action case UpdateUserAction.bio) {
        await _updateUserData({'bio': userData as String});
      }
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  Future<DocumentSnapshot<DataMap>> _getUserData(String uid) async {
    return _dbClient.collection('users').doc(uid).get();
  }

  Future<void> _setUserData(User user, String fallbackEmail) async {
    await _dbClient.collection('users').doc(user.uid).set(
          LocalUserModel(
            uid: user.uid,
            email: user.email ?? fallbackEmail,
            points: 0,
            fullName: user.displayName ?? '',
            profilePicture: user.photoURL ?? '',
          ).toMap(),
        );
  }

  Future<void> _updateUserData(DataMap data) async {
    await _dbClient
        .collection('users')
        .doc(_authClient.currentUser?.uid)
        .update(data);
  }
}

import 'dart:convert';

import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/auth/data/models/user_model.dart';
import 'package:education_app/src/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  // Setup
  // benchmark of [LocalUserModel]
  final tLocalUserModel = LocalUserModel.empty();

  test(
    'should be a subclass of [LocalUser] entity',
    () => expect(tLocalUserModel, isA<LocalUser>()),
  );

  final tMap = jsonDecode(fixture('user.json')) as DataMap;

  group('fromMap', () {
    test(
      'should return a valid [LocalUserModel] from the map',
      () {
        // Act
        final result = LocalUserModel.fromMap(tMap);

        expect(result, isA<LocalUserModel>());
        // see if it satisfies the benchmark of [LocalUserModel]
        expect(result, equals(tLocalUserModel));
      },
    );

    test(
      'should throw an [Error] when the map is invalid',
      () {
        final errorMap = DataMap.from(tMap)..remove('uid');

        const call = LocalUserModel.fromMap;

        expect(
          () => call(errorMap),
          throwsA(isA<Error>()),
        );
      },
    );
  });

  group('toMap', () {
    test(
      'should return a valid [DataMap] from the model',
      () {
        final result = tLocalUserModel.toMap();

        expect(result, equals(tMap));
      },
    );
  });

  group('copyWith', () {
    test(
      'should return a valid [LocalUserModel] with updated values',
      () {
        final result = tLocalUserModel.copyWith(fullName: 'John Doe');

        expect(result.fullName, 'John Doe');
      },
    );
  });
}

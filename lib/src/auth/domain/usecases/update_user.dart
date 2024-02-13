import 'package:educa_app/core/enums/update_user.dart';
import 'package:educa_app/core/usecase/usecase.dart';
import 'package:educa_app/core/utils/typedef.dart';
import 'package:educa_app/src/auth/domain/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

class UpdateUser extends UseCaseWithParams<void, UpdateUserParams> {
  const UpdateUser(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(UpdateUserParams params) {
    return _repo.updateUser(
      action: params.action,
      userData: params.userData,
    );
  }
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.action,
    required this.userData,
  });

  factory UpdateUserParams.empty() {
    return const UpdateUserParams(
      action: UpdateUserAction.displayName,
      userData: '',
    );
  }

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<Object?> get props => [action, userData];
}

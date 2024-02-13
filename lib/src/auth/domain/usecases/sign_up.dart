import 'package:educa_app/core/usecase/usecase.dart';
import 'package:educa_app/core/utils/typedef.dart';
import 'package:educa_app/src/auth/domain/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

class SignUp extends UseCaseWithParams<void, SignUpParams> {
  const SignUp(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(SignUpParams params) {
    return _repo.signUp(
      email: params.email,
      fullName: params.fullName,
      password: params.password,
    );
  }
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.fullName,
    required this.password,
  });

  factory SignUpParams.empty() {
    return const SignUpParams(
      email: '',
      fullName: '',
      password: '',
    );
  }

  final String email;
  final String fullName;
  final String password;

  @override
  List<Object?> get props => [
        email,
        fullName,
        password,
      ];
}

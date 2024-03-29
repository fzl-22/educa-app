import 'package:educa_app/core/usecase/usecase.dart';
import 'package:educa_app/core/utils/typedef.dart';
import 'package:educa_app/src/auth/domain/repos/auth_repo.dart';

class ForgotPassword extends UseCaseWithParams<void, String> {
  const ForgotPassword(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(String params) {
    return _repo.forgotPassword(params);
  }
}

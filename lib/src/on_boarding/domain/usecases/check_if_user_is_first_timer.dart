import 'package:education_app/core/usecase/usecase.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';

class CheckIfUserIsFirstTimer extends UseCaseWithoutParams<bool> {
  CheckIfUserIsFirstTimer(
    this._repo,
  );

  final OnBoardingRepo _repo;

  @override
  ResultFuture<bool> call() {
    return _repo.checkIfUserIsFirstTimer();
  }
}

import 'package:educa_app/core/usecase/usecase.dart';
import 'package:educa_app/core/utils/typedef.dart';
import 'package:educa_app/src/on_boarding/domain/repos/on_boarding_repo.dart';

class CacheFirstTimer extends UseCaseWithoutParams<void> {
  CacheFirstTimer(
    this._repo,
  );

  final OnBoardingRepo _repo;

  @override
  ResultFuture<void> call() {
    return _repo.cacheFirstTimer();
  }
}

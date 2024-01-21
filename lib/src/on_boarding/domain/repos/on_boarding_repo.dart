import 'package:education_app/core/utils/typedef.dart';

abstract class OnBoardingRepo {
  ResultFuture<void> cacheFirstTimer();

  ResultFuture<bool> checkIfUserIsFirstTimer();
}

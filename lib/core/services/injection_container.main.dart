part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initOnBoarding();
  await _initAuth();
}

Future<void> _initAuth() async {
  final authClient = FirebaseAuth.instance;
  final dbClient = FirebaseFirestore.instance;
  final cloudStorageClient = FirebaseStorage.instance;

  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signUp: sl(),
        forgotPassword: sl(),
        updateUser: sl(),
      ),
    )
    ..registerLazySingleton(
      () => SignIn(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => SignUp(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => ForgotPassword(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => UpdateUser(
        sl(),
      ),
    )
    ..registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(
        sl(),
      ),
    )
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        authClient: sl(),
        dbClient: sl(),
        cloudStorageClient: sl(),
      ),
    )
    ..registerLazySingleton(
      () => authClient,
    )
    ..registerLazySingleton(
      () => dbClient,
    )
    ..registerLazySingleton(
      () => cloudStorageClient,
    );
}

Future<void> _initOnBoarding() async {
  final prefs = await SharedPreferences.getInstance();
  sl
    ..registerFactory(
      () => OnBoardingCubit(
        cacheFirstTimer: sl(),
        checkIfUserIsFirstTimer: sl(),
      ),
    )
    ..registerLazySingleton(
      () => CacheFirstTimer(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => CheckIfUserIsFirstTimer(
        sl(),
      ),
    )
    ..registerLazySingleton<OnBoardingRepo>(
      () => OnBoardingRepoImpl(
        sl(),
      ),
    )
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSourceImpl(
        sl(),
      ),
    )
    ..registerLazySingleton(
      () => prefs,
    );
}

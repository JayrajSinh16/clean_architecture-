import 'package:clean/core/secrets/app_secrets.dart';
import 'package:clean/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean/features/auth/data/repository/auth_repository_impl.dart';
import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:clean/features/auth/domain/usecases/current_user.dart';
import 'package:clean/features/auth/domain/usecases/user_login.dart';
import 'package:clean/features/auth/domain/usecases/user_sign_up.dart';
import 'package:clean/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  // _initBlog();

  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supaAnonKey,
  );

  // Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => supabase.client);

  // serviceLocator.registerLazySingleton(
  //   () => Hive.box(name: 'blogs'),
  // );

  // serviceLocator.registerFactory(() => InternetConnection());

  // // core
  // serviceLocator.registerLazySingleton(
  //   () => AppUserCubit(),
  // );
  // serviceLocator.registerFactory<ConnectionChecker>(
  //   () => ConnectionCheckerImpl(
  //     serviceLocator(),
  //   ),
  // );
}

void _initAuth() {
  // Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogIn(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogIn: serviceLocator(),
        currentUser: serviceLocator(),
        // appUserCubit: serviceLocator(),
      ),
    );
}

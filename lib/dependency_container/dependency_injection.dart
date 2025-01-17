import 'package:get_it/get_it.dart';
import 'package:task_mangement/modules/authentication/data/abstract/auth_abstract.dart';
import 'package:task_mangement/modules/authentication/data/datasource/remote/auth_remote_data_source.dart';
import 'package:task_mangement/modules/authentication/data/repositories/auth_repository_implement.dart';
import 'package:task_mangement/modules/authentication/domain/usecases/auth_login_usecase.dart';
import 'package:task_mangement/modules/authentication/presentation/bloc/auth/bloc/auth_bloc.dart';
import '../modules/authentication/domain/repositories/auth_repository.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;
Future<void> init() async {
  //Mark: - Authentication

  // Bloc
  sl.registerFactory(() => AuthBloc(loginUsecase: sl()));

  // UseCase
  sl.registerLazySingleton(() => AuthLoginUsecase(sl()));

  // Repository
  sl.registerLazySingleton<AuthenticationLoginRepository>(
      () => AuthLoginRepositoryImplement(authenticationDataSource: sl()));

  // DataSource
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImplementation(clientSide: sl()));

  // Core

  // Client Side
  sl.registerLazySingleton(() => http.Client());
}
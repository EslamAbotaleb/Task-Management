import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:task_mangement/modules/authentication/data/abstract/auth_abstract.dart';
import 'package:task_mangement/modules/authentication/data/datasource/remote/auth_remote_data_source.dart';
import 'package:task_mangement/modules/authentication/data/repositories/auth_repository_implement.dart';
import 'package:task_mangement/modules/authentication/domain/usecases/auth_login_usecase.dart';
import 'package:task_mangement/modules/authentication/presentation/bloc/auth/bloc/auth_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../core/network/abstract/network_abstract.dart';
import '../core/network/network_info.dart';
import '../modules/authentication/domain/repositories/auth_repository.dart';

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
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Client Side
  sl.registerLazySingleton(() => http.Client());

  //Internet
    sl.registerLazySingleton(() => InternetConnectionChecker.instance);

}

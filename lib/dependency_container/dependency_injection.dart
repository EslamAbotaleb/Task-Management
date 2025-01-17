import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:task_mangement/modules/authentication/data/abstract/auth_abstract.dart';
import 'package:task_mangement/modules/authentication/data/datasource/remote/auth_remote_data_source.dart';
import 'package:task_mangement/modules/authentication/data/repositories/auth_repository_implement.dart';
import 'package:task_mangement/modules/authentication/domain/usecases/auth_login_usecase.dart';
import 'package:task_mangement/modules/authentication/presentation/bloc/auth/bloc/auth_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task_mangement/modules/todos/data/datasource/remote/abstract/todo_abstract_remote.dart';
import 'package:task_mangement/modules/todos/data/datasource/remote/todo_remote_data_source.dart';
import 'package:task_mangement/modules/todos/data/repositories/todo_repository_implement.dart';
import 'package:task_mangement/modules/todos/domain/repositories/todo_repository.dart';
import 'package:task_mangement/modules/todos/domain/usecases/todo_usecase.dart';
import 'package:task_mangement/modules/todos/presentation/crud_todo_bloc/bloc/crud_bloc.dart';
import '../core/network/abstract/network_abstract.dart';
import '../core/network/network_info.dart';
import '../modules/authentication/domain/repositories/auth_repository.dart';
import '../modules/todos/domain/usecases/add_todo.dart';
import '../modules/todos/domain/usecases/delete_todo.dart';
import '../modules/todos/domain/usecases/update_todo.dart';
import '../modules/todos/presentation/todo_bloc/bloc/todos_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //Mark: - Authentication

  // Bloc
  sl.registerFactory(() => AuthBloc(loginUsecase: sl()));
  sl.registerFactory(() => TodosBloc(todosByPaginateUseCase: sl()));
  sl.registerFactory(
      () => CrudBloc(addTodo: sl(), updateTodo: sl(), deleteTodo: sl()));

  // UseCase
  sl.registerLazySingleton(() => AuthLoginUsecase(sl()));
  sl.registerLazySingleton(() => GetTodosByPaginateUseCase(sl()));
  sl.registerLazySingleton(() => AddTodoUsecase(sl()));
  sl.registerLazySingleton(() => DeleteTodoUsecase(sl()));
  sl.registerLazySingleton(() => UpdateTodoUsecase(sl()));

  // Repository
  sl.registerLazySingleton<AuthenticationLoginRepository>(
      () => AuthLoginRepositoryImplement(authenticationDataSource: sl()));
  sl.registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImplement(remoteDataSource: sl(), networkInfo: sl()));

  // DataSource
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImplementation(clientSide: sl()));
  sl.registerLazySingleton<TodoRemoteDataSource>(
      () => TodoRemoteDataSourceImplementation(client: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Client Side
  sl.registerLazySingleton(() => http.Client());

  //Internet
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);
}

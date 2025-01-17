
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_mangement/core/error/failures.dart';
import 'package:task_mangement/modules/authentication/domain/entities/login_entity.dart';
import 'package:task_mangement/modules/authentication/domain/usecases/auth_login_usecase.dart';
import 'package:task_mangement/modules/authentication/presentation/bloc/auth/bloc/auth_bloc.dart';

class MockAuthLoginUsecase extends Mock implements AuthLoginUsecase {}

void main() {
  late AuthBloc authBloc;
  late MockAuthLoginUsecase mockAuthLoginUsecase;

  setUp(() {
    mockAuthLoginUsecase = MockAuthLoginUsecase();
    authBloc = AuthBloc(loginUsecase: mockAuthLoginUsecase);
  });

  test('emits [AuthLoading, AuthSuccess] when login is successful', () async {
    // arrange
    final tLoginEntity = LoginEntity(accessToken: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJlbWlseXMiLCJlbWFpbCI6ImVtaWx5LmpvaG5zb25AeC5kdW1teWpzb24uY29tIiwiZmlyc3ROYW1lIjoiRW1pbHkiLCJsYXN0TmFtZSI6IkpvaG5zb24iLCJnZW5kZXIiOiJmZW1hbGUiLCJpbWFnZSI6Imh0dHBzOi8vZHVtbXlqc29uLmNvbS9pY29uL2VtaWx5cy8xMjgiLCJpYXQiOjE3MzcxMjA3MDMsImV4cCI6MTczNzEyNDMwM30.-vmN_8UbJ2RX8SSvfWA8v8aCbHke4YtFSFiTVxUm3is');
    when(() => mockAuthLoginUsecase.call(userName: 'emilys', password: 'emilyspass'))
        .thenAnswer((_) async => Right(tLoginEntity));

    // act
    authBloc.add(const LoginEvent(userName: 'emilys', password: 'emilyspass'));

    // assert
    await expectLater(
      authBloc.stream,
      emitsInOrder([AuthLoading(), AuthSuccess(loginEntity: tLoginEntity)]),
    );
  });

  test('emits [AuthLoading, AuthError] when login fails', () async {
    // arrange
    when(() => mockAuthLoginUsecase.call(userName: 'emilys', password: 'emilyspass'))
        .thenAnswer((_) async => Left(ServerFailure()));

    // act
    authBloc.add(const LoginEvent(userName: 'emilys', password: 'emilyspass'));

    // assert
    await expectLater(
      authBloc.stream,
      emitsInOrder([AuthLoading(), const AuthError(message: 'Try again later!!!')]),
    );
  });
}
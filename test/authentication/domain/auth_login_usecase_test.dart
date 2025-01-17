import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_mangement/core/error/failures.dart';
import 'package:task_mangement/modules/authentication/domain/entities/login_entity.dart';
import 'package:task_mangement/modules/authentication/domain/repositories/auth_repository.dart';
import 'package:task_mangement/modules/authentication/domain/usecases/auth_login_usecase.dart';

class MockAuthRepository extends Mock
    implements AuthenticationLoginRepository {}

void main() {
  late AuthLoginUsecase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = AuthLoginUsecase(mockAuthRepository);
  });

  final tLoginEntity = LoginEntity(
      accessToken:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJlbWlseXMiLCJlbWFpbCI6ImVtaWx5LmpvaG5zb25AeC5kdW1teWpzb24uY29tIiwiZmlyc3ROYW1lIjoiRW1pbHkiLCJsYXN0TmFtZSI6IkpvaG5zb24iLCJnZW5kZXIiOiJmZW1hbGUiLCJpbWFnZSI6Imh0dHBzOi8vZHVtbXlqc29uLmNvbS9pY29uL2VtaWx5cy8xMjgiLCJpYXQiOjE3MzcxMjA3MDMsImV4cCI6MTczNzEyNDMwM30.-vmN_8UbJ2RX8SSvfWA8v8aCbHke4YtFSFiTVxUm3is');
  const tUserName = 'emilys';
  const tPassword = 'emilyspass';

  test('should return LoginEntity when the login is successful', () async {
    // arrange
    when(() => mockAuthRepository.login(
            userName: any(named: 'userName'), password: any(named: 'password')))
        .thenAnswer((_) async => Right(tLoginEntity));

    // act
    final result = await usecase.call(userName: tUserName, password: tPassword);

    // assert
    expect(result, Right(tLoginEntity));
    verify(() => mockAuthRepository.login(
        userName: tUserName, password: tPassword)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return ServerFailure when the login is unsuccessful', () async {
    // arrange
    when(() => mockAuthRepository.login(
            userName: any(named: 'userName'), password: any(named: 'password')))
        .thenAnswer((_) async => Left(ServerFailure()));

    // act
    final result = await usecase.call(userName: tUserName, password: tPassword);

    // assert
    expect(result, Left(ServerFailure()));
    verify(() => mockAuthRepository.login(
        userName: tUserName, password: tPassword)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}

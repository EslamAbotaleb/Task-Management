import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_mangement/core/error/exceptions.dart';
import 'package:task_mangement/core/error/failures.dart';
import 'package:task_mangement/modules/authentication/data/abstract/auth_abstract.dart';
import 'package:task_mangement/modules/authentication/data/repositories/auth_repository_implement.dart';
import 'package:task_mangement/modules/authentication/domain/entities/login_entity.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthLoginRepositoryImplement repository;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthLoginRepositoryImplement(
        authenticationDataSource: mockAuthRemoteDataSource);
  });

  group('AuthLoginRepositoryImplement', () {
    final tLoginEntity = LoginEntity(
        accessToken:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJlbWlseXMiLCJlbWFpbCI6ImVtaWx5LmpvaG5zb25AeC5kdW1teWpzb24uY29tIiwiZmlyc3ROYW1lIjoiRW1pbHkiLCJsYXN0TmFtZSI6IkpvaG5zb24iLCJnZW5kZXIiOiJmZW1hbGUiLCJpbWFnZSI6Imh0dHBzOi8vZHVtbXlqc29uLmNvbS9pY29uL2VtaWx5cy8xMjgiLCJpYXQiOjE3MzcxMjA3MDMsImV4cCI6MTczNzEyNDMwM30.-vmN_8UbJ2RX8SSvfWA8v8aCbHke4YtFSFiTVxUm3is');
    const tUserName = 'emilys';
    const tPassword = 'emilyspass';

    test(
        'should return a LoginEntity when the remote data source is successful',
        () async {
      // arrange
      when(() => mockAuthRemoteDataSource.login(
              userName: any(named: 'userName'),
              password: any(named: 'password')))
          .thenAnswer((_) async => tLoginEntity);
      // act
      final result =
          await repository.login(userName: tUserName, password: tPassword);

      // assert
      expect(result, equals(Right(tLoginEntity)));
      verify(() => mockAuthRemoteDataSource.login(
            userName: tUserName,
            password: tPassword,
          )).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDataSource);
    });
    test(
        'should return InvalidCredentialsFailure when the credentials are invalid',
        () async {
      // arrange: Simulate invalid credentials by throwing an exception
      when(() => mockAuthRemoteDataSource.login(
              userName: any(named: 'userName'),
              password: any(named: 'password')))
          .thenThrow(InvalidCredentialsException()); // Custom exception

      // act
      final result =
          await repository.login(userName: tUserName, password: tPassword);

      // assert: Expect the result to be Left(InvalidCredentialsFailure())
      expect(result, equals(Left(InvalidCredentialsFailure())));
      verify(() => mockAuthRemoteDataSource.login(
          userName: tUserName, password: tPassword));
      verifyNoMoreInteractions(mockAuthRemoteDataSource);
    });
    test(
        'should return ServerFailure when the remote data source throws an exception',
        () async {
      // arrange
      when(() =>
          mockAuthRemoteDataSource.login(
              userName: any(named: 'userName'),
              password: any(named: 'password'))).thenThrow(
          ServerException()); // Ensure you're throwing a ServerException here

      // act
      final result =
          await repository.login(userName: tUserName, password: tPassword);

      // assert
      expect(
          result,
          equals(Left(
              ServerFailure()))); // Check if the result is Left(ServerFailure())
      verify(() => mockAuthRemoteDataSource.login(
          userName: tUserName, password: tPassword)); // Verify the method call
      verifyNoMoreInteractions(
          mockAuthRemoteDataSource); // Ensure no other interactions occurred
    });
  });
}

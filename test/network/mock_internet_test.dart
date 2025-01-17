import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_mangement/core/error/failures.dart';
import 'package:task_mangement/modules/authentication/data/repositories/auth_repository_implement.dart';
import 'package:task_mangement/modules/authentication/domain/entities/login_entity.dart';

import '../authentication/data/auth_repository_impl_test.dart';

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  late AuthLoginRepositoryImplement repository;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockInternetConnectionChecker mockConnectionChecker;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockConnectionChecker = MockInternetConnectionChecker();
    repository = AuthLoginRepositoryImplement(
      authenticationDataSource: mockAuthRemoteDataSource,
    );
  });

  group('AuthLoginRepositoryImplement', () {
    final tLoginEntity = LoginEntity(
        accessToken:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJlbWlseXMiLCJlbWFpbCI6ImVtaWx5LmpvaG5zb25AeC5kdW1teWpzb24uY29tIiwiZmlyc3ROYW1lIjoiRW1pbHkiLCJsYXN0TmFtZSI6IkpvaG5zb24iLCJnZW5kZXIiOiJmZW1hbGUiLCJpbWFnZSI6Imh0dHBzOi8vZHVtbXlqc29uLmNvbS9pY29uL2VtaWx5cy8xMjgiLCJpYXQiOjE3MzcxMjA3MDMsImV4cCI6MTczNzEyNDMwM30.-vmN_8UbJ2RX8SSvfWA8v8aCbHke4YtFSFiTVxUm3is');
    const tUserName = 'emilys';
    const tPassword = 'emilyspass';
    test(
      'should return a LoginEntity when the remote data source is successful and there is internet connection',
      () async {
        // arrange: Simulate internet connection
        when(() => mockConnectionChecker.hasConnection)
            .thenAnswer((_) async => true);
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
      },
    );
  });
}

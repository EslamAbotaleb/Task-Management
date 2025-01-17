import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_mangement/core/error/failures.dart';
import 'package:task_mangement/modules/authentication/domain/entities/login_entity.dart';
import 'package:task_mangement/modules/authentication/domain/usecases/auth_login_usecase.dart';
import '../../../../../../core/util/constants.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthLoginUsecase loginUsecase;

  AuthBloc({required this.loginUsecase}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(AuthLoading());
        final Either<Failure, LoginEntity> result = await loginUsecase.call(
            userName: event.userName, password: event.password);

        result.fold((failure) {
          emit(AuthError(message: _mapFailtureToMessage(failure)));
        }, (loginEntity) {
           emit(AuthSuccess(loginEntity: loginEntity));
        });
      }
    });
  }

  String _mapFailtureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return SERVER_FAILURE_MESSAGE;
      default:
        return "Try again later!!!";
    }
  }
}

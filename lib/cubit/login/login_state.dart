part of 'login_cubit.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateSuccess extends LoginState {
  String message;
  List<User>? data;

  LoginStateSuccess({
    required this.message,
    this.data,

  });
}

class LoginStateError extends LoginState {
  String message;

  LoginStateError(this.message);
}

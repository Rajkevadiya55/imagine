part of 'firebase_token_cubit.dart';

sealed class FirebaseTokenState {}

final class FirebaseTokenInitial extends FirebaseTokenState {}

class FirebaseTokenLoading extends FirebaseTokenState {}

class FirebaseTokenSuccess extends FirebaseTokenState {
  String message;

  FirebaseTokenSuccess({
    required this.message,
  });
}

class FirebaseTokenError extends FirebaseTokenState {
  String message;

  FirebaseTokenError(this.message);
}

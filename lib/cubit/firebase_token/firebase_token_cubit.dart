import 'package:bloc/bloc.dart';
import 'package:imagine/data/http/http_data_provider/custom_http_exception.dart';
import 'package:imagine/helper/helper.dart';
import 'package:imagine/model/firebase_token/firebase_token_req_model.dart';
import 'package:imagine/repositories/repository.dart';

part 'firebase_token_state.dart';

class FirebaseTokenCubit extends Cubit<FirebaseTokenState> {
  final Repository authRepository;

  FirebaseTokenCubit(this.authRepository) : super(FirebaseTokenInitial());

  firebaseTokenCubit({
    required String token,
  }) async {
    try {
      emit(FirebaseTokenLoading());
      final request = FirebaseTokenReqModel(
        userId: userId,
        token: token,
      );
      final response = await authRepository.firebaseTokenRepo(request);
      if (response.status!) {
        emit(
          FirebaseTokenSuccess(message: response.message.toString()),
        );
      } else {
        emit(FirebaseTokenError(response.message.toString()));
      }
    } catch (e) {
      print('firebaseToken $e');
      if (e is CustomHttpException) {
        emit(FirebaseTokenError(e.message));
      } else {
        emit(FirebaseTokenError("Something went wrong!"));
      }
    }
  }
}

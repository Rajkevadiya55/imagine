import 'package:bloc/bloc.dart';
import 'package:imagine/data/http/http_data_provider/custom_http_exception.dart';
import 'package:imagine/model/dropdown/dropdown_res_model.dart';
import 'package:imagine/model/login/login_res_model.dart';
import 'package:imagine/repositories/repository.dart';

part 'dropdown_state.dart';

class DropdownCubit extends Cubit<DropdownState> {
  final Repository authRepository;

  DropdownCubit(this.authRepository) : super(DropdownInitial());

  fetchPartyName() async {
    try {
      emit(DropdownLoading());
      final response = await authRepository.createDropDown();
      List<String> partyName = [];
      List<String> userName = [];
      response.partyNames?.forEach((v) {
        partyName.add(v.partyName.toString());
      });
      response.users?.forEach((v) {
        userName.add(v.fullName.toString());
      });
      if (response.status!) {
        emit(
          DropdownSuccess(
              data: partyName ?? [],
              message: 'nknk',
              userData: userName,
              users: response.users),
        );
      } else {
        emit(DropdownError('error'));
      }
    } catch (e) {
      print('errorr $e');
      if (e is CustomHttpException) {
        emit(DropdownError(e.message));
      } else {
        emit(DropdownError("Something went wrong!"));
      }
    }
  }
}

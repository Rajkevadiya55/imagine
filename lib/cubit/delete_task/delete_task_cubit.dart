import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:imagine/data/http/http_data_provider/custom_http_exception.dart';
import 'package:imagine/model/delete_task/delete_task_req_model.dart';
import 'package:imagine/repositories/repository.dart';
import 'package:meta/meta.dart';

part 'delete_task_state.dart';

class DeleteTaskCubit extends Cubit<DeleteTaskState> {
  final Repository authRepository;

  DeleteTaskCubit(this.authRepository) : super(DeleteTaskInitial());

  deleteTaskCubite({
    required String user_id,
    required String task_id,
  }) async {
    try {
      emit(DeleteTaskLoading());
      final request = DeleteTaskReqModel(userId: user_id, taskId: task_id);
      final response = await authRepository.deleteTaskRepo(request);
      if (response.status!) {
        emit(
          DeleteTaskSuccess(message: response.data.toString()),
        );
      } else {
        emit(DeleteTaskError(response.data.toString()));
      }
      return true;
    } catch (e) {
      if (e is CustomHttpException) {
        emit(DeleteTaskError(e.message));
      } else {
        emit(DeleteTaskError("Something went wrong!"));
      }
    }
  }
}

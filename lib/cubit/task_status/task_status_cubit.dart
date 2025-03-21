import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagine/cubit/task_list/task_list_cubit.dart';
import 'package:imagine/data/http/http_data_provider/custom_http_exception.dart';
import 'package:imagine/model/task_list/task_list_res_model.dart';
import 'package:imagine/model/task_status/task_status_req_model.dart';
import 'package:imagine/repositories/repository.dart';

part 'task_status_state.dart';

class TaskStatusCubit extends Cubit<TaskStatusState> {
  final Repository authRepository;

  TaskStatusCubit(this.authRepository) : super(TaskStatusInitial());

  Future<bool?> taskStatusCubit({
    required String userId,
    required String taskIds,
    required String status,
    required Data item,
    required BuildContext context,
  }) async {
    try {
      emit(TaskStatusLoading());
      final request =
          TaskStatusReqModel(taskId: taskIds, status: status, userId: userId);
      final response = await authRepository.taskStatusRepo(request);
      if (response.status!) {
        print('aaaaaaa$item');
        emit(
          TaskStatusSuccess(message: response.message.toString()),
        );
        return true;
      } else {
        emit(TaskStatusError(response.message.toString()));
      }
    } catch (e) {
      print('errorr $e');
      if (e is CustomHttpException) {
        emit(TaskStatusError(e.message));
      } else {
        emit(TaskStatusError("Something went wrong!"));
      }
    }
  }
}

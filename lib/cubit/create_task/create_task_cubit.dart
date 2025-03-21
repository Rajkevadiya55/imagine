import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:imagine/data/http/http_data_provider/custom_http_exception.dart';
import 'package:imagine/helper/helper.dart';
import 'package:imagine/model/create_task/create_task_req_model.dart';
import 'package:imagine/model/create_task/create_task_res_model.dart';
import 'package:imagine/model/create_task/edit_task_req_model.dart';
import 'package:imagine/repositories/repository.dart';
import 'package:imagine/router/app_router.dart';
import 'package:imagine/widget/app_easy_loading.dart';
import 'package:meta/meta.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  final Repository authRepository;

  CreateTaskCubit(this.authRepository) : super(CreateTaskInitial());

  createTaskCubit({
    required bool isCreate,
    required String partyName,
    required String taskDate,
    required String description,
    required String priority,
    required String note,
    required String billNo,
    required String jobNo,
    required String billAmount,
    required String deliveryDate,
    required String taskFile,
    String? status,
    String? assignTo,
    String? id,
  }) async {
    if (partyName.isEmpty) {
      easyLoadingShowError('party name cannot be empty!.');
    } else if (taskDate.isEmpty) {
      easyLoadingShowError('task date can not be empty!.');
    } else {
      try {
        emit(CreateTaskLoading());
        final response;
        if(isCreate){
          final request = CreateTaskReqModel(
            partyName: partyName,
            taskDate: taskDate,
            billAmount: billAmount,
            billNo: billNo,
            jobNo: jobNo,
            deliveryDate: deliveryDate,
            description: description,
            note: note,
            priority: priority,
            taskFile: taskFile,
            userId: userId,
          );
          print("requestrequest ${jsonEncode(request)}");
           response = await authRepository.createTaskRepo(request);
        }else {
          final request = EditTaskReqModel(
            partyName: partyName,
            taskDate: taskDate,
            billAmount: billAmount,
            billNo: billNo,
            jobNo: jobNo,
            deliveryDate: deliveryDate,
            description: description,
            note: note,
            priority: priority,
            taskFile: taskFile,
            userId: userId,
            status: status,
            assignTo: assignTo,
            id: id,
          );
          print("requestrequest ${jsonEncode(request)}");
           response = await authRepository.editTaskRepo(request);
        }
        if (response.status!) {
          emit(
            CreateTaskSuccess(message: response.message.toString()),
          );
        } else {
          emit(CreateTaskError(response.message.toString()));
        }
      } catch (e) {
        print('errorr $e');
        if (e is CustomHttpException) {
          emit(CreateTaskError(e.message));
        } else {
          emit(CreateTaskError("Something went wrong!"));
        }
      }
    }
  }
}

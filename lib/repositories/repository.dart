import 'dart:developer';
import 'package:imagine/data/http/http_data_provider/custom_http_exception.dart';
import 'package:imagine/data/http/http_data_provider/http_data_provider.dart';
import 'package:imagine/model/create_task/create_task_req_model.dart';
import 'package:imagine/model/create_task/create_task_res_model.dart';
import 'package:imagine/model/create_task/edit_task_req_model.dart';
import 'package:imagine/model/delete_task/delete_task_req_model.dart';
import 'package:imagine/model/delete_task/delete_task_res_model.dart';
import 'package:imagine/model/dropdown/dropdown_res_model.dart';
import 'package:imagine/model/firebase_token/firebase_token_req_model.dart';
import 'package:imagine/model/firebase_token/firebase_token_res_model.dart';
import 'package:imagine/model/login/login_req_model.dart';
import 'package:imagine/model/login/login_res_model.dart';
import 'package:imagine/model/task_list/task_list_req_model.dart';
import 'package:imagine/model/task_list/task_list_res_model.dart';
import 'package:imagine/model/task_status/task_status_req_model.dart';
import 'package:imagine/model/task_status/task_status_res_model.dart';

class Repository {
  Future<LoginResModel> loginRepo(LoginReqModel loginReqModel) async {
    final response = await HttpDataProvider().postLogin(loginReqModel);
    var res = loginResModelFromJson(response.body);
    if (response.statusCode == 200) {
      return res;
    } else {
      throw CustomHttpException(
          message: res.message ?? "Something went wrong!");
    }
  }

  Future<CreateTaskResModel> createTaskRepo(
      CreateTaskReqModel createTaskReqModel) async {
    final response =
        await HttpDataProvider().postCreateTask(createTaskReqModel);
    log("CreateChat${response.body}");
    // log("CreateChat${response.statusCode}");
    var res = createTaskResModelFromJson(response.body);
    if (response.statusCode == 200) {
      return res;
    } else {
      throw CustomHttpException(
          message: res.message ?? "Something went wrong!");
    }
  }

  Future<CreateTaskResModel> editTaskRepo(
      EditTaskReqModel editTaskReqModel) async {
    final response =
    await HttpDataProvider().postEditTask(editTaskReqModel);
    log("CreateChat${response.body}");
    // log("CreateChat${response.statusCode}");
    var res = createTaskResModelFromJson(response.body);
    if (response.statusCode == 200) {
      return res;
    } else {
      throw CustomHttpException(
          message: res.message ?? "Something went wrong!");
    }
  }

  Future<DropdownResModel> createDropDown() async {
    final response = await HttpDataProvider().postDropDown();
    var res = dropdownResModelFromJson(response.body);
    if (response.statusCode == 200) {
      return res;
    } else {
      throw CustomHttpException(message: "Something went wrong!");
    }
  }

  Future<FirebaseTokenResModel> firebaseTokenRepo(
      FirebaseTokenReqModel firebaseTokenReqModel) async {
    final response =
        await HttpDataProvider().postFirebaseToken(firebaseTokenReqModel);
    log("firebaseToken${response.body}");
    log("firebaseToken${response.statusCode}");
    var res = firebaseTokenResModelFromJson(response.body);
    if (response.statusCode == 200) {
      return res;
    } else {
      throw CustomHttpException(
          message: res.message ?? "Something went wrong!");
    }
  }


  Future<TaskStatusResModel> taskStatusRepo(
      TaskStatusReqModel taskStatusReqModel) async {
    final response =
    await HttpDataProvider().postTaskStatus(taskStatusReqModel);
    log("postTaskStatus${response.body}");
    log("postTaskStatus${response.statusCode}");
    var res = taskStatusResModelFromJson(response.body);
    if (response.statusCode == 200) {
      return res;
    } else {
      throw CustomHttpException(
          message: res.message ?? "Something went wrong!");
    }
  }

  Future<TaskListResModel> taskListRepo(
      TaskListReqModel taskListReqModel) async {
    final response =
    await HttpDataProvider().postTaskList(taskListReqModel);
    // log("TaskList${response.body}");
    // log("TaskList${response.statusCode}");
    var res = taskListResModelFromJson(response.body);
    if (response.statusCode == 200) {
      return res;
    } else {
      throw CustomHttpException(
          message: "Something went wrong!");
    }
  }

  Future<DeleteTaskResModel> deleteTaskRepo(
      DeleteTaskReqModel deleteTaskReqModel) async {
    final response =
    await HttpDataProvider().postDeleteTask(deleteTaskReqModel);
    log("DeleteTask==========${response.body}");
    log("DeleteTask=================${response.statusCode}");
    var res = deleteTaskResModelFromJson(response.body);
    if (response.statusCode == 200) {
      return res;
    } else {
      throw CustomHttpException(
          message: "Something went wrong!");
    }
  }

}

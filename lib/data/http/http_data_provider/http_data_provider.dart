import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:imagine/data/api/api_url.dart';
import 'package:imagine/model/create_task/create_task_req_model.dart';
import 'package:imagine/model/create_task/edit_task_req_model.dart';
import 'package:imagine/model/delete_task/delete_task_req_model.dart';
import 'package:imagine/model/firebase_token/firebase_token_req_model.dart';
import 'package:imagine/model/firebase_token/firebase_token_res_model.dart';
import 'package:imagine/model/login/login_req_model.dart';
import 'package:http/http.dart' as http;
import 'package:imagine/model/task_list/task_list_req_model.dart';
import 'package:imagine/model/task_status/task_status_req_model.dart';

class HttpDataProvider {
  static final HttpDataProvider _singleton = HttpDataProvider._internal();

  factory HttpDataProvider() {
    return _singleton;
  }

  HttpDataProvider._internal();

  Future<Response> postLogin(LoginReqModel loginReqModel) async {
    var url = Uri.parse(LOGIN_URL);
    var response = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
        'x-api-key': '44d4d94a-3939-4fbf-b5dc-1120c7b9a290'
      },
      body: jsonEncode(
        loginReqModel.toJson(),
      ),
    );
    print('res:::::: ${response.body}');
    return response;
  }

  Future<Response> postCreateTask(CreateTaskReqModel createTaskReqModel) async {
    var url = Uri.parse(CREATE_TASK);
    final request = http.MultipartRequest("POST", url);
    request.headers.addAll({
      "Content-type": "application/json",
      'x-api-key': '44d4d94a-3939-4fbf-b5dc-1120c7b9a290'
    });

    if (createTaskReqModel.taskFile != "") {
      request.files.add(await http.MultipartFile.fromPath(
          'task_file', createTaskReqModel.taskFile.toString(),
          filename: createTaskReqModel.taskFile.toString().split("/").last));
    }
    request.fields.addAll({
      'user_id': createTaskReqModel.userId.toString(),
      'party_name': createTaskReqModel.partyName.toString(),
      'task_date': createTaskReqModel.taskDate.toString(),
      'description': createTaskReqModel.description.toString(),
      'priority': createTaskReqModel.priority.toString(),
      'note': createTaskReqModel.note.toString(),
      'bill_no': createTaskReqModel.billNo.toString(),
      'job_number': createTaskReqModel.jobNo.toString(),
      'bill_amount': createTaskReqModel.billAmount.toString(),
      'delivery_date': createTaskReqModel.deliveryDate.toString(),

    });

    final response = await request.send();
    return await http.Response.fromStream(response);
  }


  Future<Response> postEditTask(EditTaskReqModel editTaskReqModel) async {
    var url = Uri.parse(CREATE_TASK);
    final request = http.MultipartRequest("POST", url);
    request.headers.addAll({
      "Content-type": "application/json",
      'x-api-key': '44d4d94a-3939-4fbf-b5dc-1120c7b9a290'
    });

    if (editTaskReqModel.taskFile != "") {
      request.files.add(await http.MultipartFile.fromPath(
          'task_file', editTaskReqModel.taskFile.toString(),
          filename: editTaskReqModel.taskFile.toString().split("/").last));
    }
    request.fields.addAll({
      'user_id': editTaskReqModel.userId.toString(),
      'party_name': editTaskReqModel.partyName.toString(),
      'task_date': editTaskReqModel.taskDate.toString(),
      'description': editTaskReqModel.description.toString(),
      'priority': editTaskReqModel.priority.toString(),
      'note': editTaskReqModel.note.toString(),
      'bill_no': editTaskReqModel.billNo.toString(),
      'job_number': editTaskReqModel.jobNo.toString(),
      'bill_amount': editTaskReqModel.billAmount.toString(),
      'delivery_date': editTaskReqModel.deliveryDate.toString(),
      'assign_to': editTaskReqModel.assignTo.toString(),
      'status': editTaskReqModel.status.toString(),
      'id': editTaskReqModel.id ?? '',
    });

    final response = await request.send();
    return await http.Response.fromStream(response);
  }

  Future<Response> postDropDown() async {
    var url = Uri.parse(DROP_DOWN);
    var response = await http.get(
      url,
      headers: {
        "Content-type": "application/json",
        'x-api-key': '44d4d94a-3939-4fbf-b5dc-1120c7b9a290'
      },
    );
    print('res:::::: ${response.body}');
    return response;
  }

  Future<Response> postFirebaseToken(
      FirebaseTokenReqModel firebaseTokenReqModel) async {
    var url = Uri.parse(SAVE_FIREBASE_TOKEN);
    var response = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
        'x-api-key': '44d4d94a-3939-4fbf-b5dc-1120c7b9a290'
      },
      body: jsonEncode(
        firebaseTokenReqModel.toJson(),
      ),
    );
    print('res:::::: ${response.body}');
    return response;
  }

  Future<Response> postTaskStatus(TaskStatusReqModel taskStatusReqModel) async {
    var url = Uri.parse(TASK_STATUS);
    var response = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
        'x-api-key': '44d4d94a-3939-4fbf-b5dc-1120c7b9a290'
      },
      body: jsonEncode(
        taskStatusReqModel.toJson(),
      ),
    );
    print('res:::::: ${response.body}');
    return response;
  }

  Future<Response> postTaskList(TaskListReqModel taskListReqModel) async {
    var url = Uri.parse(TASK_LIST);
    log("taskListReqModel===================${jsonEncode(taskListReqModel.toJson(),)}");
    var response = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
        'x-api-key': '44d4d94a-3939-4fbf-b5dc-1120c7b9a290'
      },
      body: jsonEncode(
        taskListReqModel.toJson(),
      ),
    );
    print('res:::::: ${response.body}');
    return response;
  }

  Future<Response> postDeleteTask(DeleteTaskReqModel deleteTaskReqModel) async {
    var url = Uri.parse(DELETE_TASK);
    var response = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
        'x-api-key': '44d4d94a-3939-4fbf-b5dc-1120c7b9a290'
      },
      body: jsonEncode(
        deleteTaskReqModel.toJson(),
      ),
    );
    print('res:::::: ${response.body}');
    return response;
  }
}

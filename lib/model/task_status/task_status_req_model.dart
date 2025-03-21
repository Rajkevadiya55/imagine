import 'dart:convert';
/// user_id : "DXK6R6NW8T"
/// task_id : 2
/// status : "pending"

TaskStatusReqModel taskStatusReqModelFromJson(String str) => TaskStatusReqModel.fromJson(json.decode(str));
String taskStatusReqModelToJson(TaskStatusReqModel data) => json.encode(data.toJson());
class TaskStatusReqModel {
  TaskStatusReqModel({
      String? userId,
    String? taskId,
      String? status,}){
    _userId = userId;
    _taskId = taskId;
    _status = status;
}

  TaskStatusReqModel.fromJson(dynamic json) {
    _userId = json['user_id'];
    _taskId = json['task_id'];
    _status = json['status'];
  }
  String? _userId;
  String? _taskId;
  String? _status;
TaskStatusReqModel copyWith({  String? userId,
  String? taskId,
  String? status,
}) => TaskStatusReqModel(  userId: userId ?? _userId,
  taskId: taskId ?? _taskId,
  status: status ?? _status,
);
  String? get userId => _userId;
  String? get taskId => _taskId;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['task_id'] = _taskId;
    map['status'] = _status;
    return map;
  }

}
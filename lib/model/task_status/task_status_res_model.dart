import 'dart:convert';
/// status : true
/// message : "Task status has been changed successfully."

TaskStatusResModel taskStatusResModelFromJson(String str) => TaskStatusResModel.fromJson(json.decode(str));
String taskStatusResModelToJson(TaskStatusResModel data) => json.encode(data.toJson());
class TaskStatusResModel {
  TaskStatusResModel({
      bool? status, 
      String? message,}){
    _status = status;
    _message = message;
}

  TaskStatusResModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
TaskStatusResModel copyWith({  bool? status,
  String? message,
}) => TaskStatusResModel(  status: status ?? _status,
  message: message ?? _message,
);
  bool? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}
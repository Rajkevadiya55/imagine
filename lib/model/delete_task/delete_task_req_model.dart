import 'dart:convert';
/// user_id : "DXK6R6NW8T"
/// task_id : 14

DeleteTaskReqModel deleteTaskReqModelFromJson(String str) => DeleteTaskReqModel.fromJson(json.decode(str));
String deleteTaskReqModelToJson(DeleteTaskReqModel data) => json.encode(data.toJson());
class DeleteTaskReqModel {
  DeleteTaskReqModel({
      String? userId, 
      String? taskId,}){
    _userId = userId;
    _taskId = taskId;
}

  DeleteTaskReqModel.fromJson(dynamic json) {
    _userId = json['user_id'];
    _taskId = json['task_id'];
  }
  String? _userId;
  String? _taskId;
DeleteTaskReqModel copyWith({  String? userId,
  String? taskId,
}) => DeleteTaskReqModel(  userId: userId ?? _userId,
  taskId: taskId ?? _taskId,
);
  String? get userId => _userId;
  String? get taskId => _taskId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['task_id'] = _taskId;
    return map;
  }

}
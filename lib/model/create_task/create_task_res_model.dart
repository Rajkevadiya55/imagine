import 'dart:convert';
/// status : true
/// message : "Task has been saved successfully."

CreateTaskResModel createTaskResModelFromJson(String str) => CreateTaskResModel.fromJson(json.decode(str));
String createTaskResModelToJson(CreateTaskResModel data) => json.encode(data.toJson());
class CreateTaskResModel {
  CreateTaskResModel({
      bool? status, 
      String? message,}){
    _status = status;
    _message = message;
}

  CreateTaskResModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
CreateTaskResModel copyWith({  bool? status,
  String? message,
}) => CreateTaskResModel(  status: status ?? _status,
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
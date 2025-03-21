import 'dart:convert';
/// status : true
/// data : "The task has been removed successfully."

DeleteTaskResModel deleteTaskResModelFromJson(String str) => DeleteTaskResModel.fromJson(json.decode(str));
String deleteTaskResModelToJson(DeleteTaskResModel data) => json.encode(data.toJson());
class DeleteTaskResModel {
  DeleteTaskResModel({
      bool? status, 
      String? data,}){
    _status = status;
    _data = data;
}

  DeleteTaskResModel.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'];
  }
  bool? _status;
  String? _data;
DeleteTaskResModel copyWith({  bool? status,
  String? data,
}) => DeleteTaskResModel(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['data'] = _data;
    return map;
  }

}
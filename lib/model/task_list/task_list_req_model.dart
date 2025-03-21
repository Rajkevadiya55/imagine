import 'dart:convert';
/// user_id : "RSSX406YRJ"
/// statuses : ["In Progress","Done","Awaiting","Pending","Cancelled","On Hold"]
/// assigned_to : [1,5]
/// search : {"value":""}
/// start_date : ""
/// end_date : ""
/// length : 100
/// start : 0

TaskListReqModel taskListReqModelFromJson(String str) => TaskListReqModel.fromJson(json.decode(str));
String taskListReqModelToJson(TaskListReqModel data) => json.encode(data.toJson());
class TaskListReqModel {
  TaskListReqModel({
      String? userId, 
      List<String>? statuses, 
      List<num>? assignedTo, 
      Search? search, 
      String? startDate, 
      String? endDate, 
      num? length, 
      num? start,}){
    _userId = userId;
    _statuses = statuses;
    _assignedTo = assignedTo;
    _search = search;
    _startDate = startDate;
    _endDate = endDate;
    _length = length;
    _start = start;
}

  TaskListReqModel.fromJson(dynamic json) {
    _userId = json['user_id'];
    _statuses = json['statuses'] != null ? json['statuses'].cast<String>() : [];
    _assignedTo = json['assigned_to'] != null ? json['assigned_to'].cast<num>() : [];
    _search = json['search'] != null ? Search.fromJson(json['search']) : null;
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _length = json['length'];
    _start = json['start'];
  }
  String? _userId;
  List<String>? _statuses;
  List<num>? _assignedTo;
  Search? _search;
  String? _startDate;
  String? _endDate;
  num? _length;
  num? _start;
TaskListReqModel copyWith({  String? userId,
  List<String>? statuses,
  List<num>? assignedTo,
  Search? search,
  String? startDate,
  String? endDate,
  num? length,
  num? start,
}) => TaskListReqModel(  userId: userId ?? _userId,
  statuses: statuses ?? _statuses,
  assignedTo: assignedTo ?? _assignedTo,
  search: search ?? _search,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  length: length ?? _length,
  start: start ?? _start,
);
  String? get userId => _userId;
  List<String>? get statuses => _statuses;
  List<num>? get assignedTo => _assignedTo;
  Search? get search => _search;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  num? get length => _length;
  num? get start => _start;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['statuses'] = _statuses;
    map['assigned_to'] = _assignedTo;
    if (_search != null) {
      map['search'] = _search?.toJson();
    }
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['length'] = _length;
    map['start'] = _start;
    return map;
  }

}

/// value : ""

Search searchFromJson(String str) => Search.fromJson(json.decode(str));
String searchToJson(Search data) => json.encode(data.toJson());
class Search {
  Search({
      String? value,}){
    _value = value;
}

  Search.fromJson(dynamic json) {
    _value = json['value'];
  }
  String? _value;
Search copyWith({  String? value,
}) => Search(  value: value ?? _value,
);
  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = _value;
    return map;
  }

}
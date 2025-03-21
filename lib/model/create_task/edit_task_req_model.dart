import 'dart:convert';
/// user_id : "DXK6R6NW8T"
/// assign_to : "1"
/// party_name : "raj"
/// task_date : "17-11-2024"
/// description : "Test 869"
/// priority : "High"
/// note : "Highzfz"
/// bill_no : "1564164169"
/// bill_amount : "1545"
/// delivery_date : "20-11-2024"
/// task_file : "file"
/// id : "14"

EditTaskReqModel createTaskReqModelFromJson(String str) => EditTaskReqModel.fromJson(json.decode(str));
String createTaskReqModelToJson(EditTaskReqModel data) => json.encode(data.toJson());
class EditTaskReqModel {
  EditTaskReqModel({
      String? userId, 
      String? assignTo, 
      String? partyName, 
      String? taskDate, 
      String? description, 
      String? priority, 
      String? note, 
      String? billNo, 
      String? jobNo,
      String? billAmount,
      String? deliveryDate, 
      String? taskFile, 
      String? status,
      String? id,}){
    _userId = userId;
    _assignTo = assignTo;
    _partyName = partyName;
    _taskDate = taskDate;
    _description = description;
    _priority = priority;
    _note = note;
    _billNo = billNo;
    _jobNo = jobNo;
    _billAmount = billAmount;
    _deliveryDate = deliveryDate;
    _taskFile = taskFile;
    _status = status;
    _id = id;

}

  EditTaskReqModel.fromJson(dynamic json) {
    _userId = json['user_id'];
    _assignTo = json['assign_to'];
    _partyName = json['party_name'];
    _taskDate = json['task_date'];
    _description = json['description'];
    _priority = json['priority'];
    _note = json['note'];
    _billNo = json['bill_no'];
    _jobNo = json['job_number'];
    _billAmount = json['bill_amount'];
    _deliveryDate = json['delivery_date'];
    _taskFile = json['task_file'];
    _status = json['status'];
    _id = json['id'];
  }
  String? _userId;
  String? _assignTo;
  String? _partyName;
  String? _taskDate;
  String? _description;
  String? _priority;
  String? _note;
  String? _billNo;
  String? _jobNo;
  String? _billAmount;
  String? _deliveryDate;
  String? _taskFile;
  String? _status;
  String? _id;
EditTaskReqModel copyWith({  String? userId,
  String? assignTo,
  String? partyName,
  String? taskDate,
  String? description,
  String? priority,
  String? note,
  String? billNo,
  String? jobNo,
  String? billAmount,
  String? deliveryDate,
  String? taskFile,
  String? status,
  String? id,
}) => EditTaskReqModel(  userId: userId ?? _userId,
  assignTo: assignTo ?? _assignTo,
  partyName: partyName ?? _partyName,
  taskDate: taskDate ?? _taskDate,
  description: description ?? _description,
  priority: priority ?? _priority,
  note: note ?? _note,
  billNo: billNo ?? _billNo,
  jobNo: jobNo ?? _jobNo,
  billAmount: billAmount ?? _billAmount,
  deliveryDate: deliveryDate ?? _deliveryDate,
  taskFile: taskFile ?? _taskFile,
  status: status ?? _status,
  id: id ?? _id,
);
  String? get userId => _userId;
  String? get assignTo => _assignTo;
  String? get partyName => _partyName;
  String? get taskDate => _taskDate;
  String? get description => _description;
  String? get priority => _priority;
  String? get note => _note;
  String? get billNo => _billNo;
  String? get jobNo => _jobNo;
  String? get billAmount => _billAmount;
  String? get deliveryDate => _deliveryDate;
  String? get taskFile => _taskFile;
  String? get status => _status;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['assign_to'] = _assignTo;
    map['party_name'] = _partyName;
    map['task_date'] = _taskDate;
    map['description'] = _description;
    map['priority'] = _priority;
    map['note'] = _note;
    map['bill_no'] = _billNo;
    map['job_number'] = _jobNo;
    map['bill_amount'] = _billAmount;
    map['delivery_date'] = _deliveryDate;
    map['task_file'] = _taskFile;
    map['status'] = _status;
    map['id'] = _id;
    return map;
  }

}
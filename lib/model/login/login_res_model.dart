import 'dart:convert';
/// status : true
/// message : "Logged in successfully."
/// user : {"user_id":"DXK6R6NW8T","id":"2","full_name":"Chirag Patel","username":"7016392106","email":"daniel_walker10@yopmail.com","phone":"7016392106","created_on":"10/11/2024 16:11","user_role":"user","permissions":[{"permission":"delete_tasks","id":"3","value":false},{"permission":"create_tasks","id":"1","value":true},{"permission":"view_tasks","id":"4","value":true},{"permission":"edit_tasks","id":"2","value":true},{"permission":"view_all_tasks","id":"5","value":false}]}

LoginResModel loginResModelFromJson(String str) => LoginResModel.fromJson(json.decode(str));
String loginResModelToJson(LoginResModel data) => json.encode(data.toJson());
class LoginResModel {
  LoginResModel({
      bool? status,
      String? message, 
      User? user,}){
    _status = status;
    _message = message;
    _user = user;
}

  LoginResModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  bool? _status;
  String? _message;
  User? _user;
LoginResModel copyWith({  bool? status,
  String? message,
  User? user,
}) => LoginResModel(  status: status ?? _status,
  message: message ?? _message,
  user: user ?? _user,
);
  bool? get status => _status;
  String? get message => _message;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

/// user_id : "DXK6R6NW8T"
/// id : "2"
/// full_name : "Chirag Patel"
/// username : "7016392106"
/// email : "daniel_walker10@yopmail.com"
/// phone : "7016392106"
/// created_on : "10/11/2024 16:11"
/// user_role : "user"
/// permissions : [{"permission":"delete_tasks","id":"3","value":false},{"permission":"create_tasks","id":"1","value":true},{"permission":"view_tasks","id":"4","value":true},{"permission":"edit_tasks","id":"2","value":true},{"permission":"view_all_tasks","id":"5","value":false}]

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      String? userId, 
      String? id, 
      String? fullName, 
      String? username, 
      String? email, 
      String? phone, 
      String? createdOn, 
      String? userRole, 
      List<Permissions>? permissions,}){
    _userId = userId;
    _id = id;
    _fullName = fullName;
    _username = username;
    _email = email;
    _phone = phone;
    _createdOn = createdOn;
    _userRole = userRole;
    _permissions = permissions;
}

  User.fromJson(dynamic json) {
    _userId = json['user_id'];
    _id = json['id'];
    _fullName = json['full_name'];
    _username = json['username'];
    _email = json['email'];
    _phone = json['phone'];
    _createdOn = json['created_on'];
    _userRole = json['user_role'];
    if (json['permissions'] != null) {
      _permissions = [];
      json['permissions'].forEach((v) {
        _permissions?.add(Permissions.fromJson(v));
      });
    }
  }
  String? _userId;
  String? _id;
  String? _fullName;
  String? _username;
  String? _email;
  String? _phone;
  String? _createdOn;
  String? _userRole;
  List<Permissions>? _permissions;
User copyWith({  String? userId,
  String? id,
  String? fullName,
  String? username,
  String? email,
  String? phone,
  String? createdOn,
  String? userRole,
  List<Permissions>? permissions,
}) => User(  userId: userId ?? _userId,
  id: id ?? _id,
  fullName: fullName ?? _fullName,
  username: username ?? _username,
  email: email ?? _email,
  phone: phone ?? _phone,
  createdOn: createdOn ?? _createdOn,
  userRole: userRole ?? _userRole,
  permissions: permissions ?? _permissions,
);
  String? get userId => _userId;
  String? get id => _id;
  String? get fullName => _fullName;
  String? get username => _username;
  String? get email => _email;
  String? get phone => _phone;
  String? get createdOn => _createdOn;
  String? get userRole => _userRole;
  List<Permissions>? get permissions => _permissions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['id'] = _id;
    map['full_name'] = _fullName;
    map['username'] = _username;
    map['email'] = _email;
    map['phone'] = _phone;
    map['created_on'] = _createdOn;
    map['user_role'] = _userRole;
    if (_permissions != null) {
      map['permissions'] = _permissions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
/// permission : "delete_tasks"
/// id : "3"
/// value : false

Permissions permissionsFromJson(String str) => Permissions.fromJson(json.decode(str));
String permissionsToJson(Permissions data) => json.encode(data.toJson());
class Permissions {
  Permissions({
      String? permission, 
      String? id, 
      bool? value,}){
    _permission = permission;
    _id = id;
    _value = value;
}

  Permissions.fromJson(dynamic json) {
    _permission = json['permission'];
    _id = json['id'];
    _value = json['value'];
  }
  String? _permission;
  String? _id;
  bool? _value;
Permissions copyWith({  String? permission,
  String? id,
  bool? value,
}) => Permissions(  permission: permission ?? _permission,
  id: id ?? _id,
  value: value ?? _value,
);
  String? get permission => _permission;
  String? get id => _id;
  bool? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['permission'] = _permission;
    map['id'] = _id;
    map['value'] = _value;
    return map;
  }

}
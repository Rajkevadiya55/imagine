import 'dart:convert';

/// status : true
/// users : [{"id":"1","full_name":"Admin Users","username":"9537195672","email":"admin@admin.com","user_role":"admin"},{"id":"2","full_name":"Chirag Patel","username":"7016392106","email":"daniel_walker10@yopmail.com","user_role":"user"},{"id":"3","full_name":"Kalpesh","username":"8780351583","email":"imagineartandprint@gmail.com","user_role":"user"}]
/// party_names : [{"party_name":"Balar Builder"},{"party_name":"Chirag Patel"},{"party_name":"cvv"},{"party_name":"Kiritbhai Surat"}]

DropdownResModel dropdownResModelFromJson(String str) =>
    DropdownResModel.fromJson(json.decode(str));
String dropdownResModelToJson(DropdownResModel data) =>
    json.encode(data.toJson());

class DropdownResModel {
  DropdownResModel({
    bool? status,
    List<Users>? users,
    List<PartyNames>? partyNames,
  }) {
    _status = status;
    _users = users;
    _partyNames = partyNames;
  }

  DropdownResModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['users'] != null) {
      _users = [];
      json['users'].forEach((v) {
        _users?.add(Users.fromJson(v));
      });
    }
    if (json['party_names'] != null) {
      _partyNames = [];
      json['party_names'].forEach((v) {
        _partyNames?.add(PartyNames.fromJson(v));
      });
    }
  }
  bool? _status;
  List<Users>? _users;
  List<PartyNames>? _partyNames;
  DropdownResModel copyWith({
    bool? status,
    List<Users>? users,
    List<PartyNames>? partyNames,
  }) =>
      DropdownResModel(
        status: status ?? _status,
        users: users ?? _users,
        partyNames: partyNames ?? _partyNames,
      );
  bool? get status => _status;
  List<Users>? get users => _users;
  List<PartyNames>? get partyNames => _partyNames;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_users != null) {
      map['users'] = _users?.map((v) => v.toJson()).toList();
    }
    if (_partyNames != null) {
      map['party_names'] = _partyNames?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// party_name : "Balar Builder"

PartyNames partyNamesFromJson(String str) =>
    PartyNames.fromJson(json.decode(str));
String partyNamesToJson(PartyNames data) => json.encode(data.toJson());

class PartyNames {
  PartyNames({
    String? partyName,
  }) {
    _partyName = partyName;
  }

  PartyNames.fromJson(dynamic json) {
    _partyName = json['party_name'];
  }
  String? _partyName;
  PartyNames copyWith({
    String? partyName,
  }) =>
      PartyNames(
        partyName: partyName ?? _partyName,
      );
  String? get partyName => _partyName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['party_name'] = _partyName;
    return map;
  }
}

/// id : "1"
/// full_name : "Admin Users"
/// username : "9537195672"
/// email : "admin@admin.com"
/// user_role : "admin"

Users usersFromJson(String str) => Users.fromJson(json.decode(str));
String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    String? id,
    String? fullName,
    String? username,
    String? email,
    String? userRole,
  }) {
    _id = id;
    _fullName = fullName;
    _username = username;
    _email = email;
    _userRole = userRole;
  }

  Users.fromJson(dynamic json) {
    _id = json['id'];
    _fullName = json['full_name'];
    _username = json['username'];
    _email = json['email'];
    _userRole = json['user_role'];
  }
  String? _id;
  String? _fullName;
  String? _username;
  String? _email;
  String? _userRole;
  Users copyWith({
    String? id,
    String? fullName,
    String? username,
    String? email,
    String? userRole,
  }) =>
      Users(
        id: id ?? _id,
        fullName: fullName ?? _fullName,
        username: username ?? _username,
        email: email ?? _email,
        userRole: userRole ?? _userRole,
      );
  String? get id => _id;
  String? get fullName => _fullName;
  String? get username => _username;
  String? get email => _email;
  String? get userRole => _userRole;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['full_name'] = _fullName;
    map['username'] = _username;
    map['email'] = _email;
    map['user_role'] = _userRole;
    return map;
  }
}

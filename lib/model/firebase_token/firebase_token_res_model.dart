import 'dart:convert';
/// status : true
/// message : "Token saved successfully."

FirebaseTokenResModel firebaseTokenResModelFromJson(String str) => FirebaseTokenResModel.fromJson(json.decode(str));
String firebaseTokenResModelToJson(FirebaseTokenResModel data) => json.encode(data.toJson());
class FirebaseTokenResModel {
  FirebaseTokenResModel({
      bool? status, 
      String? message,}){
    _status = status;
    _message = message;
}

  FirebaseTokenResModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
FirebaseTokenResModel copyWith({  bool? status,
  String? message,
}) => FirebaseTokenResModel(  status: status ?? _status,
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
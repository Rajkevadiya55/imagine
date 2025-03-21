import 'dart:convert';
/// user_id : "DXK6R6NW8T"
/// token : "c68si5ktRjOzdqGjOMR7eT:APA91bE48vpW404q-Dhv40XVfeUeCGAkPkPea-pzFRepUWWBwPri"

FirebaseTokenReqModel firebaseTokenReqModelFromJson(String str) => FirebaseTokenReqModel.fromJson(json.decode(str));
String firebaseTokenReqModelToJson(FirebaseTokenReqModel data) => json.encode(data.toJson());
class FirebaseTokenReqModel {
  FirebaseTokenReqModel({
      String? userId, 
      String? token,}){
    _userId = userId;
    _token = token;
}

  FirebaseTokenReqModel.fromJson(dynamic json) {
    _userId = json['user_id'];
    _token = json['token'];
  }
  String? _userId;
  String? _token;
FirebaseTokenReqModel copyWith({  String? userId,
  String? token,
}) => FirebaseTokenReqModel(  userId: userId ?? _userId,
  token: token ?? _token,
);
  String? get userId => _userId;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['token'] = _token;
    return map;
  }

}
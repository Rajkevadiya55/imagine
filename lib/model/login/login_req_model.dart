import 'dart:convert';
/// mobile : "7016392106"
/// password : "123456"

LoginReqModel loginReqModelFromJson(String str) => LoginReqModel.fromJson(json.decode(str));
String loginReqModelToJson(LoginReqModel data) => json.encode(data.toJson());
class LoginReqModel {
  LoginReqModel({
      String? mobile, 
      String? password,}){
    _mobile = mobile;
    _password = password;
}

  LoginReqModel.fromJson(dynamic json) {
    _mobile = json['mobile'];
    _password = json['password'];
  }
  String? _mobile;
  String? _password;
LoginReqModel copyWith({  String? mobile,
  String? password,
}) => LoginReqModel(  mobile: mobile ?? _mobile,
  password: password ?? _password,
);
  String? get mobile => _mobile;
  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile'] = _mobile;
    map['password'] = _password;
    return map;
  }

}
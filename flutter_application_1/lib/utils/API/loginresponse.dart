import 'dart:convert';

LoginResponse loginResponse(String str) =>
    LoginResponse.fromJson(json.decode(str));

class LoginResponse {
  String? token;
  User? user;
  String? avatar;

  LoginResponse({this.token, this.user, this.avatar});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['avatar'] = this.avatar;
    return data;
  }
}

class User {
  String? username;
  String? email;
  String? role;
  String? id;
  Null? address;

  User({this.username, this.email, this.role, this.id, this.address});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    role = json['role'];
    id = json['id'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['role'] = this.role;
    data['id'] = this.id;
    data['address'] = this.address;
    return data;
  }
}

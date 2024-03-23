import 'dart:convert';

RegistreResponse loginResponse(String str) =>
    RegistreResponse.fromJson(json.decode(str));

class RegistreResponse {
  String? token;
  User? user;

  RegistreResponse({this.token, this.user});

  RegistreResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? username;
  String? email;
  String? role;
  Null? address;

  User({this.username, this.email, this.role, this.address});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    role = json['role'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['role'] = this.role;
    data['address'] = this.address;
    return data;
  }
}

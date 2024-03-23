import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> register(String firstname, String lastname, String username,
    String email, String phonenumber, String password) async {
  final response = await http.post(
    Uri.parse('https://localhost:7172/api/Account/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'email': email,
      'phonenumber': phonenumber,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response,
    // then parse the JSON.
    return jsonDecode(response.body)['token'];
  } else {
    // If the server returns an unsuccessful response code,
    // then throw an exception.
    throw Exception('Failed to register');
  }
}

 //class registre_request {
//   String? firstName;
//   String? lastName;
//   String? username;
//   String? email;
//   String? phoneNumber;
//   String? password;

//   registre_request(
//       {this.firstName,
//       this.lastName,
//       this.username,
//       this.email,
//       this.phoneNumber,

//       this.password});

//   registre_request.fromJson(Map<String, dynamic> json) {
//     firstName = json['first name'];
//     lastName = json['last name'];
//     username = json['username'];
//     email = json['email'];
//     phoneNumber = json['phone number'];
//     password = json['password'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['first name'] = this.firstName;
//     data['last name'] = this.lastName;
//     data['username'] = this.username;
//     data['email'] = this.email;
//     data['phone number'] = this.phoneNumber;
//     data['password'] = this.password;
//     return data;
//   }
// }

// Future<http.Response> register(registre_request user) async {
//   final response = await http.post(
//     Uri.parse('https://localhost:7172/api/Account/register'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(user.toJson()),
//   );
//   return response;
// }
//}
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('https://localhost:7172/api/Account/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
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
    throw Exception('Failed to login');
  }
}

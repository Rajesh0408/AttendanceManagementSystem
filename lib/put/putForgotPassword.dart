import 'dart:convert';

import 'package:http/http.dart' as http;

Future<bool> putForgotPassword(String userId, String password) async {
  const url = 'http://10.10.51.107:5000/UpdatePassword'; // Use the appropriate endpoint

  final response = await  http.Client().put(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'user_id':userId,
            'password':password}),
  );

  if (response.statusCode == 201) {
    print('PUT successful!');
    return true;
  } else {
    print('PUT failed with status: ${response.statusCode}');
    return false;
  }
}

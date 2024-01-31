import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> postSignUpData(String role,String batch, String branch, String userId,String username,String password,String email) async {
  Map<String,dynamic> courseDetails={
    'role': role,
    'batch': batch,
    'branch': branch,
    'user_id': userId,
    'user_name': username,
    'email_id':email,
    'password': password
  };
  String jsonData = json.encode(courseDetails);
  http.Response response = await http.post(
    Uri.parse('http://10.0.2.2:5000/UserRegister'), // Replace with your actual API endpoint
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonData,
  );
  if (response.statusCode == 201) {
    print('Data posted successfully');
    print(response.body);
    return true;
  } else {
    print('Failed to post data. Error ${response.statusCode}: ${response.body}');
    return false;
  }
}

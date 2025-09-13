import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> postStudentLogInData(String userId,String password) async {
  Map<String,dynamic> courseDetails={
    'user_id': userId,
    'password': password,
  };
  String jsonData = json.encode(courseDetails);
  http.Response response = await http.post(
    Uri.parse('https://attendancemanagementsystembackend.onrender.com/studLogin'), // Replace with your actual API endpoint
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonData,
  );
  if (response.statusCode == 200) {
    print('Data posted successfully');
    print(response.body);
    return true;
  } else {
    print('Failed to post data. Error ${response.statusCode}: ${response.body}');
    return false;
  }
}

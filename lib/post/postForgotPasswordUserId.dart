import 'dart:convert';
import 'package:http/http.dart' as http;
Future<bool> postForgotPasswordUserId(String userId ) async {
  Map<String,dynamic> courseDetails={
    "user_id":userId
  };

  String jsonData = json.encode(courseDetails);
  http.Response response = await http.post(
    Uri.parse('http://10.0.2.2:5000/ViewFacultyEnrolled'), // Replace with your actual API endpoint
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

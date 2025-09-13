import 'dart:convert';
import 'package:http/http.dart' as http;
Future<bool> postForgotPasswordOTP(String otp,String userId ) async {
  Map<String,dynamic> courseDetails={
    "otp":otp,
    "user_id":userId
  };

  String jsonData = json.encode(courseDetails);
  http.Response response = await http.post(
    Uri.parse('https://attendancemanagementsystembackend.onrender.com/UpdatePassword'), // Replace with your actual API endpoint
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

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> postaddStudent(int rollno,String name, String email ) async {
  Map<String,dynamic> courseDetails={
    'roll_no': rollno,
    'user_name': name,
    'email': email
  };
  String jsonData = json.encode(courseDetails);
  http.Response response = await http.post(
    Uri.parse('http://10.0.2.2:5000/addStudent'), // Replace with your actual API endpoint
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonData,
  );
  if (response.statusCode == 201) {
    print('Data posted successfully');
    print(response.body);
  } else {
    print('Failed to post data. Error ${response.statusCode}: ${response.body}');
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
Future<bool> postEnrollStudent(List<Map<String, dynamic>>  list) async {
  String jsonData = json.encode(list);
  http.Response response = await http.post(
    Uri.parse('http://10.0.2.2:5000/MyStudentEnrollment'), // Replace with your actual API endpoint
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

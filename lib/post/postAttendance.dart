import 'dart:convert';
import 'package:http/http.dart' as http;
Future<void> postAttendance(List<Map<String, dynamic>>  selectedStudents, String courseCode) async {
  String jsonData = json.encode(selectedStudents);
  http.Response response = await http.post(
    Uri.parse('https://attendancemanagementsystembackend.onrender.com/TakeAttendance/$courseCode'), // Replace with your actual API endpoint
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonData,
  );
  if (response.statusCode == 200) {
    print('Data posted successfully');
    print(response.body);
  } else {
    print('Failed to post data. Error ${response.statusCode}: ${response.body}');
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>?> fetchCoursesUsingSem(String sem) async {
  List<String> courseCodes = [];
  http.Response response;
  try {
    response = await http.get(Uri.parse('http://10.0.2.2:5000/listCourses/$sem'));
    if (response.statusCode == 200) {
      List<dynamic> courseJsonList = json.decode(response.body);

      courseCodes = courseJsonList.map((json) => json['course_code'] as String).toList();

      print(courseCodes.toString());
      return courseCodes;
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (error) {
    print("Error: $error");
    return null;
  }
}

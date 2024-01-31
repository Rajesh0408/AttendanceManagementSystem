import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List?> fetchCoursesUsingSem(String sem) async {
  List courseCodes;
  http.Response response;
  try {
    response = await http.get(Uri.parse('http://10.0.2.2:5000/CoursesInSem/$sem'));
    if (response.statusCode == 200) {
      courseCodes = json.decode(response.body);

      //courseCodes = courseJsonList.map((json) => json['course_code'] as String).toList();
      print("courseCodes");
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

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> ForgotPasswordUserID(String userId) async {
  List<String> courseCodes = [];
  http.Response response;
  try {
    response = await http.get(Uri.parse('http://10.0.2.2:5000/upPass/$userId'));
    if (response.statusCode == 200) {
      List<dynamic> courseJsonList = json.decode(response.body);
      return true;
    } else {
      print("Error: ${response.statusCode}");
      return false;
    }
  } catch (error) {
    print("Error: $error");
    return false;
  }
}

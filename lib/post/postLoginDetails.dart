import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> postLogInData(String userId,String password) async {
  Map<String,dynamic>? data;
  Map<String,dynamic> courseDetails={
    'user_id': userId,
    'password': password,
  };
  String jsonData = json.encode(courseDetails);
  http.Response response = await http.post(
    Uri.parse('http://10.0.2.2:5000/UserLogin'), // Replace with your actual API endpoint
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonData,
  );
  if (response.statusCode == 200) {
    print('Data posted successfully');
    data=json.decode(response.body ); //as Map<String, dynamic>;
    return data;
  } else {
    print('Failed to post data. Error ${response.statusCode}: ${response.body}');
    data= {};
    return data ;
  }
}

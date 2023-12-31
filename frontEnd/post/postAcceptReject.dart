import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

Future<void> postAcceptReject(int absent_id, bool status) async {
  Map<String,dynamic> data={
    'status': status
  };
  String jsonData = json.encode(data);
  http.Response response = await http.post(
    Uri.parse('http://10.0.2.2:5000/up_status/$absent_id'), // Replace with your actual API endpoint
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
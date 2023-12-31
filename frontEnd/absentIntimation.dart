import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/colours.dart';
import 'NavBar.dart';
import 'absentIntimationReason.dart';

class absentIntimation extends StatefulWidget{
  String userId;
  bool isfaculty;
  absentIntimation(this.userId,this.isfaculty, {super.key});
  @override
  absentIntimationState createState() => absentIntimationState();
}

class absentIntimationState extends State<absentIntimation> {
  List<dynamic>? form;
  String userId='';
  bool? isfaculty;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId=widget.userId;
    isfaculty=widget.isfaculty;
    fetchData();
  }
  Future fetchData() async {
    http.Response response;
    try {
      response = await http.get(Uri.parse('http://10.0.2.2:5000/absence_list/$userId'));
      if (response.statusCode == 200) {
        setState(() {
          form = json.decode(response.body);
          print(form);
        });
      }
    } catch (error) {
      print("Error: $error");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: AppColor.appbar,
        title: Text('Absent Intimation Forms'),
    ),
    drawer: NavBar(userId,isfaculty!),
    body: ListView.builder(itemBuilder: (context, index) {
      return ListTile(
      leading: const ImageIcon(
      AssetImage(
      'lib/assets/form.png',
      ),
      size: 25.0, // Set the size as per your requirement
      // color: Colors.black, // Set the color as per your requirement
      ),
      title: Text(form?[index]['user_name'] ?? 'N/A'),
      onTap: (){
        print(form?[index]['absent_id']);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  absentIntimationReason(form?[index]['absent_id'], form?[index]['user_name'])),
        );
      },
      );
    },
    itemCount: form?.length ?? 0,
    ),
    );
  }
}

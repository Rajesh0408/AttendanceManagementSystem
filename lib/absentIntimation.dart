import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'NavBar.dart';
import 'absentIntimationReason.dart';
import 'constants/colours.dart';

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
      response = await http.get(Uri.parse('http://10.0.2.2:5000/AbsenceListFaculty/$userId'));
      if (response.statusCode == 200) {
        setState(() {
          form = json.decode(response.body);

        });
      }
    } catch (error) {
      print("Error: $error");
    }
  }
  @override
  Widget build(BuildContext context) {
    form?.sort((a, b) {
      if (a["status"] == -1) {
        return -1; // "Not seen" comes first
      } else if (b["status"] == -1) {
        return 1; // "Not seen" comes first
      } else {
        return 0; // Keep the order unchanged for other statuses
      }
    });
    return Scaffold(
        appBar: AppBar(
        backgroundColor: AppColor.orange,
        title: Text('Absent Intimation Forms'),
    ),
    //drawer: NavBar(userId,isfaculty!),
    body: ListView.builder(reverse:false, itemBuilder: (context, index) {
      return ListTile(
      leading: const ImageIcon(
      AssetImage(
      'lib/assets/icons/form.png',
      ),
      size: 25.0, // Set the size as per your requirement
      // color: Colors.black, // Set the color as per your requirement
      ),

      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  absentIntimationReason(form?[index]['absent_id'], form?[index]['user_name'], userId, isfaculty!,form?[index]['status'])),
        );
      },
        title: Row(
          children: [
            Text("${form?[index]['user_name'] ?? 'N/A'}"),
            Spacer(), // Add this to push the status to the right
            if (form?[index]["status"] == -1)
              Text("Not seen", style: TextStyle(fontWeight: FontWeight.bold),),
            if (form?[index]["status"] == 0)
              Text("Rejected", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
            if (form?[index]["status"] == 1)
              Text("Accepted", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),),

          ],
        ),

      );
    },
    itemCount: form?.length ?? 0,
    ),
    );
  }
}

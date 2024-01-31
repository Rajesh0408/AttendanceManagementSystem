import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:myapp/post/postAcceptReject.dart';

import 'NavBar.dart';
import 'absentIntimation.dart';
import 'constants/colours.dart';

class ViewFormsReasonByStudent extends StatefulWidget {
  String userId;
  bool isfaculty;
  final int absent_id;
  final String user_name;
  String courseName;
  int status;
  ViewFormsReasonByStudent(
      this.absent_id, this.user_name, this.userId, this.isfaculty, this.status, this.courseName,
      {super.key});
  @override
  ViewFormsReasonByStudentState createState() => ViewFormsReasonByStudentState();
}

class ViewFormsReasonByStudentState extends State<ViewFormsReasonByStudent> {
  Map? studentDetails;
  String? userId;
  bool? isfaculty;
  int absent_id = 0;
  String user_name = '';
  int? status;
  String courseName='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    absent_id = widget.absent_id;
    user_name = widget.user_name;
    userId = widget.userId;
    isfaculty = widget.isfaculty;
    status = widget.status;
    courseName= widget.courseName;
    print(status);
    fetchData();
  }

  Future fetchData() async {
    http.Response response;
    try {
      response = await http
          .get(Uri.parse('http://10.0.2.2:5000/ViewFormFaculty/$absent_id'));
      if (response.statusCode == 200) {
        setState(() {
          studentDetails = json.decode(response.body);
          print(studentDetails);
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
        backgroundColor: AppColor.orange,
        title: Text(courseName),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.orange),
              borderRadius: BorderRadius.circular(20),
              color: AppColor.orangeCard),
          //margin: EdgeInsets.all(50.0),
          width: 350.0,
          height: 520.0,
          //color: AppColor.card,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50.0),
              Text(
                "\t\t\t\t\t\t\t\t\t\tCourse code:   ${studentDetails?['course_code']}",
                style: TextStyle(fontSize: 18.0),
              ),

              SizedBox(height: 30.0),
              Text(
                "\t\t\t\t\t\t\t\t\t\tDate:   ${studentDetails?['absent_date']}",
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 30.0),
              Text(
                "\t\t\t\t\t\t\t\t\t\tNumber of hours: ${studentDetails?['absent_hour']}",
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 30.0),
              Center(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.orangeCardd),
                  width: 300.0,
                  height: 220.0,
                  //color: AppColor.button,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\nReason: ",
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                      Center(
                          child: Text(
                            "\n  ${studentDetails?['absent_reason']}",
                            style: TextStyle(fontSize: 18.0, color: Colors.black),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
